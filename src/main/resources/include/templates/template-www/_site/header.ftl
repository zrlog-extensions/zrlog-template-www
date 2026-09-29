<#import "navigation.ftl" as nav>
<#-- Slots: beforeTheme, afterTheme, mobile. No host-specific globals. -->
<#macro header baseUrl init _res logoUrl=(baseUrl + "favicon.ico")>
<nav class="sticky top-0 z-50 py-3" id="header">
    <div class="container mx-auto flex items-center justify-between px-4 md:px-6">
        <div class="flex min-w-0 items-center">
            <a href="${baseUrl?html}" class="zr-brand mr-4 flex min-w-0 items-center gap-2 text-xl font-bold text-on-surface md:mr-8" aria-label="${_res.home?html}">
                <img src="${logoUrl?html}" alt="" class="h-9 w-9 shrink-0"/>
                <span class="truncate">${(_res.navBarBrand!'')?html}</span>
            </a>
            <ul class="hidden shrink-0 items-center gap-1 xl:flex">
                <@nav.navigation logNavs=init.logNavs/>
            </ul>
        </div>

        <div class="flex shrink-0 items-center gap-2 md:gap-3">
            <#nested "beforeTheme">
            <button type="button" data-theme-button
                    class="zr-icon-button"
                    aria-label="${_res.switchTheme?html}" title="${_res.switchTheme?html}">
                <i class="ri-moon-line text-lg" aria-hidden="true" data-theme-icon></i>
            </button>
            <#nested "afterTheme">
            <button type="button"
                    class="zr-icon-button xl:hidden"
                    id="toggleSidebar" aria-label="${_res.openNav?html}" aria-controls="sidebar" aria-expanded="false">
                <i class="ri-menu-4-line text-lg" aria-hidden="true"></i>
            </button>
        </div>
    </div>
</nav>

<div id="overlay" class="fixed inset-0 z-[60] hidden bg-black/60"></div>
<aside id="sidebar" class="fixed left-0 top-0 z-[70] hidden h-full -translate-x-full p-6 transition-transform duration-300 ease-standard"
       role="dialog" aria-modal="true" aria-hidden="true" aria-label="${_res.mobileNav?html}">
    <div class="flex h-full flex-col">
        <div class="mb-8 flex items-center justify-between">
            <a href="${baseUrl?html}" class="flex min-w-0 items-center gap-2 text-lg font-bold text-on-surface">
                <img src="${logoUrl?html}" alt="" class="h-8 w-8 shrink-0"/>
                <span class="truncate">${(_res.navBarBrand!'')?html}</span>
            </a>
            <button type="button" id="closeSidebar" class="zr-icon-button" aria-label="${_res.closeNav?html}">
                <i class="ri-close-line text-xl" aria-hidden="true"></i>
            </button>
        </div>
        <ul class="flex flex-col gap-2">
            <@nav.navigation logNavs=init.logNavs/>
        </ul>
        <div class="mt-auto flex flex-col gap-2 border-t border-outline-variant pt-6">
            <#nested "mobile">
        </div>
    </div>
</aside>
</#macro>
