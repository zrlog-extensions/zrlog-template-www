# zrlog-template-www

独立的 ZrLog 内置主题资源 JAR，通过 Java ServiceLoader 注册，不属于主题市场索引。

Maven 坐标：`com.hibegin:zrlog-template-www:3.2`。主题 id 与包内路径保持 `template-www`、`include/templates/template-www/`。版本以 template.properties 为准。

先构建 zrlog-template-spi，再运行 `./mvnw verify` 或 `./mvnw install`。部署应用引入 JAR 即可发现主题，无需运行时下载或复制源码。

构建由 SPI 工具自动生成资源索引、Native Image resource-config.json 与 provider 构造器反射注册，勿手工维护资源清单。

发布到 Maven Central：配置现有 OSSRH_USERNAME、OSSRH_PASSWORD、GPG_PRIVATE_KEY、GPG_PASSPHRASE 后推送匹配版本的 tag。先发布 SPI，再发布主题。
