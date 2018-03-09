<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:output method="html" encoding="utf-8" omit-xml-declaration="yes" standalone="no" indent="yes" />
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html lang="en-us">
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

        <title>Pokemon Stats</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon Stats
        </h1>
        <p class="PARENT">
          Each Pokemon has a bunch of statistics associated with them. Candies, Types, Gender Ratios, and a whole lot more.
          <br />I have created a chart containing what I consider to be the important info for each generation of Pokemon:
        </p>
        <div class="INDENT CHILD">
          <script>InsertURL('_linkslist.html?cacherefresh={$CurrentDate}')</script>
        </div>

        <br />
        <p class="NOTE PARENT">
          <b>NOTE</b>: If there is info you want to see, but it is not included in the charts, please let me know.
        </p>
        <div class="INDENT">
          <script>WriteContactInfo();</script>
        </div>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
