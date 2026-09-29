<#macro pageIntro title summary="" breadcrumbs=[] meta=[] hasActions=false breadcrumbLabel="Breadcrumb" tonal=true>
    <section class="zr-page-intro<#if !tonal> zr-page-intro--plain</#if>">
        <div class="container mx-auto px-4 md:px-6">
            <#if breadcrumbs?size gt 0>
                <nav class="mb-5 flex min-w-0 flex-wrap items-center gap-2 text-label" aria-label="${breadcrumbLabel?html}">
                    <#list breadcrumbs as breadcrumb>
                        <#if breadcrumb?index gt 0>
                            <i class="ri-arrow-right-s-line shrink-0" aria-hidden="true"></i>
                        </#if>
                        <#if breadcrumb.href??>
                            <a href="${breadcrumb.href?html}" class="${breadcrumb.linkClass!''} break-words underline-offset-4 hover:underline">${breadcrumb.label?html}</a>
                        <#else>
                            <span class="break-words font-medium" <#if breadcrumb?is_last>aria-current="page"</#if>>${breadcrumb.label?html}</span>
                        </#if>
                    </#list>
                </nav>
            </#if>

            <div class="grid gap-6 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-center">
                <div class="max-w-3xl">
                    <h1 class="text-page-title">${title?html}</h1>
                    <#if summary?has_content><p class="mt-4 max-w-2xl text-base leading-7 ${tonal?then('text-on-primary-container', 'text-on-surface-variant')}">${summary?html}</p></#if>
                    <#if meta?size gt 0>
                        <div class="mt-5 flex flex-wrap items-center gap-x-5 gap-y-2 text-sm ${tonal?then('text-on-primary-container', 'text-on-surface-variant')}">
                            <#list meta as item>
                                <span class="inline-flex items-center gap-2">
                                    <#if item.icon??><i class="${item.icon}" aria-hidden="true"></i></#if>
                                    ${item.label?html}
                                </span>
                            </#list>
                        </div>
                    </#if>
                </div>
                <#if hasActions>
                    <div class="flex flex-wrap items-center gap-3 lg:justify-end">
                        <#nested>
                    </div>
                </#if>
            </div>
        </div>
    </section>
</#macro>
