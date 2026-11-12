<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xo="http://panax.io/xover"
  xmlns:sitemap="http://panax.io/sitemap"
  xmlns:state="http://panax.io/state"
  xmlns:layout="http://panax.io/layout/view/form"
  exclude-result-prefixes="xo xsl sitemap layout"
>
	<xsl:key name="item" match="item" use="'#any'"/>
	<xsl:key name="menu-item" match="item[item]" use="@xo:id"/>

	<xsl:key name="expanded" match="*[@state:expanded='true']" use="true()"/>

	<xsl:key name="hidden" match="fechas[count(fecha/@limit)&gt;1]/fecha[not(@limit) and not(preceding-sibling::fecha/@limit and following-sibling::fecha/@limit)]" use="@xo:id"/>
	<!--<xsl:key name="hidden" match="cuenta[@state:expanded='false']//cuenta" use="@xo:id"/>-->
	<xsl:key name="hidden" match="cuenta[starts-with(@num,'1')]" use="@xo:id"/>
	<xsl:key name="hidden" match="cuenta[starts-with(@num,'2')]" use="@xo:id"/>
	<xsl:key name="hidden" match="cuenta[starts-with(@num,'3')]" use="@xo:id"/>
	<xsl:key name="hidden" match="cuenta[starts-with(@num,'A')]" use="@xo:id"/>

	<xsl:key name="ventas" match="cuenta[starts-with(@num,'4')]" use="@xo:id"/>
	<xsl:key name="ingresos" match="cuenta[starts-with(@num,'4')]" use="@xo:id"/>
	<xsl:key name="costo_ventas" match="cuenta[starts-with(@num,'5')]" use="@xo:id"/>
	<xsl:key name="gastos" match="cuenta[starts-with(@num,'6')]" use="@xo:id"/>
	<xsl:key name="gastos_administrativos" match="cuenta[starts-with(@num,'6')]" use="@xo:id"/>
	<xsl:key name="otros_gastos" match="cuenta[starts-with(@num,'7')]" use="@xo:id"/>
	<xsl:key name="otros" match="cuenta[starts-with(@num,'8')]" use="@xo:id"/>
	<xsl:key name="orden" match="cuenta[starts-with(@num,'9')]" use="@xo:id"/>
	
	<xsl:key name="costo_financiamiento" match="cuenta[starts-with(@num,'71')]" use="@xo:id"/>
	<xsl:key name="depreciacion_amortizacion" match="cuenta[starts-with(@num,'73')]" use="@xo:id"/>

	<xsl:key name="month" match="@fecha" use="concat(../@xo:id , '::', .)"/>
	
	<xsl:key name="cuentas" match="cuenta" use="''"/>

	<!--<xsl:key name="expanded" match="cuentas/cuenta" use="@xo:id"/>
	<xsl:key name="expanded" match="cuentas/cuenta[@state:expanded='true']//cuenta" use="@xo:id"/>-->

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
	<xsl:key name="cuentas" match="cuenta" use="ancestor::*[9]/@num"/>
	<xsl:key name="polizas" match="polizas/poliza" use="''"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat('', '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@cta, '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n1 , '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n2 , '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n3 , '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n4 , '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n5 , '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n5 , '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n6 , '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n7 , '::', '')"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat('', '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@cta, '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n1 , '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n2 , '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n3 , '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n4 , '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n5 , '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n5 , '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n6 , '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza" use="concat(@n7 , '::', @fecha)"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat('', '::', substring(@fecha,1,4))"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat(@cta, '::', substring(@fecha,1,4))"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat(@n1 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat(@n2 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat(@n3 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat(@n4 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat(@n5 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat(@n5 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat(@n6 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="polizas" match="polizas/poliza[not(contains(@fecha,'~'))]" use="concat(@n7 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat('', '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat(@cta, '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat(@n1 , '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat(@n2 , '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat(@n3 , '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat(@n4 , '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat(@n5 , '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat(@n5 , '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat(@n6 , '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto" use="concat(@n7 , '::', @fecha)"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat('', '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat(@cta, '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat(@n1 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat(@n2 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat(@n3 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat(@n4 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat(@n5 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat(@n5 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat(@n6 , '::', substring(@fecha,1,4))"/>
	<xsl:key name="presupuestos" match="presupuesto/presupuesto[not(contains(@fecha,'~'))]" use="concat(@n7 , '::', substring(@fecha,1,4))"/>

	<xsl:key name="unidad_negocios" match="/model" use="''"/>
	<xsl:key name="unidad_negocios" match="unidades_negocio/unidad_negocio[@state:checked]" use="@id"/>
	<xsl:key name="unidad_negocios" match="unidades_negocio[not(unidad_negocio/@state:checked)]/unidad_negocio" use="@id"/>
	<!--<xsl:key name="unidad_negocios" match="unidades_negocio[not(unidad_negocio/@state:checked)]/unidad_negocio" use="''"/>-->	
	
	<xsl:key name="divisiones" match="divisiones/division[@state:checked]" use="@id"/>
	<xsl:key name="divisiones" match="divisiones[not(division/@state:checked)]/division" use="@id"/>

	<xsl:key name="divisiones" match="razones_sociales/razon_social[@state:checked]" use="@div"/>
	
	<xsl:key name="razones_sociales" match="razones_sociales/razon_social[@state:checked]" use="@id"/>
	<xsl:key name="razones_sociales" match="razones_sociales[not(razon_social/@state:checked)]/razon_social" use="@id"/>
	<xsl:key name="razones_sociales" match="mantenibles/sucursal[mantenible/@state:checked]" use="@num"/>
	<xsl:key name="razones_sociales" match="razones_sociales[not(razon_social/@state:checked)]/razon_social" use="''"/>
	
</xsl:stylesheet>