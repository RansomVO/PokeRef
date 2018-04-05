<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>pokequick.js?cacherefresh=</xsl:text>
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

        <title>Quick Pokemon List</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Quick Pokemon List
        </h1>
        <p>
          Sometimes you just want to see a list of the Pokemon that fit your criteria.
          For example, maybe you want to perform a Field Research task that involves catching Poison type Pokemon.
          <br />This list should help you out.
        </p>


        <br />
        <hr />
        <xsl:call-template name="LoadingNotice">
          <xsl:with-param name="LoadedContent" select="'POKECHART_Content'" />
        </xsl:call-template>

        <xsl:value-of select="concat($lt, '!-- Leave this hidden until everything is loaded and .js has applied it. --', $gt)" disable-output-escaping="yes" />
        <div id="POKECHART_Content" class="DIV_HIDDEN">
          <xsl:call-template name="CreateCriteria" />

          <br />
          <hr />
          <xsl:call-template name="CreateKey" />

          <xsl:apply-templates select="PokemonStats[Generation/ID = 1]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 2]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 3]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 4]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 5]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 6]" />
          <xsl:apply-templates select="PokemonStats[Generation/ID = 7]" />
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!-- Template to write the Selection Criteria. -->
  <xsl:template name="CreateCriteria">
    <h2 id="anchor_criteria">
      <xsl:text>Selection Criteria</xsl:text>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'POKEMON_CRITERIA'" />
      </xsl:call-template>
      <xsl:call-template name="OutputResetButton">
        <xsl:with-param name="Callback" select="'OnResetCriteriaClicked();'" />
      </xsl:call-template>
    </h2>
    <div id="POKEMON_CRITERIA" style="margin-top:.5em;">
      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <xsl:call-template name="OutputTypeSelection">
        <xsl:with-param name="CallbackName" select="'OnTypesChanged'" />
        <xsl:with-param name="Title" select="'Pokemon Types'" />
        <xsl:with-param name="SliderHelp">
          <table style="width:20em;">
            <tr>
              <th width="1px;">Any</th>
              <td>Pokemon that have any of their Types matching the selected Pokemon Types.</td>
            </tr>
            <tr>
              <th>All</th>
              <td>Pokemon that have all of their Types matching the selected Pokemon Types.</td>
            </tr>
          </table>
        </xsl:with-param>
      </xsl:call-template>

      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <xsl:call-template name="OutputWeatherSelection">
        <xsl:with-param name="CallbackName" select="'OnWeatherChanged'" />
        <xsl:with-param name="Title" select="concat('Pokemon', $lt, 'br /', $gt, 'Weather Boosts')" />
        <xsl:with-param name="SliderHelp">
          <table style="width:25em">
            <tr>
              <th width="1px">Any</th>
              <td>Pokemon that have any of their Types boosted by the selected Pokemon Weather Boosts.</td>
            </tr>
            <tr>
              <th>All</th>
              <td>Pokemon that have all of their Types boosted by the selected Pokemon Weather Boosts.</td>
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
        <xsl:with-param name="CollapseeID" select="'POKESTAT_KEY'" />
      </xsl:call-template>
    </h2>
    <div id="POKESTAT_KEY" style="margin-top:.5em;">
      <xsl:call-template name="PokemonImageKey" />
    </div>
  </xsl:template>

  <xsl:template match="PokemonStats">
    <br />
    <hr />
    <h2>
      <xsl:attribute name="id">
        <xsl:value-of select="concat('GEN', Generation/ID)" />
      </xsl:attribute>
      <xsl:text>Generation </xsl:text>
      <xsl:value-of select="Generation/ID" />
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('GENERATION_', Generation/ID)" />
      </xsl:call-template>
    </h2>
    <div>
      <xsl:attribute name="id">
        <xsl:value-of select="concat('GENERATION_', Generation/ID)" />
      </xsl:attribute>
      <div style="display:flex; flex-wrap:wrap;">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('GEN', Generation/ID, '_Collection')" />
        </xsl:attribute>
        <xsl:for-each select="Pokemon">
          <xsl:if test="not(contains(Availability, /Root/Settings/Availability/Unavailable))">
            <xsl:variable name="Name" select="Name" />
            <xsl:apply-templates select=".">
              <xsl:with-param name="Settings">
                <Show boxed="true" small="true" valign="bottom" />
              </xsl:with-param>
              <xsl:with-param name="CustomAttributes">
                <Attributes>
                  <xsl:if test="count(/Root/RaidBosses/Tier[@name != '? Future ?' and RaidBoss = $Name]) != 0">
                    <xsl:attribute name="raidboss">true</xsl:attribute>
                  </xsl:if>
                </Attributes>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:if>
        </xsl:for-each>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
