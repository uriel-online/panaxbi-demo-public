<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xo="http://panax.io/xover"
  xmlns:sitemap="http://panax.io/sitemap"
  xmlns:state="http://panax.io/state"
  xmlns:layout="http://panax.io/layout/view/form"
  exclude-result-prefixes="xo xsl sitemap layout"
>
  <xsl:key name="hidden" match="fechas[count(fecha/@limit)&gt;1]/fecha[not(@limit or string-length(@mes)=4) and not(preceding-sibling::fecha/@limit and following-sibling::fecha/@limit)]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[@state:expanded='false']//cuenta" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'1')]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'2')]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'3')]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'9')]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'A')]" use="@xo:id"/>

  <xsl:key name="hidden" match="cuenta[starts-with(@num,'A')]" use="@xo:id"/>

  <xsl:key name="visible" match="mantenibles/sucursal/tracto[@state:active]" use="@xo:id"/>
  <xsl:key name="visible" match="mantenibles/sucursal/tracto[@state:active]/mantenible[@state:checked]" use="@xo:id"/>
  <xsl:key name="visible" match="mantenibles/sucursal/tracto/mantenible[@state:active]" use="@xo:id"/>

  <xsl:key name="ventas" match="cuenta[starts-with(@num,'4')]" use="@xo:id"/>
  <xsl:key name="costo_ventas" match="cuenta[starts-with(@num,'5')]" use="@xo:id"/>
  <xsl:key name="gastos" match="cuenta[starts-with(@num,'6')]" use="@xo:id"/>
  <xsl:key name="otros_gastos" match="cuenta[starts-with(@num,'7')]" use="@xo:id"/>
  <xsl:key name="otros" match="cuenta[starts-with(@num,'8')]" use="@xo:id"/>
  <xsl:key name="orden" match="cuenta[starts-with(@num,'9')]" use="@xo:id"/>

  <!--<xsl:key name="visible" match="cuenta[@n&lt;=ancestor::cuentas/@state:expanded]" use="@xo:id"/>
	<xsl:key name="visible" match="cuentas/cuenta" use="@xo:id"/>
	<xsl:key name="visible" match="cuenta[descendant-or-self::*[@state:expanded='true']]" use="@xo:id"/>
	<xsl:key name="visible" match="cuenta[@state:expanded='true']/cuenta" use="@xo:id"/>-->

  <xsl:key name="cuentas" match="cuenta" use="''"/>
  <xsl:key name="cuentas" match="cuenta" use="@num"/>
  <xsl:key name="cuentas" match="cuenta" use="ancestor::*[1]/@num"/>
  <xsl:key name="cuentas" match="cuenta" use="ancestor::*[2]/@num"/>
  <xsl:key name="cuentas" match="cuenta" use="ancestor::*[3]/@num"/>
  <xsl:key name="cuentas" match="cuenta" use="ancestor::*[4]/@num"/>
  <xsl:key name="cuentas" match="cuenta" use="ancestor::*[5]/@num"/>
  <xsl:key name="cuentas" match="cuenta" use="ancestor::*[6]/@num"/>
  <xsl:key name="cuentas" match="cuenta" use="ancestor::*[7]/@num"/>
  <xsl:key name="cuentas" match="cuenta" use="ancestor::*[8]/@num"/>
  <xsl:key name="polizas" match="poliza" use="''"/>
  <xsl:key name="polizas" match="poliza" use="@cta"/>
  <xsl:key name="polizas" match="poliza" use="@n1"/>
  <xsl:key name="polizas" match="poliza" use="@n2"/>
  <xsl:key name="polizas" match="poliza" use="@n3"/>
  <xsl:key name="polizas" match="poliza" use="@n4"/>
  <xsl:key name="polizas" match="poliza" use="@n5"/>
  <xsl:key name="polizas" match="poliza" use="@n5"/>
  <xsl:key name="polizas" match="poliza" use="@n6"/>
  <xsl:key name="polizas" match="poliza" use="@n7"/>

  <xsl:key name="month" match="@fecha" use="concat(../@xo:id , '::', .)"/>
  <xsl:key name="month" match="@fecha" use="concat(../@xo:id , '::', substring(.,1,4))"/>

  <xsl:key name="unidad_negocios" match="/model" use="''"/>
  <xsl:key name="unidad_negocios" match="unidades_negocio/unidad_negocio[@state:checked]" use="@id"/>
  <xsl:key name="unidad_negocios" match="unidades_negocio[not(unidad_negocio/@state:checked)]/unidad_negocio" use="@id"/>
  <xsl:key name="unidad_negocios" match="mantenibles/sucursal[mantenible/@state:checked]" use="@num"/>
  <xsl:key name="unidad_negocios" match="unidades_negocio[not(unidad_negocio/@state:checked)]/unidad_negocio" use="''"/>

  <xsl:key name="razones_sociales" match="razones_sociales/razon_social[@state:checked]" use="@id"/>
  <xsl:key name="razones_sociales" match="razones_sociales[not(razon_social/@state:checked)]/razon_social" use="@id"/>
  <xsl:key name="razones_sociales" match="mantenibles/sucursal[mantenible/@state:checked]" use="@num"/>
  <xsl:key name="razones_sociales" match="razones_sociales[not(razon_social/@state:checked)]/razon_social" use="''"/>

  <xsl:key name="tracto" match="mantenibles/sucursal/tracto[@state:checked]" use="@num"/>
  <xsl:key name="tracto" match="mantenibles/sucursal/tracto/mantenible[@state:checked]" use="@num"/>
  <xsl:key name="tracto" match="mantenibles[not(.//@state:checked)]/sucursal/tracto[@num=../../@state:active]" use="@num"/>
  <xsl:key name="tracto" match="mantenibles[not(.//@state:checked)]/sucursal/tracto[@num=../../@state:active]/mantenible" use="@num"/>
</xsl:stylesheet>