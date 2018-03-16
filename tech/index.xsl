<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html>
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/controls.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
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
        <h1>
          <xsl:call-template name="HomePageLink" />
          Technical Reference
        </h1>
        <img class="FLOAT_RIGHT" style="width:25%; margin:1em;" src="/images/EeveeDi.png" />
        <p>
          Sometimes you want to really understand how things work.
          There are a lot of technical things under the covers of Pokemon GO.
          <br />This section contains gory details about how things work.
        </p>

        <br />
        <hr />
        <h2 id="anchor_gamemaster">
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
            <p class="PARENT">
              Each Pokemon has a bunch of statistics associated with them. Candies, Types, Gender Ratios, and a whole lot more.
              <br />I have created a chart for each generation of Pokemon.
            </p>
            <div class="INDENT CHILD">
              <script>InsertURL('GAME_MASTER/pokestats/_linkslist.html?cacherefresh={$CurrentDate}')</script>
            </div>
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
                "<a href="GAME_MASTER/moves/moves.fast.html">
                  <b>Fast</b>
                </a>": The Moves performed by tapping on the screen during battle.
              </li>
              <li>
                "<a href="GAME_MASTER/moves/moves.charged.html">
                  <b>Charged</b>
                </a>": The Moves performed by tapping the button at the bottom of the screen during battle.
              </li>
            </ul>
            <p class="NOTE">
              <b>NOTE</b>: If you find you want to change the Move Set one of your Pokemons have, you can make use of "TMs" that can be one of the rewards you get from defeating a Raid Boss.
            </p>
            <p class="PARENT">
              Here are charts with the important values regarding each type:
            </p>
            <div class="CHILD">
              <script>InsertURL('moves/_linkslist.html?cacherefresh={$CurrentDate}')</script>
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
        <h2 id="anchor_formulas">
          <a href="formulas">
            <b>Technical Formulas</b>
          </a>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'TECH_FORMULAS'" />
          </xsl:call-template>
        </h2>
        <div id="TECH_FORMULAS" class="INDENT">
          <h3 id="anchor_cphpformulas">
            <a href="formulas/cphp.html">
              <b>CP and HP Formulas</b>
            </a>
          </h3>
          <div class="INDENT">
            <p>
              Pokemon have scores called "CP" and "HP".
              But what do they mean?
              <br />This page tells you about them and shows the formulas used to calculate them.
            </p>
          </div>

          <h3 id="anchor_movesetformulas">
            <a href="formulas/movesetdamage.html">
              <b>Move Set Damage Formulas</b>
            </a>
          </h3>
          <div class="INDENT">
            <p>
              Want to know how to figure out the DPS for a Pokemon's Move Set?
              <br />This page goes into detail of describing the formulas used to figure that out.
            </p>
          </div>

          <h3 id="anchor_cpm">
            <a href="formulas/cpm.html">
              <b>CP Modifiers</b>
            </a>
          </h3>
          <div class="INDENT">
            <p>
              When calculating how much damage a Pokemon will do, Pokemon GO takes into account the Level of the Pokemon.
              It does this by multiplying the Pokemon's BaseAttack and Attack IV by a constant corresponding to the Pokemon's level.
              <br />This page lists the CPM values.
            </p>
          </div>
        </div>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
