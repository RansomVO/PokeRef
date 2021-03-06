﻿<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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

        <title>
          <xsl:value-of select="Moves/@category" /> Moves
        </title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          <xsl:value-of select="Moves/@category" /> Moves
        </h1>

        <p>
          This chart lists the info for all of the <xsl:value-of select="Moves/Category" /> Moves for Pokemon.
        </p>
        <div class="INDENT">
          <p class="PARENT">
            Here is what is in each column:
          </p>
          <ul class="CHILD">
            <li>
              <b>Move Name</b>: The name of the move. <span class="NOTE">(Duh!)</span>
            </li>
            <li>
              <b>Type</b>: The type of the Move. <span class="NOTE">
                (This is used to determine the Effectiveness of the Move against a Defending Pokemon.)
              </span>
            </li>
            <li>
              <b>Energy</b>
              <xsl:text>: The amount of energy </xsl:text>
              <xsl:choose>
                <xsl:when test="Moves/Category = 'Charged'">
                  <xsl:text>required to perform the Move.</xsl:text>
                  <span class="NOTE"> (The '-' indicates it is using Energy instead of creating it.)</span>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>generated by performing the Move.</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </li>
            <li>
              <b>Power</b>: The amount of damage caused by the Move.
            </li>
            <li>
              <b>Time</b>: The amount of time <span class="NOTE">(in seconds)</span> it takes to perform Move.
            </li>
          </ul>
          <p>
            More info about the use of these values can be found in <a href="/charts/effectiveness.html">Move Effectiveness</a> or <a href="/tech/formulas/movesetdamage.html">Move Set Damage Formulas</a> pages.
            <br />Also see
            <xsl:choose>
              <xsl:when test="Moves/@category = 'Charged'">
                <a href="moves.fast.html">Fast Moves</a>
              </xsl:when>
              <xsl:otherwise>
                <a href="moves.charged.html">Charged Moves</a>
              </xsl:otherwise>
            </xsl:choose>.
          </p>
          <div class="INDENT CHILD NOTE">
            <p class="PARENT">
              <b>NOTE</b>: These are the values necessary to calculate the DPS of <a href="/charts/movesets/">Move Sets</a>.
            </p>
          </div>
        </div>

        <br />
        <table border="1">
          <xsl:call-template name="CreateTableHeaders" />
          <xsl:apply-templates select="Moves/Move">
            <xsl:sort select="@name" data-type="text" order="ascending" />
          </xsl:apply-templates>
        </table>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <tr style="font-size:x-large;">
      <th>Move Name</th>
      <th>Type</th>
      <th>Boost</th>
      <th>Energy</th>
      <th>Power</th>
      <th>Time</th>
    </tr>
  </xsl:template>

  <xsl:template match="Move">
    <xsl:variable name="Type" select="@type" />
    <tr>
      <th align="left">
        <xsl:value-of select="@name" />
      </th>
      <td align="left">
        <xsl:call-template name="OutputTypeIcon">
          <xsl:with-param name="Type" select="$Type" />
        </xsl:call-template>
        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
        <xsl:value-of select="$Type" />
      </td>
      <td>
        <xsl:call-template name="OutputWeatherBoostIcon">
          <xsl:with-param name="Type" select="$Type" />
        </xsl:call-template>
        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
        <xsl:value-of select="/Root/Constants/Mappings/WeatherBoost[@type=$Type]/@boost" />
      </td>
      <td align="right">
        <xsl:value-of select="@energy" />
      </td>
      <td align="right">
        <xsl:value-of select="@power" />
      </td>
      <td align="right">
        <xsl:value-of select="format-number(@duration, '0.0')" />
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>