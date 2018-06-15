<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <!-- #region Global Variables -->
  <xsl:variable name="MaxBaseDPS" select="format-number($MoveSetStats_Overall/@dps_max, '#0.00')" />
  <xsl:variable name="AverageBaseDPS" select="format-number($MoveSetStats_Overall/@dps_avg, '#0.00')" />
  <xsl:variable name="MaxTrueDPS" select="format-number($MoveSetStats_Overall/@true_dps_max, '#0.00')" />
  <xsl:variable name="AverageTrueDPS" select="format-number($MoveSetStats_Overall/@true_dps_avg, '#0.00')" />

  <xsl:variable name="DPSOkay" select="number($AverageBaseDPS)" />

  <xsl:variable name="TypeSeparator" select="$amp" />
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
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/pokemon.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
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
          Pokemon Move Sets
          <xsl:choose>
            <xsl:when test="count(MoveSets/@gen) > 1">
              <xsl:text> - All Gens</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> - Gen </xsl:text>
              <xsl:value-of select="MoveSets/@gen" />
            </xsl:otherwise>
          </xsl:choose>
        </title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon Move Sets
          <xsl:choose>
            <xsl:when test="count(MoveSets/@gen) > 1">
              <xsl:text> - All Gens </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text> - Gen </xsl:text>
              <xsl:value-of select="MoveSets/@gen" />
            </xsl:otherwise>
          </xsl:choose>
        </h1>
        <p class="NOTE">
          <b>NOTE</b>: Last Updated <xsl:value-of select="$GAME_MASTER_Timestamp" />
        </p>
        <p>
          This chart lists the Move Sets for Pokemon.
          <br />Just look up the Pokemon you are interested in, find the entry for the Move Set for your Pokemon, and compare it to the other possible Move Sets.
        </p>
        <p>
          For a technical description of the formulas used, check out <a href="/tech/formulas/movesetdamage.html">Move Set Damage Formulas</a>.
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

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!-- Template to write the Selection Criteria. -->
  <xsl:template name="CreateCriteria">
    <h2 id="anchor_criteria">
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'MOVESET_CRITERIA'" />
      </xsl:call-template>
      <xsl:text>Selection Criteria</xsl:text>
      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
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
                  <td>
                    <xsl:call-template name="OutputFilterPokemonNameIDLabel" />
                  </td>
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
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'MOVESET_KEY'" />
      </xsl:call-template>
      <xsl:text>Key</xsl:text>
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
            <td style="white-space:normal;">This is a possible combination of a Fast Attack and a Charged Attack.</td>
          </tr>
          <tr>
            <th align="left">
              STAB
              <span class="NOTE">
                (<span class="SIGNIFICANT">S</span>ame <span class="SIGNIFICANT">T</span>ype <span class="SIGNIFICANT">A</span>ttack <span class="SIGNIFICANT">B</span>onus)
              </span>
            </th>
            <td style="white-space:normal;">Tells whether the Pokemon get a 25% bonus because the Move's Type is the same as the Pokemon's type.</td>
          </tr>
          <tr>
            <th align="left">
              Base DPS
              <span class="NOTE">
                (<span class="SIGNIFICANT">D</span>amage <span class="SIGNIFICANT">P</span>er <span class="SIGNIFICANT">S</span>econd)
              </span>
            </th>
            <td style="white-space:normal;">Tells the raw DPS for Move Set itself, without taking into account the Pokemon's Stats.</td>
          </tr>
          <tr>
            <th align="left">True DPS</th>
            <td>Tells the DPS for Move Set, for the specified Pokemon.</td>
          </tr>
          <tr>
            <th align="left">%</th>
            <td style="white-space:normal;">
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
                True DPS &gt;= <xsl:value-of select="$DPSGreat" />% of Max Possible
                <xsl:value-of select="concat($nbsp,$nbsp,$nbsp,$nbsp)" disable-output-escaping="yes" />
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="format-number($MaxTrueDPS * $DPSGreat div 100, '#0.00')" /> - <xsl:value-of select="format-number($MaxTrueDPS, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="GOOD">
                True DPS &gt;= <xsl:value-of select="$DPSGood" />% of Max Possible
                <xsl:value-of select="concat($nbsp,$nbsp,$nbsp,$nbsp)" disable-output-escaping="yes" />
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="format-number($MaxTrueDPS * $DPSGood div 100, '#0.00')" /> - <xsl:value-of select="format-number($MaxTrueDPS * $DPSGreat div 100, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="POOR">
                True DPS Above Average
                <xsl:value-of select="concat($nbsp,$nbsp,$nbsp,$nbsp)" disable-output-escaping="yes" />
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="$AverageTrueDPS" /> - <xsl:value-of select="format-number($MaxTrueDPS * $DPSGood div 100, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="BAD">
                True DPS Below Average
                <xsl:value-of select="concat($nbsp,$nbsp,$nbsp,$nbsp)" disable-output-escaping="yes" />
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
                Base DPS &gt;= <xsl:value-of select="$DPSGreat" />% of Max Possible
                <xsl:value-of select="concat($nbsp,$nbsp,$nbsp,$nbsp)" disable-output-escaping="yes" />
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="format-number($MaxBaseDPS * $DPSGreat div 100, '#0.00')" /> - <xsl:value-of select="$MaxBaseDPS" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="GOOD">
                Base DPS &gt;= <xsl:value-of select="$DPSGood" />% of Max Possible
                <xsl:value-of select="concat($nbsp,$nbsp,$nbsp,$nbsp)" disable-output-escaping="yes" />
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="format-number($MaxBaseDPS * $DPSGood div 100, '#0.00')" /> - <xsl:value-of select="format-number($MaxBaseDPS * $DPSGreat div 100, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="POOR">
                Base DPS Above Average
                <xsl:value-of select="concat($nbsp,$nbsp,$nbsp,$nbsp)" disable-output-escaping="yes" />
                <span class="NOTE" style="float:right;">
                  (<xsl:value-of select="$AverageBaseDPS" /> - <xsl:value-of select="format-number($MaxBaseDPS * $DPSGood div 100, '#0.00')" />)
                </span>
              </td>
            </tr>
            <tr>
              <td class="BAD">
                Base DPS Below Average
                <xsl:value-of select="concat($nbsp,$nbsp,$nbsp,$nbsp)" disable-output-escaping="yes" />
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
                &gt;= <xsl:value-of select="$DPSPercentGreat" />% of best current Move Set
              </td>
            </tr>
            <tr>
              <td class="GOOD">
                &gt;= <xsl:value-of select="$DPSPercentGood" />% of best current Move Set
              </td>
            </tr>
            <tr>
              <td class="POOR">
                &gt;= <xsl:value-of select="$DPSPercentOkay" />% of best current Move Set
              </td>
            </tr>
            <tr>
              <td class="BAD">
                &lt; <xsl:value-of select="$DPSPercentOkay" />% of best current Move Set
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
    <xsl:variable name="gen" select="@gen" />

    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('MOVESET_DIV_GEN_', $gen)" />
      </xsl:call-template>
      <xsl:text>Generation </xsl:text>
      <xsl:value-of select="$gen" />
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
              <xsl:value-of select="concat('GEN', $gen)" />
            </xsl:attribute>
            Gen <xsl:value-of select="$gen"  />
          </th>
          <th colspan="2" class="GEN_OVERALL">Overall</th>
        </tr>
        <tr>
          <th>
            <xsl:attribute name="class">
              <xsl:value-of select="concat('GEN', $gen)" />
            </xsl:attribute>
            Base DPS
          </th>
          <th>
            <xsl:attribute name="class">
              <xsl:value-of select="concat('GEN', $gen)" />
            </xsl:attribute>
            True DPS
          </th>
          <th class="GEN_OVERALL">Base DPS</th>
          <th class="GEN_OVERALL">True DPS</th>
        </tr>
        <tr class="GREAT" style="font-weight:normal;">
          <th align="left">Maximum</th>
          <td align="right" style="margin-left:.5em;">
            <xsl:value-of select="format-number(/Root/Settings/GameMasterStats/MoveSets[@gen = $gen]/@dps_max, '#0.00')" />
          </td>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Settings/GameMasterStats/MoveSets[@gen = $gen]/@true_dps_max, '#0.00')" />
          </td>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Settings/GameMasterStats/MoveSets[@gen = 0]/@dps_max, '#0.00')" />
          </td>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Settings/GameMasterStats/MoveSets[@gen = 0]/@true_dps_max, '#0.00')" />
          </td>
        </tr>
        <tr class="POOR">
          <th align="left">Average</th>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Settings/GameMasterStats/MoveSets[@gen = $gen]/@dps_avg, '#0.00')" />
          </td>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Settings/GameMasterStats/MoveSets[@gen = $gen]/@true_dps_avg, '#0.00')" />
          </td>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Settings/GameMasterStats/MoveSets[@gen = 0]/@dps_avg, '#0.00')" />
          </td>
          <td align="right">
            <xsl:value-of select="format-number(/Root/Settings/GameMasterStats/MoveSets[@gen = 0]/@true_dps_avg, '#0.00')" />
          </td>
        </tr>
      </table>

      <br />
      <table border="1" style="white-space:nowrap;">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('MOVESET_GEN_', $gen)" />
        </xsl:attribute>

        <xsl:call-template name="CreateTableHeaders" />

        <xsl:for-each select="MoveSet[not(Pokemon/@name=preceding-sibling::MoveSet/Pokemon/@name)]">
          <xsl:sort order="ascending" data-type="number" select="Pokemon/@id" />
          <xsl:sort order="ascending" data-type="number" select="Pokemon/@formId" />

          <xsl:variable name="PokemonName" select="Pokemon/@name" />
          <xsl:variable name="PokemonStats" select="/Root/PokeStats/Pokemon[@name=$PokemonName]" />
          <xsl:variable name="PokemonMoveSetCount" select="count(../MoveSet[Pokemon/@name=$PokemonName])" />

          <tr align="left" style="border-top-width:5px">
            <xsl:attribute name="class">
              <xsl:text>PRIMARY_ROW</xsl:text>
              <xsl:if test="contains($PokemonStats/@availability, $Availability_Unreleased)"> UNAVAILABLE_ROW</xsl:if>
            </xsl:attribute>
            <xsl:attribute name="movesetCount">
              <xsl:value-of select="$PokemonMoveSetCount" />
            </xsl:attribute>

            <td class="CELL_FILLED">
              <xsl:attribute name="rowspan">
                <xsl:value-of select="$PokemonMoveSetCount + 1" />
              </xsl:attribute>
              <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name=$PokemonName]">
                <xsl:with-param name="Settings">
                  <Show hide_name="true" valign="middle" />
                </xsl:with-param>
              </xsl:apply-templates>
            </td>
            <th style="font-size:large;" align="right">
              <xsl:attribute name="rowspan">
                <xsl:value-of select="$PokemonMoveSetCount + 1" />
              </xsl:attribute>
              <xsl:value-of select="Pokemon/@id" />
            </th>
            <th style="font-size:large;">
              <xsl:attribute name="rowspan">
                <xsl:value-of select="$PokemonMoveSetCount + 1" />
              </xsl:attribute>
              <xsl:value-of select="Pokemon/@name" />
            </th>
            <xsl:value-of select="concat($lt, '!-- Add a blank line as a separater. (It also makes adding the MoveSets easier.) --', $gt)" disable-output-escaping="yes" />
            <td colspan="5" class="HIDDEN_CONVENIENCE_ROW" />
          </tr>

          <xsl:for-each select="../MoveSet[Pokemon/@name=$PokemonName]">
            <xsl:sort order="descending" data-type="number" select="@comparison" />

            <xsl:apply-templates select="." />
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

  <!-- Template to create a row for a Pokemon's Move Set -->
  <xsl:template match="MoveSet">
    <xsl:variable name="legacyFast" select="pokeref:ToUpper(FastAttack/@legacy) = 'TRUE'" />
    <xsl:variable name="legacyCharged" select="pokeref:ToUpper(ChargedAttack/@legacy) = 'TRUE'" />
    <xsl:variable name="legacy" select="$legacyFast or $legacyCharged" />
    <xsl:variable name="fastSTAB" select="pokeref:ToUpper(FastAttack/@stab) = 'TRUE'" />
    <xsl:variable name="chargedSTAB" select="pokeref:ToUpper(ChargedAttack/@stab) = 'TRUE'" />
    <xsl:variable name="valueDamageDPS" select="format-number(@base_dps, '#0.00')" />
    <xsl:variable name="valueDamageTrueDPS" select="format-number(@true_dps, '#0.00')" />
    <xsl:variable name="valueDamagePercentOfMax" select="format-number(@comparison, '##0')" />

    <xsl:variable name="pokemonName" select="Pokemon/@name" />
    <xsl:variable name="pokemonTypePrimary" select="/Root/PokeStats/Pokemon[@name=$pokemonName]/Type/@primary" />
    <xsl:variable name="pokemonTypeSecondary" select="/Root/PokeStats/Pokemon[@name=$pokemonName]/Type/@secondary" />

    <xsl:variable name="fastMoveName" select="FastAttack/@name" />
    <xsl:variable name="fastMoveType">
      <xsl:choose>
        <xsl:when test="$fastMoveName='Hidden Power'">
          <!-- Special Case: Hidden Power may be of any type, so we need to distinguish between those that boost and those that don't.-->
          <xsl:if test="$fastSTAB">
            <xsl:value-of select="concat($pokemonTypePrimary, $TypeSeparator, $pokemonTypeSecondary)" />
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="/Root/Moves/Move[@name=$fastMoveName]/@type" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="fastMoveBoost">
      <xsl:choose>
        <xsl:when test="$fastMoveName='Hidden Power'">
          <!-- Special Case: Hidden Power may be of any type, so we need to distinguish between those that boost and those that don't.-->
          <xsl:if test="$fastSTAB">
            <xsl:value-of select="concat(/Root/Constants/Mappings/WeatherBoost[@type=$pokemonTypePrimary]/@boost,
              $TypeSeparator, /Root/Constants/Mappings/WeatherBoost[@type=$pokemonTypeSecondary]/@boost)" />
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="/Root/Constants/Mappings/WeatherBoost[@type=$fastMoveType]/@boost" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="chargedMoveName" select="ChargedAttack/@name" />
    <xsl:variable name="chargedMoveType" select="concat(/Root/Moves/Move[@name=$chargedMoveName]/@type, $TypeSeparator)" />
    <xsl:variable name="chargedMoveBoost" select="/Root/Constants/Mappings/WeatherBoost[@type=$chargedMoveType]/@boost" />

    <tr>
      <xsl:if test="contains(/Root/PokeStats/Pokemon[@name=$pokemonName]/@availability,$Availability_Unreleased)">
        <xsl:attribute name="class">UNAVAILABLE_ROW</xsl:attribute>
      </xsl:if>
      <xsl:attribute name="fastMoveName">
        <xsl:value-of select="$fastMoveName" />
      </xsl:attribute>
      <xsl:attribute name="fastMoveType">
        <xsl:value-of select="$fastMoveType" />
      </xsl:attribute>
      <xsl:attribute name="fastMoveBoost">
        <xsl:value-of select="$fastMoveBoost" />
      </xsl:attribute>
      <xsl:attribute name="chargedMoveName">
        <xsl:value-of select="$chargedMoveName" />
      </xsl:attribute>
      <xsl:attribute name="chargedMoveType">
        <xsl:value-of select="$chargedMoveType" />
      </xsl:attribute>
      <xsl:attribute name="chargedMoveBoost">
        <xsl:value-of select="$chargedMoveBoost" />
      </xsl:attribute>

      <xsl:call-template name="MoveSetCell">
        <xsl:with-param name="Content" select="$fastMoveName" />
        <xsl:with-param name="TypeIcon" select="$fastMoveType" />
        <xsl:with-param name="TrueDPS" select="$valueDamageTrueDPS" />
        <xsl:with-param name="LegacyMove" select="$legacyFast" />
        <xsl:with-param name="Legacy" select="$legacy" />
        <xsl:with-param name="STAB" select="$fastSTAB" />
      </xsl:call-template>
      <xsl:call-template name="MoveSetCell">
        <xsl:with-param name="Content" select="$chargedMoveName" />
        <xsl:with-param name="TypeIcon" select="$chargedMoveType" />
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
    </tr>
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
            <xsl:value-of select="$Align" />
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
                <xsl:when test="$BaseDPS &gt;= $MaxBaseDPS * $DPSGreat div 100">
                  <xsl:text>GREAT </xsl:text>
                </xsl:when>
                <xsl:when test="$BaseDPS &gt;= $MaxBaseDPS * $DPSGood div 100">
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
                <xsl:when test="$TrueDPS &gt;= $MaxTrueDPS * $DPSGreat div 100">
                  <xsl:text>GREAT </xsl:text>
                </xsl:when>
                <xsl:when test="$TrueDPS &gt;= $MaxTrueDPS * $DPSGood div 100">
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
                <xsl:when test="$Percent &gt;= $DPSPercentGreat">
                  <xsl:text>GREAT </xsl:text>
                </xsl:when>
                <xsl:when test="$Percent &gt;= $DPSPercentGood">
                  <xsl:text>GOOD </xsl:text>
                </xsl:when>
                <xsl:when test="$Percent &gt;= $DPSPercentOkay">
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
        <!-- Handle multiple types for Hidden Power. -->
        <xsl:variable name="typePrimary">
          <xsl:choose>
            <xsl:when test="contains($TypeIcon, $TypeSeparator)">
              <xsl:value-of select="substring-before($TypeIcon, $TypeSeparator)" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$TypeIcon" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="typeSecondary" select="substring-after($TypeIcon, $TypeSeparator)" />

        <xsl:choose>
          <xsl:when test="$typePrimary=''">
            <xsl:call-template name="OutputTypeIconWithBoost">
              <xsl:with-param name="Type" select="'Other'" />
              <xsl:with-param name ="Settings">
                <Show size="large" />
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="OutputTypeIconWithBoost">
              <xsl:with-param name="Type" select="$typePrimary" />
              <xsl:with-param name ="Settings">
                <Show size="large" />
              </xsl:with-param>
            </xsl:call-template>
            <xsl:if test="not($typeSecondary='')">
              <xsl:value-of select="concat($nbsp, 'or', $nbsp)" disable-output-escaping="yes" />
              <xsl:call-template name="OutputTypeIconWithBoost">
                <xsl:with-param name="Type" select="$typeSecondary" />
                <xsl:with-param name ="Settings">
                  <Show size="large" />
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
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
        <xsl:if test="$Percent != ''">
          <xsl:text>%</xsl:text>
        </xsl:if>
      </span>
    </td>
  </xsl:template>

</xsl:stylesheet>