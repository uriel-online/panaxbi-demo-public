<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:js="http://panax.io/xover/javascript"
xmlns:session="http://panax.io/session"
xmlns:sitemap="http://panax.io/sitemap"
xmlns:shell="http://panax.io/shell"
xmlns:state="http://panax.io/state"
xmlns:visible="http://panax.io/state/visible"
xmlns:x="http://panax.io/xover"
exclude-result-prefixes="#default session sitemap shell"
>
  <xsl:import href="keys.xslt"/>
  <xsl:output method="xml"
	   omit-xml-declaration="yes"
	   indent="yes"/>
  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:param name="state:show_empty">false</xsl:param>

  <xsl:template match="text()"/>
  <!--<xsl:param name="session:debug">false</xsl:param>-->

  <xsl:key name="visible:account" match="@visible:*" use="local-name()"/>
  <xsl:template match="/model">
    <div class="container-fluid">
      <xo-listener attribute="state:active"/>
      <xo-listener attribute="state:checked"/>
      <xsl:apply-templates select="cuentas"/>
    </div>
  </xsl:template>

  <xsl:key name="active" match="poliza/@fecha" use="concat(name(),'::',@fecha)"/>
  <xsl:template match="cuentas">
    <xsl:variable name="polizas" select="../polizas"/>
    <xsl:variable name="selected" select="../polizas/@state:selected"/>
    <xsl:variable name="fechas" select="../fechas/fecha[not(key('hidden',@x:id))]/@mes"/>
    <div class="container-fluid">
      <style>
        <![CDATA[
        thead th { text-align:center; background-color: #375623; color: white; padding: 5px 10px}
        tfoot th { text-align:center; background-color: #375623; color: white; padding: 5px 10px}
        tbody td { white-space: nowrap; }
        table td.freeze {
          background-color: white;
        }

        table thead tr.freeze td, table thead tr.freeze th {
          position: sticky;
        }

        table > thead > tr.freeze:nth-child(1) > td, table > thead > tr.freeze:nth-child(1) > th {
          top: 0px;
        }

        table > thead > tr.freeze:nth-child(2) > td, table > thead > tr.freeze:nth-child(2) > th {
          top: 20px;
        }

        table > thead > tr.freeze:nth-child(3) > td, table > thead > tr.freeze:nth-child(3) > th {
          top: 40px;
        }

        table > thead > tr.freeze:nth-child(4) > td, table > thead > tr.freeze:nth-child(4) > th {
          top: 60px;
        }

        table > thead > tr.freeze:nth-child(5) > td, table > thead > tr.freeze:nth-child(5) > th {
          top: 80px;
        }

        table tr.freeze td.freeze, table tr.freeze th.freeze {
          z-index: 911;
        }

        table tr.freeze td.freeze img, table tr.freeze th.freeze img {
          z-index: 912;
        }

        table tr.n1 .concepto {
          color: black !important;
        }

        table tr.n1 .concepto {
          padding-left: 10px;
        }

        table tr.n2 .concepto {
          padding-left: 27px;
        }

        table tr.n3 .concepto {
          padding-left: 44px;
        }

        table tr.n4 .concepto {
          padding-left: 61px;
        }

        table tr.n5 .concepto {
          padding-left: 88px;
        }

        table tr.n6 .concepto {
          padding-left: 95px;
        }

        table tr.n1 {
          font-weight: 900;
        }

        table tr.n2 {
          font-weight: bold;
        }

        table tr.n3 th, table tr.n3 td {
          font-weight: normal;
          background-color: cornsilk !important;
        }

        table tr.n4 {
          font-weight: normal;
          font-style: italic;
        }

        table tr.n5 th, table tr.n5 td {
          font-weight: lighter;
          background-color: aliceblue !important;
        }

        table tr.n6 {
          font-weight: lighter;
          font-style: italic;
        }
        
        svg.disabled {color:silver;}
      ]]>
      </style>
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <div class="row">
          <style>
            .offcanvas-end { width:530px !important }
          </style>
          <div class="offcanvas offcanvas-end" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-header">
              <h5 id="offcanvasRightLabel">Gráfica</h5>
              <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
              <div style="width:30vw; max-height:30vh;">
                <canvas id="myChart" width="400" height="200"></canvas>
              </div>
              <script>
                <![CDATA[
				const data = {
				labels: [
					]]>
                <xsl:for-each select="$fechas">
                  <xsl:if test="position()&gt;1">,</xsl:if>
                  <xsl:value-of select="concat(&quot;'&quot;,substring(.,1,4),'-',substring(.,5),&quot;'&quot;)"/>
                </xsl:for-each>
                <![CDATA[
				],
				datasets: [{
					type: 'bar',
					label: 'Ingresos',
					data: []]>
                <xsl:for-each select="key('cuentas',string($selected))[key('ventas',@x:id)][@n=1][key('expanded',@x:id) and not(key('hidden',@x:id))]">
                  <xsl:variable name="cuenta" select="."/>
                  <xsl:for-each select="$fechas">
                    <xsl:variable name="monto" select="sum(key('polizas', concat($cuenta/@id, '::', .))[key('unidad_negocios',string(../@un))][key('divisiones',string(../@div))][key('razones_sociales',string(../@rs))]/@monto)"/>
                    <xsl:if test="position()&gt;1">,</xsl:if>
                    <xsl:value-of select="$monto"/>
                  </xsl:for-each>
                </xsl:for-each>
                <![CDATA[],
					borderColor: 'rgb(255, 99, 132)',
					backgroundColor: 'rgba(255, 99, 132, 0.2)'
				}, {
					type: 'line',
					label: 'Presupuesto',
					data: []]>
                <xsl:for-each select="key('cuentas',string($selected))[key('ventas',@x:id)][@n=1][key('expanded',@x:id) and not(key('hidden',@x:id))]">
                  <xsl:variable name="cuenta" select="."/>
                  <xsl:for-each select="$fechas">
                    <xsl:variable name="monto" select="sum(key('presupuestos', concat($cuenta/@id, '::', .))[key('unidad_negocios',string(../@un))][key('divisiones',string(../@div))][key('razones_sociales',string(../@rs))]/@monto)"/>
                    <xsl:if test="position()&gt;1">,</xsl:if>
                    <xsl:value-of select="$monto"/>
                  </xsl:for-each>
                </xsl:for-each>
                <![CDATA[],
					fill: false,
					borderColor: 'rgb(54, 162, 235)'
				}]
				};
				const config = {
					type: 'scatter',
					data: data,
					options: {
						scales: { y: { beginAtZero: true } }
					}
				};
				const ctx = document.getElementById('myChart').getContext('2d');
				const myChart = new Chart(ctx, config);
]]>
              </script>
            </div>
          </div>
        </div>
      </div>
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <table width="border-spacing: 10px; border-collapse: separate;">
          <thead>
            <tr style="background-color:#375623; color: white;" class="freeze">
              <th>&#160;</th>
              <th class="freeze">Cuenta</th>
              <xsl:for-each select="../fechas/fecha[not(key('hidden',@x:id))]/@mes">
                <th style="padding: 10px; text-align: center; white-space: nowrap; cursor: pointer;" xo-scope="{../@x:id}" xo-attribute="limit" onclick="scope.set('true')">
                  <xsl:if test="../@limit">
                    <xsl:attribute name="onclick">scope.remove()</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="concat(substring(.,1,4),'-',substring(.,5))"/>
                  <xsl:if test="../@limit">
                    &#160;
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-flag-fill" viewBox="0 0 16 16">
                      <path d="M14.778.085A.5.5 0 0 1 15 .5V8a.5.5 0 0 1-.314.464L14.5 8l.186.464-.003.001-.006.003-.023.009a12.435 12.435 0 0 1-.397.15c-.264.095-.631.223-1.047.35-.816.252-1.879.523-2.71.523-.847 0-1.548-.28-2.158-.525l-.028-.01C7.68 8.71 7.14 8.5 6.5 8.5c-.7 0-1.638.23-2.437.477A19.626 19.626 0 0 0 3 9.342V15.5a.5.5 0 0 1-1 0V.5a.5.5 0 0 1 1 0v.282c.226-.079.496-.17.79-.26C4.606.272 5.67 0 6.5 0c.84 0 1.524.277 2.121.519l.043.018C9.286.788 9.828 1 10.5 1c.7 0 1.638-.23 2.437-.477a19.587 19.587 0 0 0 1.349-.476l.019-.007.004-.002h.001"/>
                    </svg>
                  </xsl:if>
                </th>
              </xsl:for-each>
            </tr>
          </thead>
          <xsl:for-each select="/model[divisiones/division[2]][not(divisiones/division[@state:checked='true'] or unidades_negocio/unidad_negocio[@state:checked='true'])]
              |/model[razones_sociales/razon_social[2]][not(razones_sociales/razon_social[@state:checked='true'] or unidades_negocio/unidad_negocio[@state:checked='true'])]/divisiones/division[key('divisiones',@id)]
              |/model[razones_sociales/razon_social[@state:checked='true'] or divisiones/division[@state:checked='true']][not(unidades_negocio/unidad_negocio[@state:checked='true'])]/razones_sociales/razon_social[key('razones_sociales',@id)]
              |/model[unidades_negocio/unidad_negocio[@state:checked='true'] or razones_sociales/razon_social[@state:checked='true']]/unidades_negocio/unidad_negocio[key('unidad_negocios',string(../@un))][not(@id=-1 and not(../unidad_negocio[2]) and not(@state:checked='true'))]">
            <xsl:variable name="div" select="self::division/@id|self::model/division/@id|self::*[not(self::division)]/ancestor-or-self::model[1]/divisiones/division[key('divisiones',@id)]/@id"/>
            <xsl:variable name="rs" select="self::razon_social/@id|self::*[not(self::razon_social)]/ancestor-or-self::model[1]/razones_sociales/razon_social[key('razones_sociales',@id)]/@id"/>
            <xsl:variable name="un" select="self::unidad_negocio/@id|self::*[not(self::unidad_negocio)]/ancestor-or-self::model[1]/unidades_negocio/unidad_negocio[key('unidad_negocios',string(../@un))]/@id"/>
            <tbody>
              <xsl:attribute name="div">
                <xsl:choose>
                  <xsl:when test="count($div)=1">
                    <xsl:value-of select="$div"/>
                  </xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:attribute name="rs">
                <xsl:choose>
                  <xsl:when test="count($rs)=1">
                    <xsl:value-of select="$rs"/>
                  </xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:attribute name="un">
                <xsl:choose>
                  <xsl:when test="count($un)=1">
                    <xsl:value-of select="$un"/>
                  </xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
              <xsl:variable name="dims">
                <xsl:text>dims_</xsl:text>
                <xsl:choose>
                  <xsl:when test="not($div[2])">
                    <xsl:value-of select="$div"/>
                  </xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
                <xsl:text>_</xsl:text>
                <xsl:choose>
                  <xsl:when test="not($rs[2])">
                    <xsl:value-of select="$rs"/>
                  </xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
                <xsl:text>_</xsl:text>
                <xsl:choose>
                  <xsl:when test="not($un[2])">
                    <xsl:value-of select="$un"/>
                  </xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <tr>
                <td>
                  <select xo-attribute="state:selectedLevel" onchange="scope.set(this.value)">
                    <option selected=""></option>
                    <option>
                      <xsl:if test="@state:selectedLevel=1">
                        <xsl:attribute name="selected"/>
                      </xsl:if>1
                    </option>
                    <option>
                      <xsl:if test="@state:selectedLevel=2">
                        <xsl:attribute name="selected"/>
                      </xsl:if>2
                    </option>
                    <option>
                      <xsl:if test="@state:selectedLevel=3">
                        <xsl:attribute name="selected"/>
                      </xsl:if>3
                    </option>
                    <option>
                      <xsl:if test="@state:selectedLevel=4">
                        <xsl:attribute name="selected"/>
                      </xsl:if>4
                    </option>
                    <option>
                      <xsl:if test="@state:selectedLevel=5">
                        <xsl:attribute name="selected"/>
                      </xsl:if>5
                    </option>
                  </select>
                </td>
                <th colspan="100" style="text-align:left" class="freeze">
                  <xsl:variable name="header_type">
                    <xsl:choose>
                      <xsl:when test="self::model">h1</xsl:when>
                      <xsl:when test="self::division">h1</xsl:when>
                      <xsl:when test="self::razon_social">h3</xsl:when>
                      <xsl:when test="self::unidad_negocio">h5</xsl:when>
                    </xsl:choose>
                  </xsl:variable>
                  <xsl:element name="{$header_type}">
                    <xsl:choose>
                      <xsl:when test="self::model">GLOBAL</xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="@nom"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:element>
                </th>
              </tr>
              <xsl:for-each select="key('cuentas',string($selected))[key('ventas',@x:id) or key('costo_ventas',@x:id)][@n='1' or key('visible:account',concat($dims,'_',@id))]">
                <xsl:variable name="cuenta" select="."/>
                <xsl:variable name="polizas_x_cuenta" select="key('polizas', concat($cuenta/@id, '::',''))[(@n1 or count($un)=1) and ../@un=$un or count($un)!=1 and ../@un=0][(@n1 or count($rs)=1) and ../@rs=$rs or count($rs)!=1 and ../@rs=0][(@n1 or count($div)=1) and ../@div=$div or count($div)!=1 and ../@div=0]/@monto"/>
                <xsl:variable name="style_row">
                  <xsl:if test="$cuenta/@n=1">background-color:#A9D08E !important;</xsl:if>
                </xsl:variable>
                <tr xo-scope="{@x:id}" style="{$style_row}" cta="{$cuenta/@id}" dims="{$dims}">
                  <xsl:attribute name="class">
                    <xsl:value-of select="concat('n',$cuenta/@n)"/>
                    <xsl:for-each select="ancestor::cuenta/@id">
                      <xsl:text/> cta_<xsl:value-of select="."/><xsl:text/>
                    </xsl:for-each>
                    <xsl:if test="count($polizas_x_cuenta)=0 and not($state:show_empty='true')"> hidden</xsl:if>
                    <xsl:if test="@n and not(//polizas/poliza/@*[name()=concat('n',current()/@n)])">
                      <xsl:text> skeleton skeleton-text</xsl:text>
                    </xsl:if>
                  </xsl:attribute>
                  <td>
                    <xsl:value-of select="@n"/>
                  </td>
                  <td style="white-space: nowrap; {$style_row}" class="freeze concepto">
                    <xsl:choose>
                      <xsl:when test="not($cuenta/cuenta)">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-slash-square disabled" viewBox="0 0 16 16">
                          <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                          <path d="M11.354 4.646a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708l6-6a.5.5 0 0 1 .708 0z"/>
                        </svg>
                      </xsl:when>
                      <xsl:when test="key('visible:account',concat($dims,'_',$cuenta/cuenta/@id))">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-square" viewBox="0 0 16 16" style="cursor:pointer;" xo-attribute="state:expanded" onclick="scope.set('false')">
                          <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                          <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                        </svg>
                      </xsl:when>
                      <xsl:otherwise>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16" style="cursor:pointer;" xo-attribute="state:expanded" onclick="scope.set('true')">
                          <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                          <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                        </svg>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="concat(' ',@num, ' - ', @nom)"/>
                    <!--- <xsl:value-of select="concat($cuenta/@id, '::', .)"/> - <xsl:value-of select="count(key('polizas', concat($cuenta/@id, '::', .))[../@un=$un or count($un)!=1 and ../@un=0][../@rs=$rs or count($rs)!=1 and ../@rs=0][../@div=$div or count($div)!=1 and ../@div=0])"/>
                    -<xsl:value-of select="$div[count($div)=1]"/>/<xsl:value-of select="$rs[count($rs)=1]"/>/<xsl:value-of select="$un[count($un)=1]"/>/<xsl:value-of select="$cuenta/@id"/>-->
                  </td>
                  <xsl:for-each select="$fechas">
                    <xsl:variable name="factor">
                      <xsl:choose>
                        <xsl:when test="starts-with($cuenta/@num,'4')">1</xsl:when>
                        <xsl:otherwise>-1</xsl:otherwise>
                      </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="monto" select="$factor * sum(key('polizas', concat($cuenta/@id, '::', .))[(@n1 or count($un)=1) and ../@un=$un or count($un)!=1 and ../@un=0][(@n1 or count($rs)=1) and ../@rs=$rs or count($rs)!=1 and ../@rs=0][(@n1 or count($div)=1) and ../@div=$div or count($div)!=1 and ../@div=0]/@monto)"/>
                    <xsl:variable name="style">
                      <xsl:if test="$monto&lt;0">color: red;</xsl:if>
                    </xsl:variable>
                    <xsl:variable name="fecha" select="."/>
                    <xsl:variable name="domain">
                      <xsl:choose>
                        <xsl:when test="count($div)=1">
                          <xsl:value-of select="$div"/>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                      </xsl:choose>
                      <xsl:text>-</xsl:text>
                      <xsl:choose>
                        <xsl:when test="count($rs)=1">
                          <xsl:value-of select="$rs"/>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                      </xsl:choose>
                      <xsl:text>-</xsl:text>
                      <xsl:choose>
                        <xsl:when test="count($un)=1">
                          <xsl:value-of select="$un"/>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                      </xsl:choose>
                      <xsl:text>-</xsl:text>
                      <xsl:value-of select="$cuenta/../@num"/>
                    </xsl:variable>
                    <td class="cell domain-lvl-{$domain}" style="text-align: right; white-space: nowrap; cursor: cell; {$style}">
                      <xsl:attribute name="div">
                        <xsl:choose>
                          <xsl:when test="count($div)=1">
                            <xsl:value-of select="$div"/>
                          </xsl:when>
                          <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <xsl:attribute name="rs">
                        <xsl:choose>
                          <xsl:when test="count($rs)=1">
                            <xsl:value-of select="$rs"/>
                          </xsl:when>
                          <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <xsl:attribute name="un">
                        <xsl:choose>
                          <xsl:when test="count($un)=1">
                            <xsl:value-of select="$un"/>
                          </xsl:when>
                          <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <xsl:attribute name="cta">
                        <xsl:value-of select="$cuenta/@num"/>
                      </xsl:attribute>
                      <xsl:attribute name="fecha">
                        <xsl:value-of select="$fecha"/>
                      </xsl:attribute>
                      <xsl:attribute name="value">
                        <xsl:value-of select="$monto"/>
                      </xsl:attribute>
                      <xsl:value-of select="format-number($monto,'$,##0;-$,##0')"/>
                    </td>
                  </xsl:for-each>
                </tr>
              </xsl:for-each>
              <xsl:variable name="style_row_subtotales">
                <xsl:text/>background-color:#548235; font-weight:bolder; color: white;<xsl:text/>
              </xsl:variable>
              <tr style="{$style_row_subtotales}">
                <td>
                  <xsl:text/>&#160;<xsl:text/>
                </td>
                <td style="white-space: nowrap; {$style_row_subtotales}" class="freeze concepto">
                  <xsl:text/>UTILIDAD / PÉRDIDA BRUTA<xsl:text/>
                </td>
                <xsl:for-each select="$fechas">
                  <xsl:variable name="ventas" select="key('polizas', concat(//cuentas/cuenta[key('ventas',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>
                  <xsl:variable name="costo_ventas" select="key('polizas', concat(//cuentas/cuenta[key('costo_ventas',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>

                  <xsl:variable name="monto" select="sum($ventas|$costo_ventas)"/>
                  <xsl:variable name="style">
                    <xsl:if test="$monto&lt;0">color: red;</xsl:if>
                  </xsl:variable>
                  <td style="text-align: right; {$style}">
                    <xsl:value-of select="format-number($monto,'$,##0;-$,##0')"/>
                  </td>
                </xsl:for-each>
              </tr>
              <xsl:for-each select="key('cuentas',string($selected))[key('gastos',@x:id)][@n='1' or key('visible:account',concat($dims,'_',@id))]">
                <xsl:variable name="cuenta" select="."/>
                <xsl:variable name="polizas_x_cuenta" select="key('polizas', concat($cuenta/@id, '::',''))[(@n1 or count($un)=1) and ../@un=$un or count($un)!=1 and ../@un=0][(@n1 or count($rs)=1) and ../@rs=$rs or count($rs)!=1 and ../@rs=0][(@n1 or count($div)=1) and ../@div=$div or count($div)!=1 and ../@div=0]/@monto"/>
                <xsl:variable name="style_row">
                  <xsl:if test="$cuenta/@n=1">background-color:#A9D08E !important;</xsl:if>
                </xsl:variable>
                <tr xo-scope="{@x:id}" style="{$style_row}" cta="{$cuenta/@id}">
                  <xsl:attribute name="class">
                    <xsl:value-of select="concat('n',$cuenta/@n)"/>
                    <xsl:for-each select="ancestor::cuenta/@id">
                      <xsl:text/> cta_<xsl:value-of select="."/><xsl:text/>
                    </xsl:for-each>
                    <xsl:if test="count($polizas_x_cuenta)=0 and not($state:show_empty='true')"> hidden</xsl:if>
                    <xsl:if test="@n and not(//polizas/poliza/@*[name()=concat('n',current()/@n)])">
                      <xsl:text> skeleton skeleton-text</xsl:text>
                    </xsl:if>
                  </xsl:attribute>
                  <td>
                    <xsl:value-of select="@n"/>
                  </td>
                  <td style="white-space: nowrap; {$style_row}" class="freeze concepto">
                    <xsl:choose>
                      <xsl:when test="not($cuenta/cuenta)">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-slash-square disabled" viewBox="0 0 16 16">
                          <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                          <path d="M11.354 4.646a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708l6-6a.5.5 0 0 1 .708 0z"/>
                        </svg>
                      </xsl:when>
                      <xsl:when test="key('visible:account',concat($dims,'_',$cuenta/cuenta/@id))">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-square" viewBox="0 0 16 16" style="cursor:pointer;" xo-attribute="state:expanded" onclick="scope.set('false')">
                          <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                          <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                        </svg>
                      </xsl:when>
                      <xsl:otherwise>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16" style="cursor:pointer;" xo-attribute="state:expanded" onclick="scope.set('true')">
                          <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                          <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                        </svg>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="concat(' ',@num, ' - ', @nom)"/>
                  </td>
                  <xsl:for-each select="$fechas">
                    <xsl:variable name="factor">
                      <xsl:choose>
                        <xsl:when test="starts-with($cuenta/@num,'4')">1</xsl:when>
                        <xsl:otherwise>-1</xsl:otherwise>
                      </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="monto" select="$factor * sum(key('polizas', concat($cuenta/@id, '::', .))[(@n1 or count($un)=1) and ../@un=$un or count($un)!=1 and ../@un=0][(@n1 or count($rs)=1) and ../@rs=$rs or count($rs)!=1 and ../@rs=0][(@n1 or count($div)=1) and ../@div=$div or count($div)!=1 and ../@div=0]/@monto)"/>
                    <xsl:variable name="style">
                      <xsl:if test="$monto&lt;0">color: red;</xsl:if>
                    </xsl:variable>
                    <xsl:variable name="fecha" select="."/>
                    <xsl:variable name="domain">
                      <xsl:choose>
                        <xsl:when test="count($div)=1">
                          <xsl:value-of select="$div"/>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                      </xsl:choose>
                      <xsl:text>-</xsl:text>
                      <xsl:choose>
                        <xsl:when test="count($rs)=1">
                          <xsl:value-of select="$rs"/>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                      </xsl:choose>
                      <xsl:text>-</xsl:text>
                      <xsl:choose>
                        <xsl:when test="count($un)=1">
                          <xsl:value-of select="$un"/>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                      </xsl:choose>
                      <xsl:text>-</xsl:text>
                      <xsl:value-of select="$cuenta/../@num"/>
                    </xsl:variable>
                    <td class="cell domain-lvl-{$domain}" style="text-align: right; white-space: nowrap; cursor: cell; {$style}">
                      <xsl:attribute name="div">
                        <xsl:choose>
                          <xsl:when test="count($div)=1">
                            <xsl:value-of select="$div"/>
                          </xsl:when>
                          <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <xsl:attribute name="rs">
                        <xsl:choose>
                          <xsl:when test="count($rs)=1">
                            <xsl:value-of select="$rs"/>
                          </xsl:when>
                          <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <xsl:attribute name="un">
                        <xsl:choose>
                          <xsl:when test="count($un)=1">
                            <xsl:value-of select="$un"/>
                          </xsl:when>
                          <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <xsl:attribute name="cta">
                        <xsl:value-of select="$cuenta/@num"/>
                      </xsl:attribute>
                      <xsl:attribute name="fecha">
                        <xsl:value-of select="$fecha"/>
                      </xsl:attribute>
                      <xsl:value-of select="format-number($monto,'$,##0;-$,##0')"/>
                    </td>
                  </xsl:for-each>
                </tr>
              </xsl:for-each>
              <tr style="{$style_row_subtotales}">
                <td>
                  <xsl:text/>&#160;<xsl:text/>
                </td>
                <td style="white-space: nowrap; {$style_row_subtotales}" class="freeze concepto">
                  <xsl:text/>UTILIDAD (PÉRDIDA) OPERATIVA / EBITDA<xsl:text/>
                </td>
                <xsl:for-each select="$fechas">
                  <xsl:variable name="ventas" select="key('polizas', concat(//cuentas/cuenta[key('ventas',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>
                  <xsl:variable name="costo_ventas" select="key('polizas', concat(//cuentas/cuenta[key('costo_ventas',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>
                  <xsl:variable name="gastos" select="key('polizas', concat(//cuentas/cuenta[key('gastos',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>

                  <xsl:variable name="monto" select="sum($ventas|$costo_ventas|$gastos)"/>
                  <xsl:variable name="style">
                    <xsl:if test="$monto&lt;0">color: red;</xsl:if>
                  </xsl:variable>
                  <td style="text-align: right; {$style}">
                    <xsl:value-of select="format-number($monto,'$,##0;-$,##0')"/>
                  </td>
                </xsl:for-each>
              </tr>
              <xsl:for-each select="key('cuentas',string($selected))[key('otros_gastos',@x:id) or key('otros',@x:id) or key('orden',@x:id)][@n='1' or key('visible:account',concat($dims,'_',@id))]">
                <xsl:variable name="cuenta" select="."/>
                <xsl:variable name="polizas_x_cuenta" select="key('polizas', concat($cuenta/@id, '::',''))[(@n1 or count($un)=1) and ../@un=$un or count($un)!=1 and ../@un=0][(@n1 or count($rs)=1) and ../@rs=$rs or count($rs)!=1 and ../@rs=0][(@n1 or count($div)=1) and ../@div=$div or count($div)!=1 and ../@div=0]/@monto"/>
                <xsl:variable name="style_row">
                  <xsl:if test="$cuenta/@n=1">background-color:#A9D08E !important;</xsl:if>
                </xsl:variable>
                <xsl:variable name="domain">
                  <xsl:if test="count($div)=1">
                    <xsl:value-of select="$div"/>
                  </xsl:if>
                  <xsl:text>-</xsl:text>
                  <xsl:if test="count($rs)=1">
                    <xsl:value-of select="$rs"/>
                  </xsl:if>
                  <xsl:text>-</xsl:text>
                  <xsl:if test="count($un)=1">
                    <xsl:value-of select="$un"/>
                  </xsl:if>
                  <xsl:text>-</xsl:text>
                  <xsl:value-of select="$cuenta/../@num"/>
                </xsl:variable>
                <tr xo-scope="{@x:id}" style="{$style_row}" cta="{$cuenta/@id}">
                  <xsl:attribute name="class">
                    <xsl:value-of select="concat('n',$cuenta/@n)"/>
                    <xsl:for-each select="ancestor::cuenta/@id">
                      <xsl:text/> cta_<xsl:value-of select="."/><xsl:text/>
                    </xsl:for-each>
                    <xsl:if test="count($polizas_x_cuenta)=0 and not($state:show_empty='true')"> hidden</xsl:if>
                    <xsl:if test="@n and not(//polizas/poliza/@*[name()=concat('n',current()/@n)])">
                      <xsl:text> skeleton skeleton-text</xsl:text>
                    </xsl:if>
                  </xsl:attribute>
                  <td>
                    <xsl:value-of select="@n"/>
                  </td>
                  <td style="white-space: nowrap; {$style_row}" class="freeze concepto">
                    <xsl:choose>
                      <xsl:when test="not($cuenta/cuenta)">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-slash-square disabled" viewBox="0 0 16 16">
                          <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                          <path d="M11.354 4.646a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708l6-6a.5.5 0 0 1 .708 0z"/>
                        </svg>
                      </xsl:when>
                      <xsl:when test="key('visible:account',concat($dims,'_',$cuenta/*/@id))">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-square" viewBox="0 0 16 16" style="cursor:pointer;" xo-attribute="state:expanded" onclick="scope.set('false')">
                          <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                          <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
                        </svg>
                      </xsl:when>
                      <xsl:otherwise>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16" style="cursor:pointer;" xo-attribute="state:expanded" onclick="scope.set('true')">
                          <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                          <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                        </svg>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="concat(' ',@num, ' - ', @nom)"/>
                  </td>
                  <xsl:for-each select="$fechas">
                    <xsl:variable name="factor">
                      <xsl:choose>
                        <xsl:when test="starts-with($cuenta/@num,'4')">1</xsl:when>
                        <xsl:otherwise>-1</xsl:otherwise>
                      </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="monto" select="$factor * sum(key('polizas', concat($cuenta/@id, '::', .))[(@n1 or count($un)=1) and ../@un=$un or count($un)!=1 and ../@un=0][(@n1 or count($rs)=1) and ../@rs=$rs or count($rs)!=1 and ../@rs=0][(@n1 or count($div)=1) and ../@div=$div or count($div)!=1 and ../@div=0]/@monto)"/>
                    <xsl:variable name="style">
                      <xsl:if test="$monto&lt;0">color: red;</xsl:if>
                    </xsl:variable>
                    <xsl:variable name="fecha" select="."/>
                    <td class="cell domain-lvl-{$domain}" style="text-align: right; white-space: nowrap; cursor: cell; {$style}">
                      <xsl:attribute name="div">
                        <xsl:choose>
                          <xsl:when test="count($div)=1">
                            <xsl:value-of select="$div"/>
                          </xsl:when>
                          <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <xsl:attribute name="rs">
                        <xsl:choose>
                          <xsl:when test="count($rs)=1">
                            <xsl:value-of select="$rs"/>
                          </xsl:when>
                          <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <xsl:attribute name="un">
                        <xsl:choose>
                          <xsl:when test="count($un)=1">
                            <xsl:value-of select="$un"/>
                          </xsl:when>
                          <xsl:otherwise></xsl:otherwise>
                        </xsl:choose>
                      </xsl:attribute>
                      <xsl:attribute name="cta">
                        <xsl:value-of select="$cuenta/@num"/>
                      </xsl:attribute>
                      <xsl:attribute name="fecha">
                        <xsl:value-of select="$fecha"/>
                      </xsl:attribute>
                      <xsl:value-of select="format-number($monto,'$,##0;-$,##0')"/>
                    </td>
                  </xsl:for-each>
                </tr>
              </xsl:for-each>
              <tr style="{$style_row_subtotales}">
                <td>
                  <xsl:text/>&#160;<xsl:text/>
                </td>
                <td style="white-space: nowrap; {$style_row_subtotales}" class="freeze concepto">
                  <xsl:text/>UTILIDAD NETA<xsl:text/>
                </td>
                <xsl:for-each select="$fechas">
                  <xsl:variable name="ventas" select="key('polizas', concat(//cuentas/cuenta[key('ventas',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>
                  <xsl:variable name="costo_ventas" select="key('polizas', concat(//cuentas/cuenta[key('costo_ventas',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>
                  <xsl:variable name="gastos" select="key('polizas', concat(//cuentas/cuenta[key('gastos',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>
                  <xsl:variable name="otros_gastos" select="key('polizas', concat(//cuentas/cuenta[key('otros_gastos',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>
                  <xsl:variable name="otros" select="key('polizas', concat(//cuentas/cuenta[key('otros',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>
                  <xsl:variable name="orden" select="key('polizas', concat(//cuentas/cuenta[key('orden',@x:id)]/@id, '::', .))[../@un=$un or ../@un=0][../@rs=$rs or ../@rs=0][../@div=$div or ../@div=0]/@monto"/>

                  <xsl:variable name="monto" select="sum($ventas|$costo_ventas|$gastos|$otros_gastos|$otros|$orden)"/>
                  <xsl:variable name="style">
                    <xsl:if test="$monto&lt;0">color: red;</xsl:if>
                  </xsl:variable>
                  <td style="text-align: right; {$style}">
                    <xsl:value-of select="format-number($monto,'$,##0;-$,##0')"/>
                  </td>
                </xsl:for-each>
              </tr>
            </tbody>
          </xsl:for-each>
        </table>
      </div>
    </div>
  </xsl:template>

  <xsl:template mode="link" match="@*">
    <xsl:param name="n" select="node-expected"/>
    <xsl:param name="cta" select="node-expected"/>
    <xsl:param name="fecha" select="node-expected"/>
    <xsl:param name="div" select="node-expected"/>
    <xsl:param name="rs" select="node-expected"/>
    <xsl:param name="un" select="node-expected"/>
    <xsl:param name="monto" select="node-expected"/>
    <xsl:variable name="substring">
      <xsl:choose>
        <xsl:when test="$cta/@n=1">1</xsl:when>
        <xsl:when test="$cta/@n=2">3</xsl:when>
        <xsl:when test="$cta/@n=3">4</xsl:when>
        <xsl:when test="$cta/@n=4">8</xsl:when>
        <xsl:when test="$cta/@n=5">12</xsl:when>
        <xsl:when test="$cta/@n=6">12</xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:attribute name="href">
      <xsl:text>#polizas?@cta=</xsl:text>
      <xsl:value-of select="substring($cta/@num,1,$substring)"/>
      <xsl:text>&amp;@fecha=</xsl:text>
      <xsl:value-of select="$fecha"/>
      <xsl:text>&amp;@div=</xsl:text>
      <xsl:value-of select="$div"/>
      <xsl:text>&amp;monto=</xsl:text>
      <xsl:value-of select="$monto"/>
      <!--<xsl:if test="count($rs)=1">
        <xsl:text>&amp;@rs=</xsl:text>
        <xsl:value-of select="$rs"/>
      </xsl:if>
      <xsl:if test="count($un)=1">
        <xsl:text>&amp;@un=</xsl:text>
        <xsl:value-of select="$un"/>
      </xsl:if>-->
    </xsl:attribute>
  </xsl:template>

  <xsl:template mode="value" match="@status">
    <xsl:value-of select="concat(translate(substring(.,1,1),$lowercase,$uppercase), substring(.,2))"/>
  </xsl:template>
</xsl:stylesheet>