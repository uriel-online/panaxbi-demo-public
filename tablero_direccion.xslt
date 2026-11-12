<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:js="http://panax.io/xover/javascript"
xmlns:session="http://panax.io/session"
xmlns:sitemap="http://panax.io/sitemap"
xmlns:shell="http://panax.io/shell"
xmlns:state="http://panax.io/state"
xmlns:xo="http://panax.io/xover"
xmlns:v="urn:schemas-microsoft-com:vml"
exclude-result-prefixes="#default session sitemap shell"
>
  <xsl:output method="xml"
	   omit-xml-declaration="yes"
	   indent="yes"/>
  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

  <xsl:template match="text()"/>
  <xsl:param name="session:debug">false</xsl:param>
  <xsl:param name="js:cache_name">xover.session.cache_name.split('_').pop()</xsl:param>
  <xsl:key name="expanded" match="*[@state:expanded='true']" use="true()"/>

  <xsl:key name="hidden" match="fechas[count(fecha/@limit)&gt;1]/fecha[not(@limit) and not(preceding-sibling::fecha/@limit and following-sibling::fecha/@limit)]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[@state:expanded='false']//cuenta" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'1')]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'2')]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'3')]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'9')]" use="@xo:id"/>
  <xsl:key name="hidden" match="cuenta[starts-with(@num,'A')]" use="@xo:id"/>

  <xsl:key name="hidden" match="cuenta[starts-with(@num,'A')]" use="@xo:id"/>

  <xsl:key name="ventas" match="cuenta[starts-with(@num,'4')]" use="@xo:id"/>
  <xsl:key name="costo_ventas" match="cuenta[starts-with(@num,'5')]" use="@xo:id"/>
  <xsl:key name="gastos" match="cuenta[starts-with(@num,'6')]" use="@xo:id"/>
  <xsl:key name="otros_gastos" match="cuenta[starts-with(@num,'7')]" use="@xo:id"/>
  <xsl:key name="otros" match="cuenta[starts-with(@num,'8')]" use="@xo:id"/>
  <xsl:key name="gastos_administrativos" match="cuenta[starts-with(@num,'6')]" use="@xo:id"/>


  <xsl:key name="expanded" match="cuentas/cuenta" use="@xo:id"/>
  <xsl:key name="expanded" match="cuenta[descendant-or-self::*[@state:expanded='true']]" use="@xo:id"/>
  <xsl:key name="expanded" match="cuenta[@state:expanded='true']/cuenta" use="@xo:id"/>

  <xsl:key name="cuentas" match="cuenta" use="''"/>
  <xsl:key name="cuentas" match="cuenta" use="@num"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'01')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'02')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'03')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'04')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'05')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'06')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'07')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'08')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'09')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='01']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'02')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'03')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'04')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'05')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'06')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'07')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'08')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'09')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='02']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'03')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'04')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'05')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'06')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'07')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'08')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'09')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='03']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='04']" use="concat(../@xo:id,'::', substring(.,1,4),'04')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='04']" use="concat(../@xo:id,'::', substring(.,1,4),'05')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='04']" use="concat(../@xo:id,'::', substring(.,1,4),'06')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='04']" use="concat(../@xo:id,'::', substring(.,1,4),'07')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='04']" use="concat(../@xo:id,'::', substring(.,1,4),'08')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='04']" use="concat(../@xo:id,'::', substring(.,1,4),'09')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='04']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='04']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='04']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='05']" use="concat(../@xo:id,'::', substring(.,1,4),'05')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='05']" use="concat(../@xo:id,'::', substring(.,1,4),'06')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='05']" use="concat(../@xo:id,'::', substring(.,1,4),'07')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='05']" use="concat(../@xo:id,'::', substring(.,1,4),'08')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='05']" use="concat(../@xo:id,'::', substring(.,1,4),'09')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='05']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='05']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='05']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='06']" use="concat(../@xo:id,'::', substring(.,1,4),'06')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='06']" use="concat(../@xo:id,'::', substring(.,1,4),'07')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='06']" use="concat(../@xo:id,'::', substring(.,1,4),'08')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='06']" use="concat(../@xo:id,'::', substring(.,1,4),'09')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='06']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='06']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='06']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='07']" use="concat(../@xo:id,'::', substring(.,1,4),'07')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='07']" use="concat(../@xo:id,'::', substring(.,1,4),'08')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='07']" use="concat(../@xo:id,'::', substring(.,1,4),'09')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='07']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='07']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='07']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='08']" use="concat(../@xo:id,'::', substring(.,1,4),'08')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='08']" use="concat(../@xo:id,'::', substring(.,1,4),'09')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='08']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='08']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='08']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='09']" use="concat(../@xo:id,'::', substring(.,1,4),'09')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='09']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='09']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='09']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='10']" use="concat(../@xo:id,'::', substring(.,1,4),'10')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='10']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='10']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='11']" use="concat(../@xo:id,'::', substring(.,1,4),'11')"/>
  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='11']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="ytd" match="@fecha[substring(.,5,2)='12']" use="concat(../@xo:id,'::', substring(.,1,4),'12')"/>

  <xsl:key name="month" match="@fecha" use="concat(../@xo:id , '::', .)"/>

  <xsl:key name="polizas" match="poliza" use="''"/>
  <xsl:key name="polizas" match="poliza" use="@cta"/>
  <xsl:key name="polizas" match="poliza" use="@n1 "/>
  <xsl:key name="polizas" match="poliza" use="@n2 "/>
  <xsl:key name="polizas" match="poliza" use="@n3 "/>
  <xsl:key name="polizas" match="poliza" use="@n4 "/>
  <xsl:key name="polizas" match="poliza" use="@n5 "/>
  <xsl:key name="polizas" match="poliza" use="@n5 "/>
  <xsl:key name="polizas" match="poliza" use="@n6 "/>
  <xsl:key name="polizas" match="poliza" use="@n7 "/>
  <xsl:key name="presupuestos" match="presupuesto" use="''"/>
  <xsl:key name="presupuestos" match="presupuesto" use="@cta"/>
  <xsl:key name="presupuestos" match="presupuesto" use="@n1 "/>
  <xsl:key name="presupuestos" match="presupuesto" use="@n2 "/>
  <xsl:key name="presupuestos" match="presupuesto" use="@n3 "/>
  <xsl:key name="presupuestos" match="presupuesto" use="@n4 "/>
  <xsl:key name="presupuestos" match="presupuesto" use="@n5 "/>
  <xsl:key name="presupuestos" match="presupuesto" use="@n5 "/>
  <xsl:key name="presupuestos" match="presupuesto" use="@n6 "/>
  <xsl:key name="presupuestos" match="presupuesto" use="@n7 "/>
  <xsl:key name="viajes" match="viaje" use="''"/>
  <xsl:key name="viajes" match="viaje" use="@un"/>
  <xsl:key name="rendimientos" match="rendimiento" use="''"/>
  <xsl:key name="rendimientos" match="rendimiento" use="@un"/>

  <xsl:key name="unidad_negocios" match="unidades_negocio/unidad_negocio[@state:checked]" use="@cve"/>
  <xsl:key name="unidad_negocios" match="unidades_negocio[not(unidad_negocio/@state:checked)]/unidad_negocio" use="@cve"/>
  <xsl:key name="unidad_negocios" match="unidades_negocio[not(unidad_negocio/@state:checked)]/unidad_negocio" use="''"/>

  <xsl:template match="/model">
    <xsl:variable name="polizas" select="polizas"/>
    <xsl:variable name="selected" select="fechas/@state:selected"/>
    <xsl:variable name="prev_month" select="fechas/fecha[@mes=../@state:selected]/preceding-sibling::*[1]/@mes"/>
    <xsl:variable name="current_month" select="fechas/fecha[@mes=../@state:selected]/@mes"/>
    <div class="container-fluid">

      <style id="Tablero Direccion Flimsa (version 1) Ene 22_19670_Styles">
        table > thead > tr > td { background-color: white;}
        table > thead.freeze > tr:nth-child(2) > td, table > thead.freeze > tr:nth-child(2) > th {
        top: 73px;
        }

        table
        {mso-displayed-decimal-separator:"\.";
        mso-displayed-thousand-separator:"\,";}
        .font519670
        {color:black;
        font-size:9.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Tahoma, sans-serif;
        mso-font-charset:0;}
        .font619670
        {color:black;
        font-size:9.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:Tahoma, sans-serif;
        mso-font-charset:0;}
        .xl6419670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl6519670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl6619670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:1.0pt solid windowtext;
        border-left:.5pt hairline windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl6719670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl6819670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0;
        text-align:right;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl6919670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl7019670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl7119670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Fixed;
        text-align:right;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl7219670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:right;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl7319670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:right;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl7419670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl7519670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl7619670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Fixed;
        text-align:right;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl7719670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Fixed;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl7819670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0;
        text-align:right;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl7919670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border-top:1.0pt solid windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl8019670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border-top:1.0pt solid windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl8119670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl8219670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl8319670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl8419670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl8519670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl8619670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl8719670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl8819670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Fixed;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl8919670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Fixed;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl9019670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Fixed;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl9119670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl9219670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl9319670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl9419670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:1.0pt solid windowtext;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl9519670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        border-top:1.0pt solid windowtext;
        border-right:.5pt solid windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:1.0pt solid windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl9619670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt solid windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:1.0pt solid windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl9719670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt solid windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:1.0pt solid windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl9819670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt solid windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:1.0pt solid windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl9919670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt solid windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:1.0pt solid windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl10019670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt solid windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:1.0pt solid windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl10119670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt solid windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:1.0pt solid windowtext;
        background:white;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl10219670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt solid windowtext;
        border-bottom:1.0pt solid windowtext;
        border-left:1.0pt solid windowtext;
        background:white;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl10319670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:middle;
        border-top:1.0pt solid windowtext;
        border-right:none;
        border-bottom:1.0pt solid windowtext;
        border-left:1.0pt solid windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:normal;}
        .xl10419670
        {padding:0px;
        mso-ignore:padding;
        color:white;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:middle;
        border-top:1.0pt solid windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:1.0pt solid windowtext;
        border-left:1.0pt solid windowtext;
        background-color:hsl(0, 100%, 40%);
        mso-pattern:black none;
        white-space:normal;}
        .xl10519670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:middle;
        border-top:1.0pt solid windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:1.0pt solid windowtext;
        border-left:.5pt hairline windowtext;
        background:yellow;
        mso-pattern:black none;
        white-space:normal;}
        .xl10619670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:middle;
        border-top:1.0pt solid windowtext;
        border-right:1.0pt solid windowtext;
        border-bottom:1.0pt solid windowtext;
        border-left:.5pt hairline windowtext;
        background-color:hsl(120, 100%, 30%); color: white;
        mso-pattern:black none;
        white-space:normal;}
        .xl10719670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:center;
        vertical-align:middle;
        border-top:1.0pt solid windowtext;
        border-right:1.0pt solid windowtext;
        border-bottom:1.0pt solid windowtext;
        border-left:none;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:normal;}
        .xl10819670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl10919670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"mmm\/yy";
        text-align:center;
        vertical-align:middle;
        border-top:none;
        border-right:none;
        border-bottom:1.0pt solid windowtext;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl11019670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:top;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:normal;}
        .xl11119670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:normal;}
        .xl11219670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:normal;}
        .xl11319670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl11419670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:general;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl11519670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:left;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl11619670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:normal;}
        .xl11719670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl11819670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl11919670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl12019670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:left;
        vertical-align:bottom;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl12119670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:left;
        vertical-align:bottom;
        background:#F2F2F2;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl12219670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:left;
        vertical-align:bottom;
        background:#BFBFBF;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl12319670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:left;
        vertical-align:bottom;
        background:#A6A6A6;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl12419670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:left;
        vertical-align:bottom;
        background:gray;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl12519670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:left;
        vertical-align:bottom;
        background:#D9E1F2;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl12619670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:left;
        vertical-align:bottom;
        background:#8EA9DB;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl12719670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl12819670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl12919670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl13019670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:left;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl13119670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl13219670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:right;
        vertical-align:middle;
        border-top:none;
        border-right:none;
        border-bottom:1.0pt solid windowtext;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl13319670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        border-top:1.0pt solid windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl13419670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl13519670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl13619670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl13719670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl13819670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl13919670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl14019670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl14119670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl14219670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:right;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:.5pt hairline windowtext;
        border-left:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl14319670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:none;
        border-bottom:1.0pt solid windowtext;
        border-left:.5pt hairline windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl14419670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        border-top:1.0pt solid windowtext;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl14519670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl14619670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl14719670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl14819670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl14919670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl15019670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl15119670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:right;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        background:#B4C6E7;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl15219670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:right;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl15319670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:0%;
        text-align:general;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:1.0pt solid windowtext;
        border-left:1.0pt solid windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl15419670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl15519670
        {padding:0px;
        mso-ignore:padding;
        color:windowtext;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl15619670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl15719670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl15819670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        background:#D9D9D9;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl15919670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border-top:.5pt hairline windowtext;
        border-right:.5pt hairline windowtext;
        border-bottom:.5pt hairline windowtext;
        border-left:none;
        background:white;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl16019670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:general;
        vertical-align:bottom;
        border:.5pt hairline windowtext;
        background:white;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl16119670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:700;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:Percent;
        text-align:general;
        vertical-align:bottom;
        border-top:none;
        border-right:1.0pt solid windowtext;
        border-bottom:none;
        border-left:1.0pt solid windowtext;
        background:red;
        mso-pattern:black none;
        white-space:nowrap;}
        .xl16219670
        {padding:0px;
        mso-ignore:padding;
        color:#009900;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"\#\,\#\#0";
        text-align:right;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl16319670
        {padding:0px;
        mso-ignore:padding;
        color:#009900;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl16419670
        {padding:0px;
        mso-ignore:padding;
        color:#009900;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl16519670
        {padding:0px;
        mso-ignore:padding;
        color:#009900;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:"_-\0022$\0022* \#\,\#\#0\.00_-\;\\-\0022$\0022* \#\,\#\#0\.00_-\;_-\0022$\0022* \0022-\0022??_-\;_-\@_-";
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl16619670
        {padding:0px;
        mso-ignore:padding;
        color:#009900;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl16719670
        {padding:0px;
        mso-ignore:padding;
        color:#009900;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:Calibri, sans-serif;
        mso-font-charset:0;
        mso-number-format:0;
        text-align:center;
        vertical-align:bottom;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
        .xl16819670
        {padding:0px;
        mso-ignore:padding;
        color:black;
        font-size:8.0pt;
        font-weight:400;
        font-style:normal;
        text-decoration:none;
        font-family:"Century Gothic", sans-serif;
        mso-font-charset:0;
        mso-number-format:General;
        text-align:center;
        vertical-align:middle;
        border-top:none;
        border-right:none;
        border-bottom:1.0pt solid windowtext;
        border-left:none;
        mso-background-source:auto;
        mso-pattern:auto;
        white-space:nowrap;}
      </style>
      <span style='mso-ignore:vglayout;
  position:absolute;z-indexo:10;margin-left:49px;margin-top:14px;width:78px;
  height:41px'>
        <img width='78' height='41' src="assets/flimsa.png"/>
      </span>
      <table border="0" cellpadding="0" cellspacing="0" width="1714" class="xl6419670" style="border-collapse:collapse;table-layout:fixed;width:1285pt">
        <colgroup>
          <col class="xl6419670" width="23" style="mso-width-source:userset;mso-width-alt:
 841;width:17pt"/>
          <col class="xl6419670" width="259" style="mso-width-source:userset;mso-width-alt:
 9472;width:194pt"/>
          <col class="xl6419670" width="49" style="mso-width-source:userset;mso-width-alt:
 1792;width:37pt"/>
          <col class="xl6419670" width="88" style="mso-width-source:userset;mso-width-alt:
 3218;width:66pt"/>
          <col class="xl6419670" width="65" style="mso-width-source:userset;mso-width-alt:
 2377;width:49pt"/>
          <col class="xl11419670" width="91" span="2" style="mso-width-source:userset;
 mso-width-alt:3328;width:68pt"/>
          <col class="xl10819670" width="291" style="mso-width-source:userset;mso-width-alt:
 10642;width:218pt"/>
          <col class="xl10819670" width="104" style="mso-width-source:userset;mso-width-alt:
 3803;width:78pt"/>
          <col class="xl10819670" width="141" style="mso-width-source:userset;mso-width-alt:
 5156;width:106pt"/>
          <col class="xl10819670" width="88" span="3" style="mso-width-source:userset;
 mso-width-alt:3218;width:66pt"/>
          <col class="xl6419670" width="80" span="2" style="mso-width-source:userset;
 mso-width-alt:2925;width:60pt"/>
          <col class="xl6419670" width="88" style="mso-width-source:userset;mso-width-alt:
 3218;width:66pt"/>
        </colgroup>
        <thead class="freeze">
          <tr height="72" style="mso-height-source:userset;height:54.6pt">
            <td height="72" class="xl6419670" width="23" style="height:54.6pt;width:17pt"></td>
            <td colspan="4" height="72" width="461" style="height:54.6pt;width:346pt" align="left" valign="top">
              <span style="mso-ignore:vglayout2">
                <table cellpadding="0" cellspacing="0">
                  <tbody>
                    <tr>
                      <td colspan="4" height="72" class="xl16819670" width="461" style="height:54.6pt;
    width:346pt">
                        <span style="mso-spacerun:yes">
                          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;
                        </span>TABLERO DE CONTROL DIRECCIÓN
                      </td>
                    </tr>
                  </tbody>
                </table>
              </span>
            </td>
            <td class="xl13219670" width="91" style="width:68pt">Mes actual:</td>
            <td class="xl10919670" width="91" style="width:68pt">
              <select xo-scope="{fechas/@xo:id}" xo-attribute="state:selected">
                <option value="">Todas</option>
                <xsl:for-each select="fechas/fecha/@mes">
                  <xsl:variable name="value" select="concat(substring(.,1,4),'-',substring(.,5))"/>
                  <option value="{.}">
                    <xsl:if test=".=$current_month">
                      <xsl:attribute name="selected"/>
                    </xsl:if>
                    <xsl:value-of select="$value"/>
                  </option>
                </xsl:for-each>
              </select>
            </td>
            <td class="xl10819670" width="291" style="width:218pt"></td>
            <td class="xl10819670" width="104" style="width:78pt"></td>
            <td class="xl10819670" width="141" style="width:106pt"></td>
            <td class="xl10819670" width="88" style="width:66pt"></td>
            <td class="xl10819670" width="88" style="width:66pt"></td>
            <td class="xl10819670" width="88" style="width:66pt"></td>
            <td class="xl6419670" width="80" style="width:60pt"></td>
            <td class="xl6419670" width="80" style="width:60pt"></td>
            <td class="xl6419670" width="88" style="width:66pt"></td>
          </tr>
          <tr class="xl11219670" height="45" style="mso-height-source:userset;height:33.75pt">
            <td height="45" class="xl11219670" width="23" style="height:33.75pt;width:17pt"></td>
            <td class="xl10319670" width="259" style="border-top:none;width:194pt">INDICADOR</td>
            <td class="xl10419670" width="49" style="border-top:none;width:37pt">
              MÍNIMO<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl10519670" width="88" style="border-top:none;border-left:none;
  width:66pt">
              SATISFACTORIO<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl10619670" width="65" style="border-top:none;border-left:none;
  width:49pt">EXCELENTE</td>
            <td class="xl10719670" width="91" style="border-top:none;width:68pt; text-transform: uppercase">
              <span style="mso-spacerun:yes">&#160;</span>MES ANTERIOR<br/><xsl:value-of select="$prev_month/../@nom"/><span style="mso-spacerun:yes">&#160;</span>

            </td>
            <td class="xl10719670" width="91" style="border-top:none;width:68pt; text-transform: uppercase">
              <span style="mso-spacerun:yes">&#160;</span>MES <br/><xsl:value-of select="$current_month/../@nom"/><span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl11019670" width="291" style="width:218pt"></td>
            <td class="xl11619670" width="104" style="width:78pt">REAL/PROYECCION</td>
            <td class="xl11619670" width="141" style="width:106pt">
              PRESUPUESTO/<br/>
              OBJETIVO DEL MES
            </td>
            <td class="xl11619670" width="88" style="width:66pt">DIFERENCIA</td>
            <td class="xl11119670" width="88" style="width:66pt"></td>
            <td class="xl11119670" width="88" style="width:66pt"></td>
            <td class="xl11219670" width="80" style="width:60pt"></td>
            <td class="xl11219670" width="80" style="width:60pt"></td>
            <td class="xl11219670" width="88" style="width:66pt"></td>
          </tr>
        </thead>
        <tbody>
          <xsl:variable name="plataformas_viajes_prev" select="key('viajes','102')[key('month',concat(@xo:id , '::', $prev_month))]"/>
          <xsl:variable name="plataformas_rendimientos_prev" select="key('rendimientos','102')[key('month',concat(@xo:id , '::', $prev_month))]"/>

          <xsl:variable name="plataformas_ventas_prev" select="key('polizas',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='102']"/>
          <xsl:variable name="plataformas_ppto_ventas_prev" select="key('presupuestos',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='102']"/>

          <xsl:variable name="plataformas_viajes_curr" select="key('viajes','102')[key('month',concat(@xo:id , '::', $current_month))]"/>
          <xsl:variable name="plataformas_rendimientos_curr" select="key('rendimientos','102')[key('month',concat(@xo:id , '::', $current_month))]"/>

          <xsl:variable name="plataformas_ventas_curr" select="key('polizas',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='102']"/>
          <xsl:variable name="plataformas_ppto_ventas_curr" select="key('presupuestos',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='102']"/>

          <xsl:variable name="plataformas_costo_ventas_prev" select="key('polizas',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='102']"/>
          <xsl:variable name="plataformas_ppto_costo_ventas_prev" select="key('presupuestos',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('costo_ventas',@xo:id)][key('month',concat(@xo:id , '::', $prev_month))][@un='102']"/>

          <xsl:variable name="plataformas_costo_ventas_curr" select="key('polizas',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='102']"/>
          <xsl:variable name="plataformas_ppto_costo_ventas_curr" select="key('presupuestos',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='102']"/>

          <xsl:variable name="plataformas_gastos_prev" select="key('polizas',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='102']"/>
          <xsl:variable name="plataformas_ppto_gastos_prev" select="key('presupuestos',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='102']"/>

          <xsl:variable name="plataformas_gastos_curr" select="key('polizas',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='102']"/>
          <xsl:variable name="plataformas_ppto_gastos_curr" select="key('presupuestos',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='102']"/>

          <xsl:variable name="plataformas_gastos_administrativos_prev" select="key('polizas',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='102']"/>
          <xsl:variable name="plataformas_ppto_gastos_administrativos_prev" select="key('presupuestos',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='102']"/>

          <xsl:variable name="plataformas_gastos_administrativos_curr" select="key('polizas',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='102']"/>
          <xsl:variable name="plataformas_ppto_gastos_administrativos_curr" select="key('presupuestos',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='102']"/>

          <xsl:variable name="tolva_viajes_prev" select="key('viajes','101')[key('month',concat(@xo:id , '::', $prev_month))]"/>
          <xsl:variable name="tolva_rendimientos_prev" select="key('rendimientos','101')[key('month',concat(@xo:id , '::', $prev_month))]"/>

          <xsl:variable name="tolva_ventas_prev" select="key('polizas',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='101']"/>
          <xsl:variable name="tolva_ppto_ventas_prev" select="key('presupuestos',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='101']"/>

          <xsl:variable name="tolva_ventas_curr" select="key('polizas',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='101']"/>

          <xsl:variable name="tolva_viajes_curr" select="key('viajes','101')[key('month',concat(@xo:id , '::', $current_month))]"/>
          <xsl:variable name="tolva_rendimientos_curr" select="key('rendimientos','101')[key('month',concat(@xo:id , '::', $current_month))]"/>

          <xsl:variable name="tolva_ppto_ventas_curr" select="key('presupuestos',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='101']"/>

          <xsl:variable name="tolva_costo_ventas_prev" select="key('polizas',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='101']"/>
          <xsl:variable name="tolva_ppto_costo_ventas_prev" select="key('presupuestos',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('costo_ventas',@xo:id)][key('month',concat(@xo:id , '::', $prev_month))][@un='101']"/>

          <xsl:variable name="tolva_costo_ventas_curr" select="key('polizas',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='101']"/>
          <xsl:variable name="tolva_ppto_costo_ventas_curr" select="key('presupuestos',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='101']"/>

          <xsl:variable name="tolva_gastos_prev" select="key('polizas',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='101']"/>
          <xsl:variable name="tolva_ppto_gastos_prev" select="key('presupuestos',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='101']"/>

          <xsl:variable name="tolva_gastos_curr" select="key('polizas',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='101']"/>
          <xsl:variable name="tolva_ppto_gastos_curr" select="key('presupuestos',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='101']"/>

          <xsl:variable name="tolva_gastos_administrativos_prev" select="key('polizas',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='101']"/>
          <xsl:variable name="tolva_ppto_gastos_administrativos_prev" select="key('presupuestos',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='101']"/>

          <xsl:variable name="tolva_gastos_administrativos_curr" select="key('polizas',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='101']"/>
          <xsl:variable name="tolva_ppto_gastos_administrativos_curr" select="key('presupuestos',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='101']"/>

          <xsl:variable name="autotanque_viajes_prev" select="key('viajes','103')[key('month',concat(@xo:id , '::', $prev_month))]"/>
          <xsl:variable name="autotanque_rendimientos_prev" select="key('rendimientos','103')[key('month',concat(@xo:id , '::', $prev_month))]"/>

          <xsl:variable name="autotanque_ventas_prev" select="key('polizas',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='103']"/>
          <xsl:variable name="autotanque_ppto_ventas_prev" select="key('presupuestos',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='103']"/>

          <xsl:variable name="autotanque_viajes_curr" select="key('viajes','103')[key('month',concat(@xo:id , '::', $current_month))]"/>
          <xsl:variable name="autotanque_rendimientos_curr" select="key('rendimientos','103')[key('month',concat(@xo:id , '::', $current_month))]"/>

          <xsl:variable name="autotanque_ventas_curr" select="key('polizas',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='103']"/>
          <xsl:variable name="autotanque_ppto_ventas_curr" select="key('presupuestos',//cuenta[key('ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='103']"/>

          <xsl:variable name="autotanque_costo_ventas_prev" select="key('polizas',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='103']"/>
          <xsl:variable name="autotanque_ppto_costo_ventas_prev" select="key('presupuestos',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('costo_ventas',@xo:id)][key('month',concat(@xo:id , '::', $prev_month))][@un='103']"/>

          <xsl:variable name="autotanque_costo_ventas_curr" select="key('polizas',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='103']"/>
          <xsl:variable name="autotanque_ppto_costo_ventas_curr" select="key('presupuestos',//cuenta[key('costo_ventas',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='103']"/>

          <xsl:variable name="autotanque_gastos_prev" select="key('polizas',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='103']"/>
          <xsl:variable name="autotanque_ppto_gastos_prev" select="key('presupuestos',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='103']"/>

          <xsl:variable name="autotanque_gastos_curr" select="key('polizas',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='103']"/>
          <xsl:variable name="autotanque_ppto_gastos_curr" select="key('presupuestos',//cuenta[key('gastos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='103']"/>

          <xsl:variable name="autotanque_gastos_administrativos_prev" select="key('polizas',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='103']"/>
          <xsl:variable name="autotanque_ppto_gastos_administrativos_prev" select="key('presupuestos',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $prev_month))][@un='103']"/>

          <xsl:variable name="autotanque_gastos_administrativos_curr" select="key('polizas',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='103']"/>
          <xsl:variable name="autotanque_ppto_gastos_administrativos_curr" select="key('presupuestos',//cuenta[key('gastos_administrativos',@xo:id)]/@num)[key('month',concat(@xo:id , '::', $current_month))][@un='103']"/>

          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_ventas_prev/@monto|$tolva_ventas_prev/@monto|$autotanque_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_ventas_curr/@monto|$tolva_ventas_curr/@monto|$autotanque_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($plataformas_ppto_ventas_prev/@monto|$tolva_ppto_ventas_prev/@monto|$autotanque_ppto_ventas_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="sum($plataformas_ppto_ventas_curr/@monto|$tolva_ppto_ventas_curr/@monto|$autotanque_ppto_ventas_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9519670" style="border-top:none">VENTA VS PRESUPUESTO</td>
            <td class="xl8019670" style="border-top:none">100%</td>
            <td class="xl7919670" style="border-top:none;border-left:none">105%</td>
            <td class="xl7919670" style="border-top:none;border-left:none">110%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="100"/>
              <xsl:with-param name="max" select="110"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="100"/>
              <xsl:with-param name="max" select="110"/>
            </xsl:call-template>
            <td class="xl12119670">
              VTA PROYECTADA/PTTO <xsl:value-of select="substring($current_month,1,4)"/><br/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="-sum($plataformas_gastos_administrativos_prev/@monto|$tolva_gastos_administrativos_prev/@monto|$autotanque_gastos_administrativos_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="-sum($plataformas_gastos_administrativos_curr/@monto|$tolva_gastos_administrativos_curr/@monto|$autotanque_gastos_administrativos_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="-sum($plataformas_ppto_gastos_administrativos_prev/@monto|$tolva_ppto_gastos_administrativos_prev/@monto|$autotanque_ppto_gastos_administrativos_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="-sum($plataformas_ppto_gastos_administrativos_curr/@monto|$tolva_ppto_gastos_administrativos_curr/@monto|$autotanque_ppto_gastos_administrativos_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9619670" style="border-top:none">
              GASTOS ADMINISTRATIVOS VS PRESUPUESTO
            </td>
            <td class="xl8119670" style="border-top:none">100%</td>
            <td class="xl6519670" style="border-top:none;border-left:none">95%</td>
            <td class="xl6519670" style="border-top:none;border-left:none">90%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="1"/>
              <xsl:with-param name="max" select=".9"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="1"/>
              <xsl:with-param name="max" select=".9"/>
            </xsl:call-template>

            <td class="xl12019670">
              GASTO ADMON DIA/PTTO <xsl:value-of select="substring($current_month,1,4)"/>
            </td>
            <td class="xl16419670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>
              <xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="3" style="mso-height-source:userset;height:2.45pt">
            <td height="3" class="xl6419670" style="height:2.45pt"></td>
            <td class="xl9719670" style="border-top:none">&#160;</td>
            <td class="xl8219670" style="border-top:none">&#160;</td>
            <td class="xl7419670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl7419670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl13519670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl14619670">&#160;</td>
            <td class="xl10819670"></td>
            <td class="xl16619670"></td>
            <td class="xl16619670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_ventas_prev/@monto|$tolva_ventas_prev/@monto|$autotanque_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_ventas_curr/@monto|$tolva_ventas_curr/@monto|$autotanque_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="-sum($plataformas_costo_ventas_prev/@monto|$tolva_costo_ventas_prev/@monto|$autotanque_costo_ventas_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="-sum($plataformas_costo_ventas_curr/@monto|$tolva_costo_ventas_curr/@monto|$autotanque_costo_ventas_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">MARGEN DE CONTRIBUCIÓN</td>
            <td class="xl8319670" style="border-top:none">12.44%</td>
            <td class="xl6719670" style="border-top:none;border-left:none">13.44%</td>
            <td class="xl6719670" style="border-top:none;border-left:none">14.44%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev - $objetivo_prev"/>
              <xsl:with-param name="dividendo" select="$monto_prev"/>
              <xsl:with-param name="min" select=".1244"/>
              <xsl:with-param name="max" select=".1444"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr - $objetivo_curr"/>
              <xsl:with-param name="dividendo" select="$monto_curr"/>
              <xsl:with-param name="min" select=".1244"/>
              <xsl:with-param name="max" select=".1444"/>
            </xsl:call-template>
            <td class="xl12219670">(VTA DIA-GASTO OPERATIVO DIA)/VTA DIA</td>

            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr - $objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_ventas_prev/@monto|$tolva_ventas_prev/@monto|$autotanque_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_ventas_curr/@monto|$tolva_ventas_curr/@monto|$autotanque_ventas_curr/@monto)"/>

            <xsl:variable name="objetivo_prev" select="sum($plataformas_rendimientos_prev/@kms|$tolva_rendimientos_prev/@kms|$autotanque_rendimientos_prev/@kms)"/>
            <xsl:variable name="objetivo_curr" select="sum($plataformas_rendimientos_curr/@kms|$tolva_rendimientos_curr/@kms|$autotanque_rendimientos_curr/@kms)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">PRECIO DE VENTA KM</td>
            <td class="xl8419670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;</span>$ 32.10
            </td>
            <td class="xl7219670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>33.10
            </td>
            <td class="xl7219670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">
                &#160;&#160;&#160;&#160;&#160;&#160;
              </span>34.10
            </td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="32.10"/>
              <xsl:with-param name="max" select="34.10"/>
            </xsl:call-template>
            <xsl:variable name="curr_resultado" select="1"></xsl:variable>
            <xsl:variable name="curr_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="32.10"/>
              <xsl:with-param name="max" select="34.10"/>
            </xsl:call-template>
            <td class="xl12319670">
              <span style="mso-spacerun:yes">&#160;</span>VTA DIA/KMS<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="-sum($plataformas_costo_ventas_prev/@monto|$tolva_costo_ventas_prev/@monto|$autotanque_costo_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="-sum($plataformas_costo_ventas_curr/@monto|$tolva_costo_ventas_curr/@monto|$autotanque_costo_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($plataformas_rendimientos_prev/@kms|$tolva_rendimientos_prev/@kms|$autotanque_rendimientos_prev/@kms)"/>
            <xsl:variable name="objetivo_curr" select="sum($plataformas_rendimientos_curr/@kms|$tolva_rendimientos_curr/@kms|$autotanque_rendimientos_curr/@kms)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">COSTO DE VENTA KM</td>
            <td class="xl8419670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;</span> $ 31.29
            </td>
            <td class="xl7219670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>30.29
            </td>
            <td class="xl7219670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">
                &#160;&#160;&#160;&#160;&#160;&#160;
              </span> 29.29
            </td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="31.29"/>
              <xsl:with-param name="max" select="29.29"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="31.29"/>
              <xsl:with-param name="max" select="29.29"/>
            </xsl:call-template>
            <td class="xl12419670">
              <span style="mso-spacerun:yes">&#160;</span>COSTO
              OPERATIVO/KMS<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_ventas_prev/@monto|$tolva_ventas_prev/@monto|$autotanque_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_ventas_curr/@monto|$tolva_ventas_curr/@monto|$autotanque_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="-sum($plataformas_costo_ventas_prev/@monto|$tolva_costo_ventas_prev/@monto|$autotanque_costo_ventas_prev/@monto|$plataformas_gastos_prev/@monto|$tolva_gastos_prev/@monto|$autotanque_gastos_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="-sum($plataformas_costo_ventas_curr/@monto|$tolva_costo_ventas_curr/@monto|$autotanque_costo_ventas_curr/@monto|$plataformas_gastos_curr/@monto|$tolva_gastos_curr/@monto|$autotanque_gastos_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">UTILIDAD (EBITDA)</td>
            <td class="xl8319670" style="border-top:none">
              7.87%
            </td>
            <td class="xl6719670" style="border-top:none;border-left:none">
              8.87%
            </td>
            <td class="xl6719670" style="border-top:none;border-left:none">
              9.87%
            </td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev - $objetivo_prev"/>
              <xsl:with-param name="dividendo" select="$monto_prev"/>
              <xsl:with-param name="min" select=".0787"/>
              <xsl:with-param name="max" select=".0987"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr - $objetivo_curr"/>
              <xsl:with-param name="dividendo" select="$monto_curr"/>
              <xsl:with-param name="min" select=".0787"/>
              <xsl:with-param name="max" select=".0987"/>
            </xsl:call-template>
            <td class="xl12219670">MARGEN DE CONTRIBUCIÓN - GASTOS</td>

            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr - $objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_rendimientos_prev/@kms|$tolva_rendimientos_prev/@kms|$autotanque_rendimientos_prev/@kms) div sum($plataformas_rendimientos_prev/@lts|$tolva_rendimientos_prev/@lts|$autotanque_rendimientos_prev/@lts)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_rendimientos_curr/@kms|$tolva_rendimientos_curr/@kms|$autotanque_rendimientos_curr/@kms) div sum($plataformas_rendimientos_curr/@lts|$tolva_rendimientos_curr/@lts|$autotanque_rendimientos_curr/@lts)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9919670" style="border-top:none">RENDIMIENTO DE COMBUSTIBLE</td>
            <td class="xl8519670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160; </span> 1.67
            </td>
            <td class="xl7019670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>1.68
            </td>
            <td class="xl7019670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>1.69
            </td>
            <xsl:variable name="prev_resultado" select="1"></xsl:variable>
            <xsl:variable name="prev_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="1.67"/>
              <xsl:with-param name="max" select="1.69"/>
            </xsl:call-template>
            <xsl:variable name="curr_resultado" select="1"></xsl:variable>
            <xsl:variable name="curr_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="1.67"/>
              <xsl:with-param name="max" select="1.69"/>
            </xsl:call-template>
            <td class="xl12519670">RENDIMIENTO REAL KMS/LITROS</td>
            <td class="xl16219670">
              <xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl11719670">
              <xsl:value-of select="format-number(sum($plataformas_rendimientos_curr/@kms|$tolva_rendimientos_curr/@kms|$autotanque_rendimientos_curr/@kms),',##0.00 kms;-,##0.00 kms')"/>
            </td>
            <td class="xl11719670">
              <xsl:value-of select="format-number(sum($plataformas_rendimientos_curr/@lts|$tolva_rendimientos_curr/@lts|$autotanque_rendimientos_curr/@lts),',##0.00 lts;-,##0.00 lts')"/>
            </td>
            <td class="xl11719670"></td>
            <td class="xl15519670"></td>
            <td class="xl15619670"></td>
            <td class="xl15619670"></td>
            <td class="xl15719670"></td>
          </tr>
          <tr height="3" style="mso-height-source:userset;height:2.45pt">
            <td height="3" class="xl6419670" style="height:2.45pt"></td>
            <td class="xl10019670" style="border-top:none">&#160;</td>
            <td class="xl8619670" style="border-top:none">&#160;</td>
            <td class="xl7519670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl7519670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl13919670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl15019670">&#160;</td>
            <td class="xl10819670"></td>
            <td class="xl16619670"></td>
            <td class="xl16619670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($plataformas_ppto_ventas_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="sum($plataformas_ppto_ventas_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9519670" style="border-top:none">VENTA VS PPTO PLATAFORMA</td>
            <td class="xl8019670" style="border-top:none">100%</td>
            <td class="xl7919670" style="border-top:none;border-left:none">105%</td>
            <td class="xl7919670" style="border-top:none;border-left:none">110%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="1.0"/>
              <xsl:with-param name="max" select="1.1"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="1.0"/>
              <xsl:with-param name="max" select="1.1"/>
            </xsl:call-template>
            <td class="xl12119670">
              VTA PROYECTADA/PTTO <xsl:value-of select="substring($current_month,1,4)"/><br/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="-sum($plataformas_costo_ventas_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="-sum($plataformas_costo_ventas_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">MARGEN DE CONTRIBUCIÓN PLATAFORMA</td>
            <td class="xl8319670" style="border-top:none">
              5.02%
            </td>
            <td class="xl6719670" style="border-top:none;border-left:none">6.02%</td>
            <td class="xl6719670" style="border-top:none;border-left:none">7.02%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev - $objetivo_prev"/>
              <xsl:with-param name="dividendo" select="$monto_prev"/>
              <xsl:with-param name="min" select=".0502"/>
              <xsl:with-param name="max" select=".0702"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr - $objetivo_curr"/>
              <xsl:with-param name="dividendo" select="$monto_curr"/>
              <xsl:with-param name="min" select=".0502"/>
              <xsl:with-param name="max" select=".0702"/>
            </xsl:call-template>
            <td class="xl12219670">VENTA AL DIA / GASTO OPERATIVO AL DIA</td>

            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr - $objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_ventas_curr/@monto)"/>

            <xsl:variable name="objetivo_prev" select="sum($plataformas_rendimientos_prev/@kms)"/>
            <xsl:variable name="objetivo_curr" select="sum($plataformas_rendimientos_curr/@kms)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9619670" style="border-top:none">PRECIO DE VENTA KM PLATAFORMA</td>
            <td class="xl8719670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;</span>$  36.70 	 

            </td>
            <td class="xl7319670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>37.00 	 
            </td>
            <td class="xl7319670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">
                &#160;&#160;&#160;&#160;&#160;&#160;
              </span>37.33
            </td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="36.70"/>
              <xsl:with-param name="max" select="37.33"/>
            </xsl:call-template>
            <xsl:variable name="curr_resultado" select="1"></xsl:variable>
            <xsl:variable name="curr_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="36.70"/>
              <xsl:with-param name="max" select="37.33"/>
            </xsl:call-template>
            <td class="xl12319670">
              <span style="mso-spacerun:yes">&#160;</span>VTA DIA/KMS<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="-sum($plataformas_costo_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="-sum($plataformas_costo_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($plataformas_rendimientos_prev/@kms)"/>
            <xsl:variable name="objetivo_curr" select="sum($plataformas_rendimientos_curr/@kms)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9619670" style="border-top:none">COSTO DE VENTA KM PLATAFORMA</td>
            <td class="xl8719670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;</span>$  36.65 	 
            </td>
            <td class="xl7319670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>36.60 	 
            </td>
            <td class="xl7319670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">
                &#160;&#160;&#160;&#160;&#160;&#160;
              </span>36.57
            </td>
            <xsl:variable name="prev_resultado" select="1"></xsl:variable>
            <xsl:variable name="prev_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="36.65"/>
              <xsl:with-param name="max" select="36.57"/>
            </xsl:call-template>
            <xsl:variable name="curr_resultado" select="1"></xsl:variable>
            <xsl:variable name="curr_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="36.65"/>
              <xsl:with-param name="max" select="36.57"/>
            </xsl:call-template>
            <td class="xl12419670">
              <span style="mso-spacerun:yes">&#160;</span>COSTO
              OPERATIVO/KMS<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="-sum($plataformas_costo_ventas_prev/@monto|$plataformas_gastos_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="-sum($plataformas_costo_ventas_curr/@monto|$plataformas_gastos_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">UTILIDAD (EBITDA) PLATAFORMA</td>
            <td class="xl8319670" style="border-top:none">1%</td>
            <td class="xl6719670" style="border-top:none;border-left:none">1.07%</td>
            <td class="xl6719670" style="border-top:none;border-left:none">2.07%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev - $objetivo_prev"/>
              <xsl:with-param name="dividendo" select="$monto_prev"/>
              <xsl:with-param name="min" select=".01"/>
              <xsl:with-param name="max" select=".0207"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr - $objetivo_curr"/>
              <xsl:with-param name="dividendo" select="$monto_curr"/>
              <xsl:with-param name="min" select=".01"/>
              <xsl:with-param name="max" select=".0207"/>
            </xsl:call-template>
            <td class="xl12219670">MARGEN DE CONTRIBUCIÓN - GASTOS</td>

            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr - $objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_rendimientos_prev/@kms) div sum($plataformas_rendimientos_prev/@lts)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_rendimientos_curr/@kms) div sum($plataformas_rendimientos_curr/@lts)"/>

            <xsl:variable name="objetivo_prev" select="sum($plataformas_rendimientos_prev/@lts)"/>
            <xsl:variable name="objetivo_curr" select="sum($plataformas_rendimientos_curr/@lts)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9619670" style="border-top:none">
              RENDIMIENTO DE COMBUSTIBLE
              PLATAFORMA
            </td>
            <td class="xl15919670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160; </span>1.55
            </td>
            <td class="xl16019670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>1.60
            </td>
            <td class="xl16019670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>1.65
            </td>
            <xsl:variable name="prev_resultado" select="1"></xsl:variable>
            <xsl:variable name="prev_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="1.55"/>
              <xsl:with-param name="max" select="1.65"/>
            </xsl:call-template>
            <xsl:variable name="curr_resultado" select="1"></xsl:variable>
            <xsl:variable name="curr_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="1.55"/>
              <xsl:with-param name="max" select="1.65"/>
            </xsl:call-template>
            <td class="xl12519670">RENDIMIENTO REAL KMS/LITROS</td>
            <td class="xl16219670">
              <xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl11719670">
              <xsl:value-of select="format-number(sum($plataformas_rendimientos_curr/@kms),',##0.00 kms;-,##0.00 kms')"/>
            </td>
            <td class="xl11719670">
              <xsl:value-of select="format-number(sum($plataformas_rendimientos_curr/@lts),',##0.00 lts;-,##0.00 lts')"/>
            </td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="3" style="mso-height-source:userset;height:2.45pt">
            <td height="3" class="xl6419670" style="height:2.45pt"></td>
            <td class="xl9719670" style="border-top:none">&#160;</td>
            <td class="xl8919670" style="border-top:none">&#160;</td>
            <td class="xl7619670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl7619670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl14019670" style="border-top:none">&#160;</td>
            <td class="xl15119670">&#160;</td>
            <td class="xl10819670"></td>
            <td class="xl16619670"></td>
            <td class="xl16619670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($tolva_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($tolva_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($tolva_ppto_ventas_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="sum($tolva_ppto_ventas_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9519670" style="border-top:none">VENTA VS PPTO TOLVA</td>
            <td class="xl8019670" style="border-top:none">100%</td>
            <td class="xl7919670" style="border-top:none;border-left:none">105%</td>
            <td class="xl7919670" style="border-top:none;border-left:none">110%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="1.0"/>
              <xsl:with-param name="max" select="1.1"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="1.0"/>
              <xsl:with-param name="max" select="1.1"/>
            </xsl:call-template>
            <td class="xl12119670">
              VTA PROYECTADA/PTTO <xsl:value-of select="substring($current_month,1,4)"/><br/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($tolva_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($tolva_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="-sum($tolva_costo_ventas_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="-sum($tolva_costo_ventas_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">MARGEN DE CONTRIBUCIÓN TOLVA</td>
            <td class="xl8319670" style="border-top:none">
              12.09%	
            </td>
            <td class="xl6719670" style="border-top:none;border-left:none">13.09%	</td>
            <td class="xl6719670" style="border-top:none;border-left:none">14.09%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev - $objetivo_prev"/>
              <xsl:with-param name="dividendo" select="$monto_prev"/>
              <xsl:with-param name="min" select=".1209"/>
              <xsl:with-param name="max" select=".1409"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr - $objetivo_curr"/>
              <xsl:with-param name="dividendo" select="$monto_curr"/>
              <xsl:with-param name="min" select=".1209"/>
              <xsl:with-param name="max" select=".1409"/>
            </xsl:call-template>
            <td class="xl12219670">VENTA AL DIA / GASTO OPERATIVO AL DIA</td>

            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr - $objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($tolva_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($tolva_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($tolva_rendimientos_prev/@kms)"/>
            <xsl:variable name="objetivo_curr" select="sum($tolva_rendimientos_curr/@kms)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">PRECIO DE VENTA KM TOLVA</td>
            <td class="xl8419670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;</span>$  30.15 	 

            </td>
            <td class="xl7219670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>31.15 	 
            </td>
            <td class="xl7219670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">
                &#160;&#160;&#160;&#160;&#160;&#160;
              </span>32.15
            </td>
            <xsl:variable name="prev_resultado" select="1"></xsl:variable>
            <xsl:variable name="prev_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="30.15"/>
              <xsl:with-param name="max" select="32.15"/>
            </xsl:call-template>
            <xsl:variable name="curr_resultado" select="1"></xsl:variable>
            <xsl:variable name="curr_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="30.15"/>
              <xsl:with-param name="max" select="32.15"/>
            </xsl:call-template>
            <td class="xl12319670">
              <span style="mso-spacerun:yes">&#160;</span>VTA DIA/KMS<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="-sum($tolva_costo_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="-sum($tolva_costo_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($tolva_rendimientos_prev/@kms)"/>
            <xsl:variable name="objetivo_curr" select="sum($tolva_rendimientos_curr/@kms)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">COSTO DE VENTA KM TOLVA</td>
            <td class="xl8419670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;</span>$  28.86 	 
            </td>
            <td class="xl7219670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>28.66 	 
            </td>
            <td class="xl7219670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">
                &#160;&#160;&#160;&#160;&#160;&#160;
              </span>28.16
            </td>
            <xsl:variable name="prev_resultado" select="1"></xsl:variable>
            <xsl:variable name="prev_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="28.86"/>
              <xsl:with-param name="max" select="28.16"/>
            </xsl:call-template>
            <xsl:variable name="curr_resultado" select="1"></xsl:variable>
            <xsl:variable name="curr_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="28.86"/>
              <xsl:with-param name="max" select="28.16"/>
            </xsl:call-template>
            <td class="xl12419670">
              <span style="mso-spacerun:yes">&#160;</span>COSTO
              OPERATIVO/KMS<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($tolva_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($tolva_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="-sum($tolva_costo_ventas_prev/@monto|$plataformas_gastos_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="-sum($tolva_costo_ventas_curr/@monto|$tolva_gastos_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">UTILIDAD (EBITDA) TOLVA</td>
            <td class="xl8319670" style="border-top:none">
              7.66%	</td>
            <td class="xl6719670" style="border-top:none;border-left:none">
              8.66%	
            </td>
            <td class="xl6719670" style="border-top:none;border-left:none">9.66%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev - $objetivo_prev"/>
              <xsl:with-param name="dividendo" select="$monto_prev"/>
              <xsl:with-param name="min" select=".0766"/>
              <xsl:with-param name="max" select=".0966"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr - $objetivo_curr"/>
              <xsl:with-param name="dividendo" select="$monto_curr"/>
              <xsl:with-param name="min" select=".0766"/>
              <xsl:with-param name="max" select=".0966"/>
            </xsl:call-template>
            <td class="xl12219670">MARGEN DE CONTRIBUCIÓN - GASTOS</td>

            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr - $objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($tolva_rendimientos_prev/@kms) div sum($tolva_rendimientos_prev/@lts)"/>
            <xsl:variable name="monto_curr" select="sum($tolva_rendimientos_curr/@kms) div sum($tolva_rendimientos_curr/@lts)"/>

            <xsl:variable name="objetivo_prev" select="sum($tolva_rendimientos_prev/@lts)"/>
            <xsl:variable name="objetivo_curr" select="sum($tolva_rendimientos_curr/@lts)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">RENDIMIENTO DE COMBUSTIBLE TOLVA</td>
            <td class="xl8519670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160; </span>1.55
            </td>
            <td class="xl7019670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>1.60
            </td>
            <td class="xl7019670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>1.65
            </td>
            <xsl:variable name="prev_resultado" select="1"></xsl:variable>
            <xsl:variable name="prev_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="1.55"/>
              <xsl:with-param name="max" select="1.65"/>
            </xsl:call-template>
            <xsl:variable name="curr_resultado" select="1"></xsl:variable>
            <xsl:variable name="curr_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="1.55"/>
              <xsl:with-param name="max" select="1.65"/>
            </xsl:call-template>
            <td class="xl12519670">RENDIMIENTO REAL KMS/LITROS</td>
            <td class="xl16219670">
              <xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl11719670">
              <xsl:value-of select="format-number(sum($tolva_rendimientos_curr/@kms),',##0.00 kms;-,##0.00 kms')"/>
            </td>
            <td class="xl11719670">
              <xsl:value-of select="format-number(sum($tolva_rendimientos_curr/@lts),',##0.00 lts;-,##0.00 lts')"/>
            </td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="3" style="mso-height-source:userset;height:2.45pt">
            <td height="3" class="xl6419670" style="height:2.45pt"></td>
            <td class="xl9719670" style="border-top:none">&#160;</td>
            <td class="xl8619670" style="border-top:none">&#160;</td>
            <td class="xl7519670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl7519670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl13919670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl15019670">&#160;</td>
            <td class="xl10819670"></td>
            <td class="xl16619670"></td>
            <td class="xl16619670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($autotanque_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($autotanque_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($autotanque_ppto_ventas_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="sum($autotanque_ppto_ventas_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9519670" style="border-top:none">VENTA VS PPTO AUTOTANQUE</td>
            <td class="xl8019670" style="border-top:none">100%</td>
            <td class="xl7919670" style="border-top:none;border-left:none">105%</td>
            <td class="xl7919670" style="border-top:none;border-left:none">110%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="1.0"/>
              <xsl:with-param name="max" select="1.1"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="1.0"/>
              <xsl:with-param name="max" select="1.1"/>
            </xsl:call-template>
            <td class="xl12119670">
              VTA PROYECTADA/PTTO <xsl:value-of select="substring($current_month,1,4)"/><br/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($autotanque_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($autotanque_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="-sum($autotanque_costo_ventas_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="-sum($autotanque_costo_ventas_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">MARGEN DE CONTRIBUCIÓN AUTOTANQUE</td>
            <td class="xl8319670" style="border-top:none">
              18.50%	
            </td>
            <td class="xl6719670" style="border-top:none;border-left:none">19.50%</td>
            <td class="xl6719670" style="border-top:none;border-left:none">20.50%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev - $objetivo_prev"/>
              <xsl:with-param name="dividendo" select="$monto_prev"/>
              <xsl:with-param name="min" select=".1850"/>
              <xsl:with-param name="max" select=".2050"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr - $objetivo_curr"/>
              <xsl:with-param name="dividendo" select="$monto_curr"/>
              <xsl:with-param name="min" select=".1850"/>
              <xsl:with-param name="max" select=".2050"/>
            </xsl:call-template>
            <td class="xl12219670">VENTA AL DIA / GASTO OPERATIVO AL DIA</td>

            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr - $objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($autotanque_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($autotanque_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($autotanque_rendimientos_prev/@kms)"/>
            <xsl:variable name="objetivo_curr" select="sum($autotanque_rendimientos_curr/@kms)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9619670" style="border-top:none">PRECIO DE VENTA KM AUTOTAQUE</td>
            <td class="xl8719670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;</span>$  30.35 	 
            </td>
            <td class="xl7319670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>31.35 	 
            </td>
            <td class="xl7319670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">
                &#160;&#160;&#160;&#160;&#160;&#160;
              </span>33.35
            </td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="30.35"/>
              <xsl:with-param name="max" select="33.35"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="30.35"/>
              <xsl:with-param name="max" select="33.35"/>
            </xsl:call-template>
            <td class="xl12319670">
              <span style="mso-spacerun:yes">&#160;</span>VTA DIA/KMS<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="-sum($autotanque_costo_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="-sum($autotanque_costo_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="sum($tolva_rendimientos_prev/@kms)"/>
            <xsl:variable name="objetivo_curr" select="sum($tolva_rendimientos_curr/@kms)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9619670" style="border-top:none">COSTO DE VENTA KM AUTOTANQUE</td>
            <td class="xl8719670" style="border-top:none">
              <span style="mso-spacerun:yes">&#160;</span>$  28.77 	 
            </td>
            <td class="xl7319670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>27.77 	 
            </td>
            <td class="xl7319670" style="border-top:none;border-left:none">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">
                &#160;&#160;&#160;&#160;&#160;&#160;
              </span>25.77
            </td>
            <xsl:variable name="prev_resultado" select="1"></xsl:variable>
            <xsl:variable name="prev_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$objetivo_prev"/>
              <xsl:with-param name="min" select="28.77"/>
              <xsl:with-param name="max" select="25.77"/>
            </xsl:call-template>
            <xsl:variable name="curr_resultado" select="1"></xsl:variable>
            <xsl:variable name="curr_ppto" select="1"></xsl:variable>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type">money</xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$objetivo_curr"/>
              <xsl:with-param name="min" select="28.77"/>
              <xsl:with-param name="max" select="25.77"/>
            </xsl:call-template>
            <td class="xl12419670">
              <span style="mso-spacerun:yes">&#160;</span>COSTO
              OPERATIVO/KMS<span style="mso-spacerun:yes">&#160;</span>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($autotanque_ventas_prev/@monto)"/>
            <xsl:variable name="monto_curr" select="sum($autotanque_ventas_curr/@monto)"/>
            <xsl:variable name="objetivo_prev" select="-sum($autotanque_costo_ventas_prev/@monto|$autotanque_gastos_prev/@monto)"/>
            <xsl:variable name="objetivo_curr" select="-sum($autotanque_costo_ventas_curr/@monto|$autotanque_gastos_curr/@monto)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">UTILIDAD (EBITDA) AUTOTANQUE</td>
            <td class="xl8319670" style="border-top:none">
              13.53%
            </td>
            <td class="xl6719670" style="border-top:none;border-left:none">14.53%</td>
            <td class="xl6719670" style="border-top:none;border-left:none">15.53%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev - $objetivo_prev"/>
              <xsl:with-param name="dividendo" select="$monto_prev"/>
              <xsl:with-param name="min" select=".1353"/>
              <xsl:with-param name="max" select=".1553"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr - $objetivo_curr"/>
              <xsl:with-param name="dividendo" select="$monto_curr"/>
              <xsl:with-param name="min" select=".1353"/>
              <xsl:with-param name="max" select=".1553"/>
            </xsl:call-template>
            <td class="xl12219670">MARGEN DE CONTRIBUCIÓN - GASTOS</td>

            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl16519670">
              <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span><xsl:value-of select="format-number($monto_curr - $objetivo_curr,',##0.00;-,##0.00')"/>
            </td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($autotanque_rendimientos_prev/@kms) div sum($autotanque_rendimientos_prev/@lts)"/>
            <xsl:variable name="monto_curr" select="sum($autotanque_rendimientos_curr/@kms) div sum($autotanque_rendimientos_curr/@lts)"/>

            <xsl:variable name="objetivo_prev" select="sum($autotanque_rendimientos_prev/@lts)"/>
            <xsl:variable name="objetivo_curr" select="sum($autotanque_rendimientos_curr/@lts)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9619670" style="border-top:none">
              RENDIMIENTO DE COMBUSTIBLE
              AUTOTANQUE
            </td>
            <td class="xl8819670" style="border-top:none">
              1.70	
            </td>
            <td class="xl7119670" style="border-top:none;border-left:none">1.80	</td>
            <td class="xl7119670" style="border-top:none;border-left:none">1.90</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="1.70"/>
              <xsl:with-param name="max" select="1.90"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="1.70"/>
              <xsl:with-param name="max" select="1.90"/>
            </xsl:call-template>
            <td class="xl12519670">RENDIMIENTO REAL KMS/LITROS</td>
            <td class="xl16219670">
              <xsl:value-of select="format-number($monto_curr,',##0.00;-,##0.00')"/>
            </td>
            <td class="xl11719670">
              <xsl:value-of select="format-number(sum($autotanque_rendimientos_curr/@kms),',##0.00 kms;-,##0.00 kms')"/>
            </td>
            <td class="xl11719670">
              <xsl:value-of select="format-number(sum($autotanque_rendimientos_curr/@lts),',##0.00 lts;-,##0.00 lts')"/>
            </td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="3" style="mso-height-source:userset;height:2.45pt">
            <td height="3" class="xl6419670" style="height:2.45pt"></td>
            <td class="xl9719670" style="border-top:none">&#160;</td>
            <td class="xl9019670" style="border-top:none">&#160;</td>
            <td class="xl7719670" style="border-top:none">&#160;</td>
            <td class="xl7619670" style="border-top:none">&#160;</td>
            <td class="xl14119670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl15119670">&#160;</td>
            <td class="xl10819670"></td>
            <td class="xl16619670"></td>
            <td class="xl16619670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_viajes_prev/@cant|$tolva_viajes_prev/@cant|$autotanque_viajes_prev/@cant)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_viajes_curr/@cant|$tolva_viajes_curr/@cant|$autotanque_viajes_curr/@cant)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">VIAJES REALIZADOS TOTALES</td>
            <td class="xl9119670" style="border-top:none">
              725
            </td>
            <td class="xl6919670" style="border-top:none">775	</td>
            <td class="xl6819670" style="border-top:none">815</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="725"/>
              <xsl:with-param name="max" select="815"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="725"/>
              <xsl:with-param name="max" select="815"/>
            </xsl:call-template>
            <td class="xl12519670">SUMA DE VIAJES PROYECTADOS</td>
            <td class="xl16619670"></td>
            <td class="xl16719670">
              <xsl:value-of select="$monto_curr"/>
            </td>
            <td class="xl11719670"></td>
            <td class="xl12719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_viajes_prev/@cant)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_viajes_curr/@cant)"/>

            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">VIAJES REALIZADOS PLATAFORMAS</td>
            <td class="xl9219670" style="border-top:none">
              110	
            </td>
            <td class="xl6819670" style="border-top:none;border-left:none">120	</td>
            <td class="xl6819670" style="border-top:none;border-left:none">130</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="110"/>
              <xsl:with-param name="max" select="130"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="110"/>
              <xsl:with-param name="max" select="130"/>
            </xsl:call-template>
            <td class="xl12619670">PROYECCION DE VIAJES</td>
            <td class="xl16619670"></td>
            <td class="xl16719670">
              <xsl:value-of select="$monto_curr"/>
            </td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($tolva_viajes_prev/@cant)"/>
            <xsl:variable name="monto_curr" select="sum($tolva_viajes_curr/@cant)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">VIAJES REALIZADOS TOLVAS</td>
            <td class="xl9219670" style="border-top:none">
              447	
            </td>
            <td class="xl6819670" style="border-top:none;border-left:none">467	</td>
            <td class="xl6819670" style="border-top:none;border-left:none">487</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="447"/>
              <xsl:with-param name="max" select="487"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="447"/>
              <xsl:with-param name="max" select="487"/>
            </xsl:call-template>
            <td class="xl12619670">PROYECCION DE VIAJES</td>
            <td class="xl16619670"></td>
            <td class="xl16719670">
              <xsl:value-of select="$monto_curr"/>
            </td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($autotanque_viajes_prev/@cant)"/>
            <xsl:variable name="monto_curr" select="sum($autotanque_viajes_curr/@cant)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl9819670" style="border-top:none">VIAJES REALIZADOS AUTOTANQUES</td>
            <td class="xl9219670" style="border-top:none">
              168	
            </td>
            <td class="xl6819670" style="border-top:none;border-left:none">188</td>
            <td class="xl6819670" style="border-top:none;border-left:none">198</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="168"/>
              <xsl:with-param name="max" select="198"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="type"></xsl:with-param>
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="1"/>
              <xsl:with-param name="min" select="168"/>
              <xsl:with-param name="max" select="198"/>
            </xsl:call-template>
            <td class="xl12619670">PROYECCION DE VIAJES</td>
            <td class="xl16619670"></td>
            <td class="xl16719670">
              <xsl:value-of select="$monto_curr"/>
            </td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="3" style="mso-height-source:userset;height:2.45pt">
            <td height="3" class="xl6419670" style="height:2.45pt"></td>
            <td class="xl9719670" style="border-top:none">&#160;</td>
            <td class="xl9319670" style="border-top:none">&#160;</td>
            <td class="xl7819670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl7819670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl13919670" style="border-top:none;border-left:none">&#160;</td>
            <td class="xl15019670">&#160;</td>
            <td class="xl12619670">&#160;</td>
            <td class="xl16619670"></td>
            <td class="xl16719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <!--<tr height="18" style="height:13.5pt">
            <xsl:variable name="monto_prev" select="sum($plataformas_viajes_prev/@op|$tolva_viajes_prev/@op|$autotanque_viajes_prev/@op)"/>
            <xsl:variable name="monto_curr" select="sum($plataformas_viajes_curr/@op|$tolva_viajes_curr//@op|$autotanque_viajes_curr/@op)"/>
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl10119670" style="border-top:none">UNIDADES ACTIVAS</td>
            <td class="xl8119670" style="border-top:none">
              80%	
              </td>
            <td class="xl6519670" style="border-top:none;border-left:none">85%	</td>
            <td class="xl6519670" style="border-top:none;border-left:none">90%</td>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_prev"/>
              <xsl:with-param name="dividendo" select="$monto_prev"/>
              <xsl:with-param name="min" select=".80"/>
              <xsl:with-param name="max" select=".90"/>
            </xsl:call-template>
            <xsl:call-template name="indicator">
              <xsl:with-param name="divisor" select="$monto_curr"/>
              <xsl:with-param name="dividendo" select="$monto_curr"/>
              <xsl:with-param name="min" select="134"/>
              <xsl:with-param name="max" select="159"/>
            </xsl:call-template>
            <td class="xl12619670">DIAS CAMION TOTAL/DIAS CAMION REALES</td>
            <td class="xl16619670"></td>
            <td class="xl16719670">
              <xsl:value-of select="$monto_curr"/>
            </td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="19" style="height:14.25pt">
            <td height="19" class="xl6419670" style="height:14.25pt"></td>
            <td class="xl10219670" style="border-top:none">HEAD COUNT</td>
            <td class="xl9419670" style="border-top:none">93%</td>
            <td class="xl6619670" style="border-top:none;border-left:none">94%</td>
            <td class="xl6619670" style="border-top:none;border-left:none">95%</td>
            <td class="xl14319670" align="right" style="border-top:none;border-left:none;
  font-size:8.0pt;color:black;font-weight:700;text-decoration:none;text-underline-style:
  none;text-line-through:none;font-family:&quot;Century Gothic&quot;, sans-serif;
  border-top:.5pt hairline windowtext;border-right:none;border-bottom:1.0pt solid windowtext;
  border-left:.5pt hairline windowtext;background-color:hsl(120, 100%, 30%);mso-pattern:black none">98%</td>
            <td class="xl15319670" align="right" style="font-size:8.0pt;color:black;
  font-weight:700;text-decoration:none;text-underline-style:none;text-line-through:
  none;font-family:&quot;Century Gothic&quot;, sans-serif;border-top:none;border-right:
  1.0pt solid windowtext;border-bottom:1.0pt solid windowtext;border-left:1.0pt solid windowtext;
  background-color:hsl(120, 100%, 30%);mso-pattern:black none">97%</td>
            <td class="xl11519670">PLANTILLA REAL/PLANTILLA REQUERIDA</td>
            <td class="xl11719670"></td>
            <td class="xl11719670"></td>
            <td class="xl12819670"></td>
            <td class="xl13119670"></td>
            <td class="xl10819670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>-->
          <tr height="18" style="height:13.5pt">
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl11419670"></td>
            <td class="xl11419670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl6419670"></td>
            <td class="xl11319670"></td>
            <td class="xl11319670"></td>
            <td class="xl11319670"></td>
            <td class="xl11419670"></td>
            <td class="xl11419670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl11419670"></td>
            <td class="xl11419670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl11419670"></td>
            <td class="xl11419670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl11419670"></td>
            <td class="xl11419670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <tr height="18" style="height:13.5pt">
            <td height="18" class="xl6419670" style="height:13.5pt"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl12919670"></td>
            <td class="xl12919670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl10819670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
            <td class="xl6419670"></td>
          </tr>
          <!--[if supportMisalignedColumns]-->
          <tr height="0" style="display:none">
            <td width="23" style="width:17pt"></td>
            <td width="259" style="width:194pt"></td>
            <td width="49" style="width:37pt"></td>
            <td width="88" style="width:66pt"></td>
            <td width="65" style="width:49pt"></td>
            <td width="91" style="width:68pt"></td>
            <td width="91" style="width:68pt"></td>
            <td width="291" style="width:218pt"></td>
            <td width="104" style="width:78pt"></td>
            <td width="141" style="width:106pt"></td>
            <td width="88" style="width:66pt"></td>
            <td width="88" style="width:66pt"></td>
            <td width="88" style="width:66pt"></td>
            <td width="80" style="width:60pt"></td>
            <td width="80" style="width:60pt"></td>
            <td width="88" style="width:66pt"></td>
          </tr>
          <!--[endif]-->
        </tbody>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="indicator">
    <xsl:param name="type">percent</xsl:param>
    <xsl:param name="divisor"/>
    <xsl:param name="dividendo"/>
    <xsl:param name="min" select="100"/>
    <xsl:param name="max" select="110"/>
    <xsl:variable name="percentage">
      <xsl:choose>
        <xsl:when test="$dividendo=0">0</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$divisor div $dividendo"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="current_color_code">
      <xsl:choose>
        <xsl:when test="$max &gt; $min">
          <xsl:choose>
            <xsl:when test="$percentage&gt;=$max">hsl(120, 100%, 30%);</xsl:when>
            <xsl:when test="$percentage&gt;=(($max + $min) div 2)">hsl(60, 100%, 45%)</xsl:when>
            <xsl:otherwise>hsl(0, 100%, 40%); color:white</xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$percentage&lt;=$max">hsl(120, 100%, 30%);</xsl:when>
            <xsl:when test="$percentage&lt;=(($max + $min) div 2)">hsl(60, 100%, 45%)</xsl:when>
            <xsl:otherwise>hsl(0, 100%, 40%); color:white</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <td class="xl14419670" align="right" style="border-top:none;font-size:8.0pt;
  color:black;font-weight:700;text-decoration:none;text-underline-style:none;
  text-line-through:none;font-family:&quot;Century Gothic&quot;, sans-serif;border-top:
  1.0pt solid windowtext;border-right:1.0pt solid windowtext;border-bottom:
  none;border-left:1.0pt solid windowtext;background-color:{$current_color_code};mso-pattern:black none">
      <xsl:choose>
        <xsl:when test="$type='percent'">
          <xsl:value-of select="format-number($percentage,'##0.00%;-##0.00%')"/>
        </xsl:when>
        <xsl:when test="$type='money'">
          <span style="mso-spacerun:yes">&#160;</span>$<span style="mso-spacerun:yes">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; </span>
          <xsl:value-of select="format-number($percentage,'##0.00;-##0.00')"/>
        </xsl:when>
        <xsl:when test="$type=''">
          <xsl:value-of select="format-number($percentage,'##0.##;-##0.##')"/>
        </xsl:when>
      </xsl:choose>
    </td>
  </xsl:template>

  <xsl:template name="percentage">
    <xsl:param name="divisor"/>
    <xsl:param name="dividendo"/>
    <xsl:variable name="percentage">
      <xsl:choose>
        <xsl:when test="$dividendo=0">0</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$divisor div $dividendo"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="format-number($percentage,'##0.00%;-##0.00%')"/>
  </xsl:template>


  <xsl:template mode="value" match="@status">
    <xsl:value-of select="concat(translate(substring(.,1,1),$lowercase,$uppercase), substring(.,2))"/>
  </xsl:template>
</xsl:stylesheet>