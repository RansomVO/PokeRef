﻿<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl"/>

  <xsl:template match="Root">
    <html>
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
            <xsl:text>index.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </link>

        <title>Move Set Formulas</title>
      </head>
      <body>
        <h1>Move Set Formulas</h1>
        <p>
          The formulas for determining how much damage a Pokemon can do to another is very complex.
          <br />This page does the best I can do to explain what is going on.
        </p>

        <br />
        <hr />
        <h2>
          Damage Formula
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'FORMULA_DAMAGE'" />
          </xsl:call-template>
        </h2>
        <div id="FORMULA_DAMAGE" class="INDENT">
          <p class="PARENT">
            This is the "basic" formula for the Damage inflicted by a <i>Single</i> attack Move:
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
                <td rowspan="7" style="padding-top:.5em;">*</td>
                <td rowspan="6" style="font-size:3em">(</td>
                <td />
                <td rowspan="6" style="font-size:3em">)</td>
                <td rowspan="7" style="padding-top:.5em;"> * Effectiveness</td>
                <td rowspan="7" style="font-size:4em">)</td>
                <td rowspan="7" style="padding-top:.5em;">+ 1</td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>
                  <b>(</b>BaseAttack + AttackIV<b>)</b> * AttackerCPM
                </td>
                <td>Power * STAB</td>
              </tr>
              <tr>
                <td class="DIVIDE_BY" />
                <td class="DIVIDE_BY" />
              </tr>
              <tr>
                <td>
                  <b>(</b>BaseDefense + DefenseIV<b>)</b> * DefenderCPM
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
                <th valign="top">Power</th>
                <td>
                  The Power of the move. <div class="TODO INDENT">More details to be added.</div>
                </td>
              </tr>
              <tr>
                <th valign="top">BaseAttack</th>
                <td>
                  The <b>
                    <i>Attacking</i>
                  </b> Pokemon's Base Attack score.
                </td>
              </tr>
              <tr>
                <th valign="top">BaseDefense</th>
                <td>
                  The <b>
                    <i>Defending</i>
                  </b> Pokemon's Base Defense score.
                </td>
              </tr>
              <tr>
                <th valign="top">AttackIV</th>
                <td>
                  The <b>
                    <i>Attacking</i>
                  </b> Pokemon's Attack IV score.
                </td>
              </tr>
              <tr>
                <th valign="top">DefenseIV</th>
                <td>
                  The <b>
                    <i>Defending</i>
                  </b> Pokemon's Defense IV score.
                </td>
              </tr>
              <tr>
                <th valign="top">AttackerCPM</th>
                <td>
                  The CPM for the <b>
                    <i>Attacking</i>
                  </b> Pokemon.
                </td>
              </tr>
              <tr>
                <th valign="top">DefenderCPM</th>
                <td>
                  The CPM for the <b>
                    <i>Defending</i>
                  </b> Pokemon.
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
                  If the type of the attack is the same as the attacking Pokemon's type then it is <b>1.25</b>, otherwise it is <b>1</b>.
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
                <th valign="top">Effectiveness</th>
                <td>A measure of how effective a Move will be against a Pokemon.</td>
              </tr>
              <tr>
                <th valign="top">AttackTime</th>
                <td>The amount of time it takes the Pokemon to perform the move.</td>
              </tr>
            </table>
          </div>
          <br />
          <div class="NOTE">
            <b>NOTES</b>:
            <ul>
              <li>
                The BaseAttack and BaseDefense for a Pokemon can be looked up in the <a href="GAME_MASTER/pokestats/">Pokemon Stats</a> pages.
              </li>
              <li>
                Whether a Move in a Move Set gets a STAB bonus or not can be looked up on the <a href="GAME_MASTER/movesets/">Pokemon Move Sets</a> page.
              </li>
              <li>
                CPM is a value based on the Pokemon's Level. See <a href="cpm.html">CPM</a> page.
              </li>
              <li>
                Effectiveness is determined by comparing the Move's Type to the Defending Pokemon's Type. See <a href="effectiveness.html">Move Effectiveness</a> page.
              </li>
            </ul>
          </div>
        </div>

        <br />
        <hr />
        <h2>
          <b>
            <u>D</u>
          </b>amage <b>
            <u>P</u>
          </b>er <b>
            <u>S</u>
          </b>econd <span class="NOTE">(DPS)</span> Formula
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'FORMULA_DPS'" />
          </xsl:call-template>
        </h2>
        <div id="FORMULA_DPS" class="INDENT">
          <p class="PARENT">
            To make things worse, as mentioned above, this is the formula for the <i>Damage</i> from a <b>
              <u>
                <i>Single</i>
              </u>
            </b> Move!
            To get the DPS for that Move you would only need to do:
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
                <td class="DIVIDE_BY" />
              </tr>
              <tr>
                <td>AttackTime</td>
              </tr>
            </table>
          </div>
          <p>
            <b style="font-size:x-large;">
              <xsl:value-of select="concat($nbsp, $nbsp, $nbsp)" />
              <i>
                <xsl:value-of select="concat('...', $nbsp, 'BUT', $nbsp, '...')" disable-output-escaping="yes" />
              </i>
            </b>
            <br />
          </p>
          <p class="PARENT">
            To get the DPS for a <u>
              <i>Move Set</i>
            </u> you have to use this formula:
          </p>
          <div class="INDENT">
            <table class="FORMULA">
              <tr>
                <td rowspan="15" style="padding-top:.5em;">
                  <b style="font-size:x-large">
                    <xsl:value-of select="concat('DPS', $nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                  </b>
                </td>
                <td rowspan="7" style="font-size:4em">(</td>
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="concat('FastMoveDamage', $nbsp, '*', $nbsp, 'CEILING')" disable-output-escaping="yes" />
                </td>
                <td rowspan="6" style="font-size:3em">(</td>
                <td />
                <td rowspan="6" style="font-size:3em">)</td>
                <td rowspan="7" style="font-size:4em">)</td>
                <td rowspan="7" style="padding-top:.5em;">+ ChargedMoveDamage</td>
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
                <td class="DIVIDE_BY" />
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
                <td class="DIVIDE_BY" colspan="7" />
              </tr>
              <tr>
                <td rowspan="7" style="font-size:4em">(</td>
                <td rowspan="7" style="padding-top:.5em;">
                  <xsl:value-of select="concat('*', $nbsp)" disable-output-escaping="yes" />
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
                <td class="DIVIDE_BY" />
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
          <br />
          <span class="NOTE">(If you can call that "simply".)</span>
        </div>

        <br />
        <hr />
        <h2>
          Simplifying <span class="NOTE">(True DPS)</span>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'FORMULA_TRUE_DPS'" />
          </xsl:call-template>
        </h2>
        <div id="FORMULA_TRUE_DPS" class="INDENT">
          <p>
            Obviously, we would like to do things to simplify the formula.
          </p>
          <p>
            First of all, the formulas really require us to know what Pokemon we are attacking.
            <br />There are a lot of options, but we just are looking for a way to compare one Move Set to another.
          </p>
          <p class="PARENT">
            Leveraging that, we can simplify a few things by assuming:
          </p>
          <ul class="CHILD">
            <li>
              The Pokemon being attacked has no + or - Effectiveness values.
              <div class="INDENT">
                Doing that, we can just remove Effectiveness from the formula.
              </div>
            </li>
            <li>
              The Pokemon being attacked is the same level as the attacking Pokemon.
              <div class="INDENT">
                Doing that, the CPMs cancel each other out.
              </div>
            </li>
            <li>
              A generic value for BaseDefense + DefenseIV.
              <div class="INDENT">
                For example, 100.
              </div>
            </li>
            <li>
              The AttackIV for the attacking Pokemon is perfect.
              <div class="INDENT">
                That is 15.
              </div>
            </li>
          </ul>
          <p class="PARENT">
            With those assumptions, the formula (after simplification) becomes:
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
                <td rowspan="7" style="padding-top:.5em;">+ 1</td>
              </tr>
              <tr>
                <td>
                  <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td>
                  <b>(</b>BaseAttack<xsl:value-of select="concat('BaseAttack', $nbsp, '+', $nbsp, '15')" disable-output-escaping="yes" /><b>)</b><xsl:value-of select="concat($nbsp, '*', $nbsp, 'Power', $nbsp, '*', $nbsp, 'STAB')" disable-output-escaping="yes" />
                </td>
              </tr>
              <tr>
                <td class="DIVIDE_BY" />
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
            Then, merging in the True DPS formula <span class="NOTE">(which is a little easier than it would have been with the full formula)</span>, we end up with:
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
                      <td rowspan="7" style="padding-top:.5em;">+ 1</td>
                      <td rowspan="7" style="font-size:4em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">
                        <xsl:value-of select="concat('*', $nbsp, 'CEILING')" disable-output-escaping="yes" />
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
                        <xsl:value-of select="concat($nbsp, '*', $nbsp, 'FastPower', $nbsp, '*', $nbsp, 'FastSTAB')" disable-output-escaping="yes" />
                      </td>
                      <td>ChargedMoveEnergy</td>
                      <td>
                        <b>(</b>
                        <xsl:value-of select="concat('BaseAttack', $nbsp, '+', $nbsp, '15')" disable-output-escaping="yes" />
                        <b>)</b>
                        <xsl:value-of select="concat($nbsp, '*', $nbsp, 'ChargedPower', $nbsp, '*', $nbsp, 'ChargedSTAB')" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td class="DIVIDE_BY" />
                      <td class="DIVIDE_BY" />
                      <td class="DIVIDE_BY" />
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
                <td class="DIVIDE_BY" />
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
                        <xsl:value-of select="concat('FastMoveTime', $nbsp, '*', $nbsp, 'CEILING')" disable-output-escaping="yes" />
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
                      <td colspan="4" class="DIVIDE_BY" />
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
            I refer to this as the "True DPS" on the charts in <a href="/tech/GAME_MASTER/movesets/">Pokemon Move Sets</a>.
          </p>
        </div>

        <br />
        <hr />
        <h2>
          Even Simpler <span class="NOTE">(MoveSet DPS)</span>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'FORMULA_MOVESET_DPS'" />
          </xsl:call-template>
        </h2>
        <div id="FORMULA_MOVESET_DPS" class="INDENT">
          <p>
            Obviously, this is still very complex.
            <br />To simplify it, many people will assume that both of the Pokemon's Base + IV scores cancel each other out.
            <span class="NOTE">(Which in reality is rarely the case.)</span>
          </p>
          <p class="PARENT">
            With that, we end up with:
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
                      <td rowspan="5" style="font-size:3em">(</td>
                      <td rowspan="7" style="padding-top:.5em;">
                        <xsl:value-of select="concat('FastPower', $nbsp, '*', $nbsp, 'FastSTAB')" disable-output-escaping="yes" />
                      </td>
                      <td rowspan="5" width="1" style="font-size:3em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">+ 1</td>
                      <td rowspan="7" style="font-size:4em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">*</td>
                      <td rowspan="7" style="padding-top:.5em;">CEILING</td>
                      <td rowspan="5" style="font-size:3em">(</td>
                      <td />
                      <td rowspan="5" style="font-size:3em">)</td>
                      <td rowspan="7" style="font-size:5em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">+</td>
                      <td rowspan="5" style="font-size:3em">(</td>
                      <td />
                      <td rowspan="5" style="font-size:3em">)</td>
                      <td rowspan="7" style="padding-top:.5em;">
                        <xsl:value-of select="concat('+', $nbsp)" disable-output-escaping="yes" />
                      </td>
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
                      <td>ChargedMoveEnergy</td>
                      <td rowspan="2">
                        <xsl:value-of select="concat('ChargedPower', $nbsp, '*', $nbsp, 'ChargedSTAB')" disable-output-escaping="yes" />
                      </td>
                    </tr>
                    <tr>
                      <td>FastMoveEnergy</td>
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
                      <td />
                      <td />
                      <td colspan="3" />
                      <td colspan="3" />
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="DIVIDE_BY" />
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
                        <xsl:value-of select="concat('FastMoveTime', $nbsp, '*', $nbsp, 'CEILING')" disable-output-escaping="yes" />
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
                      <td colspan="4" class="DIVIDE_BY" />
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
            I refer to this as the "MoveSet DPS" on the charts in <a href="/tech/GAME_MASTER/movesets/">Pokemon Move Sets</a>.
          </p>
        </div>

        <br />
        <hr />
        <h2>Sum-Up</h2>
        <p>
          Although these formulas are a quite technical, I have programmed them into a spreadsheet that does all the calculations.
          If any of the values change in the future, I just copy-and-paste them in and re-generate the data for the pages on this site.
          <div class="NOTE">
            NOTE: In the past, Niantic <b>
              <u>has</u>
            </b> adjusted the Base values for some of the Pokemon.
          </div>
        </p>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
