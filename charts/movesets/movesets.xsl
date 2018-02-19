<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <!-- #region Global Variables -->
  <xsl:variable name="MaxDPS" select="format-number(Root/Stats/MoveSets/Overall/DPS/Max, '##.0')" />
  <xsl:variable name="AverageDPS" select="format-number(Root/Stats/MoveSets/Overall/DPS/Average, '##.0')" />
  <xsl:variable name="MaxTrueDPS" select="format-number(Root/Stats/MoveSets/Overall/TrueDPS/Max, '##.0')" />
  <xsl:variable name="AverageTrueDPS" select="format-number(Root/Stats/MoveSets/Overall/TrueDPS/Average, '##.0')" />

  <xsl:variable name="DPSOkay" select="number($AverageDPS)" />
  <!-- #endregion-->

  <!-- Main Template -->
  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- This is to make the font size consistent on mobile. -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>movesets.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/controls.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/pokemon.js?cacherefresh=</xsl:text>
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
          Pokemon Move Sets
          <xsl:choose>
            <xsl:when test="count(MoveSets/Generation) > 1">
              <xsl:text> - All Gens</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> - Gen </xsl:text>
              <xsl:value-of select="MoveSets/Generation"/>
            </xsl:otherwise>
          </xsl:choose>
        </title>
      </head>
      <body>
        <h1>
          Pokemon Move Sets
          <xsl:choose>
            <xsl:when test="count(MoveSets/Generation) > 1">
              <xsl:text> - All Gens </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> - Gen </xsl:text>
              <xsl:value-of select="MoveSets/Generation"/>
            </xsl:otherwise>
          </xsl:choose>
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
            <b>Move Set DPS</b>: <span class="NOTE">
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
            <b>%</b>: A comparison of the Move Set's True DPS, to the True DPS of the Pokemon's best possible Move Set <i>that doesn't include a Legacy Move</i>.
          </li>
        </ul>
        <p>
          For a technical description of the formulas used, check out the <a href="/tech/movesetformulas.html">Move Set Formulas</a>.
        </p>

        <br />
        <hr />
        <xsl:call-template name="LoadingNotice">
          <xsl:with-param name="LoadedContent" select="'MOVESET_Content'" />
        </xsl:call-template>

        <!-- Leave this hidden until everything is loaded and .js has applied it. -->
        <div id="MOVESET_Content" class="DIV_HIDDEN">
          <xsl:call-template name="CreateCriteria" />

          <br />
          <hr />
          <xsl:call-template name="CreateKey" />

          <br />
          <hr />
          <div id="anchor_movesets">
            <xsl:apply-templates select="MoveSets" />
          </div>
        </div>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <!-- Template to write the Selection Criteria. -->
  <xsl:template name="CreateCriteria">
    <h2 id="anchor_criteria">
      <xsl:text>Selection Criteria</xsl:text>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'MOVESET_CRITERIA'" />
      </xsl:call-template>
    </h2>
    <br />
    <div id="MOVESET_CRITERIA">
      <table border="1" class="KEY_TABLE">
        <tr>
          <th>Filter By...</th>
        </tr>
        <tr>
          <td valign="top">
            <table style="white-space:nowrap;">
              <tr>
                <td>Pokemon Name or ID:</td>
                <td style="padding:0">
                  <xsl:call-template name="OutputFilterPokemonNameID">
                    <xsl:with-param name="Callback" select="'OnPokemonNameIDChanged'" />
                  </xsl:call-template>
                </td>
              </tr>
              <tr>
                <td>Move Name:</td>
                <td style="padding:0">
                  <input id="Filter_Text_Move" type="text" onkeyup="OnFilterCriteriaChanged(this)" />
                </td>
              </tr>
              <tr style="height:1em;" />
              <tr>
                <td colspan="2">
                  <input id="ShowOnlyReleased_Checkbox" type="checkbox" onchange="OnFilterCriteriaChanged(this);" />
                  <xsl:text>Show Only Released</xsl:text>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <div class="KEY_TABLE">
        <xsl:call-template name="OutputTypeSelection">
          <xsl:with-param name="Callback" select="'OnTypesChanged'" />
          <xsl:with-param name="Title" select="'Move Types'" />
          <xsl:with-param name="SliderLabel" select="concat($lt,'b', $gt, 'Moves:', $lt, '/b', $gt)" />
        </xsl:call-template>
      </div>
      <div class="KEY_TABLE">
        <xsl:call-template name="OutputWeatherSelection">
          <xsl:with-param name="Callback" select="'OnWeatherChanged'" />
          <xsl:with-param name="Title" select="concat('Move', $lt, 'br /', $gt, 'Weather Boosts')" />
          <xsl:with-param name="SliderLabel" select="concat($lt,'b', $gt, 'Moves:', $lt, '/b', $gt)" />
        </xsl:call-template>
      </div>
    </div>
  </xsl:template>

  <!-- Template to write the Key for the table. -->
  <xsl:template name="CreateKey">
    <h2>
      <xsl:text>Key</xsl:text>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'MOVESET_KEY'" />
      </xsl:call-template>
    </h2>
    <br />
    <div id="MOVESET_KEY">
      <table border="1" class="KEY_TABLE" style="white-space:nowrap;">
        <tr comment="General">
          <th rowspan="3">
            General
          </th>
          <td class="LEGACY_MOVESET">
            <span class="LEGACY_MOVESET LEGACY_MOVE">Legacy Move</span>
            <br />
            <spanMove class="NOTE">(Move no longer obtainable for that Pokemon)</spanMove>
          </td>
        </tr>
        <tr>
          <td class="LEGACY_MOVESET">
            Move Set with a "Legacy Move"
            <br /><spanMove class="NOTE">(Grey Text)</spanMove>
          </td>
        </tr>
        <tr>
          <td class="STAB_MOVE">Move with STAB bonus</td>
        </tr>

        <tr comment="MoveSet and True DPS">
          <th rowspan="4">
            Move Set<br />&amp;<br />True DPS
          </th>
          <td class="GREAT">
            True DPS &gt;= <xsl:value-of select="100*$DPSGreat" />% of Max Possible
          </td>
        </tr>
        <tr>
          <td class="GOOD">
            True DPS &gt;= <xsl:value-of select="100*$DPSGood" />% of Max Possible
          </td>
        </tr>
        <tr>
          <td class="POOR">True DPS Above Average</td>
        </tr>
        <tr>
          <td class="BAD">True DPS Below Average</td>
        </tr>

        <tr comment="Move Set DPS">
          <th rowspan="4">Damage: Move Set DPS</th>
          <td class="GREAT">
            &gt;= <xsl:value-of select="100*$DPSGreat" />% of Max Possible
          </td>
        </tr>
        <tr>
          <td class="GOOD">
            &gt;= <xsl:value-of select="100*$DPSGood" />% of Max Possible
          </td>
        </tr>
        <tr>
          <td class="POOR">Above Average</td>
        </tr>
        <tr>
          <td class="BAD">Below Average</td>
        </tr>

        <tr comment="Damage %">
          <th rowspan="4">Damage: %</th>
          <td class="GREAT">
            &gt;= <xsl:value-of select="100*$DPSPercentGreat" />% of best current Move Set
          </td>
        </tr>
        <tr>
          <td class="GOOD">
            &gt;= <xsl:value-of select="100*$DPSPercentGood" />% of best current Move Set
          </td>
        </tr>
        <tr>
          <td class="POOR">
            &gt;= <xsl:value-of select="100*$DPSPercentOkay" />% of best current Move Set
          </td>
        </tr>
        <tr>
          <td class="BAD">
            &lt; <xsl:value-of select="100*$DPSPercentOkay" />% of best current Move Set
          </td>
        </tr>
      </table>
    </div>
  </xsl:template>

  <!-- Template to create merged cells for each Pokemon #/Name, then call template to create the Move Set rows for that Pokemon -->
  <xsl:template match="MoveSets">
    <h2>
      <xsl:text>Generation </xsl:text>
      <xsl:value-of select="Generation" />
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('MOVESET_DIV_GEN_', Generation)" />
      </xsl:call-template>
    </h2>
    <div>
      <xsl:attribute name="id">
        <xsl:value-of select="concat('MOVESET_DIV_GEN_', Generation)" />
      </xsl:attribute>
      <table border="1">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('MOVESET_GEN_', Generation)" />
        </xsl:attribute>

        <xsl:call-template name="CreateTableHeaders" />

        <xsl:for-each select="MoveSet[not(Pokemon/ID=preceding-sibling::MoveSet/Pokemon/ID)]">
          <xsl:variable name="PokemonID" select="Pokemon/ID" />
          <xsl:variable name="PokemonStats" select="/Root/PokemonStats/Pokemon[ID=$PokemonID]" />
          <xsl:variable name="PokemonMoveSetCount" select="count(../MoveSet[Pokemon/ID=$PokemonID])" />

          <tr align="left" style="border-top-width:5px">
            <xsl:attribute name="class">
              <xsl:text>PRIMARY_ROW</xsl:text>
              <xsl:if test="contains($PokemonStats/Availability,'Unavailable')"> UNAVAILABLE_ROW </xsl:if>
            </xsl:attribute>
            <xsl:attribute name="movesetCount">
              <xsl:value-of select="$PokemonMoveSetCount" />
            </xsl:attribute>

            <td class="CELL_FILLED">
              <xsl:attribute name="rowspan">
                <xsl:value-of select="$PokemonMoveSetCount + 1" />
              </xsl:attribute>
              <xsl:apply-templates select="/Root/PokemonStats/Pokemon[ID = $PokemonID]">
                <xsl:with-param name="Settings">
                  <Show hide_name="true" />
                </xsl:with-param>
              </xsl:apply-templates>
            </td>
            <th style="font-size:large;" align="right">
              <xsl:attribute name="rowspan">
                <xsl:value-of select="$PokemonMoveSetCount + 1" />
              </xsl:attribute>
              <xsl:value-of select="$PokemonID" />
            </th>
            <th style="font-size:large;">
              <xsl:attribute name="rowspan">
                <xsl:value-of select="$PokemonMoveSetCount + 1" />
              </xsl:attribute>
              <xsl:value-of select="Pokemon/Name" />
            </th>
            <!-- Add a blank line as a separater. (It also makes adding the MoveSets easier.) -->
            <td colspan="8" class="HIDDEN_CONVENIENCE_ROW" />
          </tr>
          <xsl:for-each select="../MoveSet[Pokemon/ID=$PokemonID]">
            <xsl:sort select="Damage/PercentOfMax" data-type="number" order="descending"/>
            <tr>
              <xsl:if test="contains(/Root/PokemonStats/Pokemon[ID=$PokemonID]/Availability,'Unavailable')">
                <xsl:attribute name="class">UNAVAILABLE_ROW</xsl:attribute>
              </xsl:if>
              <xsl:variable name="FastMoveName" select="FastAttack/Move" />
              <xsl:variable name="FastMoveType" select="/Root/Moves/Move[Name=$FastMoveName]/Type" />
              <xsl:attribute name="fastMoveName">
                <xsl:value-of select="$FastMoveName"/>
              </xsl:attribute>
              <xsl:attribute name="fastMoveType">
                <xsl:value-of select="$FastMoveType"/>
              </xsl:attribute>
              <xsl:attribute name="fastMoveBoost">
                <xsl:value-of select="/Root/Mappings/WeatherBoosts[Type=$FastMoveType]/Weather"/>
              </xsl:attribute>
              <xsl:variable name="ChargedMoveName" select="ChargedAttack/Move" />
              <xsl:variable name="ChargedMoveType" select="/Root/Moves/Move[Name=$ChargedMoveName]/Type" />
              <xsl:attribute name="chargedMoveName">
                <xsl:value-of select="$ChargedMoveName"/>
              </xsl:attribute>
              <xsl:attribute name="chargedMoveType">
                <xsl:value-of select="$ChargedMoveType"/>
              </xsl:attribute>
              <xsl:attribute name="chargedMoveBoost">
                <xsl:value-of select="/Root/Mappings/WeatherBoosts[Type=$ChargedMoveType]/Weather"/>
              </xsl:attribute>
              <xsl:apply-templates select="." />
            </tr>
          </xsl:for-each>
        </xsl:for-each>
      </table>
    </div>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <tr class="HEADER_ROW" style="font-size:xx-large;">
      <th colspan="3" valign="bottom">Pokemon</th>
      <th colspan="2" valign="bottom">Move Set</th>
      <th colspan="3" valign="bottom">Damage</th>
    </tr>
    <tr class="HEADER_ROW" style="font-size:large;">
      <th colspan="2" valign="bottom">ID</th>
      <th valign="bottom" align="left">Name</th>
      <th valign="bottom">Fast</th>
      <th valign="bottom">Charged</th>
      <th valign="bottom">
        Move Set<br />DPS
      </th>
      <th valign="bottom">
        True<br />DPS
      </th>
      <th valign="bottom" style="font-size:x-large;">%</th>
    </tr>
  </xsl:template>
 
  <!-- Template to create rows for a Pokemon's Move Sets -->
  <xsl:template match="MoveSet">
    <xsl:variable name="legacyFast" select="FastAttack/Legacy != ''" />
    <xsl:variable name="legacyCharged" select="ChargedAttack/Legacy != ''" />
    <xsl:variable name="legacy" select="$legacyFast or $legacyCharged" />
    <xsl:variable name="fastSTAB" select="pokeref:ToUpper(STAB/Fast) = 'TRUE'" />
    <xsl:variable name="chargedSTAB" select="pokeref:ToUpper(STAB/Charged) = 'TRUE'" />
    <xsl:variable name="valueDamageDPS" select="format-number(Damage/DPS, '#0.00')" />
    <xsl:variable name="valueDamageTrueDPS" select="format-number(Damage/TrueDPS, '#0.00')" />
    <xsl:variable name="valueDamagePercentOfMax" select="format-number((Damage/PercentOfMax) * 100, '##0')" />

    <xsl:variable name="FastMoveName" select="FastAttack/Move" />
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="$FastMoveName" />
      <xsl:with-param name="TypeIcon" select="/Root/Moves/Move[Name=$FastMoveName]/Type" />
      <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
      <xsl:with-param name="LegacyMove" select="$legacyFast" />
      <xsl:with-param name="Legacy" select="$legacy" />
      <xsl:with-param name="STAB" select="$fastSTAB" />
    </xsl:call-template>
    <xsl:variable name="ChargedMoveName" select="ChargedAttack/Move" />
    <xsl:call-template name="MoveSetCell">
      <xsl:with-param name="Content" select="$ChargedMoveName" />
      <xsl:with-param name="TypeIcon" select="/Root/Moves/Move[Name=$ChargedMoveName]/Type" />
      <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
      <xsl:with-param name="LegacyMove" select="$legacyCharged" />
      <xsl:with-param name="Legacy" select="$legacy" />
      <xsl:with-param name="STAB" select="$chargedSTAB" />
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
    <xsl:param name="LegacyMove" />
    <xsl:param name="STAB" />
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
      </xsl:choose>

      <xsl:if test="$DPS != '' or $TrueDPS != '' or $Percent != '' or $Legacy != ''">
        <xsl:attribute name="class">
          <xsl:if test="$Legacy != ''">
            <xsl:text>LEGACY_MOVESET </xsl:text>
          </xsl:if>
          <xsl:if test="$LegacyMove != ''">
            <xsl:text>LEGACY_MOVE </xsl:text>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="$STAB and $Legacy != ''">
              <xsl:text>LEGACY_STAB_MOVE </xsl:text>
            </xsl:when>
            <xsl:when test="$STAB">
              <xsl:text>STAB_MOVE </xsl:text>
            </xsl:when>
          </xsl:choose>
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
        <xsl:call-template name="OutputTypeIconWithBoost">
          <xsl:with-param name="Type" select="$TypeIcon" />
          <xsl:with-param name ="Settings">
            <Show size="large" />
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:value-of select="$Content" />
      <xsl:if test="$Percent != ''">
        <xsl:text>%</xsl:text>
      </xsl:if>
    </td>
  </xsl:template>

</xsl:stylesheet>