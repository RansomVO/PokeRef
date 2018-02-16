<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:include href="/xsl/global.xsl" />
  <xsl:include href="raidbosses.xsl"/>
  <!--
    ***** TODO *****
    - Make it so table scrolls, leaving the headers at the top.
-->

  <xsl:template match="Root">
    <html lang="en-us">
      <head>
        <!-- This is to make the font size consistent on mobile. -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>raidboss.js?cacherefresh=</xsl:text>
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
          <xsl:value-of select="RaidBoss/Pokemon/Name" /> - RaidBoss Possible IVs
        </title>
      </head>
      <body>
        <h1>
          RaidBoss Possible IVs:<br />
          <xsl:apply-templates select="RaidBoss/Pokemon" mode="Sprite" />
          <xsl:value-of select="RaidBoss/Pokemon/Name" />
          <xsl:text> (CP: </xsl:text>
          <xsl:choose>
            <xsl:when test="RaidBoss/Pokemon/RaidCP = 0">
              <xsl:text>???</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="RaidBoss/Pokemon/RaidCP"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:text>)</xsl:text>
        </h1>
        <p>
          When you are trying to catch a Raid Boss, after the battle, you can figure out how good it may be.
          <br />
          Just look up the CP in the first column in the chart below, and then you will be able to see all of the possible IV scores.
        </p>
        <p>
          After you have caught the Raid Boss, you can compare its HP with the possibilities and narrow it down further.
        </p>
        <p>
          For more details, take a look at <a href=".">Possible IVs for Raid Bosses</a>
        </p>
        <hr />
        <input id="Checkbox_Boosted" type="checkbox" onchange="ToggleChart();" /> Weather Boosted
        <br />
        <xsl:apply-templates select="RaidBoss" />

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <xsl:param name="MaxColumns" />

    <tr>
      <th rowspan="2" valign="bottom">CP</th>
      <th colspan="2" valign="bottom">IV Range</th>
      <xsl:call-template name="OutputIVHeaders">
        <xsl:with-param name="column" select="1" />
        <xsl:with-param name="maxColumns" select="$MaxColumns" />
      </xsl:call-template>
    </tr>
    <tr>
      <td>Min</td>
      <td>Max</td>
    </tr>
  </xsl:template>

  <!-- Template to output headers for possible IVs in the row -->
  <xsl:template name="OutputIVHeaders">
    <xsl:param name="column" />
    <xsl:param name="maxColumns" />

    <th rowspan="2" valign="bottom">
      <xsl:text>IV </xsl:text>
      <xsl:value-of select="$column"/>
      <br/>
      <span class="SUBCOMMENT">
        <xsl:text>%: Atk &#8226; Def &#8226; Sta </xsl:text>
        <i>(HP)</i>
      </span>
    </th>

    <xsl:if test="$maxColumns > $column">
      <xsl:call-template name="OutputIVHeaders">
        <xsl:with-param name="column" select="$column+1" />
        <xsl:with-param name="maxColumns" select="$maxColumns" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Template that generates the table -->
  <xsl:template match="RaidBoss">
    <xsl:call-template name="RaidBossTable">
      <xsl:with-param name="Possibilities" select="Possibility/Regular" />
    </xsl:call-template>

    <xsl:call-template name="RaidBossTable">
      <xsl:with-param name="Possibilities" select="Possibility/Boosted" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="RaidBossTable">
    <xsl:param name="Possibilities" />

    <!-- Figure out how many columns should be displayed-->
    <xsl:variable name="MaxColumns">
      <xsl:choose>
        <xsl:when test="count($Possibilities//IV2/Percent[text()]) = 0">1</xsl:when>
        <xsl:when test="count($Possibilities//IV3/Percent[text()]) = 0">2</xsl:when>
        <xsl:when test="count($Possibilities//IV4/Percent[text()]) = 0">3</xsl:when>
        <xsl:when test="count($Possibilities//IV5/Percent[text()]) = 0">4</xsl:when>
        <xsl:when test="count($Possibilities//IV6/Percent[text()]) = 0">5</xsl:when>
        <xsl:when test="count($Possibilities//IV7/Percent[text()]) = 0">6</xsl:when>
        <xsl:when test="count($Possibilities//IV8/Percent[text()]) = 0">7</xsl:when>
        <xsl:when test="count($Possibilities//IV9/Percent[text()]) = 0">8</xsl:when>
        <xsl:when test="count($Possibilities//IV10/Percent[text()]) = 0">9</xsl:when>
        <xsl:when test="count($Possibilities//IV11/Percent[text()]) = 0">10</xsl:when>
        <xsl:when test="count($Possibilities//IV12/Percent[text()]) = 0">11</xsl:when>
        <xsl:when test="count($Possibilities//IV13/Percent[text()]) = 0">12</xsl:when>
        <xsl:when test="count($Possibilities//IV14/Percent[text()]) = 0">13</xsl:when>
        <xsl:when test="count($Possibilities//IV15/Percent[text()]) = 0">14</xsl:when>
        <xsl:when test="count($Possibilities//IV16/Percent[text()]) = 0">15</xsl:when>
        <xsl:when test="count($Possibilities//IV17/Percent[text()]) = 0">16</xsl:when>
        <xsl:when test="count($Possibilities//IV18/Percent[text()]) = 0">17</xsl:when>
        <xsl:when test="count($Possibilities//IV19/Percent[text()]) = 0">18</xsl:when>
        <xsl:when test="count($Possibilities//IV20/Percent[text()]) = 0">19</xsl:when>
        <xsl:otherwise>20</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Create the table -->
    <table border="1" style="display:none;">
      <xsl:attribute name="id">
        <xsl:value-of select="name($Possibilities[1])"/>
      </xsl:attribute>
      <xsl:call-template name="CreateTableHeaders">
        <xsl:with-param name="MaxColumns" select="$MaxColumns" />
      </xsl:call-template>

      <xsl:apply-templates select="$Possibilities[CP != '']">
        <xsl:with-param name="MaxColumns" select="$MaxColumns" />
      </xsl:apply-templates>
    </table>
  </xsl:template>

  <!-- Templates to allow matching, which call the template to output a row. -->
  <xsl:template match="Regular">
    <xsl:param name="MaxColumns" />

    <xsl:call-template name="Possibility">
      <xsl:with-param name="MaxColumns" select="$MaxColumns" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="Boosted">
    <xsl:param name="MaxColumns" />

    <xsl:call-template name="Possibility">
      <xsl:with-param name="MaxColumns" select="$MaxColumns" />
    </xsl:call-template>
  </xsl:template>

  <!-- Template to create row for a Possibility -->
  <xsl:template name="Possibility">
    <xsl:param name="MaxColumns" />

    <tr>
      <th style="padding:0; margin:0; border-collapse:collapse; border:none;">
        <span style="font-size:larger">
          <xsl:value-of select="CP"/>
        </span>
      </th>
      <th align="right">
        <xsl:choose>
          <xsl:when test="Range/Min = ''">
            <xsl:attribute name="style">border:none</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="format-number(Range/Min * 100, '#0')" />%
          </xsl:otherwise>
        </xsl:choose>
      </th>
      <th align="right">
        <xsl:value-of select="format-number(Range/Max * 100, '#0')" />%
      </th>

      <xsl:call-template name="OutputIVValues">
        <xsl:with-param name="column" select="1" />
        <xsl:with-param name="maxColumns" select="$MaxColumns" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <!-- Template to output possible IVs in the row -->
  <xsl:template name="OutputIVValues">
    <xsl:param name="column" />
    <xsl:param name="maxColumns" />

    <xsl:call-template name="PossibleIV">
      <xsl:with-param name="IV" select="node()[$column+2]" />
    </xsl:call-template>

    <xsl:if test="$maxColumns > $column">
      <xsl:call-template name="OutputIVValues">
        <xsl:with-param name="column" select="$column+1" />
        <xsl:with-param name="maxColumns" select="$maxColumns" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Template to output a possible IV -->
  <xsl:template name="PossibleIV">
    <xsl:param name="IV" />

    <xsl:variable name="percent" select="$IV/Percent" />
    <xsl:variable name="class">
      <xsl:choose>
        <xsl:when test="$percent = ''">
          <xsl:text>UNUSED</xsl:text>
        </xsl:when>
        <xsl:when test="$percent >= $Desirable_IV">
          <xsl:text>GREAT</xsl:text>
        </xsl:when>
        <xsl:when test="$percent >= $IV_Amaze_Min div $IV_Amaze_Max">
          <xsl:text>GOOD</xsl:text>
        </xsl:when>
        <xsl:when test="$percent >= $IV_Strong_Min div $IV_Amaze_Max">
          <xsl:text>OKAY</xsl:text>
        </xsl:when>
        <xsl:when test="$percent >= $IV_Decent_Min div $IV_Amaze_Max">
          <xsl:text>POOR</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>BAD</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <td align="right">
      <xsl:attribute name="class">
        <xsl:value-of select="$class" />
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="$IV/Percent != ''">
          <xsl:attribute name="style">padding-left:2em; padding-right:2em;</xsl:attribute>
          <b>
            <xsl:value-of select="concat(format-number($percent * 100, '#0'), '%', $nbsp)" disable-output-escaping="yes" />
          </b>
          <xsl:apply-templates select="$IV/Score" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>

  <!-- Template to output a single score -->
  <xsl:template match="Score">
    <xsl:value-of select="concat(Attack, $nbsp, '&#x2022;', $nbsp, Defense, $nbsp, '&#x2022;', $nbsp, Stamina)" disable-output-escaping="yes" />
    <i>
      <xsl:value-of select="concat($nbsp, '(', HP, ')')" disable-output-escaping="yes" />
    </i>
  </xsl:template>

</xsl:stylesheet>
