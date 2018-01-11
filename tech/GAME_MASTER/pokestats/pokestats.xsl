<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="/xsl/global.xsl"/>
  <!--

    ***** TODO *****
    - Make it so table scrolls, leaving the headers at the top.

-->

  <!-- Main Template -->
  <xsl:template match="Root">
    <html lang="en-us">
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

        <title>
          Pokemon Stats - Gen <xsl:value-of select="PokemonStats/Generation/ID" /> (First Found In The <xsl:value-of select="PokemonStats/Generation/Region" /> Region)
        </title>
      </head>
      <body>
        <h1>
          Pokemon Stats - Gen <xsl:value-of select="PokemonStats/Generation/ID" /> <span class="NOTE">
            (First Found In The <xsl:value-of select="PokemonStats/Generation/Region" /> Region)
          </span>
        </h1>
        <p class="NOTE">
          <b>NOTE</b>: Last Updated <xsl:value-of select="$GameMaster_TimeStamp" />
        </p>

        <xsl:call-template name="CreateKey" />

        <br />
        <table border="1">
          <xsl:call-template name="CreateTableHeaders" />
          <xsl:apply-templates select="PokemonStats/Pokemon"  mode="Local" />
        </table>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="CreateKey">
    <table align="center" style="border:1px solid black">
      <tr>
        <th colspan="2">
          <h2>
            <u>Key</u>
          </h2>
          <br />
        </th>
      </tr>
      <tr>
        <td valign="top">
          <table border="1">
            <comment commment="Limited Availablility">
              <tr>
                <th rowspan="2">Limited Availability</th>
                <td class="REGIONAL">Regional Availability</td>
              </tr>
              <tr>
                <td class="UNAVAILABLE">Unavailable</td>
              </tr>
            </comment>

            <comment commment="Limited Origin">
              <tr>
                <th rowspan="5">Limited Origin</th>
                <td class="HATCH_ONLY_2K">Available From 2K Egg Only</td>
              </tr>
              <tr>
                <td class="HATCH_ONLY_5K">Available From 5K Egg Only</td>
              </tr>
              <tr>
                <td class="HATCH_ONLY_10K">Available From 10K Egg Only</td>
              </tr>
              <tr>
                <td class="RAIDBOSS_ONLY">Available As Raid Boss Only</td>
              </tr>
              <tr>
                <td class="RAIDBOSS_ONLY_EX">Available As EX Raid Boss Only</td>
              </tr>
            </comment>

            <comment commment="Special">
              <tr>
                <th>Special</th>
                <td class="LEGENDARY">Legendary</td>
              </tr>
            </comment>

            <tr>
              <td colspan="2" class="NOTE">
                May combine one from each section.
              </td>
            </tr>

          </table>
        </td>
        <td valign="top">
          <table border="1">
            <tr>
              <th rowspan="4">
                Rates and Probabliities<br /><span class="NOTE">(From trainer's point of view)</span>
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
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <tr>
      <th rowspan="2" colspan="5" valign="bottom">Pokemon</th>
      <th rowspan="3" colspan="1" valign="bottom">Type of Candies</th>
      <th rowspan="2" colspan="4" valign="bottom">Evolves From</th>
      <th rowspan="3" colspan="1" valign="bottom">
        Buddy<br/>Km<br/>for<br/>Candy
      </th>
      <th rowspan="1" colspan="12" valign="bottom">Base Stats</th>
      <th rowspan="2" colspan="2" valign="bottom">Max</th>
      <th rowspan="3" colspan="1" valign="bottom">Availability</th>
    </tr>
    <tr>
      <th rowspan="1" colspan="3" valign="bottom">Base</th>
      <th rowspan="1" colspan="2" valign="bottom">Height</th>
      <th rowspan="1" colspan="2" valign="bottom">Weight</th>
      <th rowspan="1" colspan="2" valign="bottom">Rates</th>
      <th rowspan="1" colspan="2" valign="bottom">Probabilities</th>
      <th rowspan="2" colspan="1" valign="bottom">&#9792; : &#9794;</th>
    </tr>
    <tr>
      <th colspan="2">ID</th>
      <th>Name</th>
      <th colspan="2" valign="bottom">Type</th>
      <th>Candies</th>
      <th>#</th>
      <th>Special</th>
      <th>ATK</th>
      <th>DEF</th>
      <th>STA</th>
      <th>Std.</th>
      <th>Dev.</th>
      <th>Std.</th>
      <th>Dev.</th>
      <th>Capture</th>
      <th>Flee</th>
      <th>Attack</th>
      <th>Dodge</th>
      <th>CP</th>
      <th>HP</th>
    </tr>
  </xsl:template>

  <!-- Template to create row for a Pokemon -->
  <xsl:template match="Pokemon" mode="Local">
    <tr>
      <xsl:attribute name="class">
        <xsl:if test="contains(Availability,$Availability_Unavailable)">
          <xsl:text>UNAVAILABLE </xsl:text>
        </xsl:if>
        <xsl:if test="contains(Availability,$Availability_Regional)">
          <xsl:text>REGIONAL </xsl:text>
        </xsl:if>
      </xsl:attribute>
      <td id="Icon" style="padding:0;">
        <xsl:apply-templates select=".">
          <xsl:with-param name="Settings">
            <Show hide_name="true" />
          </xsl:with-param>
        </xsl:apply-templates>
      </td>
      <td id="ID" align="right">
        <xsl:value-of select="ID" />
      </td>
      <td id="Name">
        <xsl:value-of select="Name" />
      </td>
      <td id="TypePrimary">
        <xsl:value-of select="Type/Primary" />
      </td>
      <td id="TypeSecondary">
        <xsl:choose>
          <xsl:when test="Type/Secondary != ''">
            <xsl:value-of select="Type/Secondary" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">UNUSED</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td id="Candy">
        <xsl:value-of select="CandyType" />
      </td>
      <xsl:choose>
        <xsl:when test="EvolvesFrom/Pokemon/ID != ''">
          <td align="right">
            <xsl:value-of select="EvolvesFrom/Pokemon/ID" />
          </td>
          <td>
            <xsl:value-of select="EvolvesFrom/Pokemon/Name" />
          </td>
          <td align="right">
            <xsl:value-of select="EvolvesFrom/Candies" />
          </td>
          <td>
            <xsl:value-of select="EvolvesFrom/Special" />
          </td>
        </xsl:when>
        <xsl:otherwise>
          <td colspan="4">
            <xsl:attribute name="class">UNUSED</xsl:attribute>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <td id="BuddyKM" align="right">
        <xsl:value-of select="BuddyKM" />
      </td>
      <td id="BaseAttack" align="right">
        <xsl:value-of select="Stats/Base/Attack" />
      </td>
      <td id="BaseDefense" align="right">
        <xsl:value-of select="Stats/Base/Defense" />
      </td>
      <td id="BaseStamina" align="right">
        <xsl:value-of select="Stats/Base/Stamina" />
      </td>
      <td id="Height" align="right">
        <xsl:value-of select="format-number(Stats/Height/Standard, '#0.0')" />
      </td>
      <td id="Height StandardDev" align="right">
        <xsl:value-of select="format-number(Stats/Height/Deviation, '#0.0000')" />
      </td>
      <td id="Weight" align="right">
        <xsl:value-of select="format-number(Stats/Weight/Standard, '#0.0')" />
      </td>
      <td id="Weight StandardDev" align="right">
        <xsl:value-of select="format-number(Stats/Weight/Deviation, '#0.0000')" />
      </td>
      <td id="Capture Rate" align="right">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="Stats/Rates/Capture >= $Capture_Easy">
              <xsl:text>GREAT</xsl:text>
            </xsl:when>
            <xsl:when test="Stats/Rates/Capture >= $Capture_Moderate">
              <xsl:text>GOOD</xsl:text>
            </xsl:when>
            <xsl:when test="Stats/Rates/Capture >= $Capture_Difficult">
              <xsl:text>POOR</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>BAD</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="format-number(Stats/Rates/Capture * 100, '#0')" />
        <xsl:text>%</xsl:text>
      </td>
      <td id="Flee Rate" align="right">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="Stats/Rates/Flee >= $Flee_Bad">
              <xsl:text>BAD</xsl:text>
            </xsl:when>
            <xsl:when test="Stats/Rates/Flee >= $Flee_Okay">
              <xsl:text>POOR</xsl:text>
            </xsl:when>
            <xsl:when test="Stats/Rates/Flee >= $Flee_Nice">
              <xsl:text>GOOD</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>GREAT</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="format-number(Stats/Rates/Flee * 100, '#0')" />
        <xsl:text>%</xsl:text>
      </td>
      <td id="Attack Probability" align="right">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="Stats/Probability/Attack >= $Attack_Bad">
              <xsl:text>BAD</xsl:text>
            </xsl:when>
            <xsl:when test="Stats/Probability/Attack >= $Attack_Okay">
              <xsl:text>POOR</xsl:text>
            </xsl:when>
            <xsl:when test="Stats/Probability/Attack >= $Attack_Nice">
              <xsl:text>GOOD</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>GREAT</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="format-number(Stats/Probability/Attack * 100, '#0')" />
        <xsl:text>%</xsl:text>
      </td>
      <td id="Dodge Probability" align="right">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="Stats/Probability/Dodge >= $Dodge_Bad">
              <xsl:text>BAD</xsl:text>
            </xsl:when>
            <xsl:when test="Stats/Probability/Dodge >= $Dodge_Okay">
              <xsl:text>POOR</xsl:text>
            </xsl:when>
            <xsl:when test="Stats/Probability/Dodge >= $Dodge_Nice">
              <xsl:text>GOOD</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>GREAT</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="format-number(Stats/Probability/Dodge * 100, '#0')" />
        <xsl:text>%</xsl:text>
      </td>
      <td id="Gender" align="center">
        <xsl:if test="string-length(GenderRatio)=1">
          <xsl:attribute name="style">font-size:larger;</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="GenderRatio" />
      </td>
      <td id="MaxCP" align="right">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="Max/CP > $CP_Great">
              <xsl:text>GREAT</xsl:text>
            </xsl:when>
            <xsl:when test="Max/CP > $CP_Good">
              <xsl:text>GOOD</xsl:text>
            </xsl:when>
            <xsl:when test="Max/CP > $CP_OK">
              <xsl:text>POOR</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>BAD</xsl:text>
            </xsl:otherwise>
          </xsl:choose>;
        </xsl:attribute>
        <xsl:value-of select="Max/CP" />
      </td>
      <td id="MaxHP" align="right">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="Max/HP > $HP_Great">
              <xsl:text>GREAT</xsl:text>
            </xsl:when>
            <xsl:when test="Max/HP > $HP_Good">
              <xsl:text>GOOD</xsl:text>
            </xsl:when>
            <xsl:when test="Max/HP > $HP_OK">
              <xsl:text>POOR</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>BAD</xsl:text>
            </xsl:otherwise>
          </xsl:choose>;
        </xsl:attribute>
        <xsl:value-of select="Max/HP" />
      </td>
      <td id="Availability">
        <xsl:value-of select="Availability" />
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
