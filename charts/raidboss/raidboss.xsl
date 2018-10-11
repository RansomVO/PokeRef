<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:include href="/xsl/global.xsl" />
  <xsl:include href="raidbosses.xsl" />
  <!--
    ***** TODO *****
    - Make it so table scrolls, leaving the headers at the top.
-->

  <xsl:variable name="IV_Separator" select="concat($nbsp, '&#x2022;', $nbsp)" />

  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>raidboss.js?cacherefresh=</xsl:text>
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
          <xsl:value-of select="RaidBoss/Pokemon/@name" />
          <xsl:if test="RaidBoss/Pokemon/@form">
            <xsl:text> (</xsl:text>
            <xsl:value-of select="RaidBoss/Pokemon/@form"/>
            <xsl:text>)</xsl:text>
          </xsl:if>
          <xsl:text> - Raid Boss Possible IVs</xsl:text>
        </title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          RaidBoss Possible IVs<br />
          <xsl:apply-templates select="RaidBoss/Pokemon" mode="Sprite" />
          <xsl:value-of select="RaidBoss/Pokemon/@name" />
          <span class="NOTE">
            <xsl:if test="RaidBoss/Pokemon/@form">
              <xsl:text> (</xsl:text>
              <xsl:value-of select="RaidBoss/Pokemon/@form"/>
              <xsl:text>)</xsl:text>
            </xsl:if>
          </span>
          <xsl:text> (CP: </xsl:text>
          <xsl:choose>
            <xsl:when test="not(RaidBoss/@raid_cp)">
              <xsl:text>???</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="RaidBoss/@raid_cp" />
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
          For more details, take a look at <a href=".">Possible IVs for Raid Bosses</a>.
        </p>
        <hr />
        <input id="Checkbox_Boosted" type="checkbox" onchange="ToggleChart();" /> Weather Boosted
        <br />
        <xsl:apply-templates select="RaidBoss" />

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <xsl:param name="MaxColumns" />

    <tr style="background-color:default;">
      <th rowspan="2" valign="bottom">CP</th>
      <th colspan="2" valign="bottom">IV Range</th>
      <xsl:call-template name="OutputIVHeaders">
        <xsl:with-param name="column" select="1" />
        <xsl:with-param name="maxColumns" select="$MaxColumns" />
      </xsl:call-template>
    </tr>
    <tr>
      <th>Min</th>
      <th>Max</th>
    </tr>
  </xsl:template>

  <!-- Template to output headers for possible IVs in the row -->
  <xsl:template name="OutputIVHeaders">
    <xsl:param name="column" />
    <xsl:param name="maxColumns" />

    <th rowspan="2" valign="bottom">
      <xsl:text>Possible IV </xsl:text>
      <xsl:value-of select="$column" />
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

  <!-- Template that generates the tables -->
  <xsl:template match="RaidBoss">
    <xsl:call-template name="RaidBossTable">
      <xsl:with-param name="PossibilitySet" select="Regular" />
    </xsl:call-template>

    <xsl:call-template name="RaidBossTable">
      <xsl:with-param name="PossibilitySet" select="Boosted" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="RaidBossTable">
    <xsl:param name="PossibilitySet" />

    <!-- Create the table -->
    <table border="1" style="display:none;">
      <xsl:attribute name="id">
        <xsl:value-of select="name($PossibilitySet)" />
      </xsl:attribute>
      <xsl:call-template name="CreateTableHeaders">
        <xsl:with-param name="MaxColumns" select="$PossibilitySet/@columns" />
      </xsl:call-template>

      <xsl:apply-templates select="$PossibilitySet/Possibilities">
        <xsl:sort order="descending" data-type="number" select="@cp" />
      </xsl:apply-templates>
    </table>
  </xsl:template>

  <!-- Template to create the row for a Possibility -->
  <xsl:template match="Possibilities">
    <tr>
      <th style="padding:0; margin:0; border-collapse:collapse; border:none;">
        <span style="font-size:larger">
          <xsl:value-of select="@cp" />
        </span>
      </th>
      <th align="right">
        <xsl:choose>
          <xsl:when test="@min_score=0">
            <xsl:attribute name="style">border:none</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="format-number(@min_score, '#0')" />
            <xsl:text>%</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </th>
      <th align="right">
        <xsl:value-of select="format-number(@max_score, '#0')" />
        <xsl:text>%</xsl:text>
      </th>

      <xsl:apply-templates select="IVs">
        <xsl:sort order="descending" data-type="number" select="@score" />
      </xsl:apply-templates>

      <xsl:if test="../@columns &gt; count(IVs)">
        <td class="UNUSED">
          <xsl:attribute name="colspan">
            <xsl:value-of select="../@columns - count(IVs)" />
          </xsl:attribute>
        </td>
      </xsl:if>
    </tr>
  </xsl:template>

  <!-- Template to output a cell with a possible IV -->
  <xsl:template match="IVs">
    <td align="right">
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@score >= $Desirable_IV">
            <xsl:text>GREAT</xsl:text>
          </xsl:when>
          <xsl:when test="@score >= round($IV_Amazes_Min * 100 div $IV_Max)">
            <xsl:text>GOOD</xsl:text>
          </xsl:when>
          <xsl:when test="@score >= round($IV_Strong_Min * 100 div $IV_Max)">
            <xsl:text>OKAY</xsl:text>
          </xsl:when>
          <xsl:when test="@score >= round($IV_Decent_Min * 100 div $IV_Max)">
            <xsl:text>POOR</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>BAD</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@score != ''">
          <xsl:attribute name="style">padding-left:2em; padding-right:2em;</xsl:attribute>
          <b>
            <xsl:value-of select="concat(format-number(@score, '#0'), '%', $nbsp)" disable-output-escaping="yes" />
          </b>
          <xsl:value-of select="concat(@attack, $IV_Separator, @defense, $IV_Separator, @stamina)" disable-output-escaping="yes" />
          <i>
            <xsl:value-of select="concat($nbsp, '(', @hp, ')')" disable-output-escaping="yes" />
          </i>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>

</xsl:stylesheet>
