<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:js="http://panax.io/languages/javascript"
  exclude-result-prefixes="js">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:param name="js:year">new Date().getFullYear()</xsl:param>

  <xsl:template match="/*">
    <section class="login" aria-labelledby="login-title">
      <style>
        .login {
          display: flex;
          min-height: 100vh;
          min-height: 100dvh;
          padding: 1.5rem;
          background-color: #f5f5f5;
        }
        .form-signin {
          width: 100%;
          max-width: 330px;
          margin: auto;
        }
        .form-signin input { font-size: 16px; }
        .form-signin [role="alert"]:empty { display: none; }
      </style>
      <form class="form-signin" method="post">
        <img src="assets/logo.png" alt="" height="72" class="d-block mx-auto mb-3"/>
        <h1 id="login-title" class="h3 text-center mb-4">Bienvenido</h1>
        <label for="username" class="form-label">Usuario</label>
        <input id="username" name="username" type="text" class="form-control mb-3" autocomplete="username" required="" autofocus=""/>
        <label for="password" class="form-label">Contraseña</label>
        <input id="password" name="password" type="password" class="form-control mb-3" autocomplete="current-password" required=""/>
        <button class="btn btn-primary w-100" type="submit">Ingresar</button>
        <p class="text-danger mt-3 mb-0" role="alert"/>
        <p class="text-center text-muted mt-4 mb-0">©Panax 2022 - <xsl:value-of select="$js:year"/></p>
      </form>
    </section>
  </xsl:template>
</xsl:stylesheet>
