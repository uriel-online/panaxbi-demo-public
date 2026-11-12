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
  <xsl:include href="keys_unidad.xslt"/>
  <xsl:output method="xml"
	   omit-xml-declaration="yes"
	   indent="yes"/>

  <xsl:template match="*[not(*)]|text()"/>
  <xsl:template match="/">
    <div class="offcanvas-body small">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="mantenibles">
    <div class="btn-group btn-group-sm" role="group" aria-label="Mantenibles"></div>
    <form class="" id="buscador">
      <div class="input-group">
        <input class="form-control me-2" type="search" placeholder="Buscar..." aria-label="Buscar..."/>
        <span class="input-group-append">
          <button class="btn btn-outline-secondary bg-white border-start-0 border rounded-pill ms-n3" type="button">
            <i class="fa fa-search"></i>
          </button>
        </span>
      </div>
      <select class="form-select xo-static" onchange="mostrarTracto(this)" multiple="" size="10">
        <optgroup label="Selecciona/deselecciona varios con ctrl + click"/>
        <option value=""/>
        <xsl:for-each select="(sucursal[key('unidad_negocios',string(@num))]/tracto|sucursal[key('unidad_negocios',string(@num))]/tracto/mantenible)">
          <xsl:sort select="." data-type="number" order="descending"/>
          <xsl:variable name="value" select="concat(substring(.,1,4),'-',substring(.,5))"/>
          <option value="{@num}" xo-scope="{@xo:id}" xo-attribute="state:active">
            <xsl:if test="key('visible',@xo:id)">
              <xsl:attribute name="selected"/>
            </xsl:if>
            <xsl:value-of select="@nom"/>
          </option>
        </xsl:for-each>
      </select>
    </form>
  </xsl:template>
</xsl:stylesheet>
