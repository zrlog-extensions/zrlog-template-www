<#import "navigation.ftl" as nav>
<#-- Slots: beforeTheme, afterTheme, mobile. No host-specific globals. -->
<#macro header baseUrl init _res logoUrl=(baseUrl + "favicon.ico")>
<nav class="sticky top-0 z-50 border-b border-gray-200 bg-white py-3 dark:border-gray-800 dark:bg-black" id="header">
    <div class="container mx-auto flex items-center justify-between px-4 md:px-6">
        <div class="flex min-w-0 items-center">
            <a href="${baseUrl?html}" class="mr-8 flex shrink-0 items-center gap-2 text-xl font-bold text-gray-950 dark:text-white" aria-label="${_res.home?html}">
                <img src="${logoUrl?html}" alt="" class="h-9 w-9"/>
                <span>${(_res.navBarBrand!'')?html}</span>
            </a>
            <ul class="hidden items-center gap-1 xl:flex">
                <@nav.navigation logNavs=init.logNavs/>
            </ul>
        </div>

        <div class="flex items-center gap-2 md:gap-3">
            <#nested "beforeTheme">
            <button type="button" data-theme-button
                    class="inline-flex h-10 w-10 items-center justify-center rounded-lg border border-gray-200 text-gray-700 transition-colors hover:border-blue-500 hover:text-blue-600 dark:border-gray-700 dark:text-gray-300"
                    aria-label="${_res.switchTheme?html}" title="${_res.switchTheme?html}">
                <i class="ri-moon-line text-lg" data-theme-icon></i>
            </button>
            <#nested "afterTheme">
            <button type="button"
                    class="inline-flex h-10 w-10 items-center justify-center rounded-lg border border-gray-200 text-gray-900 hover:border-blue-500 dark:border-gray-700 dark:text-white xl:hidden"
                    id="toggleSidebar" aria-label="${_res.openNav?html}" aria-controls="sidebar" aria-expanded="false">
                <i class="ri-menu-4-line text-lg"></i>
            </button>
        </div>
    </div>
</nav>

<div id="overlay" class="fixed inset-0 z-[60] hidden bg-black/60"></div>
<aside id="sidebar" class="fixed left-0 top-0 z-[70] hidden h-full w-72 -translate-x-full border-r border-gray-200 bg-white p-6 shadow-2xl transition-transform duration-300 dark:border-gray-800 dark:bg-gray-950"
       role="dialog" aria-modal="true" aria-hidden="true" aria-label="${_res.mobileNav?html}">
    <div class="flex h-full flex-col">
        <div class="mb-8 flex items-center justify-between">
            <a href="${baseUrl?html}" class="flex items-center gap-2 text-lg font-bold text-gray-950 dark:text-white">
                <img src="${logoUrl?html}" alt="" class="h-8 w-8"/>
                <span>${(_res.navBarBrand!'')?html}</span>
            </a>
            <button type="button" id="closeSidebar" class="inline-flex h-10 w-10 items-center justify-center rounded-lg text-gray-500 hover:bg-gray-100 hover:text-gray-950 dark:text-gray-400 dark:hover:bg-gray-900 dark:hover:text-white" aria-label="${_res.closeNav?html}">
                <i class="ri-close-line text-xl"></i>
            </button>
        </div>
        <ul class="flex flex-col gap-2">
            <@nav.navigation logNavs=init.logNavs/>
        </ul>
        <div class="mt-auto flex flex-col gap-2 border-t border-gray-200 pt-6 dark:border-gray-800">
            <#nested "mobile">
        </div>
    </div>
</aside>
</#macro>
