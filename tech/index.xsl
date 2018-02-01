﻿<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl"/>

  <xsl:template match="Root">
    <html>
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

        <title>Technical Reference</title>
      </head>
      <body>
        <h1>Technical Reference</h1>
        <img class="FLOAT_RIGHT" style="width:25%; margin:1em;" src="/images/EeveeDi.png" />
        <p>
          Sometimes you want to really understand how things work.
          There are a lot of technical things under the covers of Pokemon GO.
          <br />This section contains gory details about how things work.
        </p>

        <br />
        <hr />
        <h2>
          <a href="GAME_MASTER/">GAME_MASTER</a>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'TECH_GAME_MASTER'" />
          </xsl:call-template>
        </h2>
        <div id="TECH_GAME_MASTER" class="INDENT">
          <p>
            Pokemon GO has a file called the GAME_MASTER that contains statistics regarding just about everything in the game.
            <br />This file is updated on a semi-regular basis.
          </p>
          <h3 class="PARENT">
            <a href="GAME_MASTER/pokestats/">Pokemon Stats</a>
          </h3>
          <div class="INDENT">
            <p>
              Each Pokemon has a bunch of statistics associated with them. Candies, Types, Gender Ratios, and a whole lot more.
              <br />I have created a chart for each generation of Pokemon.
            </p>
          </div>

          <h3>
            <a href="GAME_MASTER/moves/">Pokemon Moves</a>
          </h3>
          <div class="INDENT">
            <p class="PARENT">
              To do battling, Pokemon use Moves (or "Attacks").
              These moves come in two types:
            </p>
            <ul class="CHILD">
              <li>
                <b>"Fast"</b>: The Moves performed by tapping on the screen during battle.
              </li>
              <li>
                <b>"Charged""</b>: The Moves performed by tap-and-holding on the screen during battle.
              </li>
            </ul>
            <p class="NOTE">
              <b>NOTE</b>: If you find you want to change the Move Set one of your Pokemons have, you can make use of "TMs" that can be one of the rewards you get from defeating a Raid Boss.
            </p>
            <p class="PARENT">
              Here are charts with the important values regarding each type:
            </p>
            <div class="CHILD">
              <script>InsertURL('moves/_linkslist.html')</script>
            </div>
          </div>

          <h3 class="PARENT">
            <a href="GAME_MASTER/archive/">GAME_MASTER Archive</a>
          </h3>
          <div class="CHILD INDENT">
            <p class="CHILD">
              I have collected as many GAME_MASTER files as I could find.
              What I have is available for download.
            </p>
            <p class="NOTE PARENT">
              <b>NOTE</b>: If you have a GAME_MASTER file I am missing, or know where I can get it, please let me know.
            </p>
            <div class="INDENT">
              <script>WriteContactInfo();</script>
            </div>
          </div>
        </div>

        <br />
        <hr />
        <h2>
          <a href="movesetformulas.html">
            <b>Move Set Formulas</b>
          </a>
        </h2>
        <p>
          Want to know how to figure out the DPS for a Pokemon's Move Set?
          <br />This page goes into detail of describing the formulas used to figure that out.
        </p>

        <br />
        <hr />
        <h2>
          <a href="cpm.html">
            <b>CP Modifiers</b>
          </a>
        </h2>
        <p>
          When calculating how much damage a Pokemon will do, Pokemon GO takes into account the Level of the Pokemon.
          It does this by multiplying the Pokemon's BaseAttack and Attack IV by a constant corresponding to the Pokemon's level.
          <br />This page lists the CPM values.
        </p>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>