<article class="zr-panel p-6 md:p-8">
    <h2 class="text-2xl font-bold mb-3">${_res.notFound?html}</h2>
    <p class="text-gray-600 mb-6">${_res.notFoundDescription?html}</p>
    <form method="post" action="${searchUrl?html}" class="flex flex-col sm:flex-row gap-3">
        <input type="search" name="key" value="${(key!'')?html}" aria-label="${_res.search?html}"
               placeholder="${_res.searchTip?html}" class="zr-field h-11 min-h-11 w-full sm:flex-1 px-4 text-sm"/>
        <button type="submit" class="h-11 rounded-lg bg-blue-600 px-5 text-sm font-semibold text-white">${_res.search?html}</button>
    </form>
</article>
