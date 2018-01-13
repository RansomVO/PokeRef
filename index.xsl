<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl"/>

  <xsl:template match="Root">
    <html lang="en-us" manifest="/pokeref.appcache">
      <head>
        <!-- This is to make the font size consistent on mobile. -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/global.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <link type="text/css" rel="stylesheet" >
          <xsl:attribute name="href">
            <xsl:text>local.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </link>

        <title>Pokemon Reference</title>
      </head>
      <body>
        <h1>
          <img src="images/logo.png" />
          <xsl:text> Pokemon Reference</xsl:text>
        </h1>
        <img class="FLOAT_RIGHT" style="width:45%; min-width:200px; margin-top:1em;" src="/images/NotJustAGame.png" />
        <p>
          Since I began playing Pokemon GO, I have learned a lot.
          I began making charts and spreadsheets as reference materials to help me keep track of what I wanted to know about Pokemon.
          This site is to make it so I (and others) can get quick access to this info.
        </p>

        <!-- Other top level content to go here. -->

        <!-- Add a box here with the latest news. -->
        <xsl:apply-templates select="News" />

        <h2 id="Sections">
          <u>Sections</u>
          <xsl:text> </xsl:text>
          <button id="SECTIONS_COLLAPSER" />
        </h2>
        <div id="SECTIONS">
          <p>
            I have tried to organize this site into sections to help you be able to find what you want a little quicker.
          </p>
          <table style="border:0px; border-collapse:collapse; border-spacing:0px;">
            <xsl:variable name="Sections">
              <Section>
                <Color>D5D5F5</Color>
                <Title>Tools</Title>
                <HRef>tools/</HRef>
                <Text>
                  There are a lot of places to get generic information about all sorts of stuff in Pokemon GO.
                  But what if you want to focus on stuff that is specific to <i>you</i>?
                  <br />This sections has some tools that could be helpful.
                </Text>
              </Section>
              <Section>
                <Color>FDC1C0</Color>
                <HRef>charts/</HRef>
                <Title>Charts</Title>
                <Text>
                  Everybody loves charts for quickly looking things up.
                  Like possible IVs for a Raid Bosses or the effectiveness of different Move Sets.
                  <br />All that and more can be found in this section.
                </Text>
              </Section>
              <Section>
                <Color>FFEEB8</Color>
                <HRef>resources/</HRef>
                <Title>Pokemon Resources</Title>
                <Text>
                  There are a lot of web sites, chat groups, reference data, etc. that provide a lot of resources.
                  <br />Here are a bunch of places that you could find useful.
                </Text>
              </Section>
              <Section>
                <Color>CBEBF2</Color>
                <Title>Technical Reference</Title>
                <HRef>tech/</HRef>
                <Text>
                  There are a lot of technical things under the covers of Pokemon GO.
                  <br />This section contains gory details about how things work, including the GAME_MASTER information.
                </Text>
              </Section>
            </xsl:variable>
            <xsl:apply-templates select="exslt:node-set($Sections)/Section" />
          </table>
        </div>

        <br />
        <hr />
        <h2 id="QuickAccess">
          <u>Quick Access</u>
          <xsl:text> </xsl:text>
          <button id="QUICK_ACCESS_COLLAPSER" />
        </h2>
        <div id="QUICK_ACCESS">
          <p>
            Several pages are accessed more frequently than others.
            <br />I have collected links to those pages here so you don't have to go searching.
          </p>
          <div class="INDENT">
            <div class="SECTION">
              <h2 id="RaidBosses">
                <a href="charts/raidboss">Possible IVs for Raid Bosses</a>
                <xsl:text> </xsl:text>
                <button id="RAID_BOSSES_COLLAPSER" />
              </h2>
              <div id="RAID_BOSSES">
                <p>
                  After you defeat a Raid Boss in a Raid, it is time to try to catch him.
                  But how good is he?
                </p>
                <p class="PARENT">
                  If you look at the CP of the Raid Boss, you can figure out what possible IVs it may have.
                  <br />Click on any of the Raid Bosses below to see a chart of the possibilities.
                </p>
                <div class="CHILD">
                  <script>InsertURL('charts/raidboss/_linkslist.html')</script>
                </div>
              </div>
            </div>

            <h2 id="Evolutions">
              <a href="tools/evolutions.html">Evolutions Chart</a>
            </h2>
            <div>
              <p>
                One of the fun parts of Pokemon GO is Evolving.
                But what can turn into what?
                <br />This chart can help.
              </p>
            </div>

            <h2 id="Movesets">
              <a href="charts/movesets/">Pokemon Move Sets</a>
            </h2>
            <div>
              <p class="PARENT">
                Each type of Pokemon has a set of "Fast" Moves and "Charged" moves that they may have.
                Then each individual Pokemon has only one combination.
                Of course, some moves are more effective than others.
                <br />These pages shows a list of each possible combination for each type of Pokemon, which then tells how much damage it will do.
              </p>
              <div class="CHILD">
                <script>InsertURL('charts/movesets/_linkslist.html')</script>
              </div>
            </div>

            <h2 id="GameMaster">
              <a href="tech/GAME_MASTER">GAME_MASTER</a>
            </h2>
            <div>
              <p>
                There is a file called the GAME_MASTER that contains statistics regarding just about everything in the game.
                <br />I use the data in them to generate various tables, etc.
              </p>
              <div class="INDENT">
                <h2 id="PokeStats">
                  <a href="tech/GAME_MASTER/pokestats/">Pokemon Stats</a>
                </h2>
                <div>
                  <p class="PARENT">
                    Each Pokemon has a bunch of statistics associated with them. Candies, Types, Gender Ratios, and a whole lot more.
                    <br />I have created charts containing what I consider to be the important info for each generation of Pokemon:
                  </p>
                  <div class="CHILD">
                    <script>InsertURL('tech/GAME_MASTER/pokestats/_linkslist.html')</script>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="News">
    <script type="text/javascript">
      <![CDATA[
        if (IsMobile()) {
          document.write('<br class="FLOAT_END" /><hr /><div class="NEWS_BOX">');
        } else {
          document.write('<hr /><div class="NEWS_BOX" style="width:45%;">');
        }
      ]]>
    </script>
    <h2 id="News" class="NEWS_TITLE">
      <xsl:text>Latest News! </xsl:text>
      <button id="NEWS_COLLAPSER" />
    </h2>
    <div id="NEWS" class="NEWS">
      <xsl:apply-templates select="Article" />
    </div>
    <xsl:value-of select="concat($lt, '/div', $gt)" disable-output-escaping="yes" />

    <br class="FLOAT_END" />
    <hr />
  </xsl:template>

  <xsl:template match="Article">
    <xsl:if test="position() != 1">
      <hr />
    </xsl:if>
    <h2 class="NEWS_HEADLINE">
      <xsl:copy-of select="Title/node()" />
      <span class="NOTE">
        <xsl:text> (</xsl:text>
        <xsl:value-of select="pokeref:Replace(@date, ' ', $nbsp)" disable-output-escaping="yes" />
        <xsl:text>)</xsl:text>
      </span>
    </h2>
    <p>
      <xsl:copy-of select="Text/node()" />
    </p>
    <xsl:if test="Note != ''">
      <p class="NOTE">
        <xsl:copy-of select="Note/node()" />
      </p>
    </xsl:if>
  </xsl:template>

  <xsl:template match="Section">
    <xsl:if test="position() mod 2 != 0">
      <xsl:value-of select="concat($lt, 'tr', $gt)" disable-output-escaping="yes" />
    </xsl:if>

    <td comment="Tools" class="CELL_FILLED" width="50%">
      <xsl:attribute name="style">
        <xsl:text>font-weight:bold; background-color:#</xsl:text>
        <xsl:value-of select="Color" />
        <xsl:text>; </xsl:text>
      </xsl:attribute>
      <a class="CELL_FILLER">
        <xsl:attribute name="href">
          <xsl:value-of select="HRef" />
        </xsl:attribute>
        <div>
          <xsl:attribute name="style">
            <xsl:text>padding:.1em; text-align:center; border:.4em outset #</xsl:text>
            <xsl:value-of select="pokeref:GetBorderColor(Color)" />
            <xsl:text>; </xsl:text>
          </xsl:attribute>
          <span class="SECTION_TITLE">
            <xsl:value-of select="Title" />
          </span>
          <p>
            <xsl:value-of select="Text" />
          </p>
        </div>
      </a>
    </td>

    <xsl:if test="position() mod 2 = 0">
      <xsl:value-of select="concat($lt, '/tr', $gt)" disable-output-escaping="yes" />
    </xsl:if>

  </xsl:template>

  <!-- Local functions (C#)  -->
  <msxsl:script language="C#" implements-prefix="pokeref">
    <![CDATA[  
      // Method to determine what color should be specified for an "outset" border.
      public string GetBorderColor(string color)
      {
        return Math.Min(int.Parse(color.Substring(0, 2), System.Globalization.NumberStyles.HexNumber) + 0x10, 0xFF).ToString("X")
            + Math.Min(int.Parse(color.Substring(2, 2), System.Globalization.NumberStyles.HexNumber) + 0x10, 0xFF).ToString("X")
            + Math.Min(int.Parse(color.Substring(4, 2), System.Globalization.NumberStyles.HexNumber) + 0x10, 0xFF).ToString("X");
      }
    ]]>
  </msxsl:script>

</xsl:stylesheet>