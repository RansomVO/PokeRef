<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>index.js?cacherefresh=</xsl:text>
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

        <title>Encounters</title>

        <style>
          li {
          margin: 1em 0;
          }
        </style>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Encounters
          <span class="NOTE TODO">(Under Construction/Beta)</span>
        </h1>
        <div class="INDENT">
          <span class="INDENT NOTE">
            Last Updated: <xsl:value-of select="FieldResearch/@last_updated" />
          </span>
          <p>
            Sometimes the Reward for a Research Task, is an "Encounter".
            <xsl:call-template name="SpriteImage">
              <xsl:with-param name="id" select="'Encounter'" />
              <xsl:with-param name="Settings">
                <Show sprite_class="TAG_ICON_MEDIUM" />
              </xsl:with-param>
            </xsl:call-template>
            <br />
            However, the Research Task doesn't tell you which Pokemon you will Encounter when you complete it.
            <br />This page should help you to match up which Pokemon may be the Encounter for which Research Tasks.
          </p>
        </div>

        <br />
        <hr />
        <xsl:call-template name="CreateKey" />

        <br />
        <hr class="SECTION_BORDER" />
        <xsl:apply-templates select="FieldResearch" />

        <br />
        <hr class="SECTION_BORDER" />
        <xsl:apply-templates select="SpecialResearch" />

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="SpecialResearch">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'SPECIAL_RESEARCH'" />
      </xsl:call-template>
      <xsl:text>Special Research</xsl:text>
    </h2>
    <div id="SPECIAL_RESEARCH" class="INDENT">
      <p>
        <span class="TODO QZX">TODO: Description</span>
      </p>
      <xsl:for-each select="Event">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="concat(pokeref:FixURLTarget(pokeref:ToLower(@name)), '.html')" />
          </xsl:attribute>
          <xsl:value-of select="@name"/>
        </a>
        <br />
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="EventResearch">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'EVENT_RESEARCH_TASKS'" />
      </xsl:call-template>
      <xsl:text>Event Research Tasks</xsl:text>
    </h2>
    <div id="EVENT_RESEARCH_TASKS" class="INDENT">
      <p>
        Occasionally, Pokemon GO has special events which have research tasks associated with them.
      </p>

      <hr />
      <xsl:apply-templates select="Event">
        <xsl:sort order="descending" select="@startdate" />
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <!-- #region Field Research -->

  <xsl:template match="FieldResearch">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'FIELD_RESEARCH'" />
      </xsl:call-template>
      <xsl:text>Field Research</xsl:text>
    </h2>
    <div id="FIELD_RESEARCH" class="INDENT">
      <p>
        When spinning a PokeStop you get a "Field Research" that may have and Encounter as a Reward.
        And the Pokemon encountered for a specific Field Research Task may change from time to time.
        <br />This section allows you to see what Tasks match up with which Encounters, and if you click on the Pokemon, it will show you a CP to IV reference chart.
      </p>

      <br />
      <hr />
      <xsl:call-template name="CreateCriteria" />
      <div id="ByTask" style="display:none;">
        <xsl:apply-templates select="." mode="ByTask" />
      </div>
      <div id="ByEncounter" style="display:none;">
        <xsl:apply-templates select="." mode="ByEncounter" />
      </div>

      <br />
      <hr />
      <xsl:apply-templates select="../EventResearch" />
    </div>
  </xsl:template>

  <!-- Template to write the Key for the Field Reserch table. -->
  <xsl:template name="CreateKey">
    <h3>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'POKEMON_IMAGE_KEY'" />
      </xsl:call-template>
      <xsl:text>Key</xsl:text>
    </h3>
    <br />
    <xsl:call-template name="PokemonImageKey" />
  </xsl:template>

  <!-- Template to write the Field Research Selection/ListBy Criteria. -->
  <xsl:template name="CreateCriteria">
    <h3>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'FIELD_RESEARCH_CRITERIA'" />
      </xsl:call-template>
      <xsl:text>Criteria</xsl:text>
    </h3>
    <br />
    <div id="FIELD_RESEARCH_CRITERIA">
      <!-- TODO QZX
        <xsl:call-template name="OutputGenerationSelection">
          <xsl:with-param name="Settings">
            <Show hide_slider="true" released_only="true" />
          </xsl:with-param>
          <xsl:with-param name="CallbackName" select="'OnCriteriaChanged'" />
        </xsl:call-template>
        <br />
    -->
      <table border="1" class="CRITERIA_TABLE">
        <tr>
          <td>
            <xsl:call-template name="OutputSliderButtonControl">
              <xsl:with-param name="Id" select="'FieldResearch_Slider_OrderBy'" />
              <xsl:with-param name="Callback" select="'ToggleChart(this)'" />
              <xsl:with-param name="Title" select="'Look up by:'" />
              <xsl:with-param name="OffLabel" select="'Task'" />
              <xsl:with-param name="OnLabel" select="'Encounter'" />
              <xsl:with-param name="Help">
                <table style="width:20em;">
                  <tr>
                    <th width="1px;">Task</th>
                    <td>Put the Tasks in the first column, then show all the Encounters for that task.</td>
                  </tr>
                  <tr>
                    <th>Encounter</th>
                    <td>Put the potential Encounters in the first column, then show all the Tasks that can give that Encounter.</td>
                  </tr>
                </table>
              </xsl:with-param>
            </xsl:call-template>
          </td>
        </tr>
      </table>
    </div>
  </xsl:template>

  <!-- #region Templates to output the Field Research tables by Task -->

  <xsl:template match="FieldResearch" mode="ByTask">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'STANDARD_RESEARCH_TASKS'" />
      </xsl:call-template>
      <xsl:text>Standard Research Tasks</xsl:text>
    </h2>
    <div id="STANDARD_RESEARCH_TASKS" class="INDENT">
      <p>
        This is a set of Research Tasks and Encounters that don't change much.
      </p>
      <xsl:apply-templates select="Category" />
    </div>
  </xsl:template>

  <xsl:template match="Event">
    <h3>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('EVENT_', @name)" />
      </xsl:call-template>
      <xsl:value-of select="@name" disable-output-escaping="yes" />
      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <span class="NOTE">
        <xsl:text>(</xsl:text>
        <xsl:value-of select="@startdate" />
        <xsl:text> - </xsl:text>
        <xsl:value-of select="@enddate" />
        <xsl:text>)</xsl:text>
      </span>
    </h3>
    <div style="margin-top:.5em;" class="INDENT">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('EVENT_', @name)" />
      </xsl:attribute>
      <table border="1">
        <tr>
          <th>Task</th>
          <th>Encounters</th>
        </tr>
        <xsl:apply-templates select="Research[Pokemon]">
          <xsl:with-param name="isEvent" select="'true'" />
        </xsl:apply-templates>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="Category">
    <h3>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('CATEGORY_', @type)" />
      </xsl:call-template>
      <xsl:value-of select="@type" />
    </h3>
    <div style="margin-top:.5em;" class="INDENT">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('CATEGORY_', @type)" />
      </xsl:attribute>
      <table border="1">
        <tr>
          <th>Task</th>
          <th>Encounters</th>
        </tr>
        <xsl:apply-templates select="Research[Pokemon/@current]" />
      </table>
    </div>
  </xsl:template>

  <xsl:template match="Research">
    <xsl:param name="isEvent" />
    <tr>
      <td>
        <xsl:value-of select="@task" disable-output-escaping="yes" />
      </td>
      <td style="white-space:nowrap">
        <xsl:choose>
          <xsl:when test="$isEvent">
            <xsl:apply-templates select="Pokemon" mode="ByTask" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="Pokemon[@current]" mode="ByTask" />
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="Pokemon" mode="ByTask">
    <xsl:variable name="name" select="@name" />
    <xsl:variable name="form" select="@form" />
    <div style="display:inline-block; border:1px solid black; margin:4px">
      <!-- TODO QZX: Figure out how to avoid this crap. -->
      <xsl:apply-templates select=".">
        <xsl:with-param name="Settings">
          <Show hide_type_icons="true" hide_special_icons="true">
            <xsl:attribute name="href">
              <xsl:value-of select="concat('encounter/encounter.', pokeref:ToLower($name), '.html')" />
            </xsl:attribute>
          </Show>
        </xsl:with-param>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <!-- #endregion Templates to output the Field Research tables by Task -->

  <!-- #region Templates to output the Field Research tables by Encounter -->

  <xsl:template match="FieldResearch" mode="ByEncounter">
    <!-- TODO QZX: Divide this into generations. -->
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('SECTION_', 'GEN_ALL')" />
      </xsl:call-template>
      <xsl:value-of select="'Encounters'" />
    </h2>
    <div style="margin-top:.5em;">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('SECTION_', 'GEN_ALL')" />
      </xsl:attribute>
      <table border="1">
        <tr>
          <th>Encounters</th>
          <th>Task</th>
        </tr>
        <xsl:apply-templates select="Category/Research[@current]/Pokemon[not(@id=preceding::Research/Pokemon/@id)]" mode="ByEncounter">
          <xsl:sort order="ascending" data-type="number" select="@id" />
        </xsl:apply-templates>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="Pokemon" mode="ByEncounter">
    <xsl:variable name="name" select="@name" />
    <xsl:variable name="id" select="@id" />

    <tr>
      <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name = $name and not(@form)]" mode="Cell">
        <xsl:with-param name="Settings">
          <Show hide_type_icons="true" hide_special_icons="true">
            <xsl:attribute name="href">
              <xsl:value-of select="concat('encounter/encounter.', pokeref:ToLower($name), '.html')" />
            </xsl:attribute>
          </Show>
        </xsl:with-param>
      </xsl:apply-templates>
      <td>
        <xsl:for-each select="../../../Category/Research[Pokemon/@id=$id]">
          <xsl:variable name="task" select="@task" />
          <xsl:value-of select="$task" disable-output-escaping="yes" />
          <xsl:variable name="count" select="count(../../Category/Research[@task=$task]/Pokemon)" />
          <xsl:if test="$count != 1">
            <span class="EMPHASIS">
              <xsl:value-of select="concat($nbsp, '(1', $nbsp, 'of', $nbsp, $count, $nbsp, 'possibilities)')" disable-output-escaping="yes" />
            </span>
          </xsl:if>
          <br />
        </xsl:for-each>
      </td>
    </tr>
  </xsl:template>

  <!-- #endregion Templates to output the Field Research tables by Encounter -->

  <!-- #endregion Field Research -->

</xsl:stylesheet>
