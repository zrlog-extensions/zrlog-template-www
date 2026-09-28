<#include "header.ftl">
<#import "_site/page-intro.ftl" as shellIntro>
<section class="zr-page zr-blog">
    <#if tipsType?has_content>
        <@shellIntro.pageIntro title=(tipsType + _res.directorySuffix + _res.labelSeparator + (tipsName!''))
            summary=(_res.relatedArticlesPrefix + tipsType + ' “' + (tipsName!'') + '”' + _res.relatedArticlesSuffix)
            breadcrumbs=[{"label": _res.home, "href": baseUrl}, {"label": tipsName!tipsType}]
            breadcrumbLabel=_res.breadcrumb/>
    <#else>
        <@shellIntro.pageIntro title=(webSite.title!'') summary=(webSite.second_title!webSite.description!'')/>
    </#if>
    <div class="container zr-blog-content">
        <div class="zr-blog-layout">
            <main class="zr-blog-main space-y-6">

                <#if data?has_content && data.rows?has_content>
                    <#list data.rows as log>
                        <article class="zr-panel group p-5 transition-colors flex flex-col md:flex-row gap-6 hover:border-blue-400 dark:hover:border-blue-700">
                            <#if log.thumbnail?has_content>
                                <div class="md:w-1/3 w-full shrink-0 overflow-hidden rounded-lg relative aspect-[4/3] md:aspect-[4/3] bg-gray-100 dark:bg-gray-900">
                                    <img
                                        class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500"
                                        onerror="this.style.display='none'"
                                        alt="${log.title?html}"
                                        src="${log.thumbnail}"
                                    />
                                    <div class="absolute inset-0 bg-black/5 dark:bg-black/20 group-hover:bg-transparent transition-colors duration-300"></div>
                                </div>
                            </#if>

                            <div class="flex flex-col justify-between flex-grow space-y-4">
                                <div class="space-y-3">
                                    <div class="flex items-center gap-3 text-xs font-medium text-gray-500 dark:text-gray-400">
                                        <span class="flex items-center gap-1.5 px-2.5 py-1 rounded bg-blue-50 dark:bg-blue-950 text-blue-600 dark:text-blue-300">
                                            <i class="ri-folder-line"></i>
                                            <a href="${log.typeUrl}" class="hover:underline">${log.typeName}</a>
                                        </span>
                                        <span class="text-gray-300 dark:text-gray-700">|</span>
                                        <span class="flex items-center gap-1">
                                            <i class="ri-time-line"></i> ${log.releaseTime?split("T")[0]}
                                        </span>
                                    </div>

                                    <h2 class="text-2xl font-bold leading-tight">
                                        <a rel="bookmark" href="${log.url}" class="text-gray-900 dark:text-white hover:text-blue-600 dark:hover:text-blue-400 transition-colors line-clamp-2">
                                            ${log.title?html}
                                        </a>
                                    </h2>

                                    <div class="text-gray-600 dark:text-gray-400 text-sm leading-relaxed line-clamp-3">
                                        ${log.digest!''}
                                    </div>
                                </div>

                                <div class="flex items-center justify-between pt-4 border-t border-gray-100 dark:border-gray-800 mt-auto">
                                    <div class="flex items-center gap-4 text-sm text-gray-500 dark:text-gray-400">
                                        <span class="flex items-center gap-1.5">
                                            <i class="ri-eye-line"></i> ${log.click} ${_res.views}
                                        </span>
                                        <#if log.canComment>
                                            <a href="${log.url}#comment" class="flex items-center gap-1.5 hover:text-blue-600 transition-colors group/comment">
                                                <i class="ri-chat-1-line group-hover/comment:text-blue-600 transition-colors"></i> ${log.commentSize} ${_res.commentCount}
                                            </a>
                                        </#if>
                                    </div>
                                    <a href="${log.url}" class="text-blue-600 dark:text-blue-400 text-sm font-medium hover:underline flex items-center gap-1 group/link">
                                        ${_res.readMore} <i class="ri-arrow-right-line transition-transform group-hover/link:translate-x-1"></i>
                                    </a>
                                </div>
                            </div>
                        </article>
                    </#list>
                <#else>
                    <#include "404.ftl">
                </#if>
                <#include "pager.ftl">
            </main>
            <#include "plugin.ftl">
        </div>
    </div>
</section>
<#include "footer.ftl">
