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
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>index.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
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

        <title>My Stuff</title>

        <style>
          @font-face {
          font-family: Open Sans;
          src: url("/fonts/OpenSans-Regular-webfont.woff2") format("woff2"), url("/fonts/OpenSans-Regular-webfont.woff") format("woff");
          }

          .CHARS {
          text-align: center;
          font-size: x-large;
          }
        </style>
      </head>
      <body>
        <h1>My Stuff</h1>
        <p>
          If you found this you are special or very sneaky!
          <br />This is stuff that is specific to me
        </p>

        <br />
        <hr />
        <h2>My Naming Schema</h2>
        <table id="IVs" border="1" style="margin-right:50px;">
          <tr id="IV#">
            <th>
              IV #<br />
            </th>
            <td class="CHARS">&#x24EA;</td>
            <td class="CHARS">&#x2460;</td>
            <td class="CHARS">&#x2461;</td>
            <td class="CHARS">&#x2462;</td>
            <td class="CHARS">&#x2463;</td>
            <td class="CHARS">&#x2464;</td>
            <td class="CHARS">&#x2465;</td>
            <td class="CHARS">&#x2466;</td>
            <td class="CHARS">&#x2467;</td>
            <td class="CHARS">&#x2468;</td>
            <td class="CHARS">&#x2469;</td>
            <td class="CHARS">&#x246A;</td>
            <td class="CHARS">&#x246B;</td>
            <td class="CHARS">&#x246C;</td>
            <td class="CHARS">&#x246D;</td>
            <td class="CHARS">&#x246E;</td>
          </tr>
          <tr id="Tyrogue">
            <th>
              Tyrogue Best
              <br />(To help identify what it would evolve into.)
            </th>
            <td class="CHARS">&#x24FF;</td>
            <td class="CHARS">&#x2776;</td>
            <td class="CHARS">&#x2777;</td>
            <td class="CHARS">&#x2778;</td>
            <td class="CHARS">&#x2779;</td>
            <td class="CHARS">&#x277A;</td>
            <td class="CHARS">&#x277B;</td>
            <td class="CHARS">&#x277C;</td>
            <td class="CHARS">&#x277D;</td>
            <td class="CHARS">&#x277E;</td>
            <td class="CHARS">&#x277F;</td>
            <td class="CHARS">&#x24EB;</td>
            <td class="CHARS">&#x24EC;</td>
            <td class="CHARS">&#x24ED;</td>
            <td class="CHARS">&#x24EE;</td>
            <td class="CHARS">&#x24EF;</td>
          </tr>
          <tr>
            <th>Unknown</th>
            <td class="CHARS">&#9072;</td>
            <td class="CHARS">
              &#x25CD;<br />Too Small
            </td>
          </tr>
        </table>
        <br />
        <table id="Other Chars" border="1" style="margin-right:50px;">
          <tr>
            <th colspan="3">Other Chars</th>
          </tr>
          <tr>
            <th>Char</th>
            <th>Position</th>
            <th>Description</th>
          </tr>
          <tr>
            <td class="CHARS">&#x2299;</td>
            <td>First char</td>
            <td>Favorite Battle Pokemon</td>
          </tr>
          <tr>
            <td class="CHARS">&#x300A;</td>
            <td>After IV%</td>
            <td>Pokemon that need a Fast TM.</td>
          </tr>
          <tr>
            <td class="CHARS">&#x300B;</td>
            <td>After IV%</td>
            <td>Pokemon that need a Charged TM</td>
          </tr>
          <tr>
            <td class="CHARS">&#x2606;</td>
            <td>After IV%</td>
            <td>Pokemon with the highest possible Move Set</td>
          </tr>
          <tr>
            <td class="CHARS">&#x00A7;</td>
            <td>Tacked on front</td>
            <td>Pokemon that are not fully powered up.</td>
          </tr>
          <tr>
            <td class="CHARS">=</td>
            <td>Tacked on front</td>
            <td>Pokemon that are not fully powered up but I don't have enough candies.</td>
          </tr>
          <tr>
            <td class="CHARS">&#x2667;</td>
            <td>First char</td>
            <td>Pokemon I will evolve during a Lucky Egg session</td>
          </tr>
          <tr>
            <td class="CHARS">zzz</td>
            <td>Full Name</td>
            <td>Pokemon can put in a gym,then throw away after.</td>
          </tr>
        </table>

        <br />
        <hr />
        <h2>Examples:</h2>
        <table style="white-space:nowrap;">
          <tr>
            <td class="CHARS" style="text-align:left;">86-91</td>
            <td>-</td>
            <td>Pokemon with IV in Range of 86% to 91%</td>
          </tr>
          <tr>
            <td class="CHARS" style="text-align:left;">82&#x246C;&#x246A;&#x246D;</td>
            <td>-</td>
            <td>Pokemon with Attack=13 / Defense=11 / HP=14</td>
          </tr>
          <tr>
            <td class="CHARS" style="text-align:left;">82-84&#x25CD;&#x25CD;&#x24EE;</td>
            <td>-</td>
            <td>Tyrogue with IV in Range of 82% to 84% with best attribute being HP of 14</td>
          </tr>
          <tr>
            <td class="CHARS" style="text-align:left;">&#x277F;&#x24FF;</td>
            <td>-</td>
            <td>Pokemon with Perfect IV (100%)</td>
          </tr>
          <tr>
            <td class="CHARS" style="text-align:left;">98&#x2606;&#x246E;&#x246D;&#x246E;</td>
            <td>-</td>
            <td>Pokemon with Attack=15 / Defense=14 / HP=15 and Best Possible Move Set</td>
          </tr>
          <tr>
            <td class="CHARS" style="text-align:left;">&#x2299;82-89</td>
            <td>-</td>
            <td>Battle Pokemon with IV in Range of 82% to 89%</td>
          </tr>
          <tr>
            <td class="CHARS" style="text-align:left;">&#x2299;&#x277F;&#x24FF;&#x2606;</td>
            <td>-</td>
            <td>Battle Pokemon with Perfect IV (100%) and Best Possible Move Set</td>
          </tr>
        </table>
        <br />

        <br />
        <hr />
        <h2>My Discord Searches</h2>
        <p>
          These are the searches I like to use on the Discord Channels
          <br /><span class="NOTE">
            <b>NOTE</b>: There is a limit of 512 chars in the search field so if you add stuff you may have to cut some channels out.<br />
          </span>
        </p>
        <table border="1">
          <tr>
            <th>Server</th>
            <th>Description</th>
            <th>Filter</th>
          </tr>
          <tr>
            <th rowspan="2">SeaPokeMap</th>
            <td colspan="2" />
          </tr>
          <tr>
            <td>All Sitings Near Work</td>
            <td>[West Bellevue] in:iv100 in:iv90 in:cp2500 in:tyranitar in:dragonite in:blissey in:chansey in:lapras in:snorlax in:unown in:ampharos in:aerodactyl in:alakazam in:arcanine in:blastoise in:charizard in:donphan in:exeggutor in:feraligatr in:flaaffy in:flareon in:forretress in:gengar in:golem in:gyarados in:hitmonchan in:hitmonlee in:hitmontop in:jolteon in:larvitar in:lickitung in:machamp in:mareep in:meganium in:miltank in:muk in:porygon in:pupitar in:rhydon in:togetic in:typhlosion in:vaporeon in:venusaur</td>
          </tr>
          <tr>
            <th rowspan="2">SeattlePokeMaps (SPM)</th>
            <td colspan="2" />
          </tr>
          <tr>
            <th>All Sitings Near Work</th>
            <td>in:bellevue Downtown</td>
          </tr>
        </table>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
