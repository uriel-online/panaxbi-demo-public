<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xo="http://panax.io/xover"
  xmlns:sitemap="http://panax.io/sitemap"
  xmlns:state="http://panax.io/state"
  xmlns:layout="http://panax.io/layout/view/form"
  exclude-result-prefixes="xo xsl sitemap layout"
>
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
</xsl:stylesheet>