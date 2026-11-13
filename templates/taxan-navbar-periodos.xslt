<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xo="http://panax.io/xover" exclude-result-prefixes="xo">
  <xsl:template name="taxan-navbar">
    <xsl:param name="years"/>
        <nav aria-label="Financial statements">
          <a href="#taxan/income-mxn">
            <xsl:if test="@id='income-mxn'">
              <xsl:attribute name="aria-current">page</xsl:attribute>
            </xsl:if>
            <xsl:text>Income Statement MXN</xsl:text>
          </a>
          <a href="#taxan/income-usd">
            <xsl:if test="@id='income-usd'">
              <xsl:attribute name="aria-current">page</xsl:attribute>
            </xsl:if>
            <xsl:text>Income Statement USD</xsl:text>
          </a>
          <a href="#taxan/balance-mxn">
            <xsl:if test="@id='balance-mxn'">
              <xsl:attribute name="aria-current">page</xsl:attribute>
            </xsl:if>
            <xsl:text>Balance Sheet MXN</xsl:text>
          </a>
          <a href="#taxan/balance-usd">
            <xsl:if test="@id='balance-usd'">
              <xsl:attribute name="aria-current">page</xsl:attribute>
            </xsl:if>
            <xsl:text>Balance Sheet USD</xsl:text>
          </a>
          <div class="taxan-years" role="group" aria-label="Años del reporte">
            <xsl:for-each select="$years">
              <xsl:sort select="@periodo" order="descending"/>
              <label><input type="checkbox" class="form-check-input" data-taxan-year="{@periodo}" checked="checked"/> <xsl:value-of select="@periodo"/></label>
            </xsl:for-each>
          </div>
</nav>
</xsl:template></xsl:stylesheet>