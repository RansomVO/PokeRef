<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl"/>

  <xsl:template match="Root">
    <html lang="en-us">
      <head>
        <script>
          <xsl:attribute name="src">
            <xsl:text>index.js?createdate=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/global.js?createdate=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <link type="text/css" rel="stylesheet" href="index.css" />

        <title>QZX Title</title>
      </head>
      <body>
        <h1>QZX Title</h1>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>