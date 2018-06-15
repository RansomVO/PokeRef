<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:pokeref="urn:pokeref"

>
  
  <xsl:include href="/xsl/global.xsl" />

  <!-- Main Template -->
  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

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

        <title>
          Pokemon Stats - Gen <xsl:value-of select="PokeStats/@gen" /> (First Found In The <xsl:value-of select="PokemonStats/Generation/Region" /> Region)
        </title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon Stats - Gen <xsl:value-of select="PokeStats/@gen" />
          <span class="NOTE">
            (First Found In The <xsl:value-of select="PokeStats/@region" /> Region)
          </span>
        </h1>
        <p class="NOTE">
          <b>NOTE</b>: Last Updated <xsl:value-of select="$GAME_MASTER_Timestamp" />
        </p>
        <xsl:call-template name="CreateKey" />

        <br />
        <table border="1">
          <xsl:call-template name="CreateTableHeaders" />
          <xsl:apply-templates select="PokeStats/Pokemon"  mode="Local">
            <xsl:sort order="ascending" data-type="number" select="@id" />
            <xsl:sort order="ascending" data-type="number" select="@formId" />
          </xsl:apply-templates>
        </table>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="CreateKey">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'POKESTAT_KEY'" />
      </xsl:call-template>
      <xsl:text>Key</xsl:text>
    </h2>
    <div id="POKESTAT_KEY" style="margin-top:.5em;">
      <xsl:call-template name="PokemonImageKey" />

      <div class="FLOWING_TABLE_WRAPPER">
        <table id="POKESTATS_RATING_KEY" class="KEY_TABLE" border="1">
          <tr>
            <th rowspan="4">
              Rates<br /><span class="NOTE">(From trainer's point of view)</span>
            </th>
            <td class="GREAT">Great</td>
          </tr>
          <tr>
            <td class="GOOD">Good</td>
          </tr>
          <tr>
            <td class="POOR">Poor</td>
          </tr>
          <tr>
            <td class="BAD">Bad</td>
          </tr>
        </table>
      </div>
    </div>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <tr>
      <td rowspan="2" colspan="2">
        <span style="font-size:xx-large; font-weight:bold;">Pokemon</span>
      </td>
      <th rowspan="2" valign="bottom">Evolves From</th>
      <th colspan="5" valign="bottom">GAME_MASTER Stats</th>
      <th rowspan="2" valign="bottom">
        Max<br />Stats
      </th>
      <th rowspan="2" valign="bottom">Availability</th>
    </tr>
    <tr>
      <th valign="bottom">Misc.</th>
      <th valign="bottom">Base IV</th>
      <th valign="bottom">Height</th>
      <th valign="bottom">Weight</th>
      <th valign="bottom">Rates</th>
    </tr>
  </xsl:template>

  <!-- Template to create row for a Pokemon -->
  <xsl:template match="Pokemon" mode="Local">
    <xsl:variable name="id" select="@id" />
    <xsl:variable name="typePrimary" select="Type/@primary" />
    <xsl:variable name="typeSecondary" select="Type/@secondary" />
    <xsl:variable name="attack" select="Stats/BaseIV/@attack" />
    <xsl:variable name="defense" select="Stats/BaseIV/@defense" />
    <xsl:variable name="stamina" select="Stats/BaseIV/@stamina" />
    <xsl:variable name="isForm" select="@form" />
    <xsl:variable name="formCount" select="count(../Pokemon[@id = $id and @form])" />
    <xsl:variable name="formMatchCount" select="count(
                  ../Pokemon
                  [
                    @id = $id
                    and @form
                    and Type/@primary = $typePrimary
                    and (not(Type/@secondary) or Type/@secondary=$typeSecondary)
                    and Stats/BaseIV/@attack = $attack
                    and Stats/BaseIV/@defense = $defense
                    and Stats/BaseIV/@stamina = $stamina
			              ]
                  )" />

    <!-- TODO QZX: This test will fail if we have a case where 2 forms match, but the rest don't. (We'll deal with that if it becomes and issue.) -->
    <xsl:if test="(not($isForm) and ($formCount = 0 or $formCount = $formMatchCount)) or ($isForm and $formMatchCount = 1)">
      <tr>
        <xsl:attribute name="class">
          <xsl:if test="contains(@availability,$Availability_Unreleased)">
            <xsl:text>UNRELEASED </xsl:text>
          </xsl:if>
          <xsl:if test="contains(@availability,$Availability_Regional)">
            <xsl:text>REGIONAL </xsl:text>
          </xsl:if>
        </xsl:attribute>
        <td comment="Icon" style="padding:0;">
          <xsl:apply-templates select=".">
            <xsl:with-param name="Settings">
              <Show hide_type_icons="true" />
            </xsl:with-param>
          </xsl:apply-templates>
        </td>
        <td comment="Types, etc." valign="top">
          <table>
            <tr>
              <td valign="top">
                <b>Type(s):</b>
              </td>
              <td>
                <xsl:call-template name="OutputTypeIconWithBoost">
                  <xsl:with-param name="Type" select="$typePrimary" />
                </xsl:call-template>
                <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                <xsl:value-of select="$typePrimary" />
                <xsl:if test="$typeSecondary">
                  <br />
                  <xsl:call-template name="OutputTypeIconWithBoost">
                    <xsl:with-param name="Type" select="$typeSecondary" />
                  </xsl:call-template>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                  <xsl:value-of select="$typeSecondary" />
                </xsl:if>
              </td>
            </tr>
            <tr>
              <td>
                <b>Candies:</b>
              </td>
              <td>
                <xsl:value-of select="@family" />
              </td>
            </tr>
            <xsl:if test="@shiny">
              <tr>
                <td colspan="2">
                  <span style="font-size:larger; font-weight:bold;">May be Shiny!</span>
                </td>
              </tr>
            </xsl:if>
          </table>
        </td>
        <td comment="Evolves From" valign="top">
          <xsl:choose>
            <xsl:when test="EvolvesFrom/@id">
              <b>
                <xsl:value-of select="EvolvesFrom/@id" />
                <xsl:value-of select="concat($nbsp, '-', $nbsp)" disable-output-escaping="yes" />
                <xsl:value-of select="EvolvesFrom/@name" />
              </b>
              <br />
              <table class="INDENT">
                <tr>
                  <td>
                    <b>Candies:</b>
                  </td>
                  <td>
                    <xsl:value-of select="EvolvesFrom/@candies" />
                  </td>
                </tr>
                <xsl:if test="EvolvesFrom/@special">
                  <tr>
                    <td>
                      <b>Special:</b>
                    </td>
                    <td>
                      <xsl:call-template name="Sprite">
                        <xsl:with-param name="id" select="pokeref:Replace(EvolvesFrom/@special, ' ', '')" />
                        <xsl:with-param name="Settings">
                          <Show sprite_class="TAG_ICON_MEDIUM" title_pos="after" />
                        </xsl:with-param>
                      </xsl:call-template>
                    </td>
                  </tr>
                </xsl:if>
              </table>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">UNUSED</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </td>
        <td comment="Misc" valign="top">
          <table>
            <tr>
              <td>
                <b>Buddy KM:</b>
              </td>
              <td>
                <xsl:value-of select="@buddy_km" />
              </td>
            </tr>
            <tr>
              <td>
                <b>Gender Ratio:</b>
              </td>
              <td>
                <xsl:if test="string-length(GenderRatio)=1">
                  <xsl:attribute name="style">font-size:larger;</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="@gender_ratio" />
              </td>
            </tr>
            <xsl:if test="@rarity">
              <tr>
              <td>
                <b>Rarity:</b>
              </td>
              <td>
                <xsl:value-of select="@rarity" />
              </td>
            </tr>
            </xsl:if>
            <!-- TODO QZX: Room to add an item here. -->
          </table>
        </td>
        <td comment="BaseIV" valign="top">
          <table>
            <tr>
              <td>
                <b>Attack:</b>
              </td>
              <td align="right">
                <xsl:value-of select="Stats/BaseIV/@attack" />
              </td>
            </tr>
            <tr>
              <td>
                <b>Defense:</b>
              </td>
              <td align="right">
                <xsl:value-of select="Stats/BaseIV/@defense" />
              </td>
            </tr>
            <tr>
              <td>
                <b>Stamina:</b>
              </td>
              <td align="right">
                <xsl:value-of select="Stats/BaseIV/@stamina" />
              </td>
            </tr>
          </table>
        </td>
        <td comment="Height" valign="top">
          <table>
            <tr>
              <td>
                <b>Standard:</b>
              </td>
              <td align="right">
                <xsl:value-of select="format-number(Stats/Height/@standard, '#0.0')" />
              </td>
            </tr>
            <tr>
              <td>
                <b>Deviation:</b>
              </td>
              <td align="right">
                <xsl:value-of select="format-number(Stats/Height/@deviation, '#0.0000')" />
              </td>
            </tr>
          </table>
        </td>
        <td comment="Weight" valign="top">
          <table>
            <tr>
              <td>
                <b>Standard:</b>
              </td>
              <td align="right">
                <xsl:value-of select="format-number(Stats/Weight/@standard, '#0.0')" />
              </td>
            </tr>
            <tr>
              <td>
                <b>Deviation:</b>
              </td>
              <td align="right">
                <xsl:value-of select="format-number(Stats/Weight/@deviation, '#0.0000')" />
              </td>
            </tr>
          </table>
        </td>
        <td comment="Rates" valign="top">
          <table>
            <tr>
              <td>
                <b>Capture:</b>
              </td>
              <td align="right">
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="Stats/Rates/@capture * 100 >= $Capture_Easy">
                      <xsl:text>GREAT</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Rates/@capture * 100 >= $Capture_Moderate">
                      <xsl:text>GOOD</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Rates/@capture * 100 >= $Capture_Difficult">
                      <xsl:text>POOR</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>BAD</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:value-of select="format-number(Stats/Rates/@capture * 100, '#0')" />
                <xsl:text>%</xsl:text>
              </td>
            </tr>
            <tr>
              <td>
                <b>Flee:</b>
              </td>
              <td align="right">
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="Stats/Rates/@flee * 100 >= $Flee_Bad">
                      <xsl:text>BAD</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Rates/@flee * 100 >= $Flee_Okay">
                      <xsl:text>POOR</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Rates/@flee * 100 >= $Flee_Nice">
                      <xsl:text>GOOD</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>GREAT</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:value-of select="format-number(Stats/Rates/@flee * 100, '#0')" />
                <xsl:text>%</xsl:text>
              </td>
            </tr>
            <tr>
              <td>
                <b>Attack:</b>
              </td>
              <td align="right">
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="Stats/Rates/@attack * 100 >= $Attack_Bad">
                      <xsl:text>BAD</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Rates/@attack * 100 >= $Attack_Okay">
                      <xsl:text>POOR</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Rates/@attack * 100 >= $Attack_Nice">
                      <xsl:text>GOOD</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>GREAT</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:value-of select="format-number(Stats/Rates/@attack * 100, '#0')" />
                <xsl:text>%</xsl:text>
              </td>
            </tr>
            <tr>
              <td>
                <b>Dodge:</b>
              </td>
              <td align="right">
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="Stats/Rates/@dodge * 100 >= $Dodge_Bad">
                      <xsl:text>BAD</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Rates/@dodge * 100 >= $Dodge_Okay">
                      <xsl:text>POOR</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Rates/@dodge * 100 >= $Dodge_Nice">
                      <xsl:text>GOOD</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>GREAT</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:value-of select="format-number(Stats/Rates/@dodge * 100, '#0')" />
                <xsl:text>%</xsl:text>
              </td>
            </tr>
          </table>
        </td>
        <td comment="MaxCP" valign="top">
          <table>
            <tr>
              <td>
                <b>CP:</b>
              </td>
              <td align="right">
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="Stats/Max/@cp > $CP_Great">
                      <xsl:text>GREAT</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Max/@cp > $CP_Good">
                      <xsl:text>GOOD</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Max/@cp > $CP_OK">
                      <xsl:text>POOR</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>BAD</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>;
                </xsl:attribute>
                <xsl:value-of select="Stats/Max/@cp" />
              </td>
            </tr>
            <tr>
              <td>
                <b>HP:</b>
              </td>
              <td align="right">
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="Stats/Max/@hp > $HP_Great">
                      <xsl:text>GREAT</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Max/@hp > $HP_Good">
                      <xsl:text>GOOD</xsl:text>
                    </xsl:when>
                    <xsl:when test="Stats/Max/@hp > $HP_OK">
                      <xsl:text>POOR</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>BAD</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>;
                </xsl:attribute>
                <xsl:value-of select="Stats/Max/@hp" />
              </td>
            </tr>
          </table>
        </td>
        <td comment="Availability" style="white-space:normal;">
          <xsl:value-of select="@availability" />
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
