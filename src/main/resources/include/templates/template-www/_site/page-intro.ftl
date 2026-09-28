<#macro pageIntro title summary="" breadcrumbs=[] meta=[] hasActions=false breadcrumbLabel="Breadcrumb">
    <section class="zr-page-intro border-b border-gray-200 bg-white py-10 dark:border-gray-800 dark:bg-black md:py-14">
        <div class="container mx-auto px-4 md:px-6">
            <#if breadcrumbs?size gt 0>
                <nav class="mb-5 flex min-w-0 items-center gap-2 overflow-hidden text-sm text-gray-500 dark:text-gray-400" aria-label="${breadcrumbLabel?html}">
                    <#list breadcrumbs as breadcrumb>
                        <#if breadcrumb?index gt 0>
                            <i class="ri-arrow-right-s-line shrink-0" aria-hidden="true"></i>
                        </#if>
                        <#if breadcrumb.href??>
                            <a href="${breadcrumb.href?html}" class="${breadcrumb.linkClass!''} truncate transition-colors hover:text-blue-600 dark:hover:text-blue-400">${breadcrumb.label?html}</a>
                        <#else>
                            <span class="truncate font-medium text-gray-900 dark:text-white" <#if breadcrumb?is_last>aria-current="page"</#if>>${breadcrumb.label?html}</span>
                        </#if>
                    </#list>
                </nav>
            </#if>

            <div class="grid gap-7 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-end">
                <div class="max-w-3xl">
                    <h1 class="text-3xl font-bold leading-tight text-gray-950 dark:text-white md:text-4xl">${title?html}</h1>
                    <#if summary?has_content><p class="mt-4 max-w-2xl text-base leading-7 text-gray-600 dark:text-gray-400">${summary?html}</p></#if>
                    <#if meta?size gt 0>
                        <div class="mt-5 flex flex-wrap items-center gap-x-5 gap-y-2 text-sm text-gray-500 dark:text-gray-400">
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
