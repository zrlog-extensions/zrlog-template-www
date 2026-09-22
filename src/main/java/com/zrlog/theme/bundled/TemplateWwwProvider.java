package com.zrlog.theme.bundled;
import com.zrlog.theme.spi.BundledThemeProvider;
/** Registers the template-www resources bundled in this JAR. */
public final class TemplateWwwProvider implements BundledThemeProvider {
 public String id() { return "template-www"; }
 public String engine() { return "freemarker"; }
 public String adapter() { return ""; }
 public boolean isDefault() { return false; }
}
