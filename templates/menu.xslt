<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:session="http://panax.io/session"
  exclude-result-prefixes="session">
  <xsl:param name="session:user_login"/>

  <xsl:template name="portal-menu">
    <div class="portal-shell-menu">
      <div class="portal-report-actions" aria-label="Acciones del reporte" hidden="hidden">
        <button type="button" aria-label="Descargar Excel" title="Descargar Excel" onclick="this.dispatch('report:export')">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3v12m-4-4 4 4 4-4M4 16v4h16v-4"/></svg>
        </button>
        <button type="button" aria-label="Imprimir" title="Imprimir" onclick="this.dispatch('shell:print')">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true"><path d="M6 8V3h12v5M6 17H3V8h18v9h-3M6 14h12v7H6zm12-3h1"/></svg>
        </button>
      </div>
      <div class="dropdown">
        <button type="button" class="dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="7" r="3"/><path d="M5 21v-2a7 7 0 0 1 14 0v2z"/></svg>
          <span><xsl:value-of select="$session:user_login"/></span>
        </button>
        <ul class="dropdown-menu dropdown-menu-end">
          <li><button type="button" class="dropdown-item" onclick="this.dispatch('shell:logout')">Cerrar sesión</button></li>
        </ul>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>
