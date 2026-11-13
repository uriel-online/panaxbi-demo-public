<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xo="http://panax.io/xover" exclude-result-prefixes="xo">
  <xsl:template name="taxan-navbar">
    <xsl:param name="years"/>
    <xsl:param name="selected-year"/>
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
          <label for="taxan-year">Año</label>
  <select id="taxan-year" class="form-select form-select-sm" style="width:auto">
    <option value="all">Todos · 2023–2026</option>
    <xsl:for-each select="$years">
      <xsl:sort select="@periodo"/>
      <option value="{@periodo}">
        <xsl:if test="@periodo=$selected-year"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        <xsl:value-of select="@periodo"/><xsl:if test="@simulado='1'"> · Simulado</xsl:if>
      </option>
    </xsl:for-each>
  </select>
</nav>
</xsl:template></xsl:stylesheet>