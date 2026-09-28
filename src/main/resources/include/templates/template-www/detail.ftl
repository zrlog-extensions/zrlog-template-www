<#include "header.ftl">
<#import "_site/page-intro.ftl" as shellIntro>
<section class="zr-page zr-blog">
    <#if log??>
        <@shellIntro.pageIntro title=log.title
            breadcrumbs=[{"label": _res.home, "href": baseUrl}, {"label": log.typeName, "href": log.typeUrl}, {"label": log.title}]
            breadcrumbLabel=_res.breadcrumb
            meta=[{"icon": "ri-folder-line", "label": log.typeName},
                  {"icon": "ri-time-line", "label": log.releaseTime?split("T")[0]},
                  {"icon": "ri-eye-line", "label": log.click?string + ' ' + _res.views}]/>
    </#if>
    <div class="container zr-blog-content">
        <div class="zr-blog-layout">
            <main class="zr-blog-main">
                <#if log??>
                    <#include "article.ftl">
                    <#include "comment.ftl">
                <#else>
                    <#assign pageLevel = 1>
                    <#include "404.ftl">
                </#if>
            </main>
            <#include "plugin.ftl">
        </div>
    </div>
</section>
<#include "footer.ftl">
