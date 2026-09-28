# zrlog-template-www

独立的 ZrLog 内置主题资源 JAR，通过 Java ServiceLoader 注册，不属于主题市场索引。

Maven 坐标：`com.hibegin:zrlog-template-www:3.3-SNAPSHOT`（开发版本）。主题 id 与包内路径保持 `template-www`、`include/templates/template-www/`。版本以 template.properties 为准。

先构建 zrlog-template-spi，再运行 `./mvnw verify` 或 `./mvnw install`。部署应用引入 JAR 即可发现主题，无需运行时下载或复制源码。

构建由 SPI 工具自动生成资源索引、Native Image resource-config.json 与 provider 构造器反射注册，勿手工维护资源清单。

发布到 Maven Central：配置现有 OSSRH_USERNAME、OSSRH_PASSWORD、GPG_PRIVATE_KEY、GPG_PASSPHRASE 后推送匹配版本的 tag。先发布 SPI，再发布主题。

## 公共 UI 与官网扩展

`zrlog-template-www` 是公共 UI 和数据格式的维护方，`zrlog-www` 是它的扩展消费者。视觉以新版官网为基准；官网将自己的路由、文案和内容适配为主题约定，不让博客主题迁就官网的数据结构。

公共源码位于 `src/main/resources/include/templates/template-www/`：

- `_site/header.ftl`：导航栏、移动菜单、暗色按钮；`header` 接收原生 `baseUrl`、`init`、`_res`，`logoUrl` 可选，默认 `${baseUrl}favicon.ico`。`beforeTheme`、`afterTheme`、`mobile` 三个 nested 插槽供官网添加语言、下载等操作。
- `_site/navigation.ftl`：直接使用 `init.logNavs` 的 `url / navName / icon / current`。不扩展官网专用导航字段，不维护第二套导航协议；语言切换和下载按钮放在 header 插槽中。
- `_site/footer.ftl`：`footer` 接收原生 `webSite` 和 `_res`，使用 `webSite.title / icp`、`_res.footerLinkExt / footerLink / backToTop`。现有页脚 HTML 配置继续有效。
- `_site/assets.ftl`：`head` 接收主题资源根路径 `url` 和 `_res`，统一字体图标、Tailwind 配置、基础样式和首次绘制前的暗色设置；主题色使用 `_res.colorPrimary`。
- `css/site-shell.css`、`js/site-theme.js`、`js/site-shell.js`：公共样式、暗色切换、移动菜单、焦点管理和返回顶部。配套的 `fonts/`、`js/tailwindcss-3.4.6.js` 一起分发。

`url` 始终表示主题静态资源根路径，`baseUrl` 表示站点首页地址。公共组件不读取官网的 `res / urlPrefix / request`，也不依赖官网域名。文章、评论、分页、SEO、统计及内容路由继续由各自页面处理。

官网开发与打包运行直接从 Maven 依赖 JAR 读取公共 FTL/CSS/JS，不复制到官网源码或开发静态目录。静态发布时按本主题的 `template.properties.staticResource` 和自动生成的资源索引导出文件，发布前逐个校验内容与版本；增加资源无需在官网另记文件清单。公共 UI 只在本仓库修改。更新本仓库后先执行 `./mvnw clean install`，再重启官网开发构建。正式发布时先发布新的主题正式版本，再升级官网依赖。

验证：`./mvnw clean verify` 覆盖原生博客数据、中英文列表与详情、子路径资源、主题设置和空导航；新增资源由索引器自动登记，资源变更还需验证 JVM JAR / Native Image。
