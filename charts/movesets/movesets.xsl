<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl"/>
  <!--
    ***** TODO *****
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
            <xsl:text>movesets.js?cacherefresh=</xsl:text>
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
        <hr />
        <h2>Selection Criteria</h2>
        <table class="INDENT">
          <tr>
            <td valign="top">
              <table>
                <tr style="display:none;" comment="TODO QZX: Remove display:none when sorting is supported.">
                  <td colspan="2">
                    <xsl:text>Sort By:</xsl:text>
                    <select class="PARENT" id="SortType_Combobox" onchange="OnFilterCriteriaChanged(this);">
                      <option value="1">Name</option>
                      <option value="2">Id</option>
                      <option value="3">TrueDPS</option>
                    </select>
                    <br />
                  </td>
                </tr>
                <tr>
                  <td>Filter by Pokemon Name or ID:</td>
                  <td style="padding:0">
                    <input id="Filter_Text_PokeStat" type="text" onkeyup="OnFilterCriteriaChanged(this)">
                      <xsl:attribute name="id">
                        <xsl:text>Filter_Text_PokeStat_Gen</xsl:text>
                        <xsl:value-of select="MoveSets/Generation"/>
                      </xsl:attribute>
                    </input>
                  </td>
                </tr>
                <tr>
                  <td>Move Name or Type:</td>
                  <td style="padding:0">
                    <input id="Filter_Text_Move" type="text" onkeyup="OnFilterCriteriaChanged(this)" />
                  </td>
                </tr>
              </table>
            </td>
            <td valign="top">
              <input id="ShowOnlyReleased_Checkbox" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />
              <xsl:text>Show Only Released</xsl:text>
            </td>
          </tr>
          <br />
        </table>

        <br />
        <hr />
        <div id="Loading">
          <h1>Loading...</h1>
        </div>
        <!-- Leave this hidden until we have loaded everything and applied it. -->
        <div id="Loaded" class="DIV_HIDDEN">
          <table border="1" id="MoveSets">
            <xsl:call-template name="CreateTableHeaders" />
          </table>

          <table id="MoveSetsSource" style="display:none;">
            <xsl:apply-templates select="MoveSets" />
          </table>
        </div>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <tr class="Header" style="font-size:xx-large;">
      <th colspan="3" valign="bottom">Pokemon</th>
      <th colspan="2" valign="bottom">Move Set</th>
      <th class="ROTATED_CONTAINER" rowspan="2">
        <div class="ROTATED" style="font-size:x-large;">Legacy</div>
      </th>
      <th colspan="2" valign="bottom">STAB</th>
      <th colspan="3" valign="bottom">Damage</th>
    </tr>
    <tr class="Header" style="font-size:large;">
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
    <tr class="Header">
      <td colspan="11" height="2px" style="background-color:black" />
    </tr>
    <tr class="Header" comment="GREAT">
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
    <tr class="Header" comment="GOOD">
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
    <tr class="Header" comment="POOR">
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
    <tr class="Header" comment="BAD">
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
    <tr class="Header">
      <td colspan="11" height="1px" style="background-color:grey" />
    </tr>
  </xsl:template>

  <!-- Template to create merged cells for each Pokemon #/Name, then call template to create the MoveSet rows for that Pokemon -->
  <xsl:template match="MoveSets">
    <xsl:for-each select="MoveSet[not(Pokemon/ID=preceding-sibling::MoveSet/Pokemon/ID)]">
      <xsl:variable name="PokemonID" select="Pokemon/ID" />
      <xsl:variable name="PokemonStats" select="/Root/PokemonStats/Pokemon[ID=$PokemonID]" />
      <xsl:variable name="PokemonMoveSetCount" select="count(../MoveSet[Pokemon/ID=$PokemonID])" />

      <tr align="left" style="border-top-width:5px">
        <xsl:if test="contains($PokemonStats/Availability,'Unavailable')">
          <xsl:attribute name="class">UNAVAILABLE_ROW</xsl:attribute>
        </xsl:if>
        <xsl:attribute name="id">
          <xsl:value-of select="$PokemonStats/ID" />
        </xsl:attribute>
        <xsl:attribute name="name">
          <xsl:value-of select="$PokemonStats/Name" />
        </xsl:attribute>
        <xsl:attribute name="quickMoves">
          <xsl:call-template name="MovesAttribute">
            <xsl:with-param name="Moves" select="../MoveSet[Pokemon/ID=$PokemonID]/Attack/Fast" />
          </xsl:call-template>
        </xsl:attribute>
        <xsl:attribute name="chargedMoves">
          <xsl:call-template name="MovesAttribute">
            <xsl:with-param name="Moves" select="../MoveSet[Pokemon/ID=$PokemonID]/Attack/Charged" />
          </xsl:call-template>
        </xsl:attribute>

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

    <xsl:variable name="FastMoveName" select="Attack/Fast" />
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="$FastMoveName" />
      <xsl:with-param name="TypeIcon" select="/Root/Moves/Move[Name=$FastMoveName]/Type" />
      <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
      <xsl:with-param name="Legacy" select="$legacy" />
    </xsl:call-template>
    <xsl:variable name="ChargedMoveName" select="Attack/Charged" />
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="$ChargedMoveName" />
      <xsl:with-param name="TypeIcon" select="/Root/Moves/Move[Name=$ChargedMoveName]/Type" />
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
    <xsl:param name="TypeIcon" />

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

      <xsl:if test="$TypeIcon">
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="$TypeIcon" />
        </xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:if>
      
      <xsl:value-of select="$Content" />
      <xsl:if test="$Percent != ''">
        <xsl:text>%</xsl:text>
      </xsl:if>
    </td>
  </xsl:template>

  <!-- Concats a group of Moves into 1 string containing Move name and type. -->
  <xsl:template name="MovesAttribute">
    <xsl:param name="Moves" />

    <xsl:for-each select="$Moves">
      <xsl:variable name="Name" select="./text()" />
      <xsl:value-of select="concat(' ',$Name)" />
      <xsl:value-of select="concat(' ',/Root/Moves/Move[Name=$Name]/Type)"/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>