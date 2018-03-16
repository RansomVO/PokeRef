<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:include href="/xsl/global.xsl" />
  <xsl:include href="raidbosses.xsl"/>

  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/controls.js?cacherefresh=</xsl:text>
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

        <title>Possible IVs for Raid Bosses</title>

        <style>
          li {
          margin: 1em 0;
          }
        </style>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Possible IVs for Raid Bosses
        </h1>
        <div class="INDENT">
          <p>
            After you defeat a Raid Boss in a Raid, it is time to try to catch him.
            But how good is he?
          </p>
          <p>
            If you look at the CP of the Raid Boss, you can figure out what possible IVs it may have.
            Knowing that, you can decide how much effort to put into catching it.
            <br />
            <br />For example, if it is a high IV you'll want to use your Golden Razz Berries and be careful with every throw.
            <br />On the other hand, if it is a low IV you may only want to use regular Razz Berries and save your Golden Razz Berries for the next encounter.
          </p>
          <p>
            Here's what you do:
          </p>

          <h3 id="anchor_before">
            <xsl:text>Before you throw any balls...</xsl:text>
            <xsl:call-template name="Collapser">
              <xsl:with-param name="CollapseeID" select="'BEFORE_THROW'" />
            </xsl:call-template>
          </h3>
          <ol id="BEFORE_THROW">
            <li>
              Determine whether or not the Raid Boss has a Weather Boost and set the checkbox accordingly.
              <br /><img class="INDENT" width="210" style="border:1px solid black;" src="images/weatherboosted.png" />
            </li>
            <li>
              Look at the CP of the Raid Boss.
              <br /><img class="INDENT" width="210" src="images/raidbosscp.png" />
            </li>
            <li>
              Look for that value in the CP column of the table. (1<sup>st</sup> column with the <span style="font-size:xx-large">
                <b>BIG</b>
              </span> numbers.)
              <table class="INDENT" border="1" style="white-space:nowrap;">
                <tr>
                  <th style="font-size:xx-large; padding:0; margin:0; border-collapse:collapse; border:none;">2246</th>
                  <th class="DISABLED" align="right">89% - 91%</th>
                  <td class="GREAT DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>91%: </b>11 15 15 <i>(124)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 13 13 <i>(123)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 14 12 <i>(122)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 15 11 <i>(121)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>15 10 15 <i>(124)</i>
                  </td>
                </tr>
              </table>
            </li>
            <li>
              In the IV Range column (2<sup>nd</sup> column) you will find the range of possible IVs with that score.
              <table class="INDENT" border="1" style="white-space:nowrap;">
                <tr>
                  <th class="DISABLED" style="font-size:xx-large; padding:0; margin:0; border-collapse:collapse; border:none;">2246</th>
                  <th align="right">89% - 91%</th>
                  <td class="GREAT DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>91%: </b>11 15 15 <i>(124)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 13 13 <i>(123)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 14 12 <i>(122)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 15 11 <i>(121)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>15 10 15 <i>(124)</i>
                  </td>
                </tr>
              </table>
              <ul>
                <li style="margin:unset">
                  Sometimes there is only 1 possibility so you <i>know</i> what it will be if you catch it.
                </li>
                <li style="margin:unset">Other times there are multiple possibilities, but you still will have a good idea of what you face.</li>
              </ul>
            </li>
          </ol>

          <h3 id="anchor_after">
            <xsl:text>After you catch the Pokemon...</xsl:text>
            <xsl:call-template name="Collapser">
              <xsl:with-param name="CollapseeID" select="'AFTER_THROW'" />
            </xsl:call-template>
          </h3>
          <ol id="AFTER_THROW">
            <li>
              Open the Pokemon's page, check the Pokemon's HP and compare it to the values in the chart.
              <br /><img class="INDENT" width="210" src="images/hp.png" />
              <br />
              <table class="INDENT" border="1" style="white-space:nowrap;">
                <tr>
                  <th class="DISABLED" style="font-size:xx-large; padding:0; margin:0; border-collapse:collapse; border:none;">2246</th>
                  <th class="DISABLED" align="right">89% - 91%</th>
                  <td class="GREAT" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>91%: </b>11 15 15 <i style="background-color:yellow">(124)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 13 13 <i>(123)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 14 12 <i>(122)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 15 11 <i>(121)</i>
                  </td>
                  <td class="GOOD" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>15 10 15 <i style="background-color:yellow">(124)</i>
                  </td>
                </tr>
              </table>
              Sometimes there is only 1 possibility so you <i>know</i> what you have, so you can stop here.
            </li>
            <li>
              If you haven't determined the IV yet, then open the menu and select APPRAISE.
              <br /><img class="INDENT" width="210" src="images/appraise.png" />
            </li>
            <li>
              Pay attention to what the Team Leader says is the Pokemon's best attribute(s).
              <br /><img class="INDENT" width="210" src="images/bestattribute-1.png" /><img class="INDENT" width="210" src="images/bestattribute-2.png" />
            </li>
            <li>
              Check the IV columns and find the entry where the highest values match what the Team Leader specified.
              <table class="INDENT" border="1" style="white-space:nowrap;">
                <tr>
                  <th class="DISABLED" style="font-size:xx-large; padding:0; margin:0; border-collapse:collapse; border:none;">2246</th>
                  <th class="DISABLED" align="right">89% - 91%</th>
                  <td class="GREAT" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>91%: </b>11 <span style="background-color:yellow">15 15</span><xsl:text> </xsl:text><i>(124)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 13 13 <i>(123)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 14 12 <i>(122)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>14 15 11 <i>(121)</i>
                  </td>
                  <td class="GOOD DISABLED" align="right" style="padding-left:2em; padding-right:2em;">
                    <b>89%: </b>15 10 15 <i>(124)</i>
                  </td>
                </tr>
              </table>
              Usually this will narrow it down to a single result, but occasionally it will only narrow it down to a few entries.
              <br />When this happens, the only way to narrow down the results is to use Power Ups and some tool to calculate the possible IVs.
              I recommend using IV &amp; Toolkit for Pokemon Go (Described in the <a href="/resources/#Toolkit">Pokemon Resources Section</a>) to help determine how many Power Ups would be required to narrow down the results, then decide whether it is worth the Stardust.
            </li>
          </ol>
        </div>

        <br />
        <hr />
        <xsl:call-template name="CreateKey" />

        <br />
        <hr />
        <h2>Current Raid Bosses</h2>
        <p id="anchor_bossescurrent">
          Click on any of the Raid Bosses below to see a chart of the possibilities.
        </p>
        <xsl:apply-templates select="RaidBosses[@category='Current']">
          <xsl:with-param name="Settings">
            <Show show_disabled="true" valign="bottom" />
          </xsl:with-param>
        </xsl:apply-templates>

        <br />
        <hr />
        <h2>Legacy Raid Bosses</h2>
        <p id="anchor_bosseslegacy">
          Here is a list of Raid Bosses that were available in the past, but no longer are.
          <span class="NOTE">(In case you are interested.)</span>
        </p>
        <xsl:apply-templates select="RaidBosses[@category='Legacy']">
          <xsl:with-param name="Settings">
            <Show show_disabled="true" />
          </xsl:with-param>
        </xsl:apply-templates>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

  <!-- Template to write the Key for the table. -->
  <xsl:template name="CreateKey">
    <h2>
      <xsl:text>Key</xsl:text>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'POKEMON_IMAGE_KEY'" />
      </xsl:call-template>
    </h2>
    <br />
    <xsl:call-template name="PokemonImageKey" />
  </xsl:template>

</xsl:stylesheet>
