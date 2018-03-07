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

  <xsl:template match="Root">
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

        <title>Pokemon Moves</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon Moves
        </h1>
        <p class="PARENT">
          To do battling, Pokemon use Moves (or "Attacks").
          <br />These Moves come in two types:
        </p>

        <h2>
          <a href="moves.fast.html">Fast Moves</a>
        </h2>
        <p>
          In battle, Fast Moves are the Moves performed when you just tap the screen.
          Every time a Pokemon does a Fast move it causes the opponent a little damage <i>AND</i> it generates some Energy, which, for your Pokemon, is indicated by a bar at the top of the screen under the Pokemon's name.
        </p>

        <h2>
          <a href="moves.charged.html">Charged Moves</a>
        </h2>
        <p>
          In battle, Charged Moves are performed when you tap-and-hold on the screen until a charge-up bar indicates it is ready, then letting go.
          Every time a Pokemon does a Charged move it causes the opponent a lot of damage <i>BUT</i> the Pokemon can only perform the Charged Move if it has generated enough Energy by performing Fast moves, which is indicated by the bar at the top of the screen being full.
        </p>

        <h2>Example</h2>
        <p class="TODO">(Under Construction)</p>
        <!--
    <p>
        Let's say you have a Pokemon with the Fast Move of SSS and the Charged Move of ZZZ.
    </p>
-->
        <p class="NOTE">
          <b>NOTE</b>: If you find you want to change one of the Moves for one of your Pokemons, you can make use of "TMs" that can be one of the rewards you get from defeating a Raid Boss.
          There are Fast TMs and Charged TMs so make sure you use the right one.
        </p>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
