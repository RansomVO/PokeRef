<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="/xsl/global.xsl"/>

  <!-- Main Template -->
  <xsl:template match="Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

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

        <title>GAME_MASTER Archive</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          GAME_MASTER Archive
        </h1>
        <p>
          There is a file called the GAME_MASTER that contains statistics regarding just about everything in the game.
          <br />
          This file is updated on a semi-regular basis on the Niantic servers and Pokemon GO downloads it.
          <br />
          It is encoded in a format called "protobuf" to make downloading faster, but there are utilities that will decode it and convert it into a format called JSON.
          JSON is a format that is easily read by computer code.
          It can even make sense to a human.
          (If you are a little geeky.)
        </p>
        <p>
          Originally I searched the internet to get my hands on as many of the historical GAME_MASTER files as possible.
          In some cases I found JSON versions but not the original.
          And frequently those were in a slightly invalid format, so I reformatted them.
          <br />
          Lately I have been copying them from my Android device as there are changes.
        </p>
        <p>
          In the end, I convert what I have to JSON, then use that to generate the data published in these pages.
          <br />Feel free to download what you want by clicking on the links in the table below.
        </p>
        <div class="INDENT">
          <p class="NOTE PARENT">
            <b>NOTE</b>: If you have a GAME_MASTER file I am missing, or know where I can get it, please let me know.
          </p>
          <div class="INDENT">
            <script>WriteContactInfo();</script>
          </div>
        </div>

        <br />
        <br />
        <table border="1">
          <xsl:call-template name="CreateTableHeaders" />
          <xsl:apply-templates select="GAME_MASTERS/GAME_MASTER">
            <xsl:sort select="TimeStamp_DEC" order="descending" />
          </xsl:apply-templates>
        </table>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <!-- Template to create the headers for the table -->
  <xsl:template name="CreateTableHeaders">
    <tr style="font-size:x-large;">
      <th>
        Time Stamp<br />(UTC)
      </th>
      <th>
        Protobuf<br />GAME_MASTER
      </th>
      <th>
        JSON<br />GAME_MASTER
      </th>
    </tr>
  </xsl:template>

  <!-- Template to create row for a GAME_MASTER. -->
  <xsl:template match="GAME_MASTER">
    <tr align="left" style="border-top-width:5px">
      <td>
        <code>
          <xsl:value-of select="TimeStamp" />
        </code>
      </td>
      <td>
        <xsl:choose>
          <xsl:when test="FileName != ''">
            <a>
              <xsl:attribute name="download" />
              <xsl:attribute name="href">
                <xsl:value-of select="FileName" />
              </xsl:attribute>
              <code>
                <xsl:value-of select="FileName" />
              </code>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">
              <xsl:value-of select="UNUSED" />
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <td>
        <a>
          <xsl:attribute name="download" />
          <xsl:attribute name="href">
            <xsl:value-of select="FileNameJSON" />
          </xsl:attribute>
          <code>
            <xsl:value-of select="FileNameJSON" />
          </code>
        </a>
      </td>
    </tr>
  </xsl:template>


</xsl:stylesheet>