<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xo="http://panax.io/xover"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xsl xo"
>
  <xsl:output method="xml"
     omit-xml-declaration="yes"
     indent="yes" standalone="no"/>

  <xsl:template match="xo:message">
    <dialog open="open" style="width: 450px; height: 200px; margin: 0 auto; top: 25vh; padding: 1rem; overflow: auto; position: fixed;" role="alertdialog"><header style="display:flex;justify-content: end;"><button type="button" formmethod="dialog" aria-label="Close" onclick="this.closest('dialog').remove();" style="background-color:transparent;border: none;"><svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="bi bi-x-circle text-primary_messages" viewBox="0 0 24 24"><path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path><path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"></path></svg></button></header><form method="dialog" onsubmit="closest('dialog').remove()"><h4 style="margin-left: 3rem !important;"><xsl:apply-templates/></h4></form></dialog>
  </xsl:template>

  <xsl:template match="html:*"><xsl:copy-of select="."/></xsl:template>
</xsl:stylesheet>
