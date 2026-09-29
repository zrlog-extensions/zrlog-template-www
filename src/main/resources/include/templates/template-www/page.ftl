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
                        <article class="zr-panel zr-blog-card group p-6 md:p-8 flex flex-col md:flex-row gap-6">
                            <#if log.thumbnail?has_content>
                                <div class="md:w-1/3 w-full shrink-0 overflow-hidden rounded-2xl relative aspect-[4/3] bg-surface-container-highest">
                                    <img
                                        class="w-full h-full object-cover transform group-hover:scale-105 transition-transform duration-500"
                                        onerror="this.style.display='none'"
                                        alt="${log.title?html}"
                                        src="${log.thumbnail}"
                                    />
                                    <div class="absolute inset-0 bg-black/5 dark:bg-black/20 group-hover:bg-transparent transition-colors duration-300"></div>
                                </div>
                            </#if>

                            <div class="flex flex-col justify-between flex-grow space-y-4">
                                <div class="space-y-3">
                                    <div class="flex flex-wrap items-center gap-3 text-label text-on-surface-variant">
                                        <span class="flex items-center gap-1.5 text-link">
                                            <i class="ri-folder-line" aria-hidden="true"></i>
                                            <a href="${log.typeUrl}" class="hover:underline">${log.typeName}</a>
                                        </span>
                                        <span class="text-outline">|</span>
                                        <span class="flex items-center gap-1">
                                            <i class="ri-time-line" aria-hidden="true"></i> ${log.releaseTime?split("T")[0]}
                                        </span>
                                    </div>

                                    <h2 class="text-headline">
                                        <a rel="bookmark" href="${log.url}" class="text-on-surface hover:text-link transition-colors">
                                            ${log.title?html}
                                        </a>
                                    </h2>

                                    <div class="text-on-surface-variant text-base leading-7 line-clamp-3">
                                        ${log.digest!''}
                                    </div>
                                </div>

                                <div class="flex flex-wrap items-center justify-between gap-2 pt-2 mt-auto">
                                    <div class="flex flex-wrap items-center gap-4 text-label text-on-surface-variant">
                                        <span class="flex items-center gap-1.5">
                                            <i class="ri-eye-line" aria-hidden="true"></i> ${log.click} ${_res.views}
                                        </span>
                                        <#if log.canComment>
                                            <a href="${log.url}#comment" class="flex items-center gap-1.5 hover:text-link transition-colors group/comment">
                                                <i class="ri-chat-1-line group-hover/comment:text-link transition-colors" aria-hidden="true"></i> ${log.commentSize} ${_res.commentCount}
                                            </a>
                                        </#if>
                                    </div>
                                    <a href="${log.url}" class="zr-button zr-button--tonal group/link">
                                        ${_res.readMore} <i class="ri-arrow-right-line transition-transform group-hover/link:translate-x-1" aria-hidden="true"></i>
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
