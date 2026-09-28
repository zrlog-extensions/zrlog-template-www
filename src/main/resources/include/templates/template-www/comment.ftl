<#if log.canComment>
    <div id="comment" class="zr-panel mt-6 p-6 md:p-8 space-y-4">
        <plugin name="${website.comment_plugin_name}" view="widget" param="articleId=${log.logId}"/>
    </div>
</#if>
