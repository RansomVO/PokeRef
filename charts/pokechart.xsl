<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/controls.xsl"/>

  <xsl:template match="Root">
    <html lang="en-us">
      <head>
        <!-- This is to make the font size consistent on mobile. -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

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

        <title>Pokemon Chart</title>

        <style>
          .POPUP_CELL {
          padding-left: .25em;
          padding-right: .25em;
          }

          .DATA_BOX {
          border: 1px solid black;
          }

          .LABEL_BOX {
          text-align: left;
          font-size: medium;
          }
        </style>
      </head>
      <body>
        <h1>
          Pokemon Chart <span class="NOTE TODO">(Beta)</span>
        </h1>
        <p>
          These are charts of basic info about Pokemon.
          <br /><span class="NOTE">(Pokemon that are not yet released are greyed out.)</span>
        </p>

        <!-- ======================================================================================== -->
        <!-- #region The box to contain data from selected pokemon -->
        <div id="Selected_Pokemon_Dialog" class="POPUP_DIALOG">
          <div id="Selected_Pokemon_Dialog_Header" class="POPUP_DIALOG_HEADER">
            <span class="BUTTON" style="float: right;" onclick="OnClosePopup();">
              <xsl:value-of select="$times" disable-output-escaping="yes" />
            </span>
            <span id="Selected_Pokemon_Title" class="POPUP_DIALOG_HEADER_TITLE" />
          </div>

          <div style="padding:.25em;">
            <table  width="100%" style="white-space:nowrap;">
              <!-- This stupid row is so the stupid columns will be as narrow as possible. -->
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

        <!-- #endregion  -->
        <!-- ======================================================================================== -->

        <br />
        <h2 id="anchor_criteria">
          <xsl:text>Selection Criteria</xsl:text>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'POKEMON_CRITERIA'" />
          </xsl:call-template>
        </h2>
        <br />
        <div id="POKEMON_CRITERIA">
          <table border="1" class="KEY_TABLE">
            <tr>
              <th>Show Only</th>
            </tr>
            <tr>
              <td valign="top">
                <input id="ReleasedOnly_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />Released
                <br /><input id="RegionalOnly_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />Regional
                <br /><input id="RaidBossOnly_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />Raid Bosses
                <br /><input id="LegendaryOnly_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />Legendary
                <br /><input id="HatchOnly_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />Hatch Only
                <br /><input id="ShinyOnly_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" /><img class="TAG_ICON" src="/images/shiny.png" alt="Shiny" /> Shiny
                <br />Name: <input id="Filter_Text" type="text" onkeyup="OnFilterCriteriaChanged(this)" style="margin-top:.5em; margin-bottom:.5em;"/>
              </td>
            </tr>
          </table>
          <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
          <div class="KEY_TABLE">
            <xsl:call-template name="OutputTypeSelection">
              <xsl:with-param name="Callback" select="'OnTypesChanged'" />
            </xsl:call-template>
          </div>
          <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
          <div class="KEY_TABLE">
            <xsl:call-template name="OutputWeatherSelection">
              <xsl:with-param name="Callback" select="'OnWeatherChanged'" />
              <xsl:with-param name="Title" select="'Weather Boosts'" />
            </xsl:call-template>
          </div>
          <br />
          <hr />
          <xsl:call-template name="PokemonImageKey" />
        </div>

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
