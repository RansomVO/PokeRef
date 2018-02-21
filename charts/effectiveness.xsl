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
        <!-- This is to make the font size consistent on mobile. -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

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

        <style>
          td, th {
          padding-left: 1em;
          padding-right: 1em;
          }
        </style>

        <title>Move Effectiveness</title>
      </head>
      <body>

        <h1>Move Effectiveness</h1>
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
          <xsl:apply-templates select="Effectiveness/MoveEffectiveness" />
        </table>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <!-- Template to create the key for the table -->
  <xsl:template name="CreateKey">
    <h2 id="anchor_key">
      <xsl:text>Key</xsl:text>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'EFFECTIVENESS_KEY'" />
      </xsl:call-template>
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
            <xsl:value-of select="Effectiveness/Key/SuperEffective/Symbol" />
          </th>
          <td>Super Effective</td>
          <td align="right">
            <xsl:value-of select="format-number(Effectiveness/Key/SuperEffective/Multiplier, '0.000')" />
          </td>
          <td>The Move receives a bonus when used against Pokemon of the Type.</td>
        </tr>
        <tr>
          <th>
            <xsl:value-of select="Effectiveness/Key/Neutral/Symbol" />
          </th>
          <td>Neutral</td>
          <td align="right">
            <xsl:value-of select="format-number(Effectiveness/Key/Neutral/Multiplier, '0.000')" />
          </td>
          <td>The Move receives no bonus or penalty when used against Pokemon of the Type.</td>
        </tr>
        <tr>
          <th class="BAD">
            <xsl:value-of select="Effectiveness/Key/NotVeryEffective/Symbol" />
          </th>
          <td>Not Very Effective</td>
          <td align="right">
            <xsl:value-of select="format-number(Effectiveness/Key/NotVeryEffective/Multiplier, '0.000')" />
          </td>
          <td>The Move receives a penalty when used against Pokemon of the Type.</td>
        </tr>
        <tr>
          <th class="HORRENDOUS">
            <xsl:value-of select="Effectiveness/Key/Immune/Symbol" />
          </th>
          <td>Immune</td>
          <td align="right">
            <xsl:value-of select="format-number(Effectiveness/Key/Immune/Multiplier, '0.000')" />
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
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Bug</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Bug'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Dark</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Dark'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Dragon</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Dragon'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Electric</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Electric'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Fairy</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Fairy'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Fighting</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Fighting'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Fire</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Fire'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Flying</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Flying'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Ghost</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Ghost'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Grass</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Grass'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Ground</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Ground'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Ice</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Ice'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Normal</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Normal'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Poison</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Poison'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Psychic</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Psychic'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Rock</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Rock'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Steel</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Steel'" />
        </xsl:call-template>
      </th>
      <th class="ROTATED_CONTAINER">
        <div class="ROTATED">Water</div>
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="'Water'" />
        </xsl:call-template>
      </th>
    </tr>
  </xsl:template>

  <!-- Template to create a table row for a Move Type -->
  <xsl:template match="MoveEffectiveness">
    <tr>
      <th align="right" valign="bottom" style="padding-right:0;">
        <xsl:value-of select="concat(MoveType, $nbsp)" disable-output-escaping="yes" />
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="MoveType" />
        </xsl:call-template>
      </th>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Bug" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Dark" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Dragon" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Electric" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Fairy" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Fighting" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Fire" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Flying" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Ghost" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Grass" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Ground" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Ice" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Normal" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Poison" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Psychic" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Rock" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Steel" />
      </xsl:call-template>
      <xsl:call-template name="EffectivenessCell">
        <xsl:with-param name="symbol" select="PokemonType/Water" />
      </xsl:call-template>
    </tr>
  </xsl:template>

  <xsl:template name="EffectivenessCell">
    <xsl:param name="symbol"/>

    <td align="center">
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="$symbol = /Root/Effectiveness/Key/SuperEffective/Symbol">GOOD</xsl:when>
          <xsl:when test="$symbol = /Root/Effectiveness/Key/NotVeryEffective/Symbol">BAD</xsl:when>
          <xsl:when test="$symbol = /Root/Effectiveness/Key/Immune/Symbol">HORRENDOUS</xsl:when>
        </xsl:choose>
      </xsl:attribute>

      <xsl:choose>
        <xsl:when test="$symbol = ''">&#x25CB;</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$symbol"/>
        </xsl:otherwise>
      </xsl:choose>

    </td>
  </xsl:template>

</xsl:stylesheet>