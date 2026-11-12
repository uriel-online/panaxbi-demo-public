<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:xo="http://panax.io/xover"
xmlns:px="http://panax.io/entity"
xmlns:data="http://panax.io/source"
xmlns:state="http://panax.io/state"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
exclude-result-prefixes="#default xsl px xsi xo data state"
>
	<xsl:output method="xml"
	   omit-xml-declaration="yes"
	   indent="yes"/>
	<xsl:param name="state:checked"/>

	<xsl:key name="divisiones" match="divisiones/division[@state:checked]" use="@id"/>
	<xsl:key name="divisiones" match="divisiones[not(division/@state:checked)]/division" use="@id"/>

	<xsl:template match="*[not(*)]|text()"/>

	<xsl:template match="cuentas">
		<div class="btn-group btn-group-sm" role="group" aria-label="División">
			<xsl:for-each select="../divisiones/division">
				<xsl:variable name="division" select="@id"/>
				<fieldset>
					<legend style="cursor:pointer" xo-scope="{@xo:id}" xo-attribute="state:checked" onclick="scope.parentNode.$$('../*/@state:checked|ancestor::model/unidades_negocio/*/@state:checked|ancestor::model/razones_sociales/*/@state:checked').remove(); scope.set('true');">
						<xsl:variable name="style">
							<xsl:if test="@state:checked='true'">
								<xsl:text>active</xsl:text>
							</xsl:if>
						</xsl:variable>
						<!--<button type="button" class="btn btn-outline-secondary {$style}" xo-scope="{@xo:id}" xo-attribute="state:checked" onclick="scope.parentNode.$$('../*/@state:checked|../../razones_sociales/*/@state:checked').remove(); scope.set('true');">-->
						<xsl:choose>
							<xsl:when test="@state:checked='true'">
								<!--<xsl:attribute name="onclick">scope.remove()</xsl:attribute>-->
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-square" viewBox="0 0 16 16" style="margin-right: 5pt" onclick="scope.remove(); event.stopPropagation(); return false">
									<path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
									<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
								</svg>
							</xsl:when>
							<xsl:otherwise>
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-square" viewBox="0 0 16 16" style="margin-right: 5pt" onclick="scope.set('true'); event.stopPropagation(); return false;">
									<path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
								</svg>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:value-of select="@nom"/>
						<!--</button>-->
					</legend>
					<xsl:for-each select="../../razones_sociales[*[2]]/*[@div=$division]">
						<xsl:variable name="style">
							<xsl:if test="@state:checked='true'">
								<xsl:text>active</xsl:text>
							</xsl:if>
						</xsl:variable>
						<button type="button" class="btn btn-outline-secondary {$style}" xo-scope="{@xo:id}" xo-attribute="state:checked" onclick="scope.parentNode.$$('../*/@state:checked|ancestor::model/unidades_negocio/*/@state:checked').remove(); scope.set('true');">
							<xsl:choose>
								<xsl:when test="@state:checked='true'">
									<xsl:attribute name="onclick">scope.remove()</xsl:attribute>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-square" viewBox="0 0 16 16" style="margin-right: 5pt" onclick="scope.remove(); event.stopPropagation(); return false">
										<path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
										<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"/>
									</svg>
								</xsl:when>
								<xsl:otherwise>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-square" viewBox="0 0 16 16" style="margin-right: 5pt" onclick="scope.set('true'); event.stopPropagation(); return false;">
										<path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
									</svg>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:value-of select="@nom"/>
						</button>
					</xsl:for-each>
				</fieldset>
			</xsl:for-each>
		</div>
	</xsl:template>
</xsl:stylesheet>
