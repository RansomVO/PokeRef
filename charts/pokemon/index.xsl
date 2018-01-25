<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:include href="/xsl/global.xsl"/>

  <xsl:template match="Root">
    <html lang="en-us">
      <head>
        <!-- This is to make the font size consistent on mobile. -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

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

        <title>Pokemon</title>
      </head>
      <body>
        <h1>Pokemon</h1>
        <p>
          These are charts of basic info about Pokemon.
          <br /><span class="NOTE">(Pokemon that are not yet released are greyed out.)</span>
        </p>
        
        <!-- TODO QZX: Add a Key -->
        
        <xsl:apply-templates select="PokemonStats[Generation/ID = 1]" />
        <xsl:apply-templates select="PokemonStats[Generation/ID = 2]" />
        <xsl:apply-templates select="PokemonStats[Generation/ID = 3]" />
        <xsl:apply-templates select="PokemonStats[Generation/ID = 4]" />
        <xsl:apply-templates select="PokemonStats[Generation/ID = 5]" />
        <xsl:apply-templates select="PokemonStats[Generation/ID = 6]" />
        <xsl:apply-templates select="PokemonStats[Generation/ID = 7]" />

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="PokemonStats">
    <br />
    <hr />
    <h2>
      <xsl:attribute name="id">
        <xsl:value-of select="concat('GEN', Generation/ID)" />
      </xsl:attribute>
      <xsl:text>Generation </xsl:text>
      <xsl:value-of select="Generation/ID" />
    </h2>
    <table border="1">
      <tr>
        <xsl:for-each select="Pokemon">
          <xsl:apply-templates select="." mode="Cell" />
          <xsl:if test="position() mod 10 = 0">
            <xsl:value-of select="concat($lt, '/tr', $gt, $lt, 'tr', $gt)" disable-output-escaping="yes" />
          </xsl:if>
        </xsl:for-each>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>
