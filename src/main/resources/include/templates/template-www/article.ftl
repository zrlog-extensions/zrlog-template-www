<article class="zr-panel zr-blog-article p-6 md:p-8">
    <!-- 正文内容 -->
    <div class="zr-rich-text markdown-body">
        ${log.content!''}
    </div>

    <hr class="my-10 border-outline-variant"/>

    <!-- 标签 -->
    <#if log.tags?has_content>
        <div class="flex flex-wrap items-center gap-3 mb-8">
            <#list log.tags as tag>
                <a class="zr-chip" href="${tag.url}">
                    <i class="zr-icon text-gray-400" data-icon="tag" aria-hidden="true"></i> ${tag.name}
                </a>
            </#list>
        </div>
    </#if>

    <!-- 转载说明 -->
    <div class="bg-surface-container-high rounded-2xl p-6 mb-8 text-sm text-on-surface-variant relative overflow-hidden group">
        <div class="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
            <i class="zr-icon text-6xl text-gray-400" data-icon="copyright" aria-hidden="true"></i>
        </div>
        <div class="relative z-10 space-y-2">
            <div class="flex flex-col sm:flex-row sm:items-center gap-2">
                <span class="font-medium text-on-surface min-w-[4em]">${_res.author}:</span>
                <span class="text-on-surface-variant">${website.title}</span>
            </div>
            <div class="flex flex-col sm:flex-row sm:items-center gap-2">
                <span class="font-medium text-on-surface min-w-[4em]">${_res.originalLink}${_res.labelSeparator}</span>
                <a class="text-link hover:underline break-all" title="${log.title}" href="${log.noSchemeUrl}">
                    ${log.noSchemeUrl}
                </a>
            </div>
        </div>
    </div>

    <!-- 上/下一篇 -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
        <#if log.lastLog??>
            <a href="${log.lastLog.url}" class="zr-panel zr-panel--outlined block p-5 hover:bg-surface-container-high transition-colors">
                <div class="text-label text-on-surface-variant mb-1">
                    <i class="zr-icon" data-icon="arrow_back" aria-hidden="true"></i> ${_res.lastArticle}
                </div>
                <div class="text-sm font-medium text-link break-words">
                    ${log.lastLog.title}
                </div>
            </a>
        <#else>
             <div class="p-5 rounded-card bg-surface-container-high text-on-surface-variant text-sm">
                 ${_res.lastArticle}${_res.labelSeparator}${_res.noMoreArticles}
             </div>
        </#if>
        
        <#if log.nextLog??>
            <a href="${log.nextLog.url}" class="zr-panel zr-panel--outlined block p-5 hover:bg-surface-container-high transition-colors text-right">
                <div class="text-label text-on-surface-variant mb-1">
                    ${_res.nextArticle} <i class="zr-icon" data-icon="arrow_forward" aria-hidden="true"></i>
                </div>
                <div class="text-sm font-medium text-link break-words">
                    ${log.nextLog.title}
                </div>
            </a>
        <#else>
            <div class="p-5 rounded-card bg-surface-container-high text-on-surface-variant text-sm text-right">
                ${_res.nextArticle}${_res.labelSeparator}${_res.noMoreArticles}
            </div>
        </#if>
    </div>

    <!-- 广告位 -->
    <div class="mt-6">
        ${_res.detailAd!''}
    </div>
</article>
