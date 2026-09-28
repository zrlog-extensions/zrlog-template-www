<#include "header.ftl">
<link rel="stylesheet" href="${url}/css/arrange.css">
<section class="zr-page zr-blog">
    <div class="container zr-blog-content">
        <div class="zr-panel p-6 md:p-8">
        <plugin name="${arrangePlugin}" view="${reqUriPath}" param="${reqQueryString}"/>
        </div>
    </div>
</section>
<#include "footer.ftl">
