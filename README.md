# zrlog-template-www

独立的 ZrLog 内置主题资源 JAR，通过 Java ServiceLoader 注册，不属于主题市场索引。

Maven 坐标：`com.hibegin:zrlog-template-www:4.0.1-SNAPSHOT`。主题 id 与包内路径保持 `template-www`、`include/templates/template-www/`。版本以 template.properties 为准。

先构建 zrlog-template-spi，再运行 `./mvnw verify` 或 `./mvnw install`。部署应用引入 JAR 即可发现主题，无需运行时下载或复制源码。

构建由 SPI 工具自动生成资源索引、Native Image resource-config.json 与 provider 构造器反射注册，勿手工维护资源清单。

快照发布：`main` 保持 `-SNAPSHOT` 版本，推送后先执行 `clean verify`，再通过现有 OSSRH_USERNAME / OSSRH_PASSWORD 发布至 `https://central.sonatype.com/repository/maven-snapshots/`。消费者需启用该快照仓库；需要重试时可手动运行同一 workflow。

正式发布到 Maven Central：配置现有 OSSRH_USERNAME、OSSRH_PASSWORD、GPG_PRIVATE_KEY、GPG_PASSPHRASE 后推送匹配正式版本的 tag。先发布 SPI，再发布主题；已发布的正式版本和 tag 不覆盖。

## 公共 UI 与官网扩展

UI 任务统一从 [Ops UI 总入口](../zrlog-ops/docs/ui-design-guide.md) 加载适用的规则与验收契约。本文维护公共组件、模板契约和开发预览细节。

产品控件表达读取 [Ops 产品文案规范](../zrlog-ops/docs/content-writing-guide.md)。主题自身资源位于 `src/main/resources/include/templates/template-www/language/i18n_zh_CN.properties` 与 `i18n_en_US.properties`，官网特有文案通过官网适配与插槽传入；消费者预览方式见下文。

`zrlog-template-www` 是公共 UI 和数据格式的维护方，`zrlog-www` 是它的扩展消费者。视觉按 Ops Material 3 规范实现；官网将自己的路由、文案和内容适配为主题约定，不让博客主题迁就官网的数据结构。

公共源码位于 `src/main/resources/include/templates/template-www/`：

- `_site/header.ftl`：导航栏、移动菜单、暗色按钮；`header` 接收原生 `baseUrl`、`init`、`_res`，`logoUrl` 可选，默认 `${baseUrl}favicon.ico`。`beforeTheme`、`afterTheme`、`mobile` 三个 nested 插槽供官网添加语言、下载等操作。
- `_site/navigation.ftl`：直接使用 `init.logNavs` 的 `url / navName / icon / current`。不扩展官网专用导航字段，不维护第二套导航协议；语言切换和下载按钮放在 header 插槽中。
- `_site/footer.ftl`：`footer` 接收原生 `webSite` 和 `_res`，使用 `webSite.title / icp`、`_res.footerLinkExt / footerLink / backToTop`。现有页脚 HTML 配置继续有效。
- `_site/assets.ftl`：`head` 接收主题资源根路径 `url` 和 `_res`，统一字体图标、Tailwind 配置、基础样式和首次绘制前的暗色设置；主题色使用 `_res.colorPrimary`。
- `_site/page-intro.ftl`：共用页面标题、简介、面包屑、元信息与操作插槽。默认使用 tonal 容器；传入 `tonal=false` 时使用与正文对齐的无底色标题区。官网适配其页面数据；博客直接传入站点、分类和文章字段。
- `css/site-shell.css`：统一 1200px 容器、16px / 24px 页面边距、导航、页脚与明暗色变量。`css/site-content.css`：页面标题、正文、代码、表格、卡片和输入控件；官网不再维护这些规则的副本。
- `js/site-theme.js`、`js/site-shell.js`：暗色切换（含正文语法高亮）、移动菜单、焦点管理和返回顶部。配套的 WOFF2 / WOFF 字体、`js/tailwindcss-3.4.6.js` 一起分发。

博客列表、详情、搜索、分页、侧栏和插件归档均使用这套样式。`css/style.css` 只补充博客列布局；正文不再加载旧 `editormd.css`。导航栏名称未配置时使用站点标题。主题色未配置时与官网默认值一致。

`url` 始终表示主题静态资源根路径，`baseUrl` 表示站点首页地址。公共组件不读取官网的 `res / urlPrefix / request`，也不依赖官网域名。文章、评论、分页、SEO、统计及内容路由继续由各自页面处理。

