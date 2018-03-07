<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common">
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="Root">
    <html xmlns:exslt="http://exslt.org/common">
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

        <title>CP and HP Formulas</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          CP and HP Formulas</h1>
        <p>
          <span class="TODO">TODO QZX</span>
        </p>

        <br />
        <hr />
        <h2 id="CP">CP Formula</h2>
        <div class="INDENT">
          <p class="PARENT">
            <span class="TODO">TODO QZX</span>
          </p>
          <div class="INDENT">
            <table class="FORMULA">
              <tr>
                <td rowspan="4" style="padding-top:.5em;">
                  <b style="font-size:x-large">
                    CP<xsl:value-of select="concat($nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                  </b>
                </td>
                <td rowspan="4" style="padding-top:.5em;">FLOOR</td>
                <td rowspan="4" style="font-size:4em;">(</td>
                <td />
                <td rowspan="3" valign="top" style="padding:0; font-size:3em;">(</td>
                <td rowspan="2" colspan="2" />
                <td rowspan="3" style="padding:0; font-size:3em;">)</td>
                <td />
                <td rowspan="4" style="font-size:4em;">)</td>
              </tr>
              <tr>
                <td rowspan="2" style="padding-top:.5em;">
                  <b>(</b>BaseAttack<xsl:value-of select="concat($nbsp, '+', $nbsp)" disable-output-escaping="yes" />AttackIV<b>)</b><xsl:value-of select="concat($nbsp, $times)" disable-output-escaping="yes" />
                </td>
                <td rowspan="2" style="padding-top:.5em;">
                  <xsl:value-of select="concat($times, $nbsp)" disable-output-escaping="yes" />CPM<sup>2</sup>
                </td>
              </tr>
              <tr>
                <td align="right" valign="top" style="padding:0; font-size:2em;">
                  <b>&#x221A;</b>
                </td>
                <td class="FORMULA_DIVIDE_BY">
                  <b>(</b>BaseDefense<xsl:value-of select="concat($nbsp, '+', $nbsp)" disable-output-escaping="yes" />DefenseIV<b>)</b><xsl:value-of select="concat($nbsp, $times, $nbsp)" disable-output-escaping="yes" /><b>(</b>BaseStamina<xsl:value-of select="concat($nbsp, '+', $nbsp)" disable-output-escaping="yes" />StaminaIV<b>)</b>
                </td>

              </tr>
              <tr>
                <td class="FORMULA_DIVIDE_BY" colspan="6">
                  10
                </td>
              </tr>
            </table>
          </div>

          <p class="PARENT">
            Here is what everything means:
          </p>
          <div class="INDENT">
            <table border="1" style="text-align:left">
              <tr>
                <th valign="top">FLOOR</th>
                <td>Chop off everything after the decimal point.</td>
              </tr>
              <tr>
                <th valign="top">BaseAttack</th>
                <td>
                  The Pokemon's Base Attack score.
                </td>
              </tr>
              <tr>
                <th valign="top">BaseDefense</th>
                <td>
                  The Pokemon's Base Defense score.
                </td>
              </tr>
              <tr>
                <th valign="top">BaseStamina</th>
                <td>
                  The Pokemon's Base Stamina <span class="NOTE">(HP)</span> score.
                </td>
              </tr>
              <tr>
                <th valign="top">AttackIV</th>
                <td>
                  The Pokemon's Attack IV score.
                </td>
              </tr>
              <tr>
                <th valign="top">DefenseIV</th>
                <td>
                  The Pokemon's Defense IV score.
                </td>
              </tr>
              <tr>
                <th valign="top">StaminaIV</th>
                <td>
                  The Pokemon's Stamina <span class="NOTE">(HP)</span> IV score.
                </td>
              </tr>
              <tr>
                <th valign="top">CPM</th>
                <td>
                  The CPM for the Pokémon.
                </td>
              </tr>
            </table>
          </div>
          <br />
          <div class="NOTE">
            <b>NOTES</b>:
            <ul>
              <li>
                <span class="TODO">TODO QZX</span>
              </li>
              <!--
                        <li>
                            The Power for a Move can be looked up on the <a href="GAME_MASTER/moves/moves.fast.html">Fast Moves</a> and <a href="GAME_MASTER/moves/moves.charged.html">Charged Moves</a> pages.
                        </li>
                        <li>
                            The BaseAttack and BaseDefense for a Pokémon can be looked up in the <a href="GAME_MASTER/pokestats/">Pokémon Stats</a> pages.
                        </li>
                        <li>
                            Whether a Move in a Move Set gets a STAB bonus for a specific Pokémon can be looked up on the <a href="/charts/movesets/">Pokémon Move Sets</a> page.
                        </li>
                        <li>
                            CPM is a value based on the Pokémon's Level. See <a href="cpm.html">CPM</a> page.
                        </li>
                        <li>
                            Effectiveness is determined by comparing the Move's Type to the Defending Pokémon's Type. See <a href="/charts/effectiveness.html">Move Effectiveness</a> page.
                        </li>
                        -->
            </ul>

          </div>
        </div>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
