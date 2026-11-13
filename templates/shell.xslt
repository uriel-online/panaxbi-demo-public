<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:shell="http://panax.io/shell"
  xmlns:portal="urn:panaxbi:portal"
  exclude-result-prefixes="shell portal">
  <xsl:include href="menu.xslt"/>

  <xsl:template match="/" priority="1">
    <section>
      <script src="/widgets/shell/sidebar-availability.js?v=1"/>
      <xsl:apply-templates select="*" mode="shell:widget"/>
    </section>
  </xsl:template>

  <xsl:template match="*" mode="shell:nav-title" priority="1">
    <header class="portal-shell-header">
        <div class="portal-shell-brand">
          <button type="button" class="menu_toggle" aria-label="Menú de reportes" aria-controls="sitemap" aria-expanded="false" aria-disabled="true" disabled="disabled" onclick="event.stopPropagation(); togglePortalSitemap()">&#9776;</button>
          <a href="/" title="Ir a la página principal"><img src="/assets/logo.png" alt="Panax BI"/></a>
        </div>
        <xsl:apply-templates mode="portal:title" select="."/>
        <xsl:call-template name="portal-menu"/>
      </header>
  </xsl:template>

  <xsl:template match="*" mode="portal:title">
    <div class="portal-shell-title" xo-store="#sitemap" xo-stylesheet="/title.xslt"/>
  </xsl:template>

  <xsl:template match="*" mode="shell:sitemap" priority="1">
    <aside id="sitemap" class="sidebar" xo-source="#sitemap" xo-stylesheet="/sitemap.xslt"/>
  </xsl:template>
</xsl:stylesheet>
