<aside class="zr-blog-sidebar space-y-6">
    <#-- 广告位 -->
    <#if _res.widgetAd?has_content>
        <div class="zr-panel zr-panel--tonal p-6">
            ${_res.widgetAd}
        </div>
    </#if>

    <#-- 搜索框 -->
    <form action="${searchUrl}" method="post" class="zr-panel zr-panel--tonal zr-blog-search p-6 space-y-4">
        <label for="blog-search" class="block text-title text-on-surface">${_res.search}</label>
        <div class="zr-search">
            <input
                    type="search" id="blog-search"
                    aria-label="${_res.search?html}"
                    name="key"
                    value="${(key!'')?html}"
                    placeholder="${_res.searchTip}"
                    class="min-w-0"
            />
            <button
                    type="submit"
                    class="zr-icon-button" aria-label="${_res.search?html}"
            ><i class="zr-icon text-lg" data-icon="search" aria-hidden="true"></i></button>
        </div>
    </form>

    <#-- 插件内容 -->
    <#if init.plugins?has_content>
        <#list init.plugins as plugin>
            <#if plugin.isSystem == false>
            <#-- 跳过非系统插件 -->
            <#else>
                <#switch plugin.pluginName>

                    <#case "types">
                        <div class="zr-panel zr-panel--tonal p-6">
                            <h3 class="text-title text-on-surface mb-3">${_res.category}</h3>
                            <ul class="space-y-2 text-sm text-on-surface-variant">
                                <#list init.types as type>
                                    <li>
                                        <a class="flex items-center justify-between zr-list-link" href="${type.url}">
                                            <span class="flex items-center gap-3"><i class="zr-icon text-lg text-on-surface-variant" data-icon="folder" aria-hidden="true"></i> ${type.typeName}</span>
                                            <span class="bg-surface-container-highest text-on-surface-variant text-xs px-2 py-0.5 rounded-full">${type.typeamount}</span>
                                        </a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                        <#break>

                    <#case "links">
                        <div class="zr-panel zr-panel--tonal p-6">
                            <h3 class="text-title text-on-surface mb-3">${_res.link}</h3>
                            <ul class="space-y-1 text-sm text-on-surface-variant">
                                <#list init.links as link>
                                    <li>
                                        <a class="flex items-center gap-3 zr-list-link" href="${link.url}" title="${link.alt}" target="_blank">
                                            <i class="zr-icon text-lg text-on-surface-variant" data-icon="link" aria-hidden="true"></i> ${link.linkName}
                                        </a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                        <#break>

                    <#case "archives">
                        <div class="zr-panel zr-panel--tonal p-6">
                            <h3 class="text-title text-on-surface mb-3">${_res.archive}</h3>
                            <ul id="archive-list" class="space-y-1 text-sm text-on-surface-variant">
                                <#list init.archiveList as archive>
                                    <li class="archive-item">
                                        <a class="flex items-center justify-between zr-list-link" href="${archive.url}" rel="nofollow">
                                            <span class="flex items-center gap-3"><i class="zr-icon text-lg text-on-surface-variant" data-icon="archive" aria-hidden="true"></i> ${archive.text}</span>
                                            <span class="bg-surface-container-highest text-on-surface-variant text-xs px-2 py-0.5 rounded-full">${archive.count}</span>
                                        </a>
                                    </li>
                                </#list>
                            </ul>
                            <div id="archive-more-btn-container" class="hidden mt-2">
                                <button id="archive-more-btn" class="zr-button zr-button--text w-full">
                                    ${_res.more}
                                </button>
                            </div>
                            <script>
                                (function() {
                                    const items = document.querySelectorAll('#archive-list .archive-item');
                                    const limit = 10;
                                    
                                    if (items.length > limit) {
                                        // Hide items beyond the limit
                                        for (let i = limit; i < items.length; i++) {
                                            items[i].classList.add('hidden');
                                        }
                                        
                                        // Show the button
                                        const btnContainer = document.getElementById('archive-more-btn-container');
                                        const btn = document.getElementById('archive-more-btn');
                                        btnContainer.classList.remove('hidden');
                                        
                                        btn.addEventListener('click', function() {
                                            const isExpanded = btn.getAttribute('data-expanded') === 'true';
                                            
                                            if (isExpanded) {
                                                // Collapse
                                                for (let i = limit; i < items.length; i++) {
                                                    items[i].classList.add('hidden');
                                                }
                                                btn.innerText = '${_res.more}';
                                                btn.setAttribute('data-expanded', 'false');
                                            } else {
                                                // Expand
                                                for (let i = limit; i < items.length; i++) {
                                                    items[i].classList.remove('hidden');
                                                }
                                                btn.innerText = '${_res.packUp}';
                                                btn.setAttribute('data-expanded', 'true');
                                            }
                                        });
                                    }
                                })();
                            </script>
                        </div>
                        <#break>

                    <#case "tags">
                        <div class="zr-panel zr-panel--tonal p-6">
                            <h3 class="text-title text-on-surface mb-3">${_res.tag}</h3>
                            <div class="flex flex-wrap gap-2">
                                <#list init.tags as tag>
                                    <a class="zr-chip" href="${tag.url}">
                                         ${tag.text}
                                    </a>
                                </#list>
                            </div>
                        </div>
                        <#break>

                </#switch>
            </#if>
        </#list>
    </#if>
</aside>
