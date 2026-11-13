<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:session="http://panax.io/session"
  xmlns:sitemap="http://panax.io/sitemap"
  exclude-result-prefixes="session sitemap">
  <xsl:import href="../widgets/sitemap.xslt"/>
  <xsl:param name="session:user_login"/>

  <xsl:template match="sitemap" priority="2" mode="sitemap:widget">
    <li class="sitemap-toolbar">
      <button type="button" data-sitemap-close="" aria-label="Cerrar menú" onclick="this.dispatch('shell:sitemap', {{ open: false }})">&#215;</button>
    </li>
    <xsl:apply-templates select="item[not(@user) or @user=$session:user_login]" mode="sitemap:widget"/>
  </xsl:template>

  <xsl:template match="item[item]" priority="2" mode="sitemap:widget">
    <li class="sidebar-item menu">
      <details>
        <summary class="sidebar-link">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true">
            <rect x="3" y="3" width="18" height="18" rx="2"/>
            <path d="M3 9h18M9 9v12"/>
          </svg>
          <xsl:value-of select="@title"/>
        </summary>
        <ul class="sidebar-dropdown list-unstyled">
          <xsl:apply-templates select="item[not(@user) or @user=$session:user_login]" mode="sitemap:widget"/>
        </ul>
      </details>
    </li>
  </xsl:template>

  <xsl:template match="item[@target][not(item)]" priority="2" mode="sitemap:widget">
    <li class="sidebar-item">
      <a class="sidebar-link" href="{@target}"><xsl:value-of select="@title"/></a>
    </li>
  </xsl:template>
</xsl:stylesheet>
