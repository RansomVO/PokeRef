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
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
        <link type="text/css" rel="stylesheet" >
          <xsl:attribute name="href">
            <xsl:text>index.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </link>

        <title>GAME_MASTER</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          GAME_MASTER
        </h1>
        <p>
          There is a file called the GAME_MASTER that contains statistics regarding just about everything in the game.
          <br />
          This file is updated on a semi-regular basis on the Niantic servers and Pokemon GO downloads it.
        </p>
        <p>
          I have collected as many historical GAME_MASTER files as I could find.
          Then I used the data in them to generate these pages.
        </p>
        <p class="NOTE PARENT">
          <b>NOTE</b>: If you have a GAME_MASTER file I am missing, or know where I can get it, please let me know.
          You can find my list at <a href="GAME_MASTER/archive/">GAME_MASTER Archive</a>
        </p>
        <div class="INDENT">
          <xsl:call-template name="WriteContactInfo" />
        </div>

        <br />
        <hr />
        <h2>
          <a href="pokestats/">Pokemon Stats</a>
        </h2>
        <div class="INDENT">
          <p class="PARENT">
            Each Pokemon has a bunch of statistics associated with them. Candies, Types, Gender Ratios, and a whole lot more.
            <br />I have created a chart for each generation of Pokemon:
          </p>
          <div class="CHILD">
            <script>InsertURL('pokestats/_linkslist.html?cacherefresh={$CurrentDate}')</script>
          </div>
        </div>

        <br />
        <hr />
        <h2>
          <a href="moves/">Pokemon Moves</a>
        </h2>
        <div class="INDENT">
          <p class="PARENT">
            To do battling, Pokemon use Moves (or "Attacks").
            These moves come in two types:
          </p>
          <ul class="CHILD">
            <li>
              "<a href="moves/moves.fast.html">
                <b>Fast</b>
              </a>": The Moves performed by tapping on the screen during battle.
            </li>
            <li>
              "<a href="moves/moves.charged.html">
                <b>Charged</b>
              </a>": The Moves performed by tapping the button at the bottom of the screen during battle.
            </li>
          </ul>
        </div>

        <br />
        <hr />
        <h2>
          <a href="archive/">GAME_MASTER Archive</a>
        </h2>
        <div class="INDENT">
          <p>
            As I mentioned above, I have collected as many GAME_MASTER files as I could find.
            They are available for download.
          </p>
          <p class="NOTE PARENT">
            <b>NOTE</b>: If you have a GAME_MASTER file I am missing, or know where I can get it, please let me know.
            (Pretty please with sugar on top.)
          </p>
          <div class="INDENT">
            <xsl:call-template name="WriteContactInfo" />
          </div>
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
