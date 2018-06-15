<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common">
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html xmlns:exslt="http://exslt.org/common">
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

        <title>CP and HP Formulas</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          CP and HP Formulas
        </h1>
        <div class="INDENT">
          <p class="PARENT">
            Every Pokemon has "CP" and "HP" scores associated with it.
          </p>
          <ul class="CHILD">
            <li>
              <b>
                CP <span class="NOTE">(Combat Power)</span>:
              </b>
              <br />An indicator of how strong a Pokemon will be in combat.
            </li>
            <li>
              <b>
                HP <span class="NOTE">(Hit Points)</span>:
              </b>
              <br />An indicator of how much damage a Pokemon can take before it faints.
            </li>
          </ul>
          <p>
            On the Pokemon's screen, the CP is listed at the top and the HP is listed under their name:
            <br /><img class="INDENT" src="/images/cphp.png" />
          </p>
          <p>
            These values are based on the Pokemon's IV score.
            Below are formulas used to calculate the values.
          </p>
        </div>

        <br />
        <hr />
        <h2 id="CP">CP Formula:</h2>
        <div class="INDENT">
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
        </div>

        <br />
        <h2 id="CP">HP Formula:</h2>
        <div class="INDENT">
          <div class="INDENT">
            <table class="FORMULA">
              <tr>
                <td rowspan="4" style="padding-top:.5em;">
                  <b style="font-size:x-large">
                    HP<xsl:value-of select="concat($nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                  </b>
                </td>
                <td rowspan="4" style="padding-top:.5em;">FLOOR</td>
                <td rowspan="4" style="font-size:3em;">(</td>
                <td rowspan="2" style="padding-top:.5em;">
                  <b>(</b>BaseStamina<xsl:value-of select="concat($nbsp, '+', $nbsp)" disable-output-escaping="yes" />StaminaIV<b>)</b>
                </td>
                <td rowspan="2" style="padding-top:.5em;">
                  <xsl:value-of select="concat($times, $nbsp)" disable-output-escaping="yes" />CPM
                </td>
                <td rowspan="4" style="font-size:3em;">)</td>
              </tr>
            </table>
          </div>
        </div>

        <br />
        <hr />
        <h2>Details</h2>
        <div class="INDENT">
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
                  The CPM for the Pokemon.
                </td>
              </tr>
            </table>
          </div>

          <br />
          <h3>NOTES</h3>
          <ul>
            <li>
              The BaseAttack, BaseDefense and BaseStamina for a Pokemon can be looked up in the <a href="GAME_MASTER/pokestats/">Pokemon Stats</a> pages.
            </li>
            <li>
              CPM is a value based on the Pokemon's Level. See <a href="cpm.html">CPM</a> page.
            </li>
            <li>
              In order to determine the Pokemon's IV scores, you generally need a tool that leverages these formulas to find the possibilities. Check out the Tools on the <a href="/resources/#tools_android">Resources</a> page.
            </li>
          </ul>
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
