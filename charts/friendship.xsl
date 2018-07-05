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

        <title>Friends</title>
      </head>
      <body>

        <h1>
          <xsl:call-template name="HomePageLink" />
          Friends
        </h1>
        <p>
          The ability have "Friends" has been added to Pokemon GO.
        </p>
        <p>
          Being Friends with another Trainer allows
        </p>

        <br />
        <hr />
        <xsl:call-template name="Friendship" />

        <br />
        <hr />
        <xsl:call-template name="Trading" />

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="Friendship">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'FRIENDSHIP'" />
      </xsl:call-template>
      Friendship
    </h2>
    <div id="FRIENDSHIP">
      <p>
        TODO
      </p>
      TODO
    </div>
  </xsl:template>

  <xsl:template name="Trading">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'TRADING'" />
      </xsl:call-template>
      Trading
    </h2>
    <div id="TRADING">
      <p>
        You are allowed to trade Pokemon with your Friends.
        <br />But, as with most things, there is a cost!
      </p>
      <p>
        In this case, trades cost the Trainers Stardust.
        In theory <span class="NOTE">(There is a bug right now.)</span> it costs both Trainers the same amount.
        <br />
        But the amount of Stardust depends upon the Trainers' Friendship level and what is being traded.
      </p>

      <div class="INDENT">
        <xsl:call-template name="CreateKey_Cost" />

        <br />
        <table border="1" style="white-space:nowrap">
          <xsl:call-template name="CreateTableHeaders_Cost" />
          <xsl:apply-templates select="Friends/Friendship" mode="Trading">
            <xsl:sort data-type="number" order="ascending" select="level"/>
          </xsl:apply-templates>
        </table>
      </div>
    </div>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateKey_Cost">
    <h3>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'COST_KEY'" />
      </xsl:call-template>
      <xsl:text>Key</xsl:text>
    </h3>
    <div id="COST_KEY" class="FLOWING_TABLE_WRAPPER">
      <table class="KEY_TABLE" border="1">
        <tr>
          <th>Term</th>
          <th>Description</th>
        </tr>
        <tr>
          <th>Caught</th>
          <td>Pokemon that have previously been caught by the Trainer and are registered in the their Pokedex.</td>
        </tr>
        <tr>
          <th>Uncaught</th>
          <td>
            Pokemon that have <span class="EMPHISIS">NOT</span> been caught by the Trainer and therefore are not registered in their Pokedex.
          </td>
        </tr>
        <xsl:for-each select="/Root/Friends/Trading/*">
          <tr>
            <th>
              <xsl:value-of select="name(.)"/>
            </th>
            <td>
              <xsl:value-of select="@description"/>
            </td>
          </tr>
        </xsl:for-each>
      </table>
    </div>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders_Cost">
    <xsl:variable name="rows" select="count(/Root/Friends/Trading/*) + 2" />

    <tr>
      <th rowspan="2" class="UNUSED" />
      <xsl:for-each select="/Root/Friends/Trading/*">
        <td style="padding:0; margin:0;">
          <xsl:attribute name="rowspan">
            <xsl:value-of select="$rows" />
          </xsl:attribute>
        </td>
        <th colspan="2">
          <xsl:value-of select="name(.)" />
        </th>
      </xsl:for-each>
    </tr>
    <tr>
      <xsl:for-each select="/Root/Friends/Trading/*">
        <th>Caught</th>
        <th>Uncaught</th>
      </xsl:for-each>
    </tr>
  </xsl:template>

  <!-- Template to create a table row for a Move Type -->
  <xsl:template match="Friendship" mode="Trading">
    <tr>
      <th align="left">
        <xsl:value-of select="@text" />
      </th>
      <xsl:apply-templates select="Bonus" mode="StardustCosts" />
    </tr>
  </xsl:template>

  <xsl:template match="Bonus" mode="StardustCosts">
    <xsl:variable name="bonus" select="." />
    <xsl:variable name="discount" select="@trade_discount" />

    <xsl:for-each select="/Root/Friends/Trading/*">
      <xsl:variable name="type" select="name(.)" />

      <td align="right">
        <xsl:choose>
          <xsl:when test="not(@amount_caught) or $bonus/Trade[@type=$type]/@enabled = 'false'">
            <xsl:attribute name="class">UNUSED</xsl:attribute>
            <xsl:attribute name="align">center</xsl:attribute>
            <span class="EMPHASIS NOTE">N/A</span>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="format-number(@amount_caught * (100 - $discount) div 100, '#,###,###')" />
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td align="right">
        <xsl:choose>
          <xsl:when test="not(@amount_uncaught) or $bonus/Trade[@type=$type]/@enabled = 'false'">
            <xsl:attribute name="class">UNUSED</xsl:attribute>
            <xsl:attribute name="align">center</xsl:attribute>
            <span class="EMPHASIS NOTE">N/A</span>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="format-number(@amount_uncaught * (100 - $discount) div 100, '#,###,###')" />
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>