<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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

        <style>
          td, th {
          padding-left: 1em;
          padding-right: 1em;
          }
        </style>

        <title>Move Effectiveness</title>
      </head>
      <body>

        <h1>
          <xsl:call-template name="HomePageLink" />
          Move Effectiveness
        </h1>
        <p>
          When an Attack Move is used against a Pokemon, it may either be <img src="images/supereffective.png" style="height:1em;" alt="Super Effective" /> or <img src="images/notveryeffective.png" style="height:1em;" alt="Super Effective" />.
          This is based on the Type of the Attack Move being used vs. the Type of the Pokemon being attacked.
          <br />This page will help you to determine what Attack Moves will be most effective against a Pokemon in battle.
        </p>
        <p class="NOTE">
          See <a href="/tech/formulas/movesetdamage.html">Move Set Damage Formulas</a> In the Technical Reference section for more details of where it used.
        </p>

        <xsl:call-template name="CreateKey" />
        <br />

        <table border="1" style="white-space:nowrap">
          <xsl:call-template name="CreateTableHeaders" />
          <xsl:for-each select="/Root/Constants/Types/Type">
            <xsl:sort order="ascending" data-type="text" select="." />
            <xsl:variable name="type" select="." />

            <xsl:apply-templates select="/Root/MoveEffectiveness/Moves[@type = $type]" />
          </xsl:for-each>
        </table>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!-- Template to create the key for the table -->
  <xsl:template name="CreateKey">
    <h2 id="anchor_key">
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'EFFECTIVENESS_KEY'" />
      </xsl:call-template>
      <xsl:text>Key</xsl:text>
    </h2>
    <div id="EFFECTIVENESS_KEY" class="INDENT">
      <table id="anchor_table" border="1" style="white-space:nowrap">
        <tr>
          <th class="UNUSED" />
          <th>Meaning</th>
          <th>Multiplier</th>
          <th>Notes</th>
        </tr>
        <tr>
          <th class="GOOD">
            <xsl:value-of select="MoveEffectiveness/Key/SuperEffective/@symbol" />
          </th>
          <td>Super Effective</td>
          <td align="right">
            <xsl:value-of select="format-number(MoveEffectiveness/Key/SuperEffective/@multiplier, '0.000')" />
          </td>
          <td>The Move receives a bonus when used against Pokemon of the Type.</td>
        </tr>
        <tr>
          <th>
            <xsl:value-of select="MoveEffectiveness/Key/Neutral/@symbol" />
          </th>
          <td>Neutral</td>
          <td align="right">
            <xsl:value-of select="format-number(MoveEffectiveness/Key/Neutral/@multiplier, '0.000')" />
          </td>
          <td>The Move receives no bonus or penalty when used against Pokemon of the Type.</td>
        </tr>
        <tr>
          <th class="BAD">
            <xsl:value-of select="MoveEffectiveness/Key/NotVeryEffective/@symbol" />
          </th>
          <td>Not Very Effective</td>
          <td align="right">
            <xsl:value-of select="format-number(MoveEffectiveness/Key/NotVeryEffective/@multiplier, '0.000')" />
          </td>
          <td>The Move receives a penalty when used against Pokemon of the Type.</td>
        </tr>
        <tr>
          <th class="HORRENDOUS">
            <xsl:value-of select="MoveEffectiveness/Key/Immune/@symbol" />
          </th>
          <td>Immune</td>
          <td align="right">
            <xsl:value-of select="format-number(MoveEffectiveness/Key/Immune/@multiplier, '0.000')" />
          </td>
          <td>The Move receives an extreme penalty when used against Pokemon of the Type.</td>
        </tr>
      </table>
    </div>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <tr>
      <td class="STRIKETHROUGH_TL_BR" style="padding:0px;">
        <table style="width:100%">
          <tr>
            <th align="right" style="padding-right:0;">
              Pokemon<br />Type
            </th>
          </tr>
          <tr>
            <th align="left" style="padding-left:0;">
              Move<br />Type
            </th>
          </tr>
        </table>
      </td>
      <xsl:for-each select="/Root/Constants/Types/Type">
        <xsl:sort order="ascending" data-type="text" select="." />
        <xsl:call-template name="ColumnHeaderCell">
          <xsl:with-param name="Type" select="." />
        </xsl:call-template>
      </xsl:for-each>
    </tr>
  </xsl:template>

  <xsl:template name="ColumnHeaderCell">
    <xsl:param name="Type" />
    <th style="padding:0;">
      <table>
        <tr>
          <th class="ROTATED_CONTAINER">
            <div class="ROTATED">
              <xsl:value-of select="$Type" />
            </div>
          </th>
        </tr>
        <tr>
          <th style="padding-left:0; padding-right:0;">
            <xsl:call-template name="OutputTypeIcon">
              <xsl:with-param name="Type" select="$Type" />
            </xsl:call-template>
          </th>
        </tr>
      </table>
    </th>
  </xsl:template>

  <!-- Template to create a table row for a Move Type -->
  <xsl:template match="Moves">
    <tr>
      <th align="right" valign="bottom" style="padding-right:0;">
        <xsl:value-of select="concat(@type, $nbsp)" disable-output-escaping="yes" />
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="@type" />
        </xsl:call-template>
      </th>

      <xsl:variable name="Moves" select="." />
      <xsl:for-each select="/Root/Constants/Types/Type">
        <xsl:sort order="ascending" data-type="text" select="." />
        <xsl:variable name="type" select="." />

        <xsl:apply-templates select="$Moves/Pokemon[@type = $type]"  mode="EffectivenessCell" />
      </xsl:for-each>
    </tr>
  </xsl:template>

  <xsl:template match="Pokemon" mode="EffectivenessCell">
    <td align="center">
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="@value = /Root/MoveEffectiveness/Key/SuperEffective/@symbol">GOOD</xsl:when>
          <xsl:when test="@value = /Root/MoveEffectiveness/Key/NotVeryEffective/@symbol">BAD</xsl:when>
          <xsl:when test="@value = /Root/MoveEffectiveness/Key/Immune/@symbol">HORRENDOUS</xsl:when>
        </xsl:choose>
      </xsl:attribute>

      <xsl:value-of select="@value" />
    </td>
  </xsl:template>

</xsl:stylesheet>