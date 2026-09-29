<#if pager??>
    <nav aria-label="Pagination" class="zr-pagination mt-10 flex justify-center">
        <ul class="flex flex-wrap items-center justify-center gap-2 text-sm font-medium select-none">

            <#-- 首页按钮 -->
            <#if !pager.startPage>
                <li>
                    <a href="${pager.pageStartUrl}" title="${_res.pageStart}"
                       class="zr-button zr-button--outlined">
                        ${_res.pageStart}
                    </a>
                </li>
            </#if>

            <#-- 页码列表 -->
            <#list pager.pageList as page>
                <li>
                    <a href="${page.url}" <#if page.current>aria-current="page"</#if>
                       class="zr-button zr-button--text">
                        ${page.desc}
                    </a>
                </li>
            </#list>

            <#-- 末页按钮 -->
            <#if !pager.endPage>
                <li>
                    <a href="${pager.pageEndUrl}" title="${_res.pageEnd}"
                       class="zr-button zr-button--outlined">
                        ${_res.pageEnd}
                    </a>
                </li>
            </#if>

        </ul>
    </nav>
</#if>
