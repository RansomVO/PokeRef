<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>

  <xsl:include href="/charts/movesets/movesets.xsl" />

  <!-- Global Variables -->
  <xsl:variable name="DPSFilter" select="$MaxTrueDPS * $DPSGood" />

  <xsl:template match="/">
    <xsl:apply-templates select="Root" mode="Counters" />
  </xsl:template>

  <xsl:template match="Root" mode="Counters">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>counters.js?cacherefresh=</xsl:text>
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

        <title>Raidboss Counters</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Raidboss Counters
        </h1>
        <p>
          When it comes to Raids, you want the best chance of defeating the Boss.
          But which of <span class="EMPHASIS">your</span> Pokemon will do best against the boss?
          <br />Use this tool to find out.
        </p>

        <br />
        <hr />


        <!--
        <div style="border:1px solid red">
          <xsl:copy-of select="MoveSets/MoveSet[Damage/TrueDPS >= $DPSFilter]" />
        </div>
-->
        <table border="1" style="white-space:nowrap;">
          <xsl:call-template name="CreateTableHeaders" />

          <xsl:apply-templates select="MoveSets/MoveSet[Damage/TrueDPS >= $DPSFilter]" />

          <!--
          <xsl:for-each select="MoveSets/MoveSet[Damage/TrueDPS >= $DPSFilter and not(preceding-sibling::MoveSet/Pokemon/@id = Pokemon/@id)]">
            <xsl:call-template name="PokemonMoveSets">
              <xsl:with-param name="PokemonID" select="Pokemon/@id" />
            </xsl:call-template>
          </xsl:for-each>
-->
        </table>


        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!--

  <xsl:template name="CreateTableHeaders">
    <tr>
      <th colspan="3">Pokemon</th>
      <th colspan="2">Move Set</th>
      <th rowspan="2">True DPS</th>
    </tr>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Fast</th>
      <th>Charged</th>
    </tr>
  </xsl:template>


  <xsl:template name="PokemonMoveSets">
    <xsl:param name="PokemonID" />

    <xsl:variable name="Rows" select="count(/Root/MoveSets/MoveSet[Pokemon/@id=$PokemonID]) + 1" />

    <tr>
      <td class="CELL_FILLED">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="$Rows" />
        </xsl:attribute>
        <xsl:apply-templates select="/Root/PokeStats/Pokemon[@id = $PokemonID]" />
      </td>
      <td>
        <xsl:attribute name="rowspan">
          <xsl:value-of select="$Rows" />
        </xsl:attribute>
        <xsl:value-of select="Pokemon/@id" />
      </td>
      <td>
        <xsl:attribute name="rowspan">
          <xsl:value-of select="$Rows" />
        </xsl:attribute>
        <xsl:value-of select="Pokemon/@name" />
      </td>
      <td colspan="8" style="height:0px; margin:0px; padding:0px; border:none;" />
    </tr>

    <xsl:for-each select="/Root/MoveSets/MoveSet[Pokemon/@id=$PokemonID]">
      <tr>
        <td>
          <xsl:value-of select="Attack/Fast" />
        </td>
        <td>
          <xsl:value-of select="Attack/Charged" />
        </td>
        <td>
          <xsl:value-of select="Damage/TrueDPS" />
        </td>
      </tr>
    </xsl:for-each>

  </xsl:template>
-->

</xsl:stylesheet>
