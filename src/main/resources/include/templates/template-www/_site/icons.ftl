<#-- Material Symbols Rounded names; legacy values only adapt saved blog navigation. -->
<#assign legacyNames = {
    "ri-alipay-line": "payments",
    "ri-apple-line": "desktop_mac",
    "ri-archive-line": "archive",
    "ri-arrow-down-line": "arrow_downward",
    "ri-arrow-down-s-line": "expand_more",
    "ri-arrow-left-line": "arrow_back",
    "ri-arrow-left-s-line": "chevron_left",
    "ri-arrow-right-down-line": "south_east",
    "ri-arrow-right-line": "arrow_forward",
    "ri-arrow-right-s-line": "chevron_right",
    "ri-arrow-right-up-line": "north_east",
    "ri-arrow-up-line": "arrow_upward",
    "ri-article-line": "article",
    "ri-book-read-line": "menu_book",
    "ri-braces-line": "data_object",
    "ri-bug-line": "bug_report",
    "ri-calendar-line": "calendar_today",
    "ri-chat-1-line": "chat_bubble",
    "ri-check-line": "check",
    "ri-chrome-line": "web",
    "ri-close-line": "close",
    "ri-cloud-line": "cloud",
    "ri-code-box-line": "code_blocks",
    "ri-code-s-slash-line": "code",
    "ri-computer-line": "computer",
    "ri-copyright-line": "copyright",
    "ri-database-2-line": "database",
    "ri-download-2-line": "download",
    "ri-download-cloud-2-line": "cloud_download",
    "ri-download-cloud-line": "cloud_download",
    "ri-download-line": "download",
    "ri-edge-line": "web",
    "ri-edit-2-line": "edit_note",
    "ri-external-link-line": "open_in_new",
    "ri-eye-line": "visibility",
    "ri-feedback-line": "feedback",
    "ri-file-copy-line": "content_copy",
    "ri-file-transfer-line": "file_copy",
    "ri-file-upload-line": "upload_file",
    "ri-file-zip-line": "folder_zip",
    "ri-firefox-line": "web",
    "ri-flashlight-line": "bolt",
    "ri-folder-line": "folder",
    "ri-git-branch-line": "fork_right",
    "ri-git-pull-request-line": "merge",
    "ri-github-fill": "github",
    "ri-github-line": "github",
    "ri-hand-coin-line": "volunteer_activism",
    "ri-hashtag": "tag",
    "ri-history-line": "history",
    "ri-home-4-line": "home",
    "ri-home-line": "home",
    "ri-java-line": "coffee",
    "ri-layout-grid-line": "dashboard",
    "ri-link": "link",
    "ri-markdown-line": "markdown",
    "ri-menu-4-line": "menu",
    "ri-moon-line": "dark_mode",
    "ri-opera-line": "web",
    "ri-plug-2-line": "extension",
    "ri-price-tag-3-line": "sell",
    "ri-pulse-line": "monitor_heart",
    "ri-question-answer-line": "forum",
    "ri-rss-line": "rss_feed",
    "ri-safari-line": "explore",
    "ri-scales-3-line": "balance",
    "ri-search-line": "search",
    "ri-server-line": "dns",
    "ri-sparkling-2-line": "auto_awesome",
    "ri-sun-line": "light_mode",
    "ri-terminal-line": "terminal",
    "ri-time-line": "schedule",
    "ri-translate-2": "translate",
    "ri-ubuntu-line": "package_2",
    "ri-wechat-pay-line": "payments",
    "ri-windows-line": "desktop_windows"
}>
<#assign symbolNames = ["archive", "arrow_back", "arrow_downward", "arrow_forward", "arrow_upward", "article", "auto_awesome", "balance", "bolt", "bug_report", "build", "calendar_today", "category", "chat_bubble", "check", "chevron_left", "chevron_right", "close", "cloud", "cloud_download", "code", "code_blocks", "coffee", "computer", "content_copy", "copyright", "dark_mode", "dashboard", "data_object", "database", "description", "desktop_mac", "desktop_windows", "dns", "download", "edit_note", "expand_more", "explore", "extension", "favorite", "feedback", "file_copy", "folder", "folder_zip", "fork_right", "forum", "help", "history", "home", "info", "language", "light_mode", "link", "list", "mail", "markdown", "menu", "menu_book", "merge", "monitor_heart", "neurology", "north_east", "open_in_new", "package_2", "payments", "person", "photo", "rss_feed", "schedule", "search", "sell", "send", "settings", "south_east", "star", "tag", "terminal", "translate", "upload_file", "visibility", "volunteer_activism", "web"]>
<#function resolve name>
    <#local mapped = legacyNames[name]!name>
    <#return (mapped == "github" || symbolNames?seq_contains(mapped))?then(mapped, "link")>
</#function>

<#function repositoryIcon repositoryUrl>
    <#local address = repositoryUrl?lower_case>
    <#return (address?starts_with("https://github.com/") || address?starts_with("http://github.com/"))?then("github", "code_blocks")>
</#function>

<#-- GitHub's official Primer mark-github-16, MIT license in images/github-mark-LICENSE.txt.
     Source: https://github.com/primer/octicons/blob/main/icons/mark-github-16.svg -->
<#macro render name class="">
    <#local symbol = resolve(name)>
    <#if symbol == "github">
        <svg class="zr-brand-icon ${class?html}" data-brand="github" viewBox="0 0 16 16" fill="currentColor"
             xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
            <path d="M6.766 11.328c-2.063-.25-3.516-1.734-3.516-3.656 0-.781.281-1.625.75-2.188-.203-.515-.172-1.609.063-2.062.625-.078 1.468.25 1.968.703.594-.187 1.219-.281 1.985-.281.765 0 1.39.094 1.953.265.484-.437 1.344-.765 1.969-.687.218.422.25 1.515.046 2.047.5.593.766 1.39.766 2.203 0 1.922-1.453 3.375-3.547 3.64.531.344.89 1.094.89 1.954v1.625c0 .468.391.734.86.547C13.781 14.359 16 11.53 16 8.03 16 3.61 12.406 0 7.984 0 3.563 0 0 3.61 0 8.031a7.88 7.88 0 0 0 5.172 7.422c.422.156.828-.125.828-.547v-1.25c-.219.094-.5.156-.75.156-1.031 0-1.64-.562-2.078-1.609-.172-.422-.36-.672-.719-.719-.187-.015-.25-.093-.25-.187 0-.188.313-.328.625-.328.453 0 .844.281 1.25.86.313.452.64.655 1.031.655s.641-.14 1-.5c.266-.265.47-.5.657-.656"/>
        </svg>
    <#else>
        <i class="zr-icon ${class?html}" data-icon="${symbol?html}" aria-hidden="true"></i>
    </#if>
</#macro>
