<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xo="http://panax.io/xover" exclude-result-prefixes="xo">
  <xsl:template name="taxan-navbar">
    <xsl:param name="years"/>
        <nav aria-label="Filtros del reporte">
          <div class="taxan-years" role="group" aria-label="Años del reporte">
            <xsl:for-each select="$years">
              <xsl:sort select="@periodo" order="descending"/>
              <label><input type="checkbox" class="form-check-input" data-taxan-year="{@periodo}" checked="checked"/> <xsl:value-of select="@periodo"/></label>
            </xsl:for-each>
          </div>
</nav>
</xsl:template></xsl:stylesheet>