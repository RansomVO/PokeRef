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

        <title>Pokemon Chart</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon Chart
        </h1>
        <p>
          Interested in seeing what Pokemon there are?
          How about ones that aren't even released in Pokemon GO yet?
          <br />What about getting the basic information about each of the Pokemon?
          <br />Check these out!
        </p>

        <!-- TODO QZX: Add instructions -->

        <p class="PARENT">
          I have created a chart for each generation of Pokemon, and one that has all of the generations together.
          <br /><span class="NOTE">
            (<b>NOTE</b>: The "Released" and the "All Gens" may be convenient, but they may take a while to load and run slow on a mobile device.)
          </span>
        </p>
        <div class="CHILD" style="font-size:large;">
          <script>InsertLinksList('_linkslist.html')</script>
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
