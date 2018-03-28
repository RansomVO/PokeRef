<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <!-- #region Global Variables -->
  <xsl:variable name="MaxBaseDPS" select="format-number(Root/Stats/MoveSets/Overall/BaseDPS/Max, '#0.00')" />
  <xsl:variable name="AverageBaseDPS" select="format-number(Root/Stats/MoveSets/Overall/BaseDPS/Average, '#0.00')" />
  <xsl:variable name="MaxTrueDPS" select="format-number(Root/Stats/MoveSets/Overall/TrueDPS/Max, '#0.00')" />
  <xsl:variable name="AverageTrueDPS" select="format-number(Root/Stats/MoveSets/Overall/TrueDPS/Average, '#0.00')" />

  <xsl:variable name="DPSOkay" select="number($AverageBaseDPS)" />
  <!-- #endregion-->

  <!-- Main Template -->
  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>movesets.js?cacherefresh=</xsl:text>
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
          <xsl:call-template name="HomePageLink" />
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
        <p>
          For a technical description of the formulas used, check out the <a href="/tech/formulas/movesetdamage.html">Move Set Damage Formulas</a>.
        </p>

        <br />
        <hr />
        <xsl:call-template name="LoadingNotice">
          <xsl:with-param name="LoadedContent" select="'MOVESET_Content'" />
        </xsl:call-template>

        <xsl:value-of select="concat($lt, '!-- Leave this hidden until everything is loaded and .js has applied it. --', $gt)" disable-output-escaping="yes" />
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

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
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
      <xsl:call-template name="OutputResetButton">
        <xsl:with-param name="Callback" select="'OnResetCriteriaClicked();'" />
      </xsl:call-template>
    </h2>

    <div id="MOVESET_CRITERIA" style="margin-top:.5em;">
      <div class="FLOWING_TABLE_WRAPPER">
        <table border="1" class="CRITERIA_TABLE">
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
                      <xsl:with-param name="CallbackName" select="'OnPokemonNameIDChanged'" />
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
      </div>

      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <xsl:call-template name="OutputTypeSelection">
        <xsl:with-param name="CallbackName" select="'OnTypesChanged'" />
        <xsl:with-param name="Title" select="'Move Types'" />
        <xsl:with-param name="SliderLabel">
          <b>Moves:</b>
        </xsl:with-param>
        <xsl:with-param name="SliderHelp">
          <table style="width:25em">
            <tr>
              <th width="1px">Any</th>
              <td>Move Sets where any Move is one of the selected Move Types.</td>
            </tr>
            <tr>
              <th>All</th>
              <td>Move Sets where all Moves are one of the selected Move Types.</td>
            </tr>
          </table>
        </xsl:with-param>
      </xsl:call-template>

      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <xsl:call-template name="OutputWeatherSelection">
        <xsl:with-param name="CallbackName" select="'OnWeatherChanged'" />
        <xsl:with-param name="Title" select="concat('Move', $lt, 'br /', $gt, 'Weather Boosts')" />
        <xsl:with-param name="SliderLabel">
          <b>Moves:</b>
        </xsl:with-param>
        <xsl:with-param name="SliderHelp">
          <table style="width:25em">
            <tr>
              <th width="1px">Any</th>
              <td>Move Sets where any Move is boosted by the selected Move Weather Boosts.</td>
            </tr>
            <tr>
              <th>All</th>
              <td>Move Sets where all Moves are boosted by the selected Move Weather Boosts.</td>
            </tr>
          </table>
        </xsl:with-param>
      </xsl:call-template>
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

    <div id="MOVESET_KEY" style="margin-top:.5em;">
      <div class="FLOWING_TABLE_WRAPPER">
        <table class="KEY_TABLE" border="1">
          <tr>
            <th colspan="2">
              <span style="font-size:larger;">Terms</span>
            </th>
          </tr>
          <tr>
            <th>Term</th>
            <th>Description</th>
          </tr>
          <tr>
            <th align="left">Move Set</th>
            <td>This is a possible combination of a Fast Attack and a Charged Attack.</td>
          </tr>
          <tr>
            <th align="left">
              STAB
              <span class="NOTE">
                (<span class="SIGNIFICANT">S</span>ame <span class="SIGNIFICANT">T</span>ype <span class="SIGNIFICANT">A</span>ttack <span class="SIGNIFICANT">B</span>onus)
              </span>
            </th>
            <td>Tells whether the Pokemon get a 25% bonus because the Move's Type is the same as the Pokemon's type.</td>
          </tr>
          <tr>
            <th align="left">
              Base DPS
              <span class="NOTE">
                (<span class="SIGNIFICANT">D</span>amage <span class="SIGNIFICANT">P</span>er <span class="SIGNIFICANT">S</span>econd)
              </span>
            </th>
            <td>Tells the raw DPS for Move Set itself, without taking into account the Pokemon's Stats.</td>
          </tr>
          <tr>
            <th align="left">True DPS</th>
            <td>Tells the DPS for Move Set, for the specified Pokemon.</td>
          </tr>
          <tr>
            <th align="left">%</th>
            <td>
              A comparison of the Move Set's True DPS, to the True DPS of the Pokemon's best possible Move Set <span class="EMPHASIS">that doesn't include a Legacy Move</span>.
            </td>
          </tr>
        </table>
      </div>
      <br />

      <div class="FLOWING_TABLE_WRAPPER">
        <table border="1" class="KEY_TABLE">
          <tr>
            <th colspan="2">
              <span style="font-size:larger;">Table Cells</span>
            </th>
          </tr>

          <comment comment="General">
            <tr>
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
          </comment>

          <comment comment="Base and True DPS">
            <tr>
              <th rowspan="4">
                Base<br />&amp;<br />True DPS
              </th>
              <td class="GREAT">
                True DPS &gt;= <xsl:value-of select="100*$DPSGreat" />% of Max Possible
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="format-number($MaxTrueDPS * $DPSGreat, '#0.00')" /> - <xsl:value-of select="format-number($MaxTrueDPS, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="GOOD">
                True DPS &gt;= <xsl:value-of select="100*$DPSGood" />% of Max Possible
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="format-number($MaxTrueDPS * $DPSGood, '#0.00')" /> - <xsl:value-of select="format-number($MaxTrueDPS * $DPSGreat, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="POOR">
                True DPS Above Average
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="$AverageTrueDPS" /> - <xsl:value-of select="format-number($MaxTrueDPS * $DPSGood, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="BAD">
                True DPS Below Average
                <span class="NOTE" style="float:right;">
                  (0 - <xsl:value-of select="$AverageTrueDPS" />)
                </span>
              </td>
            </tr>
          </comment>

          <comment comment="Base DPS">
            <tr>
              <th rowspan="4">Damage: Base DPS</th>
              <td class="GREAT">
                Base DPS &gt;= <xsl:value-of select="100*$DPSGreat" />% of Max Possible
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="format-number($MaxBaseDPS * $DPSGreat, '#0.00')" /> - <xsl:value-of select="$MaxBaseDPS" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="GOOD">
                Base DPS &gt;= <xsl:value-of select="100*$DPSGood" />% of Max Possible
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="format-number($MaxBaseDPS * $DPSGood, '#0.00')" /> - <xsl:value-of select="format-number($MaxBaseDPS * $DPSGreat, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="POOR">
                Base DPS Above Average
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="$AverageBaseDPS" /> - <xsl:value-of select="format-number($MaxBaseDPS * $DPSGood, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="BAD">
                Base DPS Below Average
                <span class="NOTE" style="float:right;">
                  (0 - <xsl:value-of select="$AverageBaseDPS" />)
                </span>
              </td>
            </tr>
          </comment>

          <comment comment="Damage %">
            <tr>
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
          </comment>
        </table>
      </div>

      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <xsl:call-template name="PokemonImageKey">
        <xsl:with-param name="Title">Pokemon Image</xsl:with-param>
      </xsl:call-template>
    </div>
  </xsl:template>

  <!-- Template to create merged cells for each Pokemon #/Name, then call template to create the Move Set rows for that Pokemon -->
  <xsl:template match="MoveSets">
    <xsl:variable name="gen" select="Generation" />

    <h2>
      <xsl:text>Generation </xsl:text>
      <xsl:value-of select="Generation" />
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('MOVESET_DIV_GEN_', $gen)" />
      </xsl:call-template>
    </h2>
    <div>
      <xsl:attribute name="id">
        <xsl:value-of select="concat('MOVESET_DIV_GEN_', $gen)" />
      </xsl:attribute>
      <table class="INDENT" border="1" style="margin-bottom:1em;">
        <tr>
          <th class="DISABLED UNUSED" rowspan="2" />
          <th colspan="2">
            <xsl:attribute name="class">
              <xsl:value-of select="concat('GEN', $gen)"/>
            </xsl:attribute>
            Gen <xsl:value-of select="$gen"  />
          </th>
          <th colspan="2" class="GEN_OVERALL">Overall</th>
        </tr>
        <tr>
          <th>
            <xsl:attribute name="class">
              <xsl:value-of select="concat('GEN', $gen)"/>
            </xsl:attribute>
            Base DPS
          </th>
          <th>
            <xsl:attribute name="class">
              <xsl:value-of select="concat('GEN', $gen)"/>
            </xsl:attribute>
            True DPS
          </th>
          <th class="GEN_OVERALL">Base DPS</th>
          <th class="GEN_OVERALL">True DPS</th>
        </tr>
        <tr class="GREAT" style="font-weight:normal;">
          <th align="left">Maximum</th>
          <td align="right" style="margin-left:.5em;">
            <xsl:value-of select="format-number(/Root/Stats/MoveSets/*[local-name()=concat('Gen', $gen)]/BaseDPS/Max, '#0.00')"/>
          </td>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Stats/MoveSets/*[local-name()=concat('Gen', $gen)]/TrueDPS/Max, '#0.00')"/>
          </td>
          <td align="right">
            <xsl:value-of select="$MaxBaseDPS"/>
          </td>
          <td align="right">
            <xsl:value-of select="$MaxTrueDPS"/>
          </td>
        </tr>
        <tr class="POOR">
          <th align="left">Average</th>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Stats/MoveSets/*[local-name()=concat('Gen', $gen)]/BaseDPS/Average, '#0.00')"/>
          </td>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Stats/MoveSets/*[local-name()=concat('Gen', $gen)]/TrueDPS/Average, '#0.00')"/>
          </td>
          <td align="right">
            <xsl:value-of select="$AverageBaseDPS"/>
          </td>
          <td align="right">
            <xsl:value-of select="$AverageTrueDPS"/>
          </td>
        </tr>
      </table>

      <br />
      <table border="1" style="white-space:nowrap;">
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
                  <Show hide_name="true" valign="middle"/>
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
            <xsl:value-of select="concat($lt, '!-- Add a blank line as a separater. (It also makes adding the MoveSets easier.) --', $gt)" disable-output-escaping="yes" />
            <td colspan="5" class="HIDDEN_CONVENIENCE_ROW" />
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
        Base<br />DPS
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
    <xsl:variable name="valueDamageDPS" select="format-number(Damage/BaseDPS, '#0.00')" />
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
      <xsl:with-param name="BaseDPS" select="$valueDamageDPS" />
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
    <xsl:param name="BaseDPS" />
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

      <xsl:if test="$BaseDPS != '' or $TrueDPS != '' or $Percent != '' or $Legacy != ''">
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="$BaseDPS != ''">
              <xsl:choose>
                <xsl:when test="$BaseDPS &gt;= $MaxBaseDPS * $DPSGreat">
                  <xsl:text>GREAT </xsl:text>
                </xsl:when>
                <xsl:when test="$BaseDPS &gt;= $MaxBaseDPS * $DPSGood">
                  <xsl:text>GOOD </xsl:text>
                </xsl:when>
                <xsl:when test="$BaseDPS &gt;= $DPSOkay">
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

      <span>
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
        </xsl:attribute>
        <xsl:value-of select="$Content" />
      </span>
      <xsl:if test="$Percent != ''">
        <xsl:text>%</xsl:text>
      </xsl:if>
    </td>
  </xsl:template>

</xsl:stylesheet>