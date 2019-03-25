<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <!-- Main Template -->
  <xsl:template match="/Root">
    <xsl:variable name="event" select="params/@event" />

    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
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
          Special Research:
          <xsl:value-of select="$event"/>
        </title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Special Research:
          <xsl:value-of select="$event"/>
        </h1>
        <p>
          <span class="TODO QZX">Under Construction</span>
        </p>

        <br />
        <hr />
        <xsl:apply-templates select="SpecialResearch/Event[@name=$event]" />

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!-- Template to create an Event -->
  <xsl:template match="Event">
    <xsl:apply-templates select="Stage" />
  </xsl:template>

  <xsl:template match="Stage">
    <h3>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('STAGE_', @stage)" />
      </xsl:call-template>
      <xsl:value-of select="concat(../@name, $nbsp, '(', @stage, '/', count(../Stage), ')')" disable-output-escaping="yes" />
    </h3>
    <div class="INDENT">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('STAGE_', @stage)" />
      </xsl:attribute>
      <table border="1">
        <xsl:apply-templates select="Research" />
        <xsl:apply-templates select="Rewards" />
      </table>
    </div>
  </xsl:template>

  <xsl:template match="Research">
    <tr>
      <td>
        <xsl:value-of select="@task" />
      </td>
      <xsl:apply-templates select="*" mode="Reward" />
    </tr>
  </xsl:template>

  <xsl:template match="Rewards">
    <tr>
      <td colspan="2">
        <table width="100%">
          <tr>
            <xsl:apply-templates select="*" mode="Reward" />
          </tr>
        </table>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="Item" mode="Reward">
    <td align="center">
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="@id" />
      </xsl:call-template>
      <br />
      <xsl:value-of select="concat($times, @amount)" disable-output-escaping="yes"/>
    </td>
  </xsl:template>

  <xsl:template match="Pokemon" mode="Reward">
    <xsl:variable name="name" select="@name" />

    <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name = $name]" mode="Cell">
      <xsl:with-param name="Settings">
        <Show hide_type_icons="true" hide_special_icons="true">
          <xsl:attribute name="href">
            <xsl:value-of select="concat('encounter/encounter.', pokeref:ToLower($name), '.html')" />
          </xsl:attribute>
        </Show>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

</xsl:stylesheet>