官网开发与打包运行直接从 Maven 依赖 JAR 读取公共 FTL/CSS/JS，不复制到官网源码或开发静态目录。静态发布时按本主题的 `template.properties.staticResource` 和自动生成的资源索引导出文件，发布前逐个校验内容与版本；增加资源无需在官网另记文件清单。公共 UI 只在本仓库修改。更新本仓库后先执行 `./mvnw clean install`，再重启官网开发构建。正式发布时先发布新的主题正式版本，再升级官网依赖。

验证：`./mvnw clean verify` 覆盖原生博客数据、中英文列表与详情、子路径资源、主题设置和空导航；新增资源由索引器自动登记，资源变更还需验证 JVM JAR / Native Image。

本地博客预览（使用同级 `templates` 工具的固定运行时与测试内容）：

```bash
cd ../templates
bin/theme preview ../zrlog-template-www/src/main/resources/include/templates/template-www --id template-www-review --port 7080
```

预览标识仅用于避免旧运行时内置的同名主题覆盖当前源码，制品的主题 id 不变。访问 `/`、`/writing-on-my-own-site`、`/all-2` 检查页面；源码的 FTL/CSS/JS 修改会同步，国际化和配置修改后需重启。用 `bin/theme smoke --base-url http://127.0.0.1:7080` 检查中英文路由与资源。视觉验收需同时检查官网和博客在桌面、手机、明暗模式下的容器对齐、正文溢出、菜单和主题切换。

## Tailwind M3 试点实现

`_site/assets.ftl` 扩展现有 Tailwind 3.4.6 配置，不增加组件库或另一套构建。布局继续使用 Tailwind；共享组件的形状与状态层在 `site-shell.css` / `site-content.css` 维护。

- 颜色工具类：`bg-surface` / `text-on-surface`、`bg-surface-container`、`bg-surface-container-high`、`bg-primary` / `text-on-primary`、`bg-primary-container` / `text-on-primary-container`、`text-on-surface-variant`、`text-link`、`border-outline` / `border-outline-variant`。前景和容器成对使用，无需给同一角色另外写 `dark:`。
- 排版与形状：`text-display`、`text-page-title`、`text-headline`、`text-title`、`text-label`；`rounded-card`、`rounded-button`、`rounded-field`、`rounded-chip`。页面标题卡片限制在 `--site-content-width` 内，使用 28–40px 响应式标题、24px 圆角及与正文分开的间距。阅读正文使用共享 `.zr-rich-text`，正文、导航标签和页面标题分别管理行高。
- 组件：`.zr-button` 配合 `--filled / --tonal / --outlined / --text`；`.zr-icon-button`、`.zr-chip`、`.zr-list-link`、`.zr-panel` 及 `--tonal / --outlined`。选中导航与分页使用 `aria-current`，主题按钮使用 `aria-pressed`；tonal / outlined / text 的 hover / pressed 状态层使用组件自身前景色，filled 使用确保标签可读的背景变化；键盘焦点单独描边。
- `site-theme.js` 参考 `zrlog-frontend-common/packages/ui/src/material-colors.ts` 的 sRGB 表面混色，生成当前品牌色的明暗角色。浅色 filled 背景精确保留配置主色（默认 `#1677ff`），浅色标签按本轮确认使用白色；hover / pressed 使用加深背景的状态反馈。正文链接使用独立校正后的 `text-link` / `--site-link`，不要把 `text-primary` 当作正文链接角色。深色主操作仍使用派生的浅色。它不依赖 React / Ant Design，也不是 HCT 动态配色算法。修改公共包配色规则时应对照此映射复核；现有 `--color-primary` 仍保存原始配置色。
- `--site-paper / --site-container / --site-soft / --site-tint / --site-ink / --site-muted` 等 CSS 变量是官网扩展的兼容接口。已有官网蓝色按钮和中性色工具类保留共享映射，官网特有内容布局继续由消费者维护。
- 保留原有 `theme` 偏好、系统主题监听、跨页切换、代码高亮与移动抽屉焦点管理；按钮点击区域至少 44px，并尊重减少动效设置。搜索保留可见标签，长文章标题和前后篇链接允许换行。

试点验收运行现有 Maven 渲染/制品检查，并按上面的真实博客预览及官网验收契约检查。未修改 SPI、资源路径或静态资源目录清单；不要把 JVM 验证当作完整 Native Image 验证。
