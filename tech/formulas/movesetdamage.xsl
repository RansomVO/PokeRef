﻿<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html>
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

        <title>Move Set Formulas</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Move Set Formulas
        </h1>
        <p>
          The formulas for determining how much damage a Pokemon can do to another is very complex.
          <br />This page does the best I can do to explain what is going on.
        </p>

        <br />
        <hr />
        <h2 id="anchor_damage">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'FORMULA_MOVESET_DAMAGE'" />
          </xsl:call-template>
          <xsl:text>Damage Formula</xsl:text>
        </h2>
        <div id="FORMULA_MOVESET_DAMAGE" class="INDENT">
          <p class="PARENT">
            This is the "basic" formula for the Damage inflicted by a <span class="EMPHASIS">Single</span> attack Move:
          </p>
          <div class="INDENT">
            <table class="FORMULA">
              <tr>
                <td rowspan="7" style="padding-top:.5em;">
                  <b style="font-size:x-large">
                    <xsl:value-of select="concat('Damage', $nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                  </b>
                </td>
                <td rowspan="7" style="padding-top:.5em;">FLOOR</td>
                <td rowspan="7" style="font-size:4em">(</td>
                <td rowspan="6" style="font-size:3em">(</td>
                <td />
                <td rowspan="6" style="font-size:3em">)</td>
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="$times" disable-output-escaping="yes" />
                </td>
                <td rowspan="6" style="font-size:3em">(</td>
                <td />
                <td rowspan="6" style="font-size:3em">)</td>
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="concat($times, $nbsp, 'Effectiveness')" disable-output-escaping="yes" />
                </td>
                <td rowspan="7" style="font-size:4em">)</td>
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="concat('+', $nbsp, '1')" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>
                  <b>(</b>
                  <xsl:value-of select="concat('BaseAttack', $nbsp, '+', $nbsp, 'AttackIV')" disable-output-escaping="yes" />
                  <b>)</b>
                  <xsl:value-of select="concat($nbsp, $times, $nbsp, 'AttackerCPM')" disable-output-escaping="yes" />
                </td>
                <td>
                  <xsl:value-of select="concat('Power', $nbsp, $times, $nbsp, 'STAB', $nbsp, $times, $nbsp, 'WeatherBoost')" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td class="FORMULA_DIVIDE_BY" />
                <td class="FORMULA_DIVIDE_BY" />
              </tr>
              <tr>
                <td>
                  <b>(</b>
                  <xsl:value-of select="concat('BaseDefense', $nbsp, '+', $nbsp, 'DefenseIV')" disable-output-escaping="yes" />
                  <b>)</b>
                  <xsl:value-of select="concat($nbsp, $times, $nbsp, 'DefenderCPM')" disable-output-escaping="yes" />
                </td>
                <td>2</td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td colspan="3" />
                <td colspan="3" />
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
                  The <span class="EMPHASIS">Attacking</span> Pokemon's Base Attack score.
                </td>
              </tr>
              <tr>
                <th valign="top">BaseDefense</th>
                <td>
                  The <span class="EMPHASIS">Defending</span> Pokemon's Base Defense score.
                </td>
              </tr>
              <tr>
                <th valign="top">AttackIV</th>
                <td>
                  The <span class="EMPHASIS">Attacking</span> Pokemon's Attack IV score.
                </td>
              </tr>
              <tr>
                <th valign="top">DefenseIV</th>
                <td>
                  The <span class="EMPHASIS">Defending</span> Pokemon's Defense IV score.
                </td>
              </tr>
              <tr>
                <th valign="top">AttackerCPM</th>
                <td>
                  The CPM for the <span class="EMPHASIS">Attacking</span> Pokemon.
                </td>
              </tr>
              <tr>
                <th valign="top">DefenderCPM</th>
                <td>
                  The CPM for the <span class="EMPHASIS">Defending</span> Pokemon.
                </td>
              </tr>
              <tr>
                <th valign="top">Power</th>
                <td>
                  How much damage will be caused by the move.
                </td>
              </tr>
              <tr>
                <th valign="top">
                  <xsl:text>STAB</xsl:text>
                  <br />
                  <span class="NOTE" style="font-weight:normal">
                    <xsl:value-of select="concat($nbsp, $nbsp)" disable-output-escaping="yes" />(<b>
                      <u>S</u>
                    </b>ame <b>
                      <u>T</u>
                    </b>ype <b>
                      <u>A</u>
                    </b>ttack <b>
                      <u>B</u>
                    </b>onus)
                  </span>
                </th>
                <td>
                  If the type of the attack is the same as the Attacking Pokemon's type then it is <b>1.25</b>, otherwise it is <b>1</b>.
                  <div class="NOTE" style="margin-top:.5em;">
                    <b>For example</b>:
                    <div class="INDENT">
                      Tyranitars are of type <b>Rock</b> and <b>Dark</b>.
                      <br />The Move <u>Bite</u> is a <b>Dark</b> type move, so Tyranitars with this move <b>
                        <u>DO</u>
                      </b> get a STAB. (STAB = 1.25)
                      <br />On the other hand the Move <u>Iron Tail</u> is a <b>Steel</b> type move, so Tyranitars with this move <b>
                        <u>DO NOT</u>
                      </b> get a STAB. (STAB = 1)
                    </div>
                  </div>
                </td>
              </tr>
              <tr>
                <th valign="top">
                  <xsl:text>WeatherBoost</xsl:text>
                </th>
                <td>
                  If the type of the attack is boosted by the current weather then it is <b>1.25</b>, otherwise it is <b>1</b>. <span class="NOTE">(Similar to STAB)</span>
                  <div class="NOTE" style="margin-top:.5em;">
                    <b>For example</b>:
                    <div class="INDENT">
                      Vine Whip is a <b>Grass</b> type move and Grass types are boosted by <b>Sunny</b> weather.
                      <br />So, if the weather is Sunny Vine Whip <b>
                        <u>WILL</u>
                      </b> be boosted. (WeatherBoost = 1.25)
                      <br />On the other hand if the weather is <b>Cloudy</b> Vine Whip <b>
                        <u>WILL NOT</u>
                      </b> get boosted. (WeatherBoost = 1)
                    </div>
                  </div>
                </td>
              </tr>
              <tr>
                <th valign="top">Effectiveness</th>
                <td>A bonus or penalty depending upon the Type of the Move and the Type of the Defending Pokemon.</td>
              </tr>
              <tr>
                <th valign="top">AttackTime</th>
                <td>The amount of time it takes the Attacking Pokemon to perform the move.</td>
              </tr>
            </table>
          </div>

          <br />
          <h3>NOTES:</h3>
          <ul>
            <li>
              The Power for a Move can be looked up on the <a href="../GAME_MASTER/moves/moves.fast.html">Fast Moves</a> and <a href="../GAME_MASTER/moves/moves.charged.html">Charged Moves</a> pages.
            </li>
            <li>
              The BaseAttack and BaseDefense for a Pokemon can be looked up in the <a href="../GAME_MASTER/pokestats/">Pokemon Stats</a> pages.
            </li>
            <li>
              In order to determine the Pokemon's IV score, you generally need a tool that leverages these formulas to find the possibilities. Check out the Tools on the <a href="/resources/#tools_android">Resources</a> page.
            </li>
            <li>
              Whether a Move in a Move Set gets a STAB bonus for a specific Pokemon can be looked up on the <a href="/charts/movesets/">Pokemon Move Sets</a> page.
            </li>
            <li>
              CPM is a value based on the Pokemon's Level. See <a href="cpm.html">CPM</a> page.
            </li>
            <li>
              Effectiveness is determined by comparing the Move's Type to the Defending Pokemon's Type. See <a href="/charts/effectiveness.html">Move Effectiveness</a> page.
            </li>
          </ul>
        </div>

        <br />
        <hr />
        <h2 id="anchor_dps">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'FORMULA_MOVESET_DPS'" />
          </xsl:call-template>
          <b>
            <u>D</u>
          </b>amage <b>
            <u>P</u>
          </b>er <b>
            <u>S</u>
          </b>econd <span class="NOTE">(DPS)</span> Formula
        </h2>
        <div id="FORMULA_MOVESET_DPS" class="INDENT">
          <p class="PARENT">
            To make things worse, as mentioned above, that formula is for the <i>Damage</i> from a <span class="SIGNIFICANT EMPHASIS">Single</span> Move!
            To get the DPS for that one Move you would only need to do:
          </p>
          <div class="INDENT">
            <table class="FORMULA">
              <tr>
                <td rowspan="3" style="padding-top:.5em;">
                  <b style="font-size:x-large">
                    <xsl:value-of select="concat('DPS', $nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                  </b>
                </td>
                <td>Damage</td>
              </tr>
              <tr>
                <td class="FORMULA_DIVIDE_BY" />
              </tr>
              <tr>
                <td>AttackTime</td>
              </tr>
            </table>
          </div>
          <p style="margin-top:2em; margin-bottom:2em;">
            <b style="font-size:xx-large;">
              <xsl:value-of select="concat($nbsp, $nbsp, $nbsp)" disable-output-escaping="yes" />
              <span class="EMPHASIS">
                <xsl:value-of select="concat('...', $nbsp, 'BUT', $nbsp, '...')" disable-output-escaping="yes" />
              </span>
            </b>
            <br />
          </p>
          <p class="PARENT">
            To get the DPS for a <span class="SIGNIFICANT EMPHASIS">Move Set</span> you need to figure out:
          </p>
          <ol class="CHILD">
            <li>How many Fast Moves have to be performed to generate the Energy for the Charged Move.</li>
            <li>How long it takes to perform all of those Fast Moves</li>
            <li>How long it takes to perform the Charged Move</li>
            <li>What the total damage is for all of the Fast Moves and the Charged Move</li>
          </ol>
          <p class="Parent">
            In the end, the formula looks like this:
          </p>
          <div class="INDENT">
            <table class="FORMULA">
              <tr>
                <td rowspan="15" style="padding-top:.5em;">
                  <b style="font-size:x-large">
                    <xsl:value-of select="concat('Base DPS', $nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                  </b>
                </td>
                <td rowspan="7" style="font-size:4em">(</td>
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="concat('FastMoveDamage', $nbsp, $times, $nbsp, 'CEILING')" disable-output-escaping="yes" />
                </td>
                <td rowspan="6" style="font-size:3em">(</td>
                <td />
                <td rowspan="6" style="font-size:3em">)</td>
                <td rowspan="7" style="font-size:4em">)</td>
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="concat('+', $nbsp, 'ChargedMoveDamage')" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>ChargedMoveEnergy</td>
              </tr>
              <tr>
                <td class="FORMULA_DIVIDE_BY" />
              </tr>
              <tr>
                <td>FastMoveEnergy</td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td colspan="3" />
              </tr>
              <tr>
                <td class="FORMULA_DIVIDE_BY" colspan="7" />
              </tr>
              <tr>
                <td rowspan="7" style="font-size:4em">(</td>
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="concat('FastMoveTime', $nbsp, $times, $nbsp, 'CEILING')" disable-output-escaping="yes" />
                </td>
                <td rowspan="6" style="font-size:3em">(</td>
                <td />
                <td rowspan="6" style="font-size:3em">)</td>
                <td rowspan="7" style="font-size:4em">)</td>
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="concat('+', $nbsp, 'ChargedMoveTime')" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>ChargedMoveEnergy</td>
              </tr>
              <tr>
                <td class="FORMULA_DIVIDE_BY" />
              </tr>
              <tr>
                <td>FastMoveEnergy</td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td colspan="3" />
              </tr>
            </table>
          </div>
          <p class="PARENT">
            Here is what everything means:
          </p>
          <div class="INDENT">
            <table border="1" style="text-align:left">
              <tr>
                <th valign="top">CEILING</th>
                <td>
                  Get the smallest whole number <span class="NOTE">(integer)</span> that is greater than or equal to value.
                </td>
              </tr>
              <tr>
                <th valign="top">FastMoveDamage</th>
                <td>
                  The amount of Damage <span class="NOTE">(using Damage Formula above)</span> that a single Fast Move will inflict.
                </td>
              </tr>
              <tr>
                <th valign="top">ChargedMoveDamage</th>
                <td>
                  The amount of Damage <span class="NOTE">(using Damage Formula above)</span> that a single Charged Move will inflict.
                </td>
              </tr>
              <tr>
                <th valign="top">FastMoveEnergy</th>
                <td>The amount of Energy the Fast Move generates.</td>
              </tr>
              <tr>
                <th valign="top">ChargedMoveEnergy</th>
                <td>The amount of Energy the Charged Move requires.</td>
              </tr>
              <tr>
                <th valign="top">FastMoveTime</th>
                <td>The amount of time it takes to perform the Fast Move.</td>
              </tr>
              <tr>
                <th valign="top">ChargedMoveTime</th>
                <td>The amount of time it takes to perform the Fast Move.</td>
              </tr>
            </table>
          </div>
          <p class="PARENT">
            Simply put it is:
          </p>
          <ul>
            <li>The amount of Damage done by Fast Moves until enough Energy has been created to use the Charged Move,</li>
            <li>Plus the amount of Damage done by the Charged Move,</li>
            <li>All divided by the amount of time it takes to do all of that.</li>
          </ul>
          <span class="NOTE">(If you can call that "simply".)</span>
        </div>

        <br />
        <hr />
        <h2 id="anchor_truedps">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'FORMULA_MOVESET_TRUE_DPS'" />
          </xsl:call-template>
          <xsl:text>Simplifying </xsl:text><span class="NOTE">(True DPS)</span>
        </h2>
        <div id="FORMULA_MOVESET_TRUE_DPS" class="INDENT">
          <p>
            Unfortunately, there are some things that will change for each situation.
            <br />For example, some parts of the formulas really require us to know what Pokemon is being attacked.
            <span class="NOTE">(Effectiveness, CPM, BaseIV, etc.)</span>
          </p>
          <p class="PARENT">
            However, we can choose to assume several things to get a good idea of the damage a specific Attacking Pokemon can inflict with a specific Move Set:
          </p>
          <ul class="CHILD">
            <li>
              The Moves have no + or - Effectiveness against the Defending Pokemon.
              <div class="INDENT">
                <span class="NOTE">Doing that, we can just remove Effectiveness from the formula.</span>
              </div>
            </li>
            <li>
              Nothing is boosted by weather.
              <div class="INDENT">
                <span class="NOTE">Doing that, we can just remove WeatherBoost from the formula.</span>
              </div>
            </li>
            <li>
              The Defending Pokemon is the same level as the Attacking Pokemon.
              <div class="INDENT">
                <span class="NOTE">Doing that, the CPMs cancel each other out.</span>
              </div>
            </li>
            <li>
              A generic value for BaseDefense + DefenseIV of the Defending Pokemon.
              <div class="INDENT">
                <span class="NOTE">For example, 100.</span>
              </div>
            </li>
            <li>
              The AttackIV for the Attacking Pokemon is perfect.
              <div class="INDENT">
                <span class="NOTE">That is 15.</span>
              </div>
            </li>
          </ul>
          <p class="PARENT">
            With those assumptions, the Damage formula <span class="NOTE">(after simplification)</span> becomes:
          </p>
          <div class="INDENT CHILD">
            <table class="FORMULA CHILD">
              <tr>
                <td rowspan="7" style="padding-top:.5em;">
                  <b style="font-size:x-large">
                    <xsl:value-of select="concat('Damage', $nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                  </b>
                </td>
                <td rowspan="7" style="padding-top:.5em;">FLOOR</td>
                <td rowspan="6" style="font-size:3em">(</td>
                <td />
                <td rowspan="6" style="font-size:3em">)</td>
                <td />
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="concat('+', $nbsp, '1')" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>
                  <b>(</b>
                  <xsl:value-of select="concat('BaseAttack', $nbsp, '+', $nbsp, '15')" disable-output-escaping="yes" />
                  <b>)</b>
                  <xsl:value-of select="concat($nbsp, $times, $nbsp, 'Power', $nbsp, $times, $nbsp, 'STAB')" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td class="FORMULA_DIVIDE_BY" />
              </tr>
              <tr>
                <td>200</td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td colspan="3" />
              </tr>
            </table>
          </div>
          <p class="PARENT">
            Then, merging that into the Base DPS formula <span class="NOTE">(which is now a little easier than it would have been with the full Damage formula)</span>, we end up with:
          </p>
          <div class="INDENT CHILD">
            <table class="FORMULA">
              <tr>
                <td rowspan="3" style="padding-top:.5em;">
                  <b style="font-size:x-large">
                    <xsl:value-of select="concat('True DPS', $nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                  </b>
                </td>
                <td>
                  <table align="center">
                    <tr>
                      <td rowspan="7" style="font-size:5em">(</td>
                      <td rowspan="7" style="font-size:4em">(</td>
                      <td rowspan="7" style="padding-top:.5em;">FLOOR</td>
                      <td rowspan="6" style="font-size:3em">(</td>
                      <td />
                      <td rowspan="6" width="1" style="font-size:3em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">
                        <xsl:value-of select="concat('+', $nbsp, '1')" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="7" style="font-size:4em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">
                        <xsl:value-of select="concat($times, $nbsp, 'CEILING')" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="6" style="font-size:3em">(</td>
                      <td />
                      <td rowspan="6" style="font-size:3em">)</td>
                      <td rowspan="7" style="font-size:5em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">
                        <xsl:value-of select="concat('+', $nbsp, 'FLOOR')" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="6" style="font-size:3em">(</td>
                      <td />
                      <td rowspan="6" style="font-size:3em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">
                        <xsl:value-of select="concat('+', $nbsp, '1')" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                      <td>
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                      <td>
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <b>(</b>
                        <xsl:value-of select="concat('BaseAttack', $nbsp, '+', $nbsp, '15')" disable-output-escaping="yes" />
                        <b>)</b>
                        <xsl:value-of select="concat($nbsp, $times, $nbsp, 'FastPower', $nbsp, $times, $nbsp, 'FastSTAB')" disable-output-escaping="yes" />
                      </td>
                      <td>ChargedMoveEnergy</td>
                      <td>
                        <b>(</b>
                        <xsl:value-of select="concat('BaseAttack', $nbsp, '+', $nbsp, '15')" disable-output-escaping="yes" />
                        <b>)</b>
                        <xsl:value-of select="concat($nbsp, $times, $nbsp, 'ChargedPower', $nbsp, $times, $nbsp, 'ChargedSTAB')" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td class="FORMULA_DIVIDE_BY" />
                      <td class="FORMULA_DIVIDE_BY" />
                      <td class="FORMULA_DIVIDE_BY" />
                    </tr>
                    <tr>
                      <td>200</td>
                      <td>FastMoveEnergy</td>
                      <td>200</td>
                    </tr>
                    <tr>
                      <td>
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                      <td>
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                      <td>
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td colspan="3" />
                      <td colspan="3" />
                      <td colspan="3" />
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="FORMULA_DIVIDE_BY" />
              </tr>
              <tr>
                <td>
                  <table align="center">
                    <tr>
                      <td colspan="7" rowspan="7">
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="7" width="1px" style="font-size:4em">(</td>
                      <td colspan="3" rowspan="7" width="1px" style="padding-top:.5em;">
                        <xsl:value-of select="concat('FastMoveTime', $nbsp, $times, $nbsp, 'CEILING')" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="6" style="font-size:3em">(</td>
                      <td colspan="4" />
                      <td rowspan="6" style="font-size:3em">)</td>
                      <td rowspan="7" style="font-size:4em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">+</td>
                      <td colspan="2" rowspan="7" style="padding-top:.5em;">ChargedMoveTime</td>
                      <td colspan="2" rowspan="7" />
                    </tr>
                    <tr>
                      <td colspan="4">
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td colspan="4">ChargedMoveEnergy</td>
                    </tr>
                    <tr>
                      <td colspan="4" class="FORMULA_DIVIDE_BY" />
                    </tr>
                    <tr>
                      <td colspan="4">FastMoveEnergy</td>
                    </tr>
                    <tr>
                      <td colspan="4">
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td colspan="7" />
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <br />
          </div>
          <p>
            I refer to this as the "True DPS" on the charts in <a href="/charts/movesets/">Pokemon Move Sets</a>.
          </p>
        </div>

        <br />
        <hr />
        <h2 id="anchor_movesetdps">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'FORMULA_MOVESET_MOVESET_DPS'" />
          </xsl:call-template>
          <xsl:text>Even Simpler </xsl:text><span class="NOTE">(Base DPS)</span>
        </h2>
        <div id="FORMULA_MOVESET_MOVESET_DPS" class="INDENT">
          <p>
            Obviously, True DPS is still quite a complex formula.
            <br />To simplify it further, many people will use only the values from the Move Set itself, removing the values from the Pokemon.
            This will give a <span class="EMPHASIS">generic</span> DPS for the moveset.
            <br /><span class="NOTE">(In other words, it will be the same value regardless the Pokemon.)</span>
          </p>

          <p class="PARENT">
            With that, we end up with:
          </p>
          <div class="INDENT CHILD">
            <table class="FORMULA">
              <tr>
                <td rowspan="3" style="padding-top:.5em;">
                  <b style="font-size:x-large">
                    <xsl:value-of select="concat('Base DPS', $nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                  </b>
                </td>
                <td>
                  <table align="center">
                    <tr>
                      <td rowspan="8" style="font-size:5em">(</td>
                      <td rowspan="8" style="font-size:4em">(</td>
                      <td rowspan="8" style="padding-top:.5em;">FLOOR</td>
                      <td rowspan="6" style="font-size:3em">(</td>
                      <td rowspan="8" style="padding-top:.5em;">FastPower</td>
                      <td rowspan="6" width="1" style="font-size:3em">)</td>
                      <td rowspan="8" style="padding-top:.5em;">
                        <xsl:value-of select="concat('+', $nbsp, '1')" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="8" style="font-size:4em">)</td>
                      <td rowspan="8" style="padding-top:.5em;">
                        <xsl:value-of select="$times" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="8" style="padding-top:.5em;">CEILING</td>
                      <td rowspan="6" style="font-size:3em">(</td>
                      <td />
                      <td rowspan="6" style="font-size:3em">)</td>
                      <td rowspan="8" style="font-size:5em">)</td>
                      <td rowspan="8" style="padding-top:.5em;">+</td>
                      <td rowspan="6" style="font-size:3em">(</td>
                      <td rowspan="7" style="padding-top:.5em;">ChargedPower</td>
                      <td rowspan="6" style="font-size:3em">)</td>
                      <td rowspan="8" style="padding-top:.5em;">
                        <xsl:value-of select="concat('+', $nbsp, '1')" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td>ChargedMoveEnergy</td>
                    </tr>
                    <tr>
                      <td class="FORMULA_DIVIDE_BY" />
                    </tr>
                    <tr>
                      <td>FastMoveEnergy</td>
                    </tr>
                    <tr>
                      <td>
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td />
                      <td />
                      <td colspan="3" />
                      <td />
                      <td />
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="FORMULA_DIVIDE_BY" />
              </tr>
              <tr>
                <td>
                  <table align="center">
                    <tr>
                      <td colspan="7" rowspan="7">
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="7" width="1px" style="font-size:4em">(</td>
                      <td colspan="3" rowspan="7" width="1px" style="padding-top:.5em;">
                        <xsl:value-of select="concat('FastMoveTime', $nbsp, $times, $nbsp, 'CEILING')" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="6" style="font-size:3em">(</td>
                      <td colspan="4" />
                      <td rowspan="6" style="font-size:3em">)</td>
                      <td rowspan="7" style="font-size:4em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">+</td>
                      <td colspan="2" rowspan="7" style="padding-top:.5em;">
                        <xsl:value-of select="concat($nbsp, 'ChargedMoveTime')" disable-output-escaping="yes" />
                      </td>
                      <td colspan="2" rowspan="7" />
                    </tr>
                    <tr>
                      <td colspan="4">
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td colspan="4">ChargedMoveEnergy</td>
                    </tr>
                    <tr>
                      <td colspan="4" class="FORMULA_DIVIDE_BY" />
                    </tr>
                    <tr>
                      <td colspan="4">FastMoveEnergy</td>
                    </tr>
                    <tr>
                      <td colspan="4">
                        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td colspan="7" />
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </div>

          <p>
            I personally don't pay attention to this, but I include it as the "Base DPS" on the charts in <a href="/charts/movesets/">Pokemon Move Sets</a> in case you are interested.
          </p>
        </div>

        <br />
        <hr />
        <h2 id="anchor_sumup">Sum-Up</h2>
        <p>
          I have included both Base DPS and True DPS in the <a href="/charts/movesets/">Pokemon Move Sets</a> page.
          However, in my humble opinion, the True DPS formula is the most useful, and the one I pay attention to the most.
        </p>
        <p>
          Although these formulas are a quite technical, I have programmed them into a spreadsheet that does all the calculations.
          If any of the values change in the future, I just copy-and-paste them in and re-generate the data for the pages on this site.
          <div class="NOTE">
            NOTE: In the past, Niantic <b>
              <u>has</u>
            </b> adjusted the Base values for some of the Pokemon.
          </div>
        </p>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
