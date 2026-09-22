package com.zrlog.theme.bundled;
import com.zrlog.theme.spi.*;
import org.junit.Test;
import static org.junit.Assert.*;
import java.util.*;
import java.nio.charset.StandardCharsets;
public class ThemeArtifactTest {
 @Test public void providerAndResourcesAreDiscoverable() throws Exception {
  BundledThemes registry = BundledThemes.load(getClass().getClassLoader());
  assertTrue(registry.contains("/include/templates/template-www"));
  assertFalse(registry.resources().isEmpty());
  for (String resource : registry.resources()) assertNotNull(resource, getClass().getClassLoader().getResource(resource));
  Properties meta = new Properties(); meta.load(getClass().getResourceAsStream("/include/templates/template-www/template.properties")); assertEquals(System.getProperty("artifact.version"), meta.getProperty("version"));
 }
}
