<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:js="http://panax.io/xover/javascript"
xmlns:session="http://panax.io/session"
xmlns:sitemap="http://panax.io/sitemap"
xmlns:shell="http://panax.io/shell"
xmlns:state="http://panax.io/state"
xmlns:x="http://panax.io/xover"
exclude-result-prefixes="#default session sitemap shell"
>
	<xsl:output method="xml"
	   omit-xml-declaration="yes"
	   indent="yes"/>

	<xsl:template match="text()"/>
	<xsl:param name="session:debug">false</xsl:param>
	<xsl:param name="js:cache_name">xover.session.cache_name.split('_').pop()</xsl:param>
	<xsl:key name="expanded" match="*[@state:expanded='true']" use="true()"/>

	<xsl:template match="sitemap">
		<div id="sitemap_horizontal" xo-section="#sitemap" xo-stylesheet="sitemap_horizontal.xslt">
			<xsl:apply-templates select="item[@state:active]"/>
		</div>
	</xsl:template>

	<xsl:template match="sitemap/item">
		<xsl:variable name="open">
			<xsl:if test="key('expanded',true())">open</xsl:if>
		</xsl:variable>
		<ul class="nav nav-tabs">
			<xsl:for-each select="item">
				<xsl:variable name="active">
					<xsl:if test="@state:active='true'">
						<xsl:text/>active<xsl:text/>
					</xsl:if>
				</xsl:variable>
				<li class="nav-item" onclick="scope.parentNode.$$('*/@state:active').remove(); scope.set('state:active','true');" xo-scope="{@x:id}">
					<a class="nav-link {$active}" aria-current="page" href="#" style="display:block">
						<xsl:if test="@target">
							<xsl:attribute name="href">
								<xsl:value-of select="@target"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="@title"/>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>

</xsl:stylesheet>
