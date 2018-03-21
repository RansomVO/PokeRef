<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>pokechart.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/pokemon.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
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

        <title>
          Pokemon Chart
          <xsl:choose>
            <xsl:when test="count(PokemonStats/Generation/ID) > 1">
              <xsl:text> - All Gens </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> - Gen </xsl:text>
              <xsl:value-of select="PokemonStats/Generation/ID"/>
            </xsl:otherwise>
          </xsl:choose>
        </title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon Chart
          <xsl:choose>
            <xsl:when test="count(PokemonStats/Generation/ID) > 1">
              <xsl:text> - All Gens </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> - Gen </xsl:text>
              <xsl:value-of select="PokemonStats/Generation/ID"/>
            </xsl:otherwise>
          </xsl:choose>
          <span class="NOTE TODO">(Beta)</span>
        </h1>
        <p>
          These are charts of basic info about Pokemon.
          <br /><span class="NOTE">(Pokemon that are not yet released are greyed out.)</span>
        </p>


        <br />
        <hr />
        <xsl:call-template name="LoadingNotice">
          <xsl:with-param name="LoadedContent" select="'POKECHART_Content'" />
        </xsl:call-template>

        <xsl:value-of select="concat($lt, '!-- Leave this hidden until everything is loaded and .js has applied it. --', $gt)" disable-output-escaping="yes" />
        <div id="POKECHART_Content" class="DIV_HIDDEN">
          <xsl:call-template name="CreateCriteria" />

          <br />
          <hr />
          <xsl:call-template name="CreateKey" />

          <xsl:apply-templates select="PokemonStats[Generation/ID = 1]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 2]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 3]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 4]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 5]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 6]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 7]" />
        </div>

        <xsl:call-template name="PokemonDialog" />

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <!-- The box to contain data from selected pokemon -->
  <xsl:template name="PokemonDialog">
    <xsl:value-of select="concat($lt, '!-- #region The box to contain data from selected pokemon --', $gt)" disable-output-escaping="yes" />
    <div id="Selected_Pokemon_Dialog" class="POPUP_DIALOG">
      <div id="Selected_Pokemon_Dialog_Header" class="POPUP_DIALOG_HEADER">
        <span class="BUTTON" style="float: right;" onclick="OnClosePopup();">
          <xsl:value-of select="$times" disable-output-escaping="yes" />
        </span>
        <span id="Selected_Pokemon_Title" class="POPUP_DIALOG_HEADER_TITLE" />
      </div>

      <div style="padding:.25em;">
        <table  width="100%" style="white-space:nowrap;">
          <xsl:value-of select="concat($lt, '!-- This stupid row is so the stupid columns will be as narrow as possible. --', $gt)" disable-output-escaping="yes" />
          <tr>
            <th style="width:1px;"/>
            <th style="width:1px;"/>
            <th style="width:1px;"/>
            <th style="width:1px;"/>
          </tr>
          <tr>
            <td rowspan="4" id="Selected_Pokemon" class="POPUP_CELL" />
            <th colspan="2" class="POPUP_CELL LABEL_BOX">Generation:</th>
            <td id="Selected_Pokemon_Generation" class="POPUP_CELL DATA_BOX NUMERIC" />
          </tr>
          <tr>
            <th colspan="2" class="POPUP_CELL LABEL_BOX">Candies:</th>
            <td id="Selected_Pokemon_Family" class="POPUP_CELL DATA_BOX" />
          </tr>
          <tr>
            <td colspan="2" class="POPUP_CELL LABEL_BOX">
              <xsl:value-of select="concat($Gender_Male, $nbsp, ':', $nbsp, $Gender_Female)" disable-output-escaping="yes" />
            </td>
            <td id="Selected_Pokemon_GenderRatio" class="POPUP_CELL DATA_BOX" align="center" />
          </tr>
          <tr>
            <th colspan="2" class="POPUP_CELL LABEL_BOX">Shiny Available:</th>
            <td id="Selected_Pokemon_Shiny" class="POPUP_CELL DATA_BOX" />
          </tr>
          <tr />
          <tr>
            <th colspan="2" class="POPUP_CELL LABEL_BOX">Availability:</th>
            <td colspan="2" id="Selected_Pokemon_Availability" class="POPUP_CELL DATA_BOX" />
          </tr>
          <tr>
            <th colspan="2" valign="top" class="POPUP_CELL LABEL_BOX">Type(s):</th>
            <td colspan="2" id="Selected_Pokemon_Types" class="POPUP_CELL DATA_BOX" />
          </tr>
          <tr>
            <th colspan="2" valign="top" class="POPUP_CELL LABEL_BOX">Boost(s):</th>
            <td colspan="2" id="Selected_Pokemon_Boosts" class="POPUP_CELL DATA_BOX" />
          </tr>
          <tr />
          <tr>
            <th colspan="2" class="POPUP_CELL LABEL_BOX">Buddy Km for Candy:</th>
            <td colspan="2" id="Selected_Pokemon_BuddyKM" class="POPUP_CELL DATA_BOX NUMERIC" />
          </tr>
          <tr>
            <th colspan="2" class="POPUP_CELL LABEL_BOX">Max CP/HP:</th>
            <td colspan="2" class="POPUP_CELL DATA_BOX NUMERIC">
              <table width="100%">
                <tr>
                  <td id="Selected_Pokemon_Max_CP" width="49%" align="center" />
                  <td width="2%" align="center">/</td>
                  <td id="Selected_Pokemon_Max_HP" align="center" />
                </tr>
              </table>
            </td>
          </tr>
          <tr />
          <tr>
            <th colspan="2" class="POPUP_CELL LABEL_BOX">Base ATK/DEF/STA:</th>
            <td colspan="2" class="POPUP_CELL DATA_BOX NUMERIC">
              <table width="100%">
                <tr>
                  <td id="Selected_Pokemon_BaseIV_Attack" width="32%" align="center" />
                  <td width="2%" align="center">/</td>
                  <td id="Selected_Pokemon_BaseIV_Defense" width="32%" align="center" />
                  <td width="2%" align="center">/</td>
                  <td id="Selected_Pokemon_BaseIV_Stamina"  width="32%" align="center" />
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <th colspan="2" class="POPUP_CELL LABEL_BOX">Base Capture/Flee Rate:</th>
            <td colspan="2" class="POPUP_CELL DATA_BOX NUMERIC">
              <table width="100%">
                <tr>
                  <td id="Selected_Pokemon_CaptureRate" width="49%" align="center" />
                  <td width="2%" align="center">/</td>
                  <td id="Selected_Pokemon_FleeRate" align="center" />
                </tr>
              </table>
            </td>
          </tr>
        </table>

        <table width="100%" style="margin-top:.25em; white-space:nowrap;">
          <tr>
            <th style="border-bottom:2px solid black;">Strong Against</th>
            <td width="1em" />
            <th style="border-bottom:2px solid black;">Weak Against</th>
          </tr>
          <tr>
            <td id="Selected_Pokemon_Strengths" valign="top" />
            <td />
            <td id="Selected_Pokemon_Weaknesses" valign="top" />
          </tr>
        </table>
      </div>
    </div>
  </xsl:template>

  <!-- Template to write the Selection Criteria. -->
  <xsl:template name="CreateCriteria">
    <h2 id="anchor_criteria">
      <xsl:text>Selection Criteria</xsl:text>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'POKEMON_CRITERIA'" />
      </xsl:call-template>
      <xsl:call-template name="OutputResetButton">
        <xsl:with-param name="Callback" select="'OnResetCriteriaClicked();'" />
      </xsl:call-template>
    </h2>
    <div id="POKEMON_CRITERIA" style="margin-top:.5em;">
      <table border="1" class="KEY_TABLE">
        <tr>
          <th>Show Only</th>
        </tr>
        <tr>
          <td valign="top" style="padding-bottom:.25em;">
            <input id="ReleasedOnly_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />Released
            <br /><input id="Regional_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />Regional
            <br /><input id="RaidBoss_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />Raid Bosses
            <br /><input id="Legendary_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />Legendary/Mythic
            <xsl:call-template name="OutputEggSelectionControl" >
              <xsl:with-param name="CallbackName">OnEggChanged</xsl:with-param>
            </xsl:call-template>
            <input id="Shiny_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" /><img class="TAG_ICON_REGULAR" src="/images/shiny.png" alt="Shiny" /> Shiny
            <br /><xsl:text>Pokemon Name or ID:</xsl:text>
            <xsl:call-template name="OutputFilterPokemonNameID">
              <xsl:with-param name="CallbackName" select="'OnPokemonNameIDChanged'" />
            </xsl:call-template>
          </td>
        </tr>
      </table>

      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <xsl:call-template name="OutputTypeSelection">
        <xsl:with-param name="CallbackName" select="'OnTypesChanged'" />
        <xsl:with-param name="Title" select="'Pokemon Types'" />
        <xsl:with-param name="SliderHelp">
          <table style="width:20em;">
            <tr>
              <th width="1px;">Any</th>
              <td>Pokemon that have any of their Types matching the selected Pokemon Types.</td>
            </tr>
            <tr>
              <th>All</th>
              <td>Pokemon that have all of their Types matching the selected Pokemon Types.</td>
            </tr>
          </table>
        </xsl:with-param>
      </xsl:call-template>

      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <xsl:call-template name="OutputWeatherSelection">
        <xsl:with-param name="CallbackName" select="'OnWeatherChanged'" />
        <xsl:with-param name="Title" select="concat('Pokemon', $lt, 'br /', $gt, 'Weather Boosts')" />
        <xsl:with-param name="SliderHelp">
          <table style="width:25em">
            <tr>
              <th width="1px">Any</th>
              <td>Pokemon that have any of their Types boosted by the selected Pokemon Weather Boosts.</td>
            </tr>
            <tr>
              <th>All</th>
              <td>Pokemon that have all of their Types boosted by the selected Pokemon Weather Boosts.</td>
            </tr>
          </table>
        </xsl:with-param>
      </xsl:call-template>
    </div>
  </xsl:template>

  <!-- Template to write the Key for the table. -->
  <xsl:template name="CreateKey">
    <h2>
      <xsl:text>Key</xsl:text>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'POKESTAT_KEY'" />
      </xsl:call-template>
    </h2>
    <div id="POKESTAT_KEY" style="margin-top:.5em;">
      <xsl:call-template name="PokemonImageKey" />
    </div>
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
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('GENERATION_', Generation/ID)" />
      </xsl:call-template>
    </h2>
    <div>
      <xsl:attribute name="id">
        <xsl:value-of select="concat('GENERATION_', Generation/ID)" />
      </xsl:attribute>
      <div>
        <xsl:attribute name="id">
          <xsl:value-of select="concat('GEN', Generation/ID, '_Collection')" />
        </xsl:attribute>
        <xsl:for-each select="Pokemon">
          <xsl:variable name="Name" select="Name" />
          <xsl:apply-templates select=".">
            <xsl:with-param name="Settings">
              <Show boxed="true" />
            </xsl:with-param>
            <xsl:with-param name="CustomAttributes">
              <Attributes onclick="OnSelectPokemon(this)" style="cursor:pointer;">
                <xsl:if test="count(/Root/RaidBosses/Tier[@name != '? Future ?' and RaidBoss = $Name]) != 0">
                  <xsl:attribute name="raidboss">true</xsl:attribute>
                </xsl:if>
              </Attributes>
            </xsl:with-param>
          </xsl:apply-templates>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
