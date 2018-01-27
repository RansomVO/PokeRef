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
        <link type="text/css" rel="stylesheet" >
          <xsl:attribute name="href">
            <xsl:text>index.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </link>

        <title>Pokemon</title>
      </head>
      <body>
        <h1>
          Pokemon Chart <span class="NOTE TODO">(Beta)</span>
        </h1>
        <p>
          These are charts of basic info about Pokemon.
          <br /><span class="NOTE">(Pokemon that are not yet released are greyed out.)</span>
        </p>

        <h2>
          Selection Criteria <button id="POKEMON_CRITERIA_COLLAPSER" />
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
    </h2>
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
            <xsl:if test="count(/Root/RaidBosses/Tier[@name != '? Future ?' and RaidBoss = $Name]) != 0">
              <Attributes raidboss="true" />
            </xsl:if>
          </xsl:with-param>
        </xsl:apply-templates>
      </xsl:for-each>
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
