﻿<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:variable name="Pokemon" select="/Root/PokeStats/Pokemon" />

  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>evolutions.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/pokemon.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/controls.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
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

        <title>Evolutions Chart</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Evolutions Chart
        </h1>
        <p>
          One of the fun parts of Pokemon GO is Evolving.
          But what can turn into what?
          <br />This chart can help.
        </p>

        <br />
        <hr />
        <xsl:call-template name="LoadingNotice">
          <xsl:with-param name="LoadedContent" select="'EVOLUTIONS_Content'" />
        </xsl:call-template>

        <xsl:value-of select="concat($lt, '!-- Leave this hidden until we have loaded everything and applied it. --', $gt)" disable-output-escaping="yes" />
        <div id="EVOLUTIONS_Content" class="DIV_HIDDEN">
          <xsl:call-template name="CreateCriteria" />

          <br />
          <hr />
          <xsl:call-template name="CreateKey" />

          <br />
          <hr />
          <!-- Go through families of hatchlings, then through each generation -->
          <div id="anchor_evolutions">
            <br />
            <table id="Evolutions" border="1" style="height:1em;">
              <xsl:apply-templates select="PokeStats/Pokemon[contains(@availability,'Hatch') and not(EvolvesFrom) and not(@form)]" mode="Evolver" />
              <xsl:apply-templates select="PokeStats/Pokemon[not(contains(@availability,'Hatch')) and ../@gen = '1' and not(EvolvesFrom) and not(@form)]" mode="Evolver" />
              <xsl:apply-templates select="PokeStats/Pokemon[not(contains(@availability,'Hatch')) and ../@gen = '2' and not(EvolvesFrom) and not(@form)]" mode="Evolver" />
              <xsl:apply-templates select="PokeStats/Pokemon[not(contains(@availability,'Hatch')) and ../@gen = '3' and not(EvolvesFrom) and not(@form)]" mode="Evolver" />
              <xsl:apply-templates select="PokeStats/Pokemon[not(contains(@availability,'Hatch')) and ../@gen = '4' and not(EvolvesFrom) and not(@form)]" mode="Evolver" />
              <xsl:apply-templates select="PokeStats/Pokemon[not(contains(@availability,'Hatch')) and ../@gen = '5' and not(EvolvesFrom) and not(@form)]" mode="Evolver" />
              <xsl:apply-templates select="PokeStats/Pokemon[not(contains(@availability,'Hatch')) and ../@gen = '6' and not(EvolvesFrom) and not(@form)]" mode="Evolver" />
              <xsl:apply-templates select="PokeStats/Pokemon[not(contains(@availability,'Hatch')) and ../@gen = '7' and not(EvolvesFrom) and not(@form)]" mode="Evolver" />
            </table>
          </div>
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!-- Template to write the Selection Criteria. -->
  <xsl:template name="CreateCriteria">
    <h2 id="anchor_criteria">
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'EVOLUTIONS_CRITERIA'" />
      </xsl:call-template>
      <xsl:text>Selection Criteria</xsl:text>
      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <xsl:call-template name="OutputResetButton">
        <xsl:with-param name="Callback" select="'OnResetCriteriaClicked();'" />
      </xsl:call-template>
    </h2>
    <div id="EVOLUTIONS_CRITERIA">
      <div class="FLOWING_TABLE_WRAPPER">
        <table border="1" class="CRITERIA_TABLE">
          <tr>
            <th colspan="2">Show Only Families Containing</th>
          </tr>
          <tr>
            <td>
              <table>
                <tr>
                  <td valign="top" style="padding-bottom:.25em;">
                    <xsl:call-template name="OutputEggSelectionControl" >
                      <xsl:with-param name="CallbackName">OnEggChanged</xsl:with-param>
                    </xsl:call-template>
                    <input id="Shiny_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Shiny'" />
                      <xsl:with-param name="Settings">
                        <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
                      </xsl:with-param>
                    </xsl:call-template>
                  </td>
                  <td valign="top" style="padding-bottom:.25em;">
                    <xsl:call-template name="OutputSpecialItemSelectionControl" >
                      <xsl:with-param name="CallbackName">OnSpecialItemChanged</xsl:with-param>
                    </xsl:call-template>
                  </td>
                </tr>
                <tr>
                  <td colspan="2">
                    <xsl:call-template name="OutputFilterPokemonNameIDLabel" />
                    <xsl:call-template name="OutputFilterPokemonNameID">
                      <xsl:with-param name="CallbackName" select="'OnPokemonNameIDChanged'" />
                    </xsl:call-template>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </div>

      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />

      <xsl:call-template name="OutputGenerationSelection">
        <xsl:with-param name="CallbackName" select="'OnGenChanged'" />
        <xsl:with-param name="SliderHelp">
          <div class="CONTROLS_INFO_ENTRY">
            <div class="CONTROLS_INFO_ENTRY_TITLE">Any</div>
            <div class="CONTROLS_INFO_ENTRY_DESCRIPTION">Show evolutions that contain Any of the selected Gens.</div>
          </div>
          <div class="CONTROLS_INFO_ENTRY">
            <div class="CONTROLS_INFO_ENTRY_TITLE">All</div>
            <div class="CONTROLS_INFO_ENTRY_DESCRIPTION">Show only evolutions that contain All of the selected Gens.</div>
          </div>
        </xsl:with-param>

      </xsl:call-template>
    </div>
  </xsl:template>

  <!-- Template to write the Key for the table. -->
  <xsl:template name="CreateKey">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'POKEMON_IMAGE_KEY'" />
      </xsl:call-template>
      <xsl:text>Key</xsl:text>
    </h2>
    <br />
    <xsl:call-template name="PokemonImageKey" />
  </xsl:template>

  <!-- Template to get a Family of Pokemon and start the process to write them out. -->
  <xsl:template match="Pokemon" mode="Evolver">
    <!-- Get a Family of Evolutions and convert it to a Node Set. -->
    <xsl:variable name="FamilyRaw">
      <xsl:apply-templates select="." mode="GetFamily" />
    </xsl:variable>
    <xsl:variable name="Family" select="exslt:node-set($FamilyRaw)/FamilyBranch" />

    <!-- Now output the Family. -->
    <xsl:call-template name="OutputFamily">
      <xsl:with-param name="Family" select="$Family" />
    </xsl:call-template>
  </xsl:template>

  <!-- Template to output a Family of Pokemon -->
  <xsl:template name="OutputFamily">
    <xsl:param name="Family" />
    <!-- 
      Here are samples of the weird cases:
        ┌───────────┬───────────┐   
        │ Eevee     │ Vaporeon  │
        │   (8)     ├───────────┤
        │           │ Jolteon   │
        │           ├───────────┤
        │           │ Flareon   │
        │           ├───────────┤
        │           │ Espeon    │
        │           ├───────────┤
        │           │ Umbreon   │
        │           ├───────────┤
        │           │ Leafeon   │
        │           ├───────────┤
        │           │ Glaceon   │
        │           ├───────────┤
        │           │ Sylveon   │
        └───────────┴───────────┘

        ┌───────────┬───────────┬───────────┐   
        │ Poliwag   │ Poliwhirl │ Poliwrath │
        │    (2)    │    (2)    ├───────────┤
        │           │           │ Politoed  │
        └───────────┴───────────┴───────────┘

        ┌───────────┬───────────┬───────────┐   
        │ Wurmple   │ Silcoon   │ Beautifly │
        │    (2)    ├───────────├───────────┤
        │           │ Cascoon   │ Dustox    │
        └───────────┴───────────┴───────────┘

        (TODO QZX: I haven't handled this yet. We'll see what happens when Pokemon GO gets there.)
        ┌───────────┬───────────────────────┐
        │ Nincada   │ Ninjask               │
        │    (2)    ├───────────────────────┤
        │           │ Ninjask & Shedinja    │
        └───────────┴───────────────────────┘
    -->

    <!-- Output first row. -->
    <xsl:variable name="IDs">
      <xsl:for-each select="$Family//@ID">
        <xsl:value-of select="." />
        <xsl:text> </xsl:text>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="Names">
      <xsl:for-each select="$Family//@Name">
        <xsl:value-of select="." />
        <xsl:text>-</xsl:text>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="Gens">
      <xsl:text> </xsl:text>
      <xsl:for-each select="$Family//@Gen">
        <xsl:value-of select="." />
        <xsl:text> </xsl:text>
      </xsl:for-each>
    </xsl:variable>

    <tr>
      <xsl:attribute name="ids">
        <xsl:value-of select="$IDs" />
      </xsl:attribute>
      <xsl:attribute name="names">
        <xsl:value-of select="$Names" />
      </xsl:attribute>
      <xsl:attribute name="gens">
        <xsl:value-of select="$Gens" />
      </xsl:attribute>
      <xsl:call-template name="OutputFamilyBranch">
        <xsl:with-param name="FamilyBranch" select="$Family" />
        <xsl:with-param name="FirstRow" select="true()" />
      </xsl:call-template>
    </tr>

    <!-- Find the Pokemon with multiple Evolutions and Output the rest of the rows. -->
    <xsl:call-template name="OutputFamilyBranch">
      <xsl:with-param name="FamilyBranch" select="$Family" />
      <xsl:with-param name="FirstRow" select="false()" />
    </xsl:call-template>
  </xsl:template>

  <!-- Template to output a Branch of a Family of Pokemon. -->
  <xsl:template name="OutputFamilyBranch">
    <!-- (Starts with the Root Branch, then calls itself recursively.) -->
    <xsl:param name="FamilyBranch" />
    <xsl:param name="FirstRow" />

    <xsl:choose>
      <!-- When we are starting a new Family. -->
      <xsl:when test="$FirstRow">
        <!-- Output the current cell -->
        <xsl:variable name="id" select="$FamilyBranch/@ID" />
        <xsl:variable name="pokemon" select="$Pokemon[@id = $id and not(@form)]" />

        <td class="CELL_FILLED">
          <xsl:attribute name="rowspan">
            <xsl:value-of select="$FamilyBranch/@rowspan" />
          </xsl:attribute>

          <xsl:variable name="Header">
            <i>
              <xsl:text>(Gen </xsl:text>
              <xsl:value-of select="$pokemon/../@gen" />
              <xsl:text>)</xsl:text>
            </i>
          </xsl:variable>

          <xsl:variable name="Footer">
            <xsl:choose>
              <xsl:when test="$pokemon/EvolvesFrom/@candies">
                <xsl:value-of select="concat($pokemon/EvolvesFrom/@candies, $nbsp, 'Candies')" disable-output-escaping="yes" />
                <xsl:if test="$pokemon/EvolvesFrom/@special">
                  <xsl:value-of select="concat($nbsp, '+', $nbsp)" disable-output-escaping="yes" />
                  <xsl:call-template name="Sprite">
                    <xsl:with-param name="Settings">
                      <Show sprite_class="TAG_ICON_MEDIUM" />
                    </xsl:with-param>
                    <xsl:with-param name="id" select="$pokemon/EvolvesFrom/@special" />
                  </xsl:call-template>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <!-- This template (from /xsl/global.xsl) outputs the Visual image of the Pokemon with various decorations. -->
          <xsl:apply-templates select="$pokemon">
              <xsl:with-param name="Settings">
                <xsl:if test="$FamilyBranch/@rowspan = 1">
                  <Show valign="bottom" />
                </xsl:if>
              </xsl:with-param>
            <xsl:with-param name="Header">
              <xsl:copy-of select="$Header"/>
            </xsl:with-param>
            <xsl:with-param name="Footer">
              <xsl:copy-of select="$Footer"/>
            </xsl:with-param>
          </xsl:apply-templates>
        </td>

        <!-- Call recursively to output the rest of the cells in this row. -->
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 0">
          <xsl:call-template name="OutputFamilyBranch">
            <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[1]" />
            <xsl:with-param name="FirstRow" select="$FirstRow" />
          </xsl:call-template>
        </xsl:if>
      </xsl:when>

      <!-- When the Pokemon is a repeat of the first row. -->
      <xsl:when test="count($FamilyBranch/Evolutions/FamilyBranch) = 1">
        <xsl:call-template name="OutputFamilyBranch">
          <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[1]" />
          <xsl:with-param name="FirstRow" select="$FirstRow" />
        </xsl:call-template>
      </xsl:when>

      <!-- When the Pokemon is one with multiple Evolutions. E.G. Eevee -->
      <xsl:when test="count($FamilyBranch/Evolutions/FamilyBranch) > 1">
        <!-- NOTE: If this is done with an xsl:for-each, it changes the Root node and images quit working.-->
        <tr>
          <xsl:call-template name="OutputFamilyBranch">
            <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[2]" />
            <xsl:with-param name="FirstRow" select="true()" />
          </xsl:call-template>
        </tr>
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 2">
          <tr>
            <xsl:call-template name="OutputFamilyBranch">
              <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[3]" />
              <xsl:with-param name="FirstRow" select="true()" />
            </xsl:call-template>
          </tr>
        </xsl:if>
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 3">
          <tr>
            <xsl:call-template name="OutputFamilyBranch">
              <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[4]" />
              <xsl:with-param name="FirstRow" select="true()" />
            </xsl:call-template>
          </tr>
        </xsl:if>
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 4">
          <tr>
            <xsl:call-template name="OutputFamilyBranch">
              <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[5]" />
              <xsl:with-param name="FirstRow" select="true()" />
            </xsl:call-template>
          </tr>
        </xsl:if>
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 5">
          <tr>
            <xsl:call-template name="OutputFamilyBranch">
              <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[6]" />
              <xsl:with-param name="FirstRow" select="true()" />
            </xsl:call-template>
          </tr>
        </xsl:if>
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 6">
          <tr>
            <xsl:call-template name="OutputFamilyBranch">
              <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[7]" />
              <xsl:with-param name="FirstRow" select="true()" />
            </xsl:call-template>
          </tr>
        </xsl:if>
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 7">
          <tr>
            <xsl:call-template name="OutputFamilyBranch">
              <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[8]" />
              <xsl:with-param name="FirstRow" select="true()" />
            </xsl:call-template>
          </tr>
        </xsl:if>
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 8">
          <tr>
            <xsl:call-template name="OutputFamilyBranch">
              <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[9]" />
              <xsl:with-param name="FirstRow" select="true()" />
            </xsl:call-template>
          </tr>
        </xsl:if>
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 9">
          <tr>
            <xsl:call-template name="OutputFamilyBranch">
              <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[10]" />
              <xsl:with-param name="FirstRow" select="true()" />
            </xsl:call-template>
          </tr>
        </xsl:if>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Creates a structure of evolutions for a single Family of Pokemon. -->
  <xsl:template match="Pokemon" mode="GetFamily">
    <xsl:variable name="ID" select="@id" />
    <xsl:variable name="FamilyBranch">
      <xsl:apply-templates mode="GetFamily" select="$Pokemon[EvolvesFrom/@id = $ID and not(@form)]" />
    </xsl:variable>
    <xsl:variable name="rowspan" select="sum(exslt:node-set($FamilyBranch)/FamilyBranch/@rowspan)" />
    <FamilyBranch>
      <xsl:attribute name="ID">
        <xsl:value-of select="$ID" />
      </xsl:attribute>
      <xsl:attribute name="Name">
        <xsl:value-of select="@name" />
      </xsl:attribute>
      <xsl:attribute name="Gen">
        <xsl:value-of select="../@gen" />
      </xsl:attribute>
      <xsl:attribute name="rowspan">
        <xsl:choose>
          <xsl:when test="$rowspan = 0" >1</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$rowspan" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <Evolutions>
        <xsl:copy-of select="$FamilyBranch" />
      </Evolutions>
    </FamilyBranch>
  </xsl:template>

</xsl:stylesheet>
