<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xo="http://panax.io/xover"
  xmlns:sitemap="http://panax.io/sitemap"
  xmlns:state="http://panax.io/state"
  xmlns:layout="http://panax.io/layout/view/form"
  exclude-result-prefixes="xo xsl sitemap layout"
>
	<xsl:key name="activo_circulante" match="polizas/poliza[starts-with(@cl,'1CCC')]" use="@xo:id"/>
	<xsl:key name="activo_circulante" match="polizas/poliza[starts-with(@cl,'1CXX')]" use="@xo:id"/>
	<xsl:key name="activo_circulante" match="polizas/poliza[starts-with(@cl,'1CIC')]" use="@xo:id"/>
	<xsl:key name="activo_circulante" match="polizas/poliza[starts-with(@cl,'1CIV')]" use="@xo:id"/>
	<xsl:key name="activo_circulante" match="polizas/poliza[starts-with(@cl,'1CIM')]" use="@xo:id"/>
	<xsl:key name="activo_circulante" match="polizas/poliza[starts-with(@cl,'1CAP')]" use="@xo:id"/>
  <xsl:key name="activo_circulante" match="polizas/poliza[starts-with(@cl,'1CFI')]" use="@xo:id"/>
  <xsl:key name="activo_circulante" match="polizas/poliza[starts-with(@cl,'1COA')]" use="@xo:id"/>

	<xsl:key name="activo_circulante_cc" match="polizas/poliza[starts-with(@cl,'1CCC')]" use="@xo:id"/>
	<xsl:key name="activo_circulante_ic" match="polizas/poliza[starts-with(@cl,'1CXX')]" use="@xo:id"/>
	<xsl:key name="activo_circulante_ic" match="polizas/poliza[starts-with(@cl,'1CIC')]" use="@xo:id"/>
	<xsl:key name="activo_circulante_iv" match="polizas/poliza[starts-with(@cl,'1CIV')]" use="@xo:id"/>
	<xsl:key name="activo_circulante_im" match="polizas/poliza[starts-with(@cl,'1CIM')]" use="@xo:id"/>
	<xsl:key name="activo_circulante_ap" match="polizas/poliza[starts-with(@cl,'1CAP')]" use="@xo:id"/>
  <xsl:key name="activo_circulante_fi" match="polizas/poliza[starts-with(@cl,'1CFI')]" use="@xo:id"/>
  <xsl:key name="activo_circulante_oa" match="polizas/poliza[starts-with(@cl,'1COA')]" use="@xo:id"/>
	<xsl:key name="activo_circulante_sc" match="polizas/poliza[starts-with(@cl,'1C??')]" use="@xo:id"/>

	<xsl:key name="activo_fijo" match="polizas/poliza[starts-with(@cl,'1F')]" use="@xo:id"/>

	<xsl:key name="pasivo_circulante" match="polizas/poliza[starts-with(@cl,'2CIC')]" use="@xo:id"/>
	<xsl:key name="pasivo_circulante" match="polizas/poliza[starts-with(@cl,'2CCP')]" use="@xo:id"/>
	<xsl:key name="pasivo_circulante" match="polizas/poliza[starts-with(@cl,'2CIM')]" use="@xo:id"/>
	<xsl:key name="pasivo_circulante" match="polizas/poliza[starts-with(@cl,'2CAC')]" use="@xo:id"/>
	<xsl:key name="pasivo_circulante" match="polizas/poliza[starts-with(@cl,'2COP')]" use="@xo:id"/>

	<xsl:key name="pasivo_circulante_ic" match="polizas/poliza[starts-with(@cl,'2CIC')]" use="@xo:id"/>
	<xsl:key name="pasivo_circulante_cp" match="polizas/poliza[starts-with(@cl,'2CCP')]" use="@xo:id"/>
	<xsl:key name="pasivo_circulante_im" match="polizas/poliza[starts-with(@cl,'2CIM')]" use="@xo:id"/>
	<xsl:key name="pasivo_circulante_ac" match="polizas/poliza[starts-with(@cl,'2CAC')]" use="@xo:id"/>
	<xsl:key name="pasivo_circulante_op" match="polizas/poliza[starts-with(@cl,'2COP')]" use="@xo:id"/>

	<xsl:key name="cash_balance" match="polizas/poliza[starts-with(@cl,'1CB')]" use="@xo:id"/>
	<xsl:key name="pasivo_largo_plazo" match="polizas/poliza[starts-with(@cl,'2L')]" use="@xo:id"/>
	<xsl:key name="capital" match="polizas/poliza[starts-with(@cl,'3C')]" use="@xo:id"/>
	<xsl:key name="activo_diferido" match="polizas/poliza[contains(concat(@cl,'$'),'DF')]" use="@xo:id"/>
	<xsl:key name="otras_amortizaciones" match="polizas/poliza[contains(concat(@cl,'$'),'AO$')]" use="@xo:id"/>
  <xsl:key name="otras_amortizaciones" match="polizas/poliza[contains(@cl,'Z')]" use="@xo:id"/>
  <xsl:key name="devoluciones" match="polizas/poliza[contains(concat(@cl,'$'),'DV$')]" use="@xo:id"/>

	<xsl:key name="ingresos" match="polizas/poliza[starts-with(@cl,'4')]" use="@xo:id"/>
	<xsl:key name="costo_ventas" match="polizas/poliza[starts-with(@cl,'5')]" use="@xo:id"/>
	<xsl:key name="costo_ventas_cd" match="polizas/poliza[starts-with(@cl,'5D')]" use="@xo:id"/>
	<xsl:key name="gastos_admon" match="polizas/poliza[starts-with(@cl,'6A')]" use="@xo:id"/>
	<xsl:key name="gastos_vtas" match="polizas/poliza[starts-with(@cl,'6V')]" use="@xo:id"/>

	<xsl:key name="cta_ingresos_vt" match="polizas/poliza[starts-with(@cl,'4')]" use="concat(../@rs,':',@cta)"/>
	<xsl:key name="cta_ingresos_vt" match="polizas/poliza[starts-with(@cl,'4')]" use="concat(../@rs,':',@n1)"/>
	<xsl:key name="cta_ingresos_vt" match="polizas/poliza[starts-with(@cl,'4')]" use="concat(../@rs,':',@n2)"/>
	<xsl:key name="cta_ingresos_vt" match="polizas/poliza[starts-with(@cl,'4')]" use="concat(../@rs,':',@n3)"/>
	<xsl:key name="cta_ingresos_vt" match="polizas/poliza[starts-with(@cl,'4')]" use="concat(../@rs,':',@n4)"/>
	<xsl:key name="cta_ingresos_vt" match="polizas/poliza[starts-with(@cl,'4')]" use="concat(../@rs,':',@n5)"/>
	<xsl:key name="cta_ingresos_vt" match="polizas/poliza[starts-with(@cl,'4')]" use="concat(../@rs,':',@n6)"/>

	<xsl:key name="cta_costo_ventas_cd" match="polizas/poliza[starts-with(@cl,'5D')]" use="concat(../@rs,':',@cta)"/>
	<xsl:key name="cta_costo_ventas_cd" match="polizas/poliza[starts-with(@cl,'5D')]" use="concat(../@rs,':',@n1)"/>
	<xsl:key name="cta_costo_ventas_cd" match="polizas/poliza[starts-with(@cl,'5D')]" use="concat(../@rs,':',@n2)"/>
	<xsl:key name="cta_costo_ventas_cd" match="polizas/poliza[starts-with(@cl,'5D')]" use="concat(../@rs,':',@n3)"/>
	<xsl:key name="cta_costo_ventas_cd" match="polizas/poliza[starts-with(@cl,'5D')]" use="concat(../@rs,':',@n4)"/>
	<xsl:key name="cta_costo_ventas_cd" match="polizas/poliza[starts-with(@cl,'5D')]" use="concat(../@rs,':',@n5)"/>
	<xsl:key name="cta_costo_ventas_cd" match="polizas/poliza[starts-with(@cl,'5D')]" use="concat(../@rs,':',@n6)"/>

	<!--<xsl:key name="cta_gastos_vt" match="polizas/poliza[starts-with(@cl,'6V')]" use="concat(../@rs,':',@n3)"/>-->

	<xsl:key name="cta_costo_ventas_ci" match="polizas/poliza[starts-with(@cl,'5I')]" use="concat(../@rs,':',@cta)"/>
	<xsl:key name="cta_costo_ventas_ci" match="polizas/poliza[starts-with(@cl,'5I')]" use="concat(../@rs,':',@n1)"/>
	<xsl:key name="cta_costo_ventas_ci" match="polizas/poliza[starts-with(@cl,'5I')]" use="concat(../@rs,':',@n2)"/>
	<xsl:key name="cta_costo_ventas_ci" match="polizas/poliza[starts-with(@cl,'5I')]" use="concat(../@rs,':',@n3)"/>
	<xsl:key name="cta_costo_ventas_ci" match="polizas/poliza[starts-with(@cl,'5I')]" use="concat(../@rs,':',@n4)"/>
	<xsl:key name="cta_costo_ventas_ci" match="polizas/poliza[starts-with(@cl,'5I')]" use="concat(../@rs,':',@n5)"/>
	<xsl:key name="cta_costo_ventas_ci" match="polizas/poliza[starts-with(@cl,'5I')]" use="concat(../@rs,':',@n6)"/>
</xsl:stylesheet>