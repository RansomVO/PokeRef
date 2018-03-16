<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common">
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html>
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/global.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <link type="text/css" rel="stylesheet" >
          <xsl:attribute name="href">
            <xsl:text>index.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </link>

        <title>HTTP 404 - File Not Found</title>
      </head>

      <body style="color:white; background-color:dimgray; font-size:1.5em;">
        <h1 style="color:red">HTTP 404 - File Not Found</h1>
        <br />
        <h2>The requested page cannot be found!</h2>
        <br />
        <p>
          <a href="/">
            <img src="/favicon.ico" />
          </a>Go to the <a href="/">Pokemon Reference</a> home page.
        </p>

        <br /><br /><hr class="BOTTOM_BORDER" />
        <br />It would be very, very appreciated if you would report this.
        <br />

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteContactInfo();</script>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>


