package com.zrlog.theme.bundled;

import freemarker.template.Configuration;
import freemarker.template.Template;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.junit.Test;

import java.io.InputStream;
import java.io.StringWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import static org.junit.Assert.*;

/** Exercises the native blog contract; the website must adapt to these same components. */
public class SiteUiRenderingTest {
    private static final String ROOT = "/include/templates/template-www/";
    private static final String ASSETS = "/notes/include/templates/template-www";

    @Test
    public void rendersBlogPagesWithSharedShellAndLocalAssets() throws Exception {
        for (String locale : List.of("zh_CN", "en_US")) {
            Map<String, Object> model = blogModel(locale);
            for (String page : List.of("index", "detail")) {
                Document document = render(page + ".ftl", model);
                assertEquals(1, document.select("nav#header").size());
                assertEquals(1, document.select("footer#footer").size());
                assertEquals(1, document.select("#sidebar[role=dialog][aria-modal=true]").size());
                assertEquals(2, document.select("a.zr-nav-link[aria-current=page][href='/notes/']").size());
                assertEquals("Notes <&>", document.selectFirst("nav#header a span").text());
                assertEquals("/notes/favicon.ico", document.selectFirst("nav#header img").attr("src"));
                assertEquals(1, document.select("[data-theme-button]").size());
                assertEquals(locale.equals("en_US") ? "Toggle color theme" : "切换亮暗主题",
                        document.selectFirst("[data-theme-button]").attr("aria-label"));
                assertEquals(1, document.select("#custom-footer").size());
                assertEquals(1, document.select("footer a[href='/notes/about']").size());
                assertEquals(1, document.select("script[src$='/js/site-shell.js']").size());
                assertEquals(0, document.select("script[src$='/js/helpers.js']").size());
                assertTrue(document.head().html().contains("--color-primary: #165dff"));
                assertEquals(1, document.select("style#custom-style").size());
                assertEquals(1, document.select("form[action='/notes/search']").size());
                assertTrue(document.text().contains("Example article"));
                if (page.equals("detail")) {
                    assertEquals(1, document.select("#article-body").size());
                    assertEquals(1, document.select("#comment plugin[name=comments]").size());
                }
                assertLocalAssets(document);
                Path preview = Path.of("target/ui-preview", page + "-" + locale + ".html");
                Files.createDirectories(preview.getParent());
                Files.writeString(preview, document.outerHtml());
            }
        }
    }

    @Test
    public void acceptsEmptyNavigationAndOptionalBlogSettings() throws Exception {
        Map<String, Object> model = blogModel("en_US");
        model.put("init", Map.of("logNavs", List.of()));
        Map<String, Object> resources = resources("en_US");
        model.put("_res", resources);
        model.put("webSite", Map.of("title", "Empty site"));
        StringWriter output = new StringWriter();
        new Template("empty-shell", "<#include 'header.ftl'><main>Empty</main><#include 'footer.ftl'>",
                configuration()).process(model, output);
        Document document = Jsoup.parse(output.toString());
        assertEquals(0, document.select("a.zr-nav-link").size());
        assertEquals(1, document.select("#footer").size());
        assertTrue(document.text().contains("Empty site"));
        assertFalse(document.head().html().contains("undefined"));
    }

    private static Configuration configuration() {
        Configuration cfg = new Configuration(Configuration.VERSION_2_3_32);
        cfg.setDefaultEncoding("UTF-8");
        cfg.setClassForTemplateLoading(SiteUiRenderingTest.class, ROOT);
        return cfg;
    }

    private static Document render(String page, Map<String, Object> model) throws Exception {
        StringWriter output = new StringWriter();
        configuration().getTemplate(page).process(model, output);
        return Jsoup.parse(output.toString());
    }

    private static Map<String, Object> resources(String locale) throws Exception {
        Properties properties = new Properties();
        try (InputStream stream = SiteUiRenderingTest.class.getResourceAsStream(ROOT + "language/i18n_" + locale + ".properties")) {
            properties.load(stream);
        }
        Map<String, Object> resources = new HashMap<>();
        properties.forEach((key, value) -> resources.put(key.toString(), value));
        // These labels are normally merged in from the blog's base language bundle.
        resources.putAll(Map.of("search", "Search", "searchTip", "Search articles", "author", "Author",
                "lastArticle", "Previous", "nextArticle", "Next", "notFound", "Not found"));
        return resources;
    }

    private static Map<String, Object> blogModel(String locale) throws Exception {
        Map<String, Object> model = new HashMap<>();
        Map<String, Object> resources = resources(locale);
        resources.putAll(Map.of("navBarBrand", "Notes <&>", "colorPrimary", "#165dff",
                "githubLink", "<a href='https://example.org/source'>Source</a>",
                "footerLinkExt", "<div id='custom-footer'>Custom footer</div>",
                "footerLink", "<a href='/notes/about'>About</a>"));
        model.put("_res", resources);
        model.put("url", ASSETS);
        model.put("baseUrl", "/notes/");
        model.put("lang", locale);
        model.put("title", "Example blog");
        model.put("searchUrl", "/notes/search");
        model.put("globalStyle", "<style id='custom-style'>.custom { color: red; }</style>");
        Map<String, Object> website = Map.of("title", "Example blog", "icp", "ICP example",
                "webCm", "<span id='statistics'>Stats</span>", "comment_plugin_name", "comments");
        model.put("webSite", website);
        model.put("website", website);
        model.put("init", Map.of("logNavs", List.of(
                Map.of("url", "/notes/", "navName", "Home <&>", "icon", "ri-home-line", "current", true),
                Map.of("url", "/notes/about", "navName", "About", "current", false))));
        Map<String, Object> article = new HashMap<>();
        article.putAll(Map.of("title", "Example article", "url", "/notes/example.html", "typeUrl", "/notes/category",
                "typeName", "Journal", "releaseTime", "2026-09-28T10:00:00", "click", 12,
                "canComment", true, "commentSize", 2, "digest", "Article summary", "thumbnail", ""));
        article.putAll(Map.of("logId", 1, "content", "<p id='article-body'>Article content</p>",
                "noSchemeUrl", "//example.org/notes/example.html"));
        model.put("log", article);
        model.put("data", Map.of("rows", List.of(article)));
        return model;
    }

    private static void assertLocalAssets(Document document) throws Exception {
        for (Element asset : document.select("script[src], link[rel=stylesheet]")) {
            String url = asset.hasAttr("src") ? asset.attr("src") : asset.attr("href");
            if (!url.startsWith(ASSETS + "/")) continue;
            String resource = ROOT + url.substring(ASSETS.length() + 1);
            try (InputStream stream = SiteUiRenderingTest.class.getResourceAsStream(resource)) {
                assertNotNull("Missing theme resource " + resource, stream);
                assertTrue(stream.read() >= 0);
            }
        }
    }
}
