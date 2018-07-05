<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <!-- Main Template -->
  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

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

        <title>Trading</title>
      </head>
      <body>

        <h1>
          <xsl:call-template name="HomePageLink" />
          Trading
        </h1>
        <p>
          TODO QZX
        </p>

        <table border="1" style="white-space:nowrap">
          <xsl:call-template name="CreateTableHeaders" />
          <xsl:apply-templates select="Trading/Friendship">
            <xsl:sort data-type="number" order="ascending" select="level"/>
          </xsl:apply-templates>
        </table>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <tr>
      <th />
      <th colspan="2">Regular</th>
      <th colspan="2">Regional</th>
      <th colspan="2">Shiny</th>
      <th colspan="2">Legendary</th>
      <th colspan="2">Mythic</th>
    </tr>
    <tr>
      <th />
      <th>Caught</th>
      <th>Not Caught</th>
      <th>Caught</th>
      <th>Not Caught</th>
      <th>Caught</th>
      <th>Not Caught</th>
      <th>Caught</th>
      <th>Not Caught</th>
      <th>Caught</th>
      <th>Not Caught</th>
      <th>Caught</th>
      <th>Not Caught</th>
    </tr>
  </xsl:template>

  <!-- Template to create a table row for a Move Type -->
  <xsl:template match="Friendship">
    <tr>
      <th>QZX Level</th>
      <xsl:apply-templates select="Cost[@type = 'Regular']" />
      <xsl:apply-templates select="Cost[@type = 'Regional']" />
      <xsl:apply-templates select="Cost[@type = 'Shiny']" />
      <xsl:apply-templates select="Cost[@type = 'Legendary']" />
      <xsl:apply-templates select="Cost[@type = 'Mythic']" />
    </tr>
  </xsl:template>

  <xsl:template match="Cost">
    <td>
      <xsl:choose>
        <xsl:when test="not(@amount_caught)">
          <xsl:attribute name="class">UNUSED</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@amount_caught" />
        </xsl:otherwise>
      </xsl:choose>
    </td>
    <td>
      <xsl:choose>
        <xsl:when test="not(@amount_uncaught)">
          <xsl:attribute name="class">UNUSED</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@amount_uncaught" />
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>

</xsl:stylesheet>