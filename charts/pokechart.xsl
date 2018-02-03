<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl"/>

  <xsl:template match="Root">
    <html lang="en-us">
      <head>
        <!-- This is to make the font size consistent on mobile. -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>pokechart.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/global.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/pokemon.js?cacherefresh=</xsl:text>
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
          .DATA_BOX {
          border: 1px solid black;
          }

          .POPUP_CELL {
          padding-left: .25em;
          padding-right: .25em;
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
        <!-- Region The box to contain data from selected pokemon -->
        <div id="Selected_Pokemon_Dialog" class="POPUP_DIALOG">
          <div id="Selected_Pokemon_Dialog_Header" class="POPUP_DIALOG_HEADER">
            <span class="BUTTON" style="float: right;" onclick="OnClosePopup();">
              <xsl:value-of select="$times" disable-output-escaping="yes" />
            </span>
            <span id="Selected_Pokemon_Title" class="POPUP_DIALOG_HEADER_TITLE" />
          </div>

          <div style="padding:.25em;">
            <table style="white-space:nowrap;">
              <!-- This stupid row is so the stupid columns will be as narrow as possible. -->
              <tr>
                <th style="width:1px;"/>
                <th style="width:1px;"/>
                <th style="width:1px;"/>
                <th style="width:1px;"/>
              </tr>
              <tr>
                <td rowspan="4" id="Selected_Pokemon" class="POPUP_CELL" />
                <td colspan="2" class="POPUP_CELL">Generation:</td>
                <td id="Selected_Pokemon_Generation" class="POPUP_CELL DATA_BOX NUMERIC" />
              </tr>
              <tr>
                <td colspan="2" class="POPUP_CELL">Candies:</td>
                <td id="Selected_Pokemon_Family" class="POPUP_CELL DATA_BOX" />
              </tr>
              <tr>
                <td colspan="2" class="POPUP_CELL">
                  <xsl:value-of select="concat($Gender_Male, $nbsp, ':', $nbsp, $Gender_Female)" disable-output-escaping="yes" />
                </td>
                <td id="Selected_Pokemon_GenderRatio" class="POPUP_CELL DATA_BOX" />
              </tr>
              <tr>
                <td colspan="2" class="POPUP_CELL">Shiny Available:</td>
                <td id="Selected_Pokemon_Shiny" class="POPUP_CELL DATA_BOX" />
              </tr>
              <tr />
              <tr>
                <td colspan="2" class="POPUP_CELL">Availability:</td>
                <td colspan="2" id="Selected_Pokemon_Availability" class="POPUP_CELL DATA_BOX" />
              </tr>
              <tr>
                <td colspan="2" valign="top" class="POPUP_CELL">Type(s):</td>
                <td colspan="2" id="Selected_Pokemon_Types" class="POPUP_CELL DATA_BOX" />
              </tr>
              <tr>
                <td colspan="2" valign="top" class="POPUP_CELL">Boost(s):</td>
                <td colspan="2" id="Selected_Pokemon_Boosts" class="POPUP_CELL DATA_BOX" />
              </tr>
              <tr />
              <tr>
                <td colspan="2" class="POPUP_CELL">Buddy KM for Candy:</td>
                <td colspan="2" id="Selected_Pokemon_BuddyKM" class="POPUP_CELL DATA_BOX NUMERIC" />
              </tr>
              <tr>
                <td colspan="2" class="POPUP_CELL">Max CP/HP:</td>
                <td colspan="2" id="Selected_Pokemon_Max_CP_HP" class="POPUP_CELL DATA_BOX NUMERIC" />
              </tr>
              <tr />
              <tr>
                <td colspan="2" class="POPUP_CELL">Base ATK/DEF/STA:</td>
                <td colspan="2" id="Selected_Pokemon_BaseIV" class="POPUP_CELL DATA_BOX NUMERIC" />
              </tr>
              <tr>
                <td colspan="2" class="POPUP_CELL">Base Capture/Flee Rate:</td>
                <td colspan="2" id="Selected_Pokemon_Rates" class="POPUP_CELL DATA_BOX NUMERIC" />
              </tr>
            </table>
            <!-- 
            <div>
              <br />Evolutions (Row from Evolutions Chart) + Candies/Special
              <br />
              <br />MoveSets (Rows from MoveSets chart)
            </div>
-->
          </div>
        </div>
        
        <!-- EndRegion  -->
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
          <table border="1" class="KEY_TABLE">
            <tr>
              <th colspan="2">
                Types<br /><input id="Type_All_Check" type="checkbox" onchange="OnToggleAllTypes();" />
              </th>
            </tr>
            <tr>
              <td valign="top">
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Bug'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Dark'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Dragon'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Electric'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Fairy'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Fighting'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Fire'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Flying'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Ghost'" />
                </xsl:call-template>
              </td>
              <td valign="top">
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Grass'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Ground'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Ice'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Normal'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Poison'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Psychic'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Rock'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Steel'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputTypeCheckbox">
                  <xsl:with-param name="Type" select="'Water'" />
                </xsl:call-template>
              </td>
            </tr>
          </table>
          <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
          <table border="1" class="KEY_TABLE">
            <tr>
              <th>
                Weather Boosted<br /><input id="Boost_All_Check" type="checkbox" onchange="OnToggleAllBoosts();" />
              </th>
            </tr>
            <tr>
              <td valign="top">
                <xsl:call-template name="OutputWeatherCheckbox">
                  <xsl:with-param name="Weather" select="'Sunny'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputWeatherCheckbox">
                  <xsl:with-param name="Weather" select="'Windy'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputWeatherCheckbox">
                  <xsl:with-param name="Weather" select="'Cloudy'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputWeatherCheckbox">
                  <xsl:with-param name="Weather" select="'Partly Cloudy'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputWeatherCheckbox">
                  <xsl:with-param name="Weather" select="'Fog'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputWeatherCheckbox">
                  <xsl:with-param name="Weather" select="'Rainy'" />
                </xsl:call-template>
                <br />
                <xsl:call-template name="OutputWeatherCheckbox">
                  <xsl:with-param name="Weather" select="'Snow'" />
                </xsl:call-template>
              </td>
            </tr>
          </table>

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

  <xsl:template name="OutputTypeCheckbox">
    <xsl:param name="Type" />
    <input type="checkbox" onchange="OnToggleType(this);">
      <xsl:attribute name="id">
        <xsl:text>Type_</xsl:text>
        <xsl:value-of select="pokeref:Replace($Type, ' ', '')" />
        <xsl:text>_Check</xsl:text>
      </xsl:attribute>
    </input>
    <xsl:call-template name="OutputTypeIcon">
      <xsl:with-param name="Type" select="$Type" />
    </xsl:call-template>
    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
    <xsl:value-of select="$Type" />
  </xsl:template>

  <xsl:template name="OutputWeatherCheckbox">
    <xsl:param name="Weather" />
    <input type="checkbox" onchange="OnToggleBoost(this);">
      <xsl:attribute name="id">
        <xsl:text>Boost_</xsl:text>
        <xsl:value-of select="pokeref:Replace($Weather, ' ', '')" />
        <xsl:text>_Check</xsl:text>
      </xsl:attribute>
    </input>
    <xsl:call-template name="OutputBoostIconByWeather">
      <xsl:with-param name="Weather" select="$Weather" />
    </xsl:call-template>
    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
    <xsl:value-of select="$Weather" />
    <xsl:if test="$Weather = 'Sunny'">/Clear</xsl:if>
  </xsl:template>

</xsl:stylesheet>
