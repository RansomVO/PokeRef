<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html>
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <!-- Local Script must always come first. (Shared ones need to be able to override it.) -->
        <script>
          <xsl:attribute name="src">
            <xsl:text>shoppingboxes.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
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

        <title>Shopping Box Values</title>

        <xsl:value-of select="concat($lt, '!-- Styles for just this page --', $gt)" disable-output-escaping="yes" />
        <style>
          td, th {
          white-space: nowrap;
          }

          td {
          text-align: right;
          padding-right: .5em;
          }
          
          input {
          border: none;
          text-align: right;
          width: 4em;
          background-color: inherit;
          }

          ol {
          display: table;
          counter-reset: item;
          }

          ol > li {
          display: table-row;
          counter-increment: item;
          }

          ol > li:before {
          padding-top: 1em;
          font-weight: bold;
          font-size: x-large;
          width: 2em;
          display: table-cell;
          content: counter(item) ')';
          }

          input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button {
          -webkit-appearance: none;
          margin: 0;
          }

        </style>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Shopping Box Values
        </h1>
        <p>
          When there are Events in
          Pokemon GO, they usually have some sort of special package deals in the Shop.
          However, sometimes the boxes are so full of stuff you don't need, they end up not being of any value.
          <br />
          This page is a tool to help you determine how valuable a given box is to you.
        </p>
        <p>
          <b>Last Updated</b>:
          <span id="UpdateDate">.</span> <!-- For some reason, if the '.' isn't there, the span wraps around the rest of the contents of the <p> -->
          <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
          <span id="UpdateNote" class="NOTE"/>
        </p>

        <br />
        <hr />
        <h2 id="anchor_instructions">
          Instructions
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'SHOPPING_INSTRUCTIONS'" />
          </xsl:call-template>
        </h2>
        <ol id="SHOPPING_INSTRUCTIONS">
          <li>
            Make sure the <table style="display:inline-table;">
              <tr>
                <th style="border:1px solid;" class="INPUT">
                  Values from
                  Pokemon GO Shop
                </th>
              </tr>
            </table> fields are correct.
            <br />This may need to be done for the <a href="#shopprices">Shop Prices and Values</a> as well as each of the <a href="#boxes">Boxes</a>.
            <br />
            <span class="NOTE">
              <b>NOTE</b>: I try to keep them <a href="#uptodate">up-to-date</a>, but I have left the fields editable so you can use the latest values in case I fall behind.
            </span>
          </li>
          <li>
            <b>Optional</b>: Update the <table style="display:inline-table;">
              <tr>
                <th style="border:1px solid;" class="INPUT_OPTIONAL">Values that are calculated, but you can override</th>
              </tr>
            </table> if you wish.
            <br />
            For example, if you feel Super Incubators are only worth as much as regular Incubators, change the value from 200 to 150.
          </li>
          <li>
            Now for the easy part.
            <br />Set the checkboxes in the <a href="#shopprices">Shop Prices and Values</a>:
            <ul>
              <li>If you value the item, turn the checkbox on.</li>
              <li>If you don't care about the item, turn the checkbox off.</li>
            </ul>
          </li>
          <li>
            Look in the Final Results fields to see whether the discount is <table style="display:inline-table;">
              <tr>
                <th style="border:1px solid;" class="GOOD">Good</th>
              </tr>
            </table> or <table style="display:inline-table;">
              <tr>
                <th style="border:1px solid;" class="BAD">Bad</th>
              </tr>
            </table> and which box (if any) is the best deal for <span class="EMPHASIS">you</span>.
          </li>
        </ol>

        <br />
        <hr />
        <table id="anchor_values">
          <tr>
            <td>
              <table id="shopprices" comment="Shop Prices and Values" border="1">
                <tr>
                  <th colspan="4" style="font-size:2em;">
                    Shop Prices and Values
                    <xsl:call-template name="OutputResetButton">
                      <xsl:with-param name="Callback" select="'Reset(true);'" />
                    </xsl:call-template>
                  </th>
                </tr>
                <tr>
                  <th>
                    <div style="float:left; text-align:left;">
                      <input id="AllItems_Check" class="NUMERIC" type="checkbox" onchange="OnAllItemsCheckChanged();" />
                    </div>Items
                  </th>
                  <th>Qty</th>
                  <th>Price</th>
                  <th>
                    Unit<br />Value
                  </th>
                </tr>
                <tr>
                  <th align="left" valign="middle">
                    <input id="PremiumRaidPass_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'RaidPassPremium'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Premium Raid Pass</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="PremiumRaidPass_Qty" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT">
                    <input class="INPUT" id="PremiumRaidPass_Price" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="PremiumRaidPass_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="MaxRevives_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'ReviveMax'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Max Revives</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="MaxRevives_Qty" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT">
                    <input class="INPUT" id="MaxRevives_Price" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="MaxRevives_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="MaxPotions_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'PotionMax'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Max Potions</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="MaxPotions_Qty" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT">
                    <input class="INPUT" id="MaxPotions_Price" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="MaxPotions_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="PokeBalls_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallRegular'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Poke Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="PokeBalls_Qty" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT">
                    <input class="INPUT" id="PokeBalls_Price" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="PokeBalls_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="Lures_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Lure'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Lure Modules</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="Lures_Qty" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT">
                    <input class="INPUT" id="Lures_Price" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="Lures_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="Incubator_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Incubator'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Egg Incubator</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="Incubator_Qty" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT">
                    <input class="INPUT" id="Incubator_Price" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="Incubator_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="LuckyEggs_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Lucky'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Lucky Eggs</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="LuckyEggs_Qty" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT">
                    <input class="INPUT" id="LuckyEggs_Price" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="LuckyEggs_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="Incense_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Incense'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Incense</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="Incense_Qty" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT">
                    <input class="INPUT" id="Incense_Price" type="number" onChange="OnValueChanged();" />
                  </td>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="Incense_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="StarPiece_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'StarPiece'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Star Piece</xsl:text>
                  </th>
                  <td class="SHADED" colspan="2" rowspan="8" width="1px;" style="white-space:normal; font-style:italic; text-align:center">
                    These are not for sale in the shop.
                    <br />Supply amount for how much gold they are worth to <b>
                      <u>you</u>
                    </b>.
                  </td>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="StarPiece_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="SuperIncubator_Check" type="checkbox" checked="checked" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'IncubatorSuper'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Super Egg Incubator</xsl:text>
                  </th>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="SuperIncubator_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="UltraBalls_Check" type="checkbox" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallUltra'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Ultra Balls</xsl:text>
                  </th>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="UltraBalls_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="GreatBalls_Check" type="checkbox" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallGreat'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Great Balls</xsl:text>
                  </th>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="GreatBalls_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="RazzBerries_Check" type="checkbox" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryRazz'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Razz Berries</xsl:text>
                  </th>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="RazzBerries_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="NanabBerries_Check" type="checkbox" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryNanab'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Nanab Berries</xsl:text>
                  </th>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="NanabBerries_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="PinapBerries_Check" type="checkbox" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryPinap'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Pinap Berries</xsl:text>
                  </th>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="PinapBerries_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <input id="GoldenBerries_Check" type="checkbox" onchange="OnCheckChanged(this);" />
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryGolden'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Golden Razz Berries</xsl:text>
                  </th>
                  <td class="INPUT_OPTIONAL">
                    <input class="INPUT_OPTIONAL" id="GoldenBerries_Value" type="number" onChange="OnValueChanged(this);" />
                  </td>
                </tr>
              </table>
            </td>
            <td comment="spacer" />
            <td align="left" valign="top">
              <table border="1">
                <tr>
                  <th style="border:none; font-size:xx-large">Key</th>
                </tr>
                <tr>
                  <th class="INPUT">Values from Pokemon GO Shop.</th>
                </tr>
                <tr>
                  <th class="INPUT_OPTIONAL">Values that are calculated, but you can override.</th>
                </tr>
                <tr>
                  <th class="INPUT_CALCULATED">Values that are calculated.</th>
                </tr>
                <tr>
                  <th class="GOOD">Good Final Results.</th>
                </tr>
                <tr>
                  <th class="BAD">Bad Final Results.</th>
                </tr>
              </table>
            </td>
          </tr>
        </table>
        <br />
        <table id="anchor_boxes" comment="Boxes">
          <tr>
            <td valign="top" id="SpecialBox">
              <table comment="Special Box" border="1">
                <tr>
                  <th colspan="3">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BoxSpecial'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <span style="font-size:1em;">Special Box</span>
                  </th>
                </tr>
                <tr>
                  <th>Item</th>
                  <th>Qty</th>
                  <th>Value</th>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'RaidPassPremium'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Premium Raid Pass</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_PremiumRaidPass_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_PremiumRaidPass_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th>Max Revives</th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_MaxRevives_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_MaxRevives_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'ReviveMax'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Max Revives</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_MaxPotions_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_MaxPotions_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallRegular'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Poke Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_PokeBalls_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_PokeBalls_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Lure'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Lure Modules</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_Lures_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_Lures_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Incubator'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Egg Incubator</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_Incubator_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_Incubator_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Lucky'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Lucky Eggs</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_LuckyEggs_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_LuckyEggs_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Incense'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Incense</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_Incense_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_Incense_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'StarPiece'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Star Piece</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_StarPiece_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_StarPiece_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'IncubatorSuper'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Super Egg Incubator</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_SuperIncubator_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_SuperIncubator_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallGreat'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Great Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_GreatBalls_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_GreatBalls_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallUltra'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Ultra Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_UltraBalls_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_UltraBalls_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryRazz'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Razz Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_RazzBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_RazzBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryNanab'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Nanab Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_NanabBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_NanabBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryPinap'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Pinap Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_PinapBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_PinapBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryGolden'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Golden Razz Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_GoldenBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_GoldenBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th colspan="2" align="right">Total Value</th>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="SpecialBox_Total" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th colspan="2" align="right">Price</th>
                  <td class="INPUT">
                    <input class="INPUT" id="SpecialBox_Price" type="number" />
                  </td>
                </tr>
                <tr>
                  <th colspan="2" align="right">Discount</th>
                  <td style="padding-right:1em;">
                    <input id="SpecialBox_Discount" type="number" class="HIDE_SPINNERS" readonly="" />%
                  </td>
                </tr>
              </table>
            </td>
            <td comment="spacer" />
            <td valign="top" id="GreatBox">
              <table comment="Great Box" border="1">
                <tr>
                  <th colspan="3">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BoxGreat'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <span style="font-size:1.5em;">Great Box</span>
                  </th>
                </tr>
                <tr>
                  <th>Item</th>
                  <th>Qty</th>
                  <th>Value</th>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'RaidPassPremium'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Premium Raid Pass</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_PremiumRaidPass_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_PremiumRaidPass_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th>Max Revives</th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_MaxRevives_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_MaxRevives_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'ReviveMax'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Max Revives</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_MaxPotions_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_MaxPotions_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallRegular'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Poke Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_PokeBalls_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_PokeBalls_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Lure'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Lure Modules</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_Lures_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_Lures_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Incubator'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Egg Incubator</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_Incubator_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_Incubator_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Lucky'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Lucky Eggs</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_LuckyEggs_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_LuckyEggs_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Incense'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Incense</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_Incense_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_Incense_Value" type="number" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'StarPiece'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Star Piece</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_StarPiece_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_StarPiece_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'IncubatorSuper'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Super Egg Incubator</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_SuperIncubator_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_SuperIncubator_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallGreat'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Great Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_GreatBalls_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_GreatBalls_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallUltra'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Ultra Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_UltraBalls_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_UltraBalls_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryRazz'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Razz Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_RazzBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_RazzBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryNanab'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Nanab Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_NanabBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_NanabBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryPinap'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Pinap Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_PinapBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_PinapBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryGolden'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Golden Razz Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_GoldenBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_GoldenBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th colspan="2" align="right">Total Value</th>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="GreatBox_Total" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th colspan="2" align="right">Price</th>
                  <td class="INPUT">
                    <input class="INPUT" id="GreatBox_Price" type="number" />
                  </td>
                </tr>
                <tr>
                  <th colspan="2" align="right">Discount</th>
                  <td style="padding-right:1em;">
                    <input id="GreatBox_Discount" type="number" class="HIDE_SPINNERS" readonly="" />%
                  </td>
                </tr>
              </table>
            </td>
            <td comment="spacer" />
            <td valign="top" id="UltraBox">
              <table border="1">
                <tr>
                  <th colspan="3">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BoxUltra'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <span style="font-size:2em;">Ultra Box</span>
                  </th>
                </tr>
                <tr>
                  <th>Item</th>
                  <th>Qty</th>
                  <th>Value</th>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'RaidPassPremium'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Premium Raid Pass</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_PremiumRaidPass_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_PremiumRaidPass_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th>Max Revives</th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_MaxRevives_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_MaxRevives_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'ReviveMax'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Max Revives</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_MaxPotions_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_MaxPotions_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallRegular'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Poke Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_PokeBalls_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_PokeBalls_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Lure'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Lure Modules</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_Lures_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_Lures_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Incubator'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Egg Incubator</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_Incubator_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_Incubator_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Lucky'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Lucky Eggs</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_LuckyEggs_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_LuckyEggs_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Incense'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Incense</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_Incense_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_Incense_Value" type="number" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'StarPiece'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Star Piece</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_StarPiece_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_StarPiece_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'IncubatorSuper'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Super Egg Incubator</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_SuperIncubator_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_SuperIncubator_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallGreat'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Great Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_GreatBalls_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_GreatBalls_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BallUltra'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Ultra Balls</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_UltraBalls_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_UltraBalls_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryRazz'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Razz Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_RazzBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_RazzBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryNanab'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Nanab Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_NanabBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_NanabBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th align="left">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryPinap'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Pinap Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_PinapBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_PinapBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th>
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'BerryGolden'" />
                      <xsl:with-param name="class" select="'TAG_ICON_MEDIUM'" />
                    </xsl:call-template>
                    <xsl:text>Golden Razz Berries</xsl:text>
                  </th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_GoldenBerries_Qty" type="number" />
                  </td>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_GoldenBerries_Value" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th colspan="2" align="right">Total Value</th>
                  <td class="INPUT_CALCULATED">
                    <input class="INPUT_CALCULATED" id="UltraBox_Total" type="number" readonly="" />
                  </td>
                </tr>
                <tr>
                  <th colspan="2" align="right">Price</th>
                  <td class="INPUT">
                    <input class="INPUT" id="UltraBox_Price" type="number" />
                  </td>
                </tr>
                <tr>
                  <th colspan="2" align="right">Discount</th>
                  <td style="padding-right:1em;">
                    <input id="UltraBox_Discount" type="number" class="HIDE_SPINNERS" readonly="" />%
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
