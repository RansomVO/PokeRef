﻿<?xml version="1.0" encoding="utf-8"?>
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

        <title>CP Modifiers (CPM)</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          CP Modifiers (CPM)
        </h1>
        <p>
          When calculating how much damage a Pokemon will do, Pokemon GO takes into account the Level of the Pokemon.
          It does this by multiplying the Pokemon's BaseAttack and Attack IV by a constant corresponding to the Pokemon's level.
          <span class="NOTE">
            See <a href="formulas/movesetdamage.html">Move Set Damage Formulas</a> for more details.
          </span>
          <br />This is a chart of the values.
        </p>
        <br />
        <table>
          <tr>
            <td>
              <table border="1">
                <tr>
                  <th>Level</th>
                  <th>CPM</th>
                  <th>
                    Half-Level<br />CPM
                  </th>
                </tr>
                <tr>
                  <td align="right">1</td>
                  <td>0.09400000</td>
                  <td>0.135137432</td>
                </tr>
                <tr>
                  <td align="right">2</td>
                  <td>0.16639787</td>
                  <td>0.192650915</td>
                </tr>
                <tr>
                  <td align="right">3</td>
                  <td>0.21573247</td>
                  <td>0.236572655</td>
                </tr>
                <tr>
                  <td align="right">4</td>
                  <td>0.25572005</td>
                  <td>0.273530379</td>
                </tr>
                <tr>
                  <td align="right">5</td>
                  <td>0.29024988</td>
                  <td>0.306057380</td>
                </tr>
                <tr>
                  <td align="right">6</td>
                  <td>0.32108760</td>
                  <td>0.335445035</td>
                </tr>
                <tr>
                  <td align="right">7</td>
                  <td>0.34921268</td>
                  <td>0.362457752</td>
                </tr>
                <tr>
                  <td align="right">8</td>
                  <td>0.37523559</td>
                  <td>0.387592414</td>
                </tr>
                <tr>
                  <td align="right">9</td>
                  <td>0.39956728</td>
                  <td>0.411193544</td>
                </tr>
                <tr>
                  <td align="right">10</td>
                  <td>0.42250000</td>
                  <td>0.432926409</td>
                </tr>
                <tr>
                  <td align="right">11</td>
                  <td>0.44310755</td>
                  <td>0.453059958</td>
                </tr>
                <tr>
                  <td align="right">12</td>
                  <td>0.46279839</td>
                  <td>0.472336078</td>
                </tr>
                <tr>
                  <td align="right">13</td>
                  <td>0.48168495</td>
                  <td>0.490855809</td>
                </tr>
                <tr>
                  <td align="right">14</td>
                  <td>0.49985844</td>
                  <td>0.508701759</td>
                </tr>
                <tr>
                  <td align="right">15</td>
                  <td>0.51739395</td>
                  <td>0.525942511</td>
                </tr>
                <tr>
                  <td align="right">16</td>
                  <td>0.53435433</td>
                  <td>0.542635761</td>
                </tr>
                <tr>
                  <td align="right">17</td>
                  <td>0.55079269</td>
                  <td>0.558830597</td>
                </tr>
                <tr>
                  <td align="right">18</td>
                  <td>0.56675452</td>
                  <td>0.574569149</td>
                </tr>
                <tr>
                  <td align="right">19</td>
                  <td>0.58227891</td>
                  <td>0.589887908</td>
                </tr>
                <tr>
                  <td align="right">20</td>
                  <td>0.59740000</td>
                  <td>0.604823655</td>
                </tr>
                <tr>
                  <td align="right">21</td>
                  <td>0.61215729</td>
                  <td>0.619404115</td>
                </tr>
                <tr>
                  <td align="right">22</td>
                  <td>0.62656713</td>
                  <td>0.633649182</td>
                </tr>
                <tr>
                  <td align="right">23</td>
                  <td>0.64065295</td>
                  <td>0.647580959</td>
                </tr>
                <tr>
                  <td align="right">24</td>
                  <td>0.65443563</td>
                  <td>0.661219261</td>
                </tr>
                <tr>
                  <td align="right">25</td>
                  <td>0.66793400</td>
                  <td>0.674581899</td>
                </tr>
                <tr>
                  <td align="right">26</td>
                  <td>0.68116492</td>
                  <td>0.687684904</td>
                </tr>
                <tr>
                  <td align="right">27</td>
                  <td>0.69414365</td>
                  <td>0.700542894</td>
                </tr>
                <tr>
                  <td align="right">28</td>
                  <td>0.70688421</td>
                  <td>0.713169102</td>
                </tr>
                <tr>
                  <td align="right">29</td>
                  <td>0.71939909</td>
                  <td>0.725575613</td>
                </tr>
                <tr>
                  <td align="right">30</td>
                  <td>0.73170000</td>
                  <td>0.734741007</td>
                </tr>
                <tr>
                  <td align="right">31</td>
                  <td>0.73776948</td>
                  <td>0.740785570</td>
                </tr>
                <tr>
                  <td align="right">32</td>
                  <td>0.74378943</td>
                  <td>0.746781204</td>
                </tr>
                <tr>
                  <td align="right">33</td>
                  <td>0.74976104</td>
                  <td>0.752729104</td>
                </tr>
                <tr>
                  <td align="right">34</td>
                  <td>0.75568551</td>
                  <td>0.758630369</td>
                </tr>
                <tr>
                  <td align="right">35</td>
                  <td>0.76156384</td>
                  <td>0.764486069</td>
                </tr>
                <tr>
                  <td align="right">36</td>
                  <td>0.76739717</td>
                  <td>0.770297274</td>
                </tr>
                <tr>
                  <td align="right">37</td>
                  <td>0.77318650</td>
                  <td>0.776064943</td>
                </tr>
                <tr>
                  <td align="right">38</td>
                  <td>0.77893275</td>
                  <td>0.781790078</td>
                </tr>
                <tr>
                  <td align="right">39</td>
                  <td>0.78463700</td>
                  <td>0.787473591</td>
                </tr>
                <tr>
                  <td align="right">40</td>
                  <td>0.79030000</td>
                  <td class="UNUSED" />
                </tr>
              </table>
            </td>
            <td valign="top">
              <h2>NOTES</h2>
              <ul class="CHILD">
                <li>
                  Values in the <b>CPM</b> column are the CPM constants for each level. <span class="NOTE">(E.G. 1, 2, 3, etc.)</span>
                </li>
                <li>
                  Values in the <b>Half Level CPM</b> column are calculated for half-levels <span class="NOTE">(E.G. 1.5, 2.5, 3.5, etc.)</span> using this formula:
                  <div class="INDENT">
                    <table class="FORMULA">
                      <tr>
                        <td rowspan="5" style="font-size:1.5em; padding-top:.5em;">
                          <b>
                            Half-Level CPM<xsl:value-of select="concat($nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                          </b>
                        </td>
                        <td rowspan="5" style="font-size:5em">&#x221A;</td>
                        <td class="FORMULA_DIVIDE_BY" colspan="3" />
                      </tr>
                      <tr>
                        <td valign="top" style="font-size:2em">(</td>
                        <td>
                          LevelBelow<sup>2</sup> + LevelAbove<sup>2</sup>
                        </td>
                        <td valign="top" style="font-size:2em">)</td>
                      </tr>
                      <tr>
                        <td class="FORMULA_DIVIDE_BY" colspan="3" />
                      </tr>
                      <tr>
                        <td colspan="3">2</td>
                      </tr>
                      <tr>
                        <td colspan="3">
                          <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                        </td>
                      </tr>
                    </table>
                  </div>
                  For example, for level 1.5 it would be:
                  <div class="INDENT">
                    <table class="FORMULA">
                      <tr>
                        <td rowspan="5" style="font-size:1.5em; padding-top:.5em;">
                          <b>
                            Half-Level CPM<xsl:value-of select="concat($nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                          </b>
                        </td>
                        <td rowspan="5" style="font-size:5em;">&#x221A;</td>
                        <td class="FORMULA_DIVIDE_BY" colspan="3" />
                        <td rowspan="5" style="font-size:1.5em; padding-top:.5em;">
                          <b>
                            <xsl:value-of select="concat($nbsp, $nbsp, '=', $nbsp)" disable-output-escaping="yes" />
                          </b>
                        </td>
                        <td rowspan="5" style="padding-top:.5em;">0.135137432</td>
                      </tr>
                      <tr>
                        <td valign="top" style="font-size:2em">(</td>
                        <td>
                          0.09400000<sup>2</sup> + 0.16639787<sup>2</sup>
                        </td>
                        <td valign="top" style="font-size:2em">)</td>
                      </tr>
                      <tr>
                        <td class="FORMULA_DIVIDE_BY" colspan="3" />
                      </tr>
                      <tr>
                        <td colspan="3">2</td>
                      </tr>
                      <tr>
                        <td colspan="3">
                          <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
                        </td>
                      </tr>
                    </table>
                  </div>
                </li>
              </ul>
            </td>
          </tr>
        </table>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
