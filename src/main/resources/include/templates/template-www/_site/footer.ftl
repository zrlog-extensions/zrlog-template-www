<#-- Native blog fields are the shared contract; HTML settings remain extension points. -->
<#macro footer webSite _res>
<#local hasContent = (_res.footerLinkExt!'')?has_content>
<button id="back-to-top" type="button"
        class="zr-icon-button fixed bottom-6 right-6 z-50 opacity-0 invisible"
        aria-label="${_res.backToTop?html}" title="${_res.backToTop?html}">
    <i class="zr-icon text-xl" data-icon="arrow_upward" aria-hidden="true"></i>
</button>
<footer class="py-12" id="footer">
    <div class="container mx-auto px-4 md:px-6">
        <#if hasContent>${_res.footerLinkExt}</#if>
        <div class="<#if hasContent>mt-12 border-t border-outline-variant pt-6 </#if>flex flex-col gap-5 text-sm text-on-surface-variant md:flex-row md:items-center md:justify-between">
            <div>© 2026 ${ (webSite.title!'')?html}<#if (webSite.icp!'')?has_content> · ${webSite.icp}</#if></div>
            <div class="flex flex-wrap gap-x-6 gap-y-2 md:justify-end">${_res.footerLink!''}</div>
        </div>
    </div>
</footer>
</#macro>
