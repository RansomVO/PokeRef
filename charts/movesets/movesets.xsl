<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl"/>
  <!--
    ***** TODO *****
    - Create javascript to create a combobos of Pokemon #/Name then display just the results for that Pokemon.
    - Make it so table scrolls, leaving the headers at the top.
-->

  <!-- Global Variables -->
  <xsl:variable name="MaxDPS" select="format-number(Root/Stats/MoveSets/Overall/DPS/Max, '##.0')" />
  <xsl:variable name="AverageDPS" select="format-number(Root/Stats/MoveSets/Overall/DPS/Average, '##.0')" />
  <xsl:variable name="MaxTrueDPS" select="format-number(Root/Stats/MoveSets/Overall/TrueDPS/Max, '##.0')" />
  <xsl:variable name="AverageTrueDPS" select="format-number(Root/Stats/MoveSets/Overall/TrueDPS/Average, '##.0')" />

  <xsl:variable name="DPSOkay" select="number($AverageDPS)" />

  <!-- Main Template -->
  <xsl:template match="/Root">
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
          Pokemon Move Sets - Gen <xsl:value-of select="MoveSets/Generation"/>
        </title>
      </head>
      <body>
        <h1>
          Pokemon Move Sets - Gen <xsl:value-of select="MoveSets/Generation"/>
        </h1>

        <p class="NOTE">
          <b>NOTE</b>: Last Updated <xsl:value-of select="$GameMaster_TimeStamp" />
        </p>
        <p>
          This chart lists the Move Sets for Pokemon.
          <br />Just look up the Pokemon you are interested in, find the entry for the Move Set for your Pokemon, and compare it to the other possible Move Sets.
        </p>
        <p class="PARENT">
          Here are the things you will find:
        </p>
        <ul class="CHILD">
          <li>
            <b>Move Set</b>: This is a possible combination of a Fast Attack and a Charged Attack.
          </li>
          <li>
            <b>Legacy</b>: This means the Move Set was available in the past so your Pokemon may have it, but new Pokemon won't have it.
          </li>
          <li>
            <b>STAB</b>: <span class="NOTE">
              (<b>
                <u>S</u>
              </b>ame <b>
                <u>T</u>
              </b>ype <b>
                <u>A</u>
              </b>ttack <b>
                <u>B</u>
              </b>onus)
            </span> Tells whether the Pokemon get a 25% bonus because the Move's Type is the same as the Pokemon's type.
          </li>
          <li>
            <b>MoveSet DPS</b>: <span class="NOTE">
              (<b>
                <u>D</u>
              </b>amage <b>
                <u>P</u>
              </b>er <b>
                <u>S</u>
              </b>econd)
            </span> Tells the raw DPS for Move Set itself, without taking into account the Pokemon's Stats.
          </li>
          <li>
            <b>True DPS</b>: Tells the DPS for Move Set, for the specified Pokemon.
          </li>
          <li>
            <b>%</b>: A comparison of the Move Set's True DPS, to the True DPS of the Pokemon's best <i>current</i> Move Set.
          </li>
        </ul>
        <p>
          For a technical description of the formulas used, check out the <a href="/tech/movesetformulas.html">Move Set Formulas</a>.
        </p>
        <br />
        <table border="1">
          <xsl:call-template name="CreateTableHeaders" />
          <xsl:apply-templates select="MoveSets" />
        </table>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <tr style="font-size:xx-large;">
      <th colspan="3" valign="bottom">Pokemon</th>
      <th colspan="2" valign="bottom">Move Set</th>
      <th class="ROTATED_CONTAINER" rowspan="2">
        <div class="ROTATED" style="font-size:x-large;">Legacy</div>
      </th>
      <th colspan="2" valign="bottom">STAB</th>
      <th colspan="3" valign="bottom">Damage</th>
    </tr>
    <tr style="font-size:large;">
      <th colspan="2" valign="bottom">ID</th>
      <th valign="bottom" align="left">Name</th>
      <th valign="bottom">Fast</th>
      <th valign="bottom">Charged</th>
      <th valign="bottom">Fast</th>
      <th valign="bottom">Charged</th>
      <th valign="bottom">
        MoveSet<br />DPS
      </th>
      <th valign="bottom">
        True<br />DPS
      </th>
      <th valign="bottom" style="font-size:x-large;">%</th>
    </tr>

    <!-- Write the Key for the table. -->
    <tr>
      <td colspan="11" height="2px" style="background-color:black" />
    </tr>
    <tr comment="GREAT">
      <th colspan="3" rowspan="4" style="font-size:x-large; text-align:right;">Key:</th>
      <td class="GREAT" colspan="5">
        True DPS is &gt;= <xsl:value-of select="100*$DPSGreat" />% of Max Possible.
      </td>
      <td colspan="2" class="GREAT" align="center">
        &gt;= <xsl:value-of select="100*$DPSGreat" />% of Max Possible
      </td>
      <td class="GREAT" align="right">
        &gt;= <xsl:value-of select="100*$DPSPercentGreat" />
      </td>
    </tr>
    <tr comment="GOOD">
      <td class="GOOD" colspan="5">
        True DPS is &gt;= <xsl:value-of select="100*$DPSGood" />% of Max Possible.
      </td>
      <td colspan="2" class="GOOD" align="center">
        &gt;= <xsl:value-of select="100*$DPSGood" />% of Max Possible
      </td>
      <td class="GOOD" align="right">
        &gt;= <xsl:value-of select="100*$DPSPercentGood" />
      </td>
    </tr>
    <tr comment="POOR">
      <td class="POOR" colspan="5">
        True DPS is Above Average.
      </td>
      <td colspan="2" class="POOR" align="center">
        Above Average
      </td>
      <td class="POOR" align="right">
        &gt;= <xsl:value-of select="100*$DPSPercentOkay" />
      </td>
    </tr>
    <tr comment="BAD">
      <td class="BAD" colspan="5">
        True DPS is Below Average.
      </td>
      <td colspan="2" class="BAD" align="center">
        Below Average
      </td>
      <td class="BAD" align="right">
        &lt; <xsl:value-of select="100*$DPSPercentOkay" />
      </td>
    </tr>
    <tr>
      <td colspan="11" height="1px" style="background-color:grey" />
    </tr>
  </xsl:template>

  <!-- Template to create merged cells for each Pokemon #/Name, then call template to create the MoveSet rows for that Pokemon -->
  <xsl:template match="MoveSets">
    <xsl:for-each select="MoveSet[not(Pokemon/ID=preceding-sibling::MoveSet/Pokemon/ID)]">
      <xsl:sort select="Pokemon/Name"/>
      <xsl:variable name="PokemonID" select="Pokemon/ID" />
      <xsl:variable name="PokemonMoveSetCount" select="count(../MoveSet[Pokemon/ID=$PokemonID])" />
      <tr align="left" style="border-top-width:5px">
        <xsl:if test="contains(/Root/PokemonStats/Pokemon[ID=$PokemonID]/Availability,'Unavailable')">
          <xsl:attribute name="class">UNAVAILABLE_ROW</xsl:attribute>
        </xsl:if>
        <td id="Image" class="CELL_FILLED">
          <xsl:attribute name="rowspan">
            <xsl:value-of select="$PokemonMoveSetCount + 1" />
          </xsl:attribute>
          <xsl:apply-templates select="/Root/PokemonStats/Pokemon[ID = $PokemonID]">
            <xsl:with-param name="Settings">
              <Show hide_name="true" />
            </xsl:with-param>
          </xsl:apply-templates>

        </td>
        <th id="ID" style="font-size:large;" align="right">
          <xsl:attribute name="rowspan">
            <xsl:value-of select="$PokemonMoveSetCount + 1" />
          </xsl:attribute>
          <xsl:value-of select="$PokemonID" />
        </th>
        <th id="Name" style="font-size:large;">
          <xsl:attribute name="rowspan">
            <xsl:value-of select="$PokemonMoveSetCount + 1" />
          </xsl:attribute>
          <xsl:value-of select="Pokemon/Name" />
        </th>
        <!-- Add a blank line as a separater. (It also make adding the movesets easier.) -->
        <td colspan="8" style="height:0px; margin:0px; padding:0px; border:none;" />
      </tr>
      <xsl:for-each select="../MoveSet[Pokemon/ID=$PokemonID]">
        <xsl:sort select="Damage/PercentOfMax" data-type="number" order="descending"/>
        <tr>
          <xsl:if test="contains(/Root/PokemonStats/Pokemon[ID=$PokemonID]/Availability,'Unavailable')">
            <xsl:attribute name="class">UNAVAILABLE_ROW</xsl:attribute>
          </xsl:if>
          <xsl:apply-templates select="." />
        </tr>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <!-- Template to create rows for a Pokemon's MoveSets -->
  <xsl:template match="MoveSet">
    <xsl:variable name="legacy" select="Legacy != ''" />
    <xsl:variable name="valueDamageDPS" select="format-number(Damage/DPS, '#0.00')" />
    <xsl:variable name="valueDamageTrueDPS" select="format-number(Damage/TrueDPS, '#0.00')" />
    <xsl:variable name="valueDamagePercentOfMax" select="format-number((Damage/PercentOfMax) * 100, '##0')" />

    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="Attack/Fast" />
      <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
      <xsl:with-param name="Legacy" select="$legacy" />
    </xsl:call-template>
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="Attack/Charged" />
      <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
      <xsl:with-param name="Legacy" select="$legacy" />
    </xsl:call-template>
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="Legacy" />
      <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
      <xsl:with-param name="Legacy" select="$legacy" />
      <xsl:with-param name="Align" select="center" />
    </xsl:call-template>
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content">
        <xsl:value-of select="pokeref:ToUpper(STAB/Fast)" />
      </xsl:with-param>
      <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
      <xsl:with-param name="Legacy" select="$legacy" />
    </xsl:call-template>
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content">
        <xsl:value-of select="pokeref:ToUpper(STAB/Charged)" />
      </xsl:with-param>
      <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
      <xsl:with-param name="Legacy" select="$legacy" />
    </xsl:call-template>
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="$valueDamageDPS" />
      <xsl:with-param name="DPS" select="$valueDamageDPS" />
      <xsl:with-param name="Legacy" select="$legacy" />
    </xsl:call-template>
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="$valueDamageTrueDPS" />
      <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
      <xsl:with-param name="Legacy" select="$legacy" />
    </xsl:call-template>
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="$valueDamagePercentOfMax" />
      <xsl:with-param name="Percent" select="$valueDamagePercentOfMax" />
      <xsl:with-param name="Legacy" select="$legacy" />
    </xsl:call-template>
  </xsl:template>

  <!-- Template to create a formatted cell in the Pokemon's Move Set -->
  <xsl:template name="MoveSetCell">
    <xsl:param name="Content" />
    <xsl:param name="DPS" />
    <xsl:param name="TrueDPS" />
    <xsl:param name="Percent" />
    <xsl:param name="Legacy" />
    <xsl:param name="Align" />

    <td>
      <xsl:choose>
        <xsl:when test="$Align != ''">
          <xsl:attribute name="align">
            <xsl:value-of select="$Align"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:when test="number($Content) = $Content">
          <xsl:attribute name="align">right</xsl:attribute>
        </xsl:when>
        <xsl:when test="$Content = 'X' or $Content = 'TRUE' or $Content = 'FALSE'">
          <xsl:attribute name="align">center</xsl:attribute>
        </xsl:when>
      </xsl:choose>

      <xsl:if test="$DPS != '' or $TrueDPS != '' or $Percent != '' or $Legacy != ''">
        <xsl:attribute name="class">
          <xsl:if test="$Legacy != ''">
            <xsl:text>UNAVAILABLE </xsl:text>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="$DPS != ''">
              <xsl:choose>
                <xsl:when test="$DPS &gt;= $MaxDPS * $DPSGreat">
                  <xsl:text>GREAT </xsl:text>
                </xsl:when>
                <xsl:when test="$DPS &gt;= $MaxDPS * $DPSGood">
                  <xsl:text>GOOD </xsl:text>
                </xsl:when>
                <xsl:when test="$DPS &gt;= $DPSOkay">
                  <xsl:text>POOR </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>BAD </xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="$TrueDPS != ''">
              <xsl:choose>
                <xsl:when test="$TrueDPS &gt;= $MaxTrueDPS * $DPSGreat">
                  <xsl:text>GREAT </xsl:text>
                </xsl:when>
                <xsl:when test="$TrueDPS &gt;= $MaxTrueDPS * $DPSGood">
                  <xsl:text>GOOD </xsl:text>
                </xsl:when>
                <xsl:when test="$TrueDPS &gt;= $AverageTrueDPS">
                  <xsl:text>POOR </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>BAD </xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="$Percent != ''">
              <xsl:choose>
                <xsl:when test="$Percent &gt;= 100*$DPSPercentGreat">
                  <xsl:text>GREAT </xsl:text>
                </xsl:when>
                <xsl:when test="$Percent &gt;= 100*$DPSPercentGood">
                  <xsl:text>GOOD </xsl:text>
                </xsl:when>
                <xsl:when test="$Percent &gt;= 100*$DPSPercentOkay">
                  <xsl:text>POOR </xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>BAD </xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>

      <xsl:value-of select="$Content" />
      <xsl:if test="$Percent != ''">
        <xsl:text>%</xsl:text>
      </xsl:if>
    </td>
  </xsl:template>

</xsl:stylesheet>