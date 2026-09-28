<#-- Exactly the native init.logNavs / LogNavDTO presentation fields. -->
<#macro navigation logNavs>
    <#list logNavs as lognav>
        <li>
            <a href="${lognav.url?html}" class="zr-nav-link" <#if lognav.current!false>aria-current="page"</#if>>
                <#if lognav.icon?has_content><i class="${lognav.icon?html}" aria-hidden="true"></i></#if>
                <span>${lognav.navName?html}</span>
            </a>
        </li>
    </#list>
</#macro>
