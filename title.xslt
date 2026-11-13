<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:js="http://panax.io/xover/javascript"
xmlns:site="http://panax.io/site"
xmlns:state="http://panax.io/state"
xmlns:px="http://panax.io/entity"
exclude-result-prefixes="#default xsl px site"
>
	<xsl:import href="widgets/title.xslt"/>
  <xsl:output method="xml"
	   omit-xml-declaration="yes"
	   indent="yes"/>
	<xsl:param name="site:seed" select="&apos;&apos;"/>

	<xsl:variable name="route" select="substring-before(concat($site:seed, &apos;?&apos;), &apos;?&apos;)"/>
	<xsl:template match="/" priority="2">
		<h1>
			<xsl:choose>
				<xsl:when test="key('title', $route)"><xsl:value-of select="key('title', $route)"/></xsl:when>
				<xsl:otherwise>Panax BI</xsl:otherwise>
			</xsl:choose>
		</h1>
	</xsl:template>
</xsl:stylesheet>
