<article class="zr-panel p-6 md:p-8">
    <#if (pageLevel!2) == 1>
        <h1 class="text-page-title mb-3">${_res.notFound?html}</h1>
    <#else>
        <h2 class="text-headline mb-3">${_res.notFound?html}</h2>
    </#if>
    <p class="text-on-surface-variant mb-6">${_res.notFoundDescription?html}</p>
    <form method="post" action="${searchUrl?html}" class="flex flex-col sm:flex-row sm:items-end gap-3">
        <div class="min-w-0 sm:flex-1">
            <label for="empty-search" class="block text-label mb-2">${_res.search?html}</label>
            <div class="zr-search"><i class="zr-icon" data-icon="search" aria-hidden="true"></i><input id="empty-search" type="search" name="key" value="${(key!'')?html}" aria-label="${_res.search?html}"
                   placeholder="${_res.searchTip?html}" class="min-w-0"/></div>
        </div>
        <button type="submit" class="zr-button zr-button--filled">${_res.search?html}</button>
    </form>
</article>
