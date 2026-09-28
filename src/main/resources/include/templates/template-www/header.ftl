<!DOCTYPE html>
<html lang="${lang!''}">
<head>
    <#include "_common/meta.ftl">
    <#import "_site/assets.ftl" as shellAssets>
    <@shellAssets.head url=url _res=_res/>
    <link href="${url}/css/style.css" rel="stylesheet"/>
    <#include "_common/auto-hljs.ftl">
    ${globalStyle!''}
</head>
<body class="zr-site min-h-screen bg-white text-gray-900 dark:bg-black dark:text-gray-200">
<#import "_site/header.ftl" as shell>
<#assign headerResources = _res + {"navBarBrand": (_res.navBarBrand?has_content)?then(_res.navBarBrand, webSite.title!'')}>
<@shell.header baseUrl=baseUrl init=init _res=headerResources; slot>
    <#if slot == "beforeTheme" && (_res['githubLink']!'')?has_content>
        <div class="hidden items-center gap-3 md:flex">${_res['githubLink']}</div>
    <#elseif slot == "mobile">
        ${_res['githubLink']!''}
    </#if>
</@shell.header>
