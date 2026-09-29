# 维护约定

- 产品表达读取 [Ops 产品文案规范](../zrlog-ops/docs/content-writing-guide.md)，语言资源与消费者集成见 README。
- UI 任务先读 [Ops UI 统一入口](../zrlog-ops/docs/ui-design-guide.md)，按其工程索引进入专项规范与验收契约；本地源码和预览方式见 [README](README.md)。
- 这是 zrlog-extensions 下的独立 Maven Central 制品，使用 Java 11。
- 主题源码和包内路径保持稳定，不复制回博客渲染工程；不登记主题市场。
- 原生主题版本与 template.properties 一致；Hexo 版本严格与 package.json 一致，保留上游来源、许可证与版权说明。
- SPI provider 与资源清单的变更必须通过 JVM JAR 和 Native Image 验证。生成资源索引与 native 元数据，不手工添加路径白名单。
- 发布前运行 ./mvnw clean verify，tag 必须与 pom.xml 一致；先发布公共 SPI，再发布依赖主题。
- Central 凭据通过现有 GitHub Secrets 注入，不提交 settings.xml 或签名密钥。
