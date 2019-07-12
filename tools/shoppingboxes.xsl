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
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
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
          <xsl:choose>
            <xsl:when test="ShoppingBoxes/Event/@note != ''">
              <xsl:value-of select="ShoppingBoxes/Event/@date" />
              <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
              <span class="NOTE">
                <xsl:text>(</xsl:text>
                <xsl:value-of select="ShoppingBoxes/Event/@note" />
                <xsl:text>)</xsl:text>
              </span>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="ShoppingBoxes/@last_updated" />
            </xsl:otherwise>
          </xsl:choose>
        </p>

        <br />
        <hr />
        <h2 id="anchor_instructions">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'SHOPPING_INSTRUCTIONS'" />
          </xsl:call-template>
          <xsl:text>Instructions</xsl:text>
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
                    <xsl:text>Shop Prices and Values</xsl:text>
                    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
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
                    <xsl:text>Unit</xsl:text>
                    <br />
                    <xsl:text>Value</xsl:text>
                  </th>
                </tr>

                <xsl:apply-templates select="ShoppingBoxes/ItemValue[not(@legacy) and not(@assumed)]" />
                <tr>
                  <td colspan="4" style="text-align:center;" class="SHADED">
                    Below are items that are not usually for sale in the shop.
                    <br />Supply amount for how much gold they are worth to
                    <b>
                      <u>you</u>
                    </b>.
                  </td>
                </tr>
                <xsl:apply-templates select="ShoppingBoxes/ItemValue[@legacy or @assumed]" />

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
            <xsl:apply-templates select="ShoppingBoxes/Box" />
          </tr>
        </table>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="Box">
    <xsl:variable name="type" select="@type" />

    <td valign="top">
      <xsl:attribute name="id">
        <xsl:value-of select="@type" />
        <xsl:text>Box</xsl:text>
      </xsl:attribute>
      <table border="1">
        <tr>
          <th colspan="3" style="font-size:1em;">
            <xsl:attribute name="style">
              <xsl:choose>
                <xsl:when test="$type='Special'">font-size:1.5em;</xsl:when>
                <xsl:when test="$type='Great'">font-size:2em;</xsl:when>
                <xsl:when test="$type='Ultra'">font-size:3em;</xsl:when>
                <xsl:when test="$type='Other'">font-size:3em;</xsl:when>
              </xsl:choose>
            </xsl:attribute>

            <xsl:variable name="id" select="@box" />
            <xsl:variable name="title_pos">
              <xsl:choose>
                <xsl:when test="@title = ''">after</xsl:when>
                <xsl:otherwise>none</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:call-template name="Sprite">
              <xsl:with-param name="id" select="$id" />
              <xsl:with-param name="Settings">
                <Show sprite_class="TAG_ICON_MEDIUM">
                  <xsl:attribute name="title_pos">
                    <xsl:value-of select="$title_pos" />
                  </xsl:attribute>
                </Show>
              </xsl:with-param>
            </xsl:call-template>
            <xsl:if test="not(@title = '')">
              <xsl:value-of select="@title" />
            </xsl:if>
          </th>
        </tr>
        <tr>
          <th>Item</th>
          <th>Qty</th>
          <th>Value</th>
        </tr>
        <xsl:apply-templates select="Item">
          <xsl:with-param name="type" select="$type" />
        </xsl:apply-templates>
        <tr>
          <th colspan="2" align="right">Total Value</th>
          <td class="INPUT_CALCULATED">
            <input class="INPUT_CALCULATED" type="number" readonly="readonly">
              <xsl:attribute name="id">
                <xsl:value-of select="$type" />
                <xsl:text>Box_Total</xsl:text>
              </xsl:attribute>
            </input>
          </td>
        </tr>
        <tr>
          <th colspan="2" align="right">Price</th>
          <td class="INPUT">
            <input class="INPUT" type="number" readonly="readonly">
              <xsl:attribute name="id">
                <xsl:value-of select="$type" />
                <xsl:text>Box_Price</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="value">
                <xsl:value-of select="@price" />
              </xsl:attribute>
            </input>
          </td>
        </tr>
        <tr>
          <th colspan="2" align="right">Discount</th>
          <td align="center" style="font-weight:bold;">
            <xsl:attribute name="id">
              <xsl:value-of select="$type" />
              <xsl:text>Box_Discount</xsl:text>
            </xsl:attribute>
          </td>
        </tr>
      </table>
    </td>
    <td comment="spacer" />
  </xsl:template>

  <xsl:template match="Item">
    <xsl:param name="type" />

    <tr>
      <xsl:if test="@quantity=0">
        <xsl:attribute name="style">display:none;</xsl:attribute>
      </xsl:if>
      <th align="left">
        <xsl:call-template name="Sprite">
          <xsl:with-param name="id" select="@name" />
          <xsl:with-param name="Settings">
            <Show sprite_class="TAG_ICON_MEDIUM" title_pos="after" />
          </xsl:with-param>
        </xsl:call-template>
      </th>
      <td class="INPUT">
        <input class="INPUT" type="number">
          <xsl:attribute name="id">
            <xsl:value-of select="$type" />
            <xsl:text>Box_</xsl:text>
            <xsl:value-of select="@name" />
            <xsl:text>_Qty</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="value">
            <xsl:value-of select="@quantity" />
          </xsl:attribute>
        </input>
      </td>
      <td class="INPUT_CALCULATED">
        <input class="INPUT_CALCULATED" type="number" readonly="">
          <xsl:attribute name="id">
            <xsl:value-of select="$type" />
            <xsl:text>Box_</xsl:text>
            <xsl:value-of select="@name" />
            <xsl:text>_Value</xsl:text>
          </xsl:attribute>
        </input>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="ItemValue" >
    <xsl:variable name="item" select="@item" />
    <tr>
      <xsl:if test="not(/Root/ShoppingBoxes/Box/Item[@name=$item and not(@quantity=0)])">
        <xsl:attribute name="class">DISABLED</xsl:attribute>
      </xsl:if>
      
      <th align="left" valign="middle">
        <input type="checkbox" checked="checked" onchange="OnCheckChanged(this);">
          <xsl:attribute name="id">
            <xsl:value-of select="$item" />
            <xsl:text>_Check</xsl:text>
          </xsl:attribute>
        </input>
        <xsl:call-template name="Sprite">
          <xsl:with-param name="id" select="$item" />
          <xsl:with-param name="Settings">
            <Show sprite_class="TAG_ICON_MEDIUM" title_pos="after" />
          </xsl:with-param>
        </xsl:call-template>
      </th>
      <xsl:choose>
        <xsl:when test="@assumed">
          <td colspan="2" class="SHADED"></td>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="class">
            <xsl:choose>
              <xsl:when test="@legacy">SHADED</xsl:when>
              <xsl:otherwise>INPUT</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <td>
            <xsl:attribute name="class">
              <xsl:value-of select="$class" />
            </xsl:attribute>
            <input type="number" readonly="readonly">
              <xsl:attribute name="class">
                <xsl:value-of select="$class" />
              </xsl:attribute>
              <xsl:attribute name="id">
                <xsl:value-of select="$item" />
                <xsl:text>_Qty</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="value">
                <xsl:value-of select="@quantity" />
              </xsl:attribute>
            </input>
          </td>
          <td>
            <xsl:attribute name="class">
              <xsl:value-of select="$class" />
            </xsl:attribute>
            <input type="number" readonly="readonly">
              <xsl:attribute name="class">
                <xsl:value-of select="$class" />
              </xsl:attribute>
              <xsl:attribute name="id">
                <xsl:value-of select="$item" />
                <xsl:text>_Price</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="value">
                <xsl:value-of select="@price" />
              </xsl:attribute>
            </input>
          </td>
        </xsl:otherwise>
      </xsl:choose>
      <td class="INPUT_OPTIONAL">
        <input class="INPUT_OPTIONAL" type="number" onChange="OnValueChanged(this);">
          <xsl:attribute name="id">
            <xsl:value-of select="$item" />
            <xsl:text>_Value</xsl:text>
          </xsl:attribute>
        </input>
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
