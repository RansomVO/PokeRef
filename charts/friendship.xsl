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
          Being Friends with another Trainer provides benefits such as being able to swap gifts, trade Pokemon, etc.
        </p>
        <p>
          This page tells you about how to become Friends, and what advantages you can get by being Friends.
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

  <!-- #region Templates for creating Friendship Section -->

  <xsl:template name="Friendship">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'FRIENDSHIP'" />
      </xsl:call-template>
      Friendship
    </h2>
    <div id="FRIENDSHIP">
      <p>
        To become friends <span class ="TODO QZX">... TODO</span>
      </p>
      <p>
        Friendship levels increase when you interact in certains ways:
        <ul>
          <li>
            Open gifts <span class ="TODO QZX">... TODO</span>
          </li>
          <li>
            Battle <span class ="TODO QZX">... TODO</span>
          </li>
          <li>
            Trade Pokemon <span class ="TODO QZX">... TODO</span>
          </li>
        </ul>
      </p>

      <div class="INDENT">
        <xsl:call-template name="CreateKey_Friendship" />

        <br />
        <table border="1" style="white-space:nowrap">
          <xsl:call-template name="CreateTableHeaders_Friendship" />
          <xsl:apply-templates select="Friends/Friendship" mode="Friendship">
            <xsl:sort data-type="number" order="ascending" select="level"/>
          </xsl:apply-templates>
        </table>
      </div>
    </div>
  </xsl:template>

  <!-- Template to create the Key for the table -->
  <xsl:template name="CreateKey_Friendship">
    <h3>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'FRIENDSHIP_KEY'" />
      </xsl:call-template>
      <xsl:text>Key</xsl:text>
    </h3>
    <div id="FRIENDSHIP_KEY" class="FLOWING_TABLE_WRAPPER">
      <table class="KEY_TABLE" border="1">
        <tr>
          <th>Term</th>
          <th>Description</th>
        </tr>
        <tr>
          <th align="left">Days</th>
          <td>The number of days you must interact with your Friend in order to reach the level</td>
        </tr>
        <tr>
          <th align="left">Raid Bonus</th>
          <td>The number of extra balls you will get when you defeat a Raid Boss with your Friend</td>
        </tr>
        <tr>
          <th align="left">Gym Bonus</th>
          <td>The amount of Bonus damage you inflict when you are battling a Gym with your Friend</td>
        </tr>
        <tr>
          <th align="left">Trade Discount</th>
          <td>
            The Discount on the amount of Stardust it takes to perform a Trade with your Friend
            <br /><span class="NOTE">(See table below for resulting amounts.)</span>
          </td>
        </tr>
      </table>
    </div>
  </xsl:template>

  <!-- Template to create the Headers for the table -->
  <xsl:template name="CreateTableHeaders_Friendship">
    <tr>
      <th rowspan="2" class="UNUSED" />
      <th rowspan="2" valign="bottom">Days</th>
      <th colspan="3">Bonuses</th>
    </tr>
    <tr>
      <th>Raid Bonus</th>
      <th>Gym Bonus</th>
      <th>Trade Discount</th>
    </tr>
  </xsl:template>

  <!-- Template to create a table row for Friendship information. -->
  <xsl:template match="Friendship" mode="Friendship">
    <tr>
      <th align="left">
        <xsl:value-of select="@text" />
      </th>
      <td align="right">
        <xsl:value-of select="@days" />
      </td>
      <td align="right">
        +<xsl:value-of select="Bonus/@raid_balls" />
      </td>
      <td align="right">
        <xsl:value-of select="Bonus/@gym_attack" />%
      </td>
      <td align="right">
        <xsl:value-of select="Bonus/@trade_discount" />%
      </td>
    </tr>
  </xsl:template>

  <!-- #endregion Templates for creating Friendship Section -->

  <!-- #region Templates for creating Trading Section -->

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
        In theory <span class="NOTE">(there is a bug right now)</span> it costs both Trainers the same amount.
        <br />But the amount of Stardust depends upon the Trainers' Friendship level and what is being traded.
        In cases where the Pokemon fall into different categories, both Trainers are stuck with the highest of the two costs.
      </p>
      <p>
        Also, be aware that when Friends trade Pokemon, the IV Score for the Pokemon will be "re-rolled".
        It may be better, or worse.
        <span class="NOTE">(Details are not firm yet about the limits of the re-roll.)</span>
        <!-- TODO QZX: Add this when we have the details added to the Friendship chart.
          See the Friendship chart above for values. 
        -->
      </p>

      <div class="INDENT">
        <xsl:call-template name="CreateKey_Trading" />

        <br />
        <table border="1" style="white-space:nowrap">
          <xsl:call-template name="CreateTableHeaders_Trading" />
          <xsl:apply-templates select="Friends/Friendship" mode="Trading">
            <xsl:sort data-type="number" order="ascending" select="level"/>
          </xsl:apply-templates>
        </table>
      </div>
    </div>
  </xsl:template>

  <!-- Template to create the Key for the table -->
  <xsl:template name="CreateKey_Trading">
    <h3>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'TRADING_KEY'" />
      </xsl:call-template>
      <xsl:text>Key</xsl:text>
    </h3>
    <div id="TRADING_KEY" class="FLOWING_TABLE_WRAPPER">
      <table class="KEY_TABLE" border="1">
        <tr>
          <th>Term</th>
          <th>Description</th>
        </tr>
        <tr>
          <th align="left">Caught</th>
          <td>Pokemon that have previously been caught by the Trainer and are registered in the their Pokedex.</td>
        </tr>
        <tr>
          <th align="left">Uncaught</th>
          <td>
            Pokemon that have <span class="EMPHISIS">NOT</span> been caught by the Trainer and therefore are not registered in their Pokedex.
          </td>
        </tr>
        <xsl:for-each select="/Root/Friends/Trading/*">
          <tr>
            <th align="left">
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

  <!-- Template to create the Headers for the table -->
  <xsl:template name="CreateTableHeaders_Trading">
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

  <!-- Template to create a table row for a Trade -->
  <xsl:template match="Friendship" mode="Trading">
    <tr>
      <th align="left">
        <xsl:value-of select="@text" />
      </th>
      <xsl:apply-templates select="Bonus" mode="StardustCosts" />
    </tr>
  </xsl:template>

  <!-- Template to output cells for the Stardust costs for a Trade -->
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

  <!-- #endregion Templates for creating Trading Section -->

</xsl:stylesheet>