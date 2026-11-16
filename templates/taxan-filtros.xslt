<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xo="http://panax.io/xover" exclude-result-prefixes="xo">
  <xsl:template name="taxan-navbar">
    <xsl:param name="years"/>
    <xsl:param name="single-year" select="false()"/>
    <nav class="taxan-filters" aria-label="Filtros del reporte">
          <div class="taxan-years" aria-label="Años del reporte">
            <xsl:attribute name="role">
              <xsl:choose>
                <xsl:when test="$single-year">radiogroup</xsl:when>
                <xsl:otherwise>group</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:for-each select="$years">
              <xsl:sort select="@periodo" order="descending"/>
              <label>
                <xsl:choose>
                  <xsl:when test="$single-year">
                    <input type="radio" name="taxan-income-year" class="form-check-input" data-taxan-year="{@periodo}">
                      <xsl:if test="position() = 1"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
                    </input>
                  </xsl:when>
                  <xsl:otherwise>
                    <input type="checkbox" class="form-check-input" data-taxan-year="{@periodo}" checked="checked"/>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text><xsl:value-of select="@periodo"/>
              </label>
            </xsl:for-each>
          </div>
      <p class="taxan-data-note text-muted">Los datos pueden ser simulados.</p>
    </nav>
</xsl:template></xsl:stylesheet>
