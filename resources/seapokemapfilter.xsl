<!-- TODO QZX:
  + Make it so multiple filters can be created. (And saved in cookies)
    - Have editable combobox to Select/Create.
    - Enhance CookieCode to support specifying a Grouping?
  + Fix it so Gen
-->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:variable name="PokemonCount">
    <Count Gen="1">
      <xsl:value-of select="count(Root/PokemonStats[Generation/ID = 1]/Pokemon)" />
    </Count>
    <Count Gen="2">
      <xsl:value-of select="count(Root/PokemonStats[Generation/ID = 2]/Pokemon)" />
    </Count>
    <Count Gen="3">
      <xsl:value-of select="count(Root/PokemonStats[Generation/ID = 3]/Pokemon)" />
    </Count>
    <Count Gen="4">
      <xsl:value-of select="count(Root/PokemonStats[Generation/ID = 4]/Pokemon)" />
    </Count>
    <Count Gen="5">
      <xsl:value-of select="count(Root/PokemonStats[Generation/ID = 5]/Pokemon)" />
    </Count>
    <Count Gen="6">
      <xsl:value-of select="count(Root/PokemonStats[Generation/ID = 6]/Pokemon)" />
    </Count>
    <Count Gen="7">
      <xsl:value-of select="count(Root/PokemonStats[Generation/ID = 7]/Pokemon)" />
    </Count>
  </xsl:variable>

  <xsl:variable name="MaxRows">
    <xsl:for-each select="exslt:node-set($PokemonCount)/Count[$ReleasedGens >= @Gen]">
      <xsl:sort select="." data-type="number" order="descending"/>
      <xsl:if test="position()=1">
        <xsl:value-of select="."/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <xsl:template match="/Root">
    <html>
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>seapokemapfilter.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/global.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/pokemon.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <link type="text/css" rel="stylesheet" >
          <xsl:attribute name="href">
            <xsl:text>index.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </link>

        <title>SEAPokeMap Filter Generator</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          SEAPokeMap Filter Generator
        </h1>
        <p class="PARENT">
          When using <a href="https://seapokemap.com/">SEAPokeMap</a> there is the ability to specify a filter.
          However, in my case I may want to see different filters at different times.
          <br />
          For example:
        </p>
        <ul class="CHILD">
          <li>
            When I am sitting at work, I may want to see only Pokemon that I don't already have.
            (Or ones that can evolve into them.)
          </li>
          <li>
            When I am on a break, I may want to see the above, <b>
              <i>PLUS</i>
            </b> all of the Pokemon that I need candies for powering up.
          </li>
          <li>Sometimes, I want to see all Pokemon with an IV score above 82.</li>
          <li>Etc.</li>
        </ul>
        <p>
          This page is a tool to help you generate javascript that can adjust the filter on SEAPokeMap.
        </p>

        <p id="anchor_instructions" class="PARENT">
          Follow the instructions below for your environment:
        </p>
        <div class="INDENT CHILD">
          <table border="1">
            <tr style="font-size:x-large;">
              <th style="width:0px;">Environment</th>
              <th>Setup</th>
              <th>Use</th>
            </tr>
            <tr>
              <th>Desktop</th>
              <td>
                <ol>
                  <li>Create a new shortcut in your browser.</li>
                  <li>Edit the shortcut.</li>
                  <li>Copy and paste the desired script from the table above into the URL field and save it.</li>
                </ol>
              </td>
              <td>
                <ol>
                  <li>Open seapokemap.com.</li>
                  <li>Click on the shortcut created in Setup.</li>
                </ol>
              </td>
            </tr>
            <tr>
              <th>Android</th>
              <td>
                Copy and paste the scripts from the table above to a location convenient for your device.
              </td>
              <td>
                <ol>
                  <li>Open seapokemap.com.</li>
                  <li>Copy and paste the desired script address bar and click Go.</li>
                </ol>
              </td>
            </tr>
            <tr>
              <th rowspan="2">Apple</th>
              <td colspan="2">
                <div class="NOTE">
                  <b>NOTE</b>: I do not have an Apple device, so I have not personally verified this works.
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <ol>
                  <li>Open browser.</li>
                  <li>Add a bookmark.</li>
                  <li>Open bookmark list.</li>
                  <li>Go to edit mode.</li>
                  <li>
                    Select the bookmark and edit the 2<sup>nd</sup> field to the desired script from the table above.
                  </li>
                </ol>
              </td>
              <td>
                <ol>
                  <li>Open seapokemap.com.</li>
                  <li>Click on the shortcut created in Setup.</li>
                  <li>
                    Refresh.
                    <br /><span class="NOTE">(I am not sure if this step is necessary because the javascript I have supplied should do it for you.)</span>
                  </li>
                </ol>
              </td>
            </tr>
          </table>
        </div>

        <br />
        <hr />
        <table id="anchor_results" border="1" width="100%" style="table-layout:fixed;">
          <tr>
            <td id="FilterResults" style="overflow-wrap:break-word;" />
          </tr>
        </table>
        <br />
        <table id="anchor_criteria">
          <tr>
            <td valign="top">
              <button onclick="Reset();">Reset</button>
            </td>
            <td valign="top">
              <h2>
                <u>Options</u>
              </h2>
              <br /><input id="Check_Icons" type="checkbox" onchange="GenerateFilter(this);" />Set icons for Pokemon on map.
              <br /><input id="Check_IVOnly" type="checkbox" onchange="OnIVOnlyCheckChanged(this);" />Set to only Pokemon that may have an IV score.
              <br />Min IV: <input id="Input_MinIV" type="number" min="0" max="100" style="text-align:right;" onchange="GenerateFilter(this);" />
            </td>
          </tr>
        </table>
        <br />
        <table comment="(more criteria)" border="1" style="table-layout:fixed;">
          <tr>
            <xsl:call-template name="OutputTableHeaders" />
          </tr>
          <xsl:call-template name="OutputTableRows" />
        </table>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="OutputTableHeaders">
    <xsl:param name="Gen" select="1" />

    <xsl:if test="$ReleasedGens >= $Gen">
      <th>
        Gen <xsl:value-of select="$Gen"/>
        <br />
        <input type="checkbox" onchange="OnColumnCheckChanged(this);">
          <xsl:attribute name="id">
            <xsl:for-each select="/Root/PokemonStats[$Gen]/Pokemon/ID">
              <xsl:value-of select="." />
              <xsl:text> </xsl:text>
            </xsl:for-each>
          </xsl:attribute>
        </input>
      </th>
      <xsl:call-template name="OutputTableHeaders">
        <xsl:with-param name="Gen" select="$Gen+1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Template that calls itself recursively to output each of the rows in the table. -->
  <xsl:template name="OutputTableRows">
    <xsl:param name="Row" select="1" />

    <xsl:if test="$MaxRows >= $Row">
      <tr>
        <xsl:call-template name="OutputTableCell">
          <xsl:with-param name="Row" select="$Row" />
        </xsl:call-template>
      </tr>

      <xsl:call-template name="OutputTableRows">
        <xsl:with-param name="Row" select="$Row+1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Template that calls itself recursively to output each cell of a row in the table. -->
  <xsl:template name="OutputTableCell">
    <xsl:param name="Row" />
    <xsl:param name="Gen" select="1" />

    <xsl:if test="$ReleasedGens >= $Gen">
      <td align="center" style="margin:0; padding:0;">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('Cell_', /Root/PokemonStats[$Gen]/Pokemon[$Row]/ID)" />
        </xsl:attribute>
        <xsl:if test="/Root/PokemonStats[$Gen]/Pokemon[$Row]">
          <xsl:apply-templates select="/Root/PokemonStats[$Gen]/Pokemon[$Row]" />
          <input type="checkbox" onchange="OnPokemonCheckChanged(this);">
            <xsl:attribute name="id">
              <xsl:text>Check_</xsl:text>
              <xsl:value-of select="/Root/PokemonStats[$Gen]/Pokemon[$Row]/ID"/>
            </xsl:attribute>
            <!-- TODO QZX: It would be nice to set some property to the Gen -->
            <xsl:attribute name="name">
              <xsl:value-of select="$Gen"/>
            </xsl:attribute>
          </input>
        </xsl:if>
      </td>

      <xsl:call-template name="OutputTableCell">
        <xsl:with-param name="Row" select="$Row" />
        <xsl:with-param name="Gen" select="$Gen+1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
