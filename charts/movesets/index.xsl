﻿<?xml version="1.0" encoding="utf-8"?>
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
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
        <link type="text/css" rel="stylesheet" >
          <xsl:attribute name="href">
            <xsl:text>index.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </link>

        <title>Pokemon Move Sets</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon Move Sets
        </h1>
        <p>
          Each type of Pokemon has a set of "Fast" Moves and "Charged" Moves that they may have.
          Then each individual Pokemon has only one combination.
          Of course, some moves are more effective than others.
          <br />
          This page shows a list of each possible combination for each type of Pokemon, which then tells how much damage it will do.
          <br />
          And since I have older GAME_MASTER files, I have included the Legacy moves.
          (Moves that Pokemon could have gotten in the past, but no longer can.)
        </p>
        <p>
          Note that Move Sets have changed over time.
          In other words, you may have Pokemon that have Move Sets that are no longer listed in the GAME_MASTER.
          These are referred to as "Legacy Move Sets".
          <br />
          However, since I have a collection of historical GAME_MASTER files, I have been able to find out what has been available in the past, and I have included them in the Move Sets table.
          <br />
          <span class="NOTE">(To keep be able to easily distinguish Legacy Move Sets, I am displaying them with a grey font.)</span>
        </p>
        <p class="PARENT">
          I have created a chart for each generation of Pokemon, and one that has all of the generations together.
          <br /><span class="NOTE">
            (<b>NOTE</b>: The one with all of the generations is convenient, but it may take a while to load.)
          </span>
        </p>
        <div class="CHILD" style="font-size:large;">
          <script>InsertLinksList('_linkslist.html')</script>
        </div>
        <p class="NOTE">
          <b>NOTE</b>: If you find you want to change the Move Set one of your Pokemon has, you can make use of "TMs" that may be one of the rewards you get from defeating a Raid Boss.
        </p>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
