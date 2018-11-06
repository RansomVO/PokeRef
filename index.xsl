<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:output method="html" encoding="utf-8" omit-xml-declaration="yes" standalone="no" indent="yes" />
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html lang="en-us" manifest="/pokeref.appcache">
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
            <xsl:text>local.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </link>

        <title>PokeRef - The Pokemon Reference</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="Logo" />
          <xsl:text> PokeRef - The Pokemon Reference</xsl:text>
        </h1>
        <img class="FLOAT_RIGHT" style="width:45%; min-width:200px; margin-top:1em;" src="/images/humor/NotJustAGame.png" />
        <p>
          Since I began playing Pokemon GO, I have learned a lot.
          I began making charts and spreadsheets as reference materials to help me keep track of what I wanted to know about Pokemon.
          This site is to make it so I (and others) can get quick access to this info.
        </p>

        <!-- Other top level content to go here. -->

        <!-- Add a box here with the latest news. -->
        <xsl:apply-templates select="News" />

        <h2 id="anchor_sections">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'HOME_SECTIONS'" />
          </xsl:call-template>
          <u>Sections</u>
        </h2>
        <div id="HOME_SECTIONS">
          <p>
            I have tried to organize this site into sections to help you be able to find what you want a little quicker.
          </p>
          <table style="border:0px; border-collapse:collapse; border-spacing:0px;">
            <xsl:variable name="Sections">
              <Section>
                <Color>D5D5F5</Color>
                <HRef>charts/</HRef>
                <Title>Charts</Title>
                <Text>
                  Everybody loves charts for quickly looking things up.
                  Like possible IVs for a Raid Bosses or the effectiveness of different Move Sets.
                  <br />All that and more can be found in this section.
                </Text>
              </Section>
              <Section>
                <Color>FDC1C0</Color>
                <Title>Tools</Title>
                <HRef>tools/</HRef>
                <Text>
                  There are a lot of places to get generic information about all sorts of stuff in Pokemon GO.
                  But what if you want to focus on stuff that is specific to <span class="EMPHASIS">you</span>?
                  <br />This sections has some tools that could be helpful.
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
        <h2 id="anchor_quick">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'HOME_QUICK_ACCESS'" />
          </xsl:call-template>
          <u>Quick Access</u>
        </h2>
        <div id="HOME_QUICK_ACCESS">
          <p>
            Several pages are accessed more frequently than others.
            <br />I have collected links to those pages here so you don't have to go searching.
          </p>
          <div class="INDENT">
            <div class="SECTION" comment="Raid Bosses">
              <h2 id="anchor_raidbosses">
                <xsl:call-template name="Collapser">
                  <xsl:with-param name="CollapseeID" select="'HOME_RAID_BOSSES'" />
                </xsl:call-template>
                <a href="charts/raidboss">Possible IVs for Raid Bosses</a>
              </h2>
              <div id="HOME_RAID_BOSSES" class="INDENT">
                <p>
                  After you defeat a Raid Boss in a Raid, it is time to try to catch him.
                  But how good is he?
                </p>
                <p class="PARENT">
                  If you look at the CP of the Raid Boss, you can figure out what possible IVs it may have.
                  <br />Click on any of the Raid Bosses below to see a chart of the possibilities.
                </p>
                <div class="CHILD">
                  <script>InsertURL('charts/raidboss/_linkslist.html?cacherefresh={$CurrentDate}')</script>
                </div>
              </div>
            </div>

            <div class="SECTION" comment="Encounters">
              <h2 id="anchor_research">
                <xsl:call-template name="Collapser">
                  <xsl:with-param name="CollapseeID" select="'HOME_FIELD_RESEARCH'" />
                </xsl:call-template>
                <a href="charts/research">Encounters</a>
                <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                <span class="NOTE TODO">(Beta)</span>
              </h2>
              <div id="HOME_FIELD_RESEARCH" class="INDENT">
                <p>
                  For Field Research, you perform a Task to get a Reward.
                  If the Reward is something like Berries or Crystals, you can see exactly what you'll get.
                </p>
                <p>
                  But sometimes the Reward is an Encounter with a Pokemon.
                  What Pokemon may be the reward for completing the Task?
                  And how good might it be?
                </p>
                <p>
                  These charts can help.
                </p>
              </div>
            </div>

            <div class="SECTION" comment="Move Sets">
              <h2 id="anchor_movesets">
                <xsl:call-template name="Collapser">
                  <xsl:with-param name="CollapseeID" select="'HOME_MOVESETS'" />
                </xsl:call-template>
                <a href="charts/movesets/">Pokemon Move Sets</a>
              </h2>
              <div id="HOME_MOVESETS" class="INDENT">
                <p>
                  Each type of Pokemon has a set of "Fast" Moves and "Charged" moves that they may have.
                  Then each individual Pokemon has only one combination.
                  Of course, some moves are more effective than others.
                  <br />These pages show a list of each possible combination for each Pokemon, which then tells how much damage it will do.
                </p>
                <p class="PARENT">
                  I have created a chart for each generation of Pokemon:
                </p>
                <div class="CHILD">
                  <script>InsertLinksList('charts/movesets/_linkslist.html')</script>
                </div>
              </div>
            </div>

            <div class="SECTION" comment="PokeChart">
              <h2 id="anchor_pokecharts">
                <xsl:call-template name="Collapser">
                  <xsl:with-param name="CollapseeID" select="'HOME_POKECHART'" />
                </xsl:call-template>
                <a href="charts/pokechart">Pokemon Chart</a>
              </h2>
              <div id="HOME_POKECHART" class="INDENT">
                <p>
                  Want to know basic information about Pokemon?
                  Check out these charts and select the Pokemon you are interested in.
                </p>
                <div class="CHILD">
                  <script>InsertLinksList('charts/pokechart/_linkslist.html')</script>
                </div>
              </div>
            </div>

            <div class="SECTION" comment="PokeQuick">
              <h2 id="anchor_quickchart">
                <a href="charts/pokequick.html">Pokemon Quick List</a>
              </h2>
              <div class="INDENT">
                <p>
                  Sometimes you just want to see a list of the Pokemon that fit your criteria.
                  For example, maybe you want to perform a Field Research task that involves catching Poison type Pokemon.
                  <br />This list should help you out.
                </p>
              </div>
            </div>

            <div class="SECTION" comment="ShoppingBoxes">
              <h2 id="anchor_shoppingboxes">
                <a href="tools/shoppingboxes.html">Shopping Boxes</a>
              </h2>
              <div class="INDENT">
                <p>
                  When there are Events in Pokémon GO, they usually have some sort of special package deals in the Shop. Ever wonder how much one of those boxes is worth <span class="EMPHISIS">to you</span>? 
                  <br />Use this tool to find out. 
                </p>
              </div>
            </div>

            <div class="SECTION" comment="Evolutions">
              <h2 id="anchor_evolutions">
                <a href="charts/evolutions.html">Evolutions Chart</a>
              </h2>
              <div class="INDENT">
                <p>
                  One of the fun parts of Pokemon GO is Evolving.
                  But what can turn into what?
                  <br />This chart can help.
                </p>
              </div>
            </div>

            <div class="SECTION" comment="GAME_MASTER">
              <h2 id="anchor_gamemaster">
                <a href="tech/GAME_MASTER">GAME_MASTER</a>
              </h2>
              <div class="INDENT">
                <p>
                  There is a file called the GAME_MASTER that contains statistics regarding just about everything in the game.
                  <br />I use the data in them to generate various tables, etc.
                </p>
              </div>
            </div>
          </div>
        </div>

        <xsl:call-template name="WriteFooter" />
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
    <h2 id="anchor_news" class="NEWS_TITLE">
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'HOME_NEWS'" />
      </xsl:call-template>
      <xsl:text>Latest News!</xsl:text>
    </h2>
    <div id="HOME_NEWS" class="NEWS">
      <xsl:apply-templates select="Article" />
    </div>
    <!-- Need to do </div> by hand since it is opened via the script above. -->
    <script type="text/javascript">
      <![CDATA[
          document.write('</div>');
      ]]>
    </script>

    <br class="FLOAT_END" />
    <hr />
  </xsl:template>

  <xsl:template match="Article">
    <div class="NEWS_ARTICLE_HEADER">
      <xsl:value-of select="pokeref:Replace(@date, ' ', $nbsp)" disable-output-escaping="yes" />
    </div>
    <div class="NEWS_HEADLINE">
      <xsl:copy-of select="Title/node()" />
    </div>
    <div class="NEWS_CONTENT">
      <xsl:copy-of select="Text/node()" />
    </div>
    <xsl:if test="Note != ''">
      <p class="NOTE">
        <xsl:copy-of select="Note/node()" />
      </p>
    </xsl:if>
    <br />
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
      <a class="SECTION_CELL_FILLER">
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
