<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:variable name="Pokemon" select="/Root/PokemonStats/Pokemon" />

  <xsl:template match="Root">
    <html lang="en-us">
      <head>
        <!-- This is to make the font size consistent on mobile. -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>evolutions.js?cacherefresh=</xsl:text>
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

        <title>Evolutions Chart</title>
      </head>
      <body>
        <h1>Evolutions Chart</h1>
        <div class="INDENT">
          <p class="NOTE PARENT">
            Please let me know if you find any issues!
            <script>WriteFeedbackNote();</script>
          </p>
        </div>
        <p>
          One of the fun parts of Pokemon GO is Evolving.
          But what can turn into what?
          <br />This chart can help.
        </p>

        <div id="Loading">
          <h1>Loading...</h1>
        </div>
        <!-- Leave this hidden until we have loaded everything and applied it. -->
        <div id="Loaded" style="display:none;">
          <h2>Selection Criteria</h2>
          <div class="INDENT">
            <xsl:text>Family Must Contain: </xsl:text>
            <select class="PARENT" id="GenFilterType_Combobox" onchange="OnFilterCriteriaChanged(this);">
              <option value="1">Any of Selected Gens</option>
              <option value="2">All Selected Gens</option>
            </select>

            <div class="INDENT CHILD">
              <input id="Gen1_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" checked="true" />Gen1
              <br /><input id="Gen2_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" checked="true" />Gen2
              <br /><input id="Gen3_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" checked="true" />Gen3
              <br /><input id="Gen4_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" checked="true" />Gen4
              <br /><input id="Gen5_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" checked="true" />Gen5
              <br /><input id="Gen6_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" checked="true" />Gen6
              <br /><input id="Gen7_Check" type="checkbox" onchange="OnFilterCriteriaChanged(this);" checked="true" />Gen7
            </div>

            <xsl:text>Filter by Name or ID: </xsl:text>
            <input id="Filter_Text" type="text" onkeyup="OnFilterCriteriaChanged(this)" />
          </div>

          <br />
          <hr />
          <!-- Go through families of hatchlings, then through each generation -->
          <table id="Evolutions" border="1" style="height:1em;">
            <xsl:apply-templates select="PokemonStats/Pokemon[contains(Availability,'Hatch') and EvolvesFrom/Pokemon/ID='']" mode="Evolver" />
            <xsl:apply-templates select="PokemonStats/Pokemon[not(contains(Availability,'Hatch')) and ../Generation/ID = '1' and EvolvesFrom/Pokemon/ID='']" mode="Evolver" />
            <xsl:apply-templates select="PokemonStats/Pokemon[not(contains(Availability,'Hatch')) and ../Generation/ID = '2' and EvolvesFrom/Pokemon/ID='']" mode="Evolver" />
            <xsl:apply-templates select="PokemonStats/Pokemon[not(contains(Availability,'Hatch')) and ../Generation/ID = '3' and EvolvesFrom/Pokemon/ID='']" mode="Evolver" />
            <xsl:apply-templates select="PokemonStats/Pokemon[not(contains(Availability,'Hatch')) and ../Generation/ID = '4' and EvolvesFrom/Pokemon/ID='']" mode="Evolver" />
            <xsl:apply-templates select="PokemonStats/Pokemon[not(contains(Availability,'Hatch')) and ../Generation/ID = '5' and EvolvesFrom/Pokemon/ID='']" mode="Evolver" />
            <xsl:apply-templates select="PokemonStats/Pokemon[not(contains(Availability,'Hatch')) and ../Generation/ID = '6' and EvolvesFrom/Pokemon/ID='']" mode="Evolver" />
            <xsl:apply-templates select="PokemonStats/Pokemon[not(contains(Availability,'Hatch')) and ../Generation/ID = '7' and EvolvesFrom/Pokemon/ID='']" mode="Evolver" />
          </table>
        </div>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <!-- Template to get a Family of Pokemon and start the process to write them out. -->
  <xsl:template match="Pokemon" mode="Evolver">
    <!-- Get a Family of Evolutions and comvert it to a Node Set. -->
    <xsl:variable name="FamilyRaw">
      <xsl:apply-templates select="." mode="GetFamily" />
    </xsl:variable>
    <xsl:variable name="Family" select="exslt:node-set($FamilyRaw)/FamilyBranch" />

    <!-- Now output the Family. -->
    <xsl:call-template name="OutputFamily">
      <xsl:with-param name="Family" select="$Family" />
    </xsl:call-template>
  </xsl:template>

  <!-- Template to output a Family of Pokemon -->
  <xsl:template name="OutputFamily">
    <xsl:param name="Family" />
    <!-- 
    Here are samples of the weird cases:
      ┌───────────┬───────────┐   
      │ Eevee     │ Vaporeon  │
      │   (8)     ├───────────┤
      │           │ Jolteon   │
      │           ├───────────┤
      │           │ Flareon   │
      │           ├───────────┤
      │           │ Espeon    │
      │           ├───────────┤
      │           │ Umbreon   │
      │           ├───────────┤
      │           │ Leafeon   │
      │           ├───────────┤
      │           │ Glaceon   │
      │           ├───────────┤
      │           │ Sylveon   │
      └───────────┴───────────┘

      ┌───────────┬───────────┬───────────┐   
      │ Poliwag   │ Poliwhirl │ Poliwrath │
      │    (2)    │    (2)    ├───────────┤
      │           │           │ Politoed  │
      └───────────┴───────────┴───────────┘
        
      ( TODO QZX: I haven't handled this yet. We'll see what happens when Pokemon GO gets there.)
      ┌───────────┬───────────────────────┐
      │ Nincada   │ Ninjask               │
      │    (2)    ├───────────────────────┤
      │           │ Ninjask & Shedinja    │
      └───────────┴───────────────────────┘
  -->

    <!-- Output first row. -->
    <xsl:variable name="IDs">
      <xsl:for-each select="$Family//@ID">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="Names">
      <xsl:for-each select="$Family//@Name">
        <xsl:value-of select="."/>
        <xsl:text>-</xsl:text>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="Gens">
      <xsl:text> </xsl:text>
      <xsl:for-each select="$Family//@Gen">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
      </xsl:for-each>
    </xsl:variable>

    <tr>
      <xsl:attribute name="ids">
        <xsl:value-of select="$IDs" />
      </xsl:attribute>
      <xsl:attribute name="names">
        <xsl:value-of select="$Names" />
      </xsl:attribute>
      <xsl:attribute name="gens">
        <xsl:value-of select="$Gens" />
      </xsl:attribute>
      <xsl:call-template name="OutputFamilyBranch">
        <xsl:with-param name="FamilyBranch" select="$Family" />
        <xsl:with-param name="FirstRow" select="true()" />
      </xsl:call-template>
    </tr>

    <!-- Find the Pokemon with multiple Evolutions and Output the rest of the rows. -->
    <xsl:call-template name="OutputFamilyBranch">
      <xsl:with-param name="FamilyBranch" select="$Family" />
      <xsl:with-param name="FirstRow" select="false()" />
    </xsl:call-template>
  </xsl:template>

  <!-- Template to output a Branch of a Family of Pokemon. -->
  <xsl:template name="OutputFamilyBranch">
    <!-- (Starts with the Root Branch, then calls itself recursively.) -->
    <xsl:param name="FamilyBranch" />
    <xsl:param name="FirstRow" />

    <xsl:choose>
      <!-- When we are starting a new Family. -->
      <xsl:when test="$FirstRow">
        <!-- Output the current cell -->
        <xsl:apply-templates select="$FamilyBranch" />

        <!-- Call recursively to output the rest of the cells in this row. -->
        <xsl:if test="count($FamilyBranch/Evolutions/FamilyBranch) > 0">
          <xsl:call-template name="OutputFamilyBranch">
            <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[1]" />
            <xsl:with-param name="FirstRow" select="$FirstRow" />
          </xsl:call-template>
        </xsl:if>
      </xsl:when>

      <!-- When the Pokemon is a repeat of the first row. -->
      <xsl:when test="count($FamilyBranch/Evolutions/FamilyBranch) = 1">
        <xsl:call-template name="OutputFamilyBranch">
          <xsl:with-param name="FamilyBranch" select="$FamilyBranch/Evolutions/FamilyBranch[1]" />
          <xsl:with-param name="FirstRow" select="$FirstRow" />
        </xsl:call-template>
      </xsl:when>

      <!-- When the Pokemon is the one with multiple Evolutions. -->
      <xsl:when test="count($FamilyBranch/Evolutions/FamilyBranch) > 1">
        <xsl:for-each select="$FamilyBranch/Evolutions/FamilyBranch[position() > 1]">
          <tr>
            <xsl:call-template name="OutputFamilyBranch">
              <xsl:with-param name="FamilyBranch" select="." />
              <xsl:with-param name="FirstRow" select="true()" />
            </xsl:call-template>
          </tr>
        </xsl:for-each>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Template to output a cell containing a Pokemon -->
  <xsl:template match="FamilyBranch">
    <xsl:variable name="ID" select="@ID" />

    <td class="CELL_FILLED">
      <xsl:attribute name="rowspan">
        <xsl:value-of select="@rowspan" />
      </xsl:attribute>

      <!-- This template (from /xsl/global.xsl) outputs the Visual image of the Pokemon with various decorations. -->
      <xsl:apply-templates select="$Pokemon[ID = $ID]">
        <xsl:with-param name="Footer">
          <i>
            <xsl:text>(Gen </xsl:text>
            <xsl:value-of select="$Pokemon[ID = $ID]/../Generation/ID" />
            <xsl:text>)</xsl:text>
          </i>
        </xsl:with-param>
      </xsl:apply-templates>

    </td>
  </xsl:template>

  <!-- Creates a structure of evolutions for a single Family of Pokemon. -->
  <xsl:template match="Pokemon" mode="GetFamily">
    <xsl:variable name="ID" select="ID" />
    <xsl:variable name="FamilyBranch">
      <xsl:apply-templates mode="GetFamily" select="$Pokemon[EvolvesFrom/Pokemon/ID = $ID]" />
    </xsl:variable>
    <xsl:variable name="rowspan" select="sum(exslt:node-set($FamilyBranch)/FamilyBranch/@rowspan)" />
    <FamilyBranch>
      <xsl:attribute name="ID">
        <xsl:value-of select="$ID" />
      </xsl:attribute>
      <xsl:attribute name="Name">
        <xsl:value-of select="Name" />
      </xsl:attribute>
      <xsl:attribute name="Gen">
        <xsl:value-of select="../Generation/ID" />
      </xsl:attribute>
      <xsl:attribute name="rowspan">
        <xsl:choose>
          <xsl:when test="$rowspan = 0" >1</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$rowspan" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <Evolutions>
        <xsl:copy-of select="$FamilyBranch" />
      </Evolutions>
    </FamilyBranch>
  </xsl:template>

</xsl:stylesheet>
