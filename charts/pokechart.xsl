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

        <title>Pokemon</title>

        <style>
          .DATA_BOX {
          width: 5em;
          border: 1px solid black;
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
        <!-- The box to contain data from selected pokemon -->
        <div id="Selected_Pokemon_Dialog" class="POPUP_DIALOG" style="top:0; right:0; width:28em; height:25em; border:4px outset grey; display:none;">
          <div id="Selected_Pokemon_Dialog_Header" style="top:0px; left:0px; right:0px; padding:0; background-color:silver; font-size:x-large;">
            <span style="float:right; color:white; cursor:pointer; margin-right:.5em;" onclick="OnClosePopup();">
              <xsl:value-of select="$times" />
            </span>
            <span id="Selected_Pokemon_Title" />
          </div>

          <div class="FLOAT_END" style="padding:.25em;">
            <span class="FLOAT_LEFT" id="Selected_Pokemon" />
            <table style="white-space:nowrap;">
              <tr>
                <td style="width:1px">Generation:</td>
                <td id="Selected_Pokemon_Generation" class="DATA_BOX" />
              </tr>
              <tr>
                <td style="width:1px">Candies:</td>
                <td id="Selected_Pokemon_Family" class="DATA_BOX" />
              </tr>
              <tr>
                <td style="width:1px">
                  <xsl:value-of select="concat($Gender_Male, $nbsp, ':', $nbsp, $Gender_Female)"/>
                </td>
                <td id="Selected_Pokemon_GenderRatio" class="DATA_BOX" />
              </tr>
              <tr>
                <td style="width:1px">Shiny Available:</td>
                <td id="Selected_Pokemon_Shiny" class="DATA_BOX" />
              </tr>
            </table>
            <table class="FLOAT_END" style="white-space:nowrap;">
              <tr>
                <td valign="top" style="width:1px;" rowspan="2">Type(s):</td>
                <td id="Selected_Pokemon_Type1" class="DATA_BOX" />
              </tr>
              <tr>
                <td id="Selected_Pokemon_Type2" class="DATA_BOX" />
              </tr>
              <tr>
                <td valign="top" style="width:1px;" rowspan="2">Boost(s):</td>
                <td id="Selected_Pokemon_Boost1" class="DATA_BOX" />
              </tr>
              <tr>
                <td id="Selected_Pokemon_Boost2" class="DATA_BOX" />
              </tr>
              <tr>
                <td style="width:1px">Availability:</td>
                <td id="Selected_Pokemon_Availability" class="DATA_BOX" />
              </tr>
              <tr style="width:1px;">
                <!-- TODO QZX -->
                <xsl:attribute name="style">display:none;</xsl:attribute>
                <td>Max CP/HP:</td>
                <td id="Selected_Pokemon_Max_CP_HP" class="DATA_BOX" />
              </tr>
              <tr style="width:1px;">
                <!-- TODO QZX -->
                <xsl:attribute name="style">display:none;</xsl:attribute>
                <td>Buddy KM for Candy:</td>
                <td id="Selected_Pokemon_BuddyKM" class="DATA_BOX" />
              </tr>
              <tr style="width:1px;">
                <!-- TODO QZX -->
                <xsl:attribute name="style">display:none;</xsl:attribute>
                <td>Base ATK/DEF/STA:</td>
                <td id="Selected_Pokemon_BaseIV" class="DATA_BOX" />
              </tr>
              <tr style="width:1px;">
                <!-- TODO QZX -->
                <xsl:attribute name="style">display:none;</xsl:attribute>
                <td>Capture Rate:</td>
                <td id="Selected_Pokemon_Capture" class="DATA_BOX" />
              </tr>
              <tr style="width:1px;">
                <!-- TODO QZX -->
                <xsl:attribute name="style">display:none;</xsl:attribute>
                <td>Flee Rate:</td>
                <td id="Selected_Pokemon_Flee" class="DATA_BOX" />
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
        <!-- ======================================================================================== -->

        <br />
        <h2>
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
          <xsl:value-of select="$nbsp" />
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
          <xsl:value-of select="$nbsp" />
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
              <Attributes onclick="OnSelectPokemon(this)">
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
    <xsl:value-of select="$nbsp" />
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
    <xsl:value-of select="$nbsp" />
    <xsl:value-of select="$Weather" />
    <xsl:if test="$Weather = 'Sunny'">/Clear</xsl:if>
  </xsl:template>

</xsl:stylesheet>
