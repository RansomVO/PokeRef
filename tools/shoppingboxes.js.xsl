<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:output omit-xml-declaration="yes" />
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <xsl:text>LastUpdated = '</xsl:text>
    <xsl:value-of select="ShoppingBoxes/@last_updated" />
    <xsl:text>';
    
// #region Common
// ============================================================================
// #region Global Variables
// ============================================================================

// Constants: Prices in Shop
</xsl:text>
    <xsl:apply-templates select="ShoppingBoxes/ItemValue[not(@legacy) and not(@assumed)]" />
    <xsl:text>
// Constants: Prices seen when available
</xsl:text>
    <xsl:apply-templates select="ShoppingBoxes/ItemValue[@legacy and not(@assumed)]" />
    <xsl:text>
// Constants: Assumed Values for items that may be in boxes, but are not in Shop.
</xsl:text>
    <xsl:apply-templates select="ShoppingBoxes/ItemValue[@assumed]" />
    <xsl:text>
// #endregion Global Variables
    <!-- #region Cookies -->
// ============================================================================
//#region Cookies
// ============================================================================

// Fields that should be saved in cookies.
var CookieSettings = {
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>    '</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check': '</xsl:text>
      <xsl:value-of select="@default_check" />
      <xsl:text>',
</xsl:text>
    </xsl:for-each>
    <xsl:text>
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:choose>
        <xsl:when test="@assumed">
          <xsl:text>    '</xsl:text>
          <xsl:value-of select="@item" />
          <xsl:text>_Value': </xsl:text>
          <xsl:value-of select="@item" />
          <xsl:text>_AssumedValue,
</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>    '</xsl:text>
          <xsl:value-of select="@item" />
          <xsl:text>_Value': </xsl:text>
          <xsl:value-of select="@item" />
          <xsl:text>_Value_Price / </xsl:text>
          <xsl:value-of select="@item" />
          <xsl:text>_Value_Qty,
</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:text>};

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    ApplyCookieSettings(CookieSettings);
}

// #endregion Cookies
    <!-- #endregion Cookies -->
    <!-- #region Static Code -->
// ==============================================================================================
// Called when page is loaded to perform up-front work.
// ==============================================================================================
// NOTE: This .js MUST be specified BEFORE any other </xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text>script</xsl:text>
    <xsl:value-of select="$gt" disable-output-escaping="yes" />
    <xsl:text> nodes in the </xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text>html</xsl:text>
    <xsl:value-of select="$gt" disable-output-escaping="yes" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text>head</xsl:text>
    <xsl:value-of select="$gt" disable-output-escaping="yes" />
    <xsl:text> so that 
//          the window.onload() from the other scripts have the opportunity to overload this.
window.onload = function () {
    try {
        GetFields();</xsl:text>

    <xsl:if test="ShoppingBoxes/Box[@type='Community']/@price=0 or ShoppingBoxes/Box[@type='Special']/@price=0 or ShoppingBoxes/Box[@type='Great']/@price=0 or ShoppingBoxes/Box[@type='Ultra']/@price=0 or ShoppingBoxes/Box[@type='Other']/@price=0">
      <xsl:text>
        // Hide boxes that are not available.
</xsl:text>
      <xsl:if test="ShoppingBoxes/Box[@type='Community']/@price=0">
        <xsl:text>        document.getElementById('CommunityBox').style.display = 'none';</xsl:text>
      </xsl:if>
      <xsl:if test="ShoppingBoxes/Box[@type='Special']/@price=0">
        <xsl:text>        document.getElementById('SpecialBox').style.display = 'none';</xsl:text>
      </xsl:if>
      <xsl:if test="ShoppingBoxes/Box[@type='Great']/@price=0">
        <xsl:text>        document.getElementById('GreatBox').style.display = 'none';</xsl:text>
      </xsl:if>
      <xsl:if test="ShoppingBoxes/Box[@type='Ultra']/@price=0">
        <xsl:text>        document.getElementById('UltraBox').style.display = 'none';</xsl:text>
      </xsl:if>
      <xsl:if test="ShoppingBoxes/Box[@type='Other']/@price=0">
        <xsl:text>        document.getElementById('Other').style.display = 'none';</xsl:text>
      </xsl:if>
    </xsl:if>
    <xsl:text>

        var updateDate = GetCookieSetting('LastUpdated');
        Reset(updateDate !== LastUpdated);
        SetCookieSetting('LastUpdated', LastUpdated);
    } catch (err) {
        ShowError(err);
    }
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

// Get the fields we will be using multiple times.
function GetFields() {
    AllItems_Check = document.getElementById('AllItems_Check');
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>    </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check = document.getElementById('</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check');
</xsl:text>
      <xsl:text>    </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value = document.getElementById('</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value');
</xsl:text>
    </xsl:for-each>

    <xsl:text>
    CommunityBox_Price = document.getElementById('CommunityBox_Price');
    CommunityBox_Total = document.getElementById('CommunityBox_Total');
    CommunityBox_Discount = document.getElementById('CommunityBox_Discount');
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>    CommunityBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty = document.getElementById('CommunityBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty');
</xsl:text>
    </xsl:for-each>

    <xsl:text>
    SpecialBox_Price = document.getElementById('SpecialBox_Price');
    SpecialBox_Total = document.getElementById('SpecialBox_Total');
    SpecialBox_Discount = document.getElementById('SpecialBox_Discount');
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>    SpecialBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty = document.getElementById('SpecialBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty');
</xsl:text>
    </xsl:for-each>

    <xsl:text>
    GreatBox_Price = document.getElementById('GreatBox_Price');
    GreatBox_Total = document.getElementById('GreatBox_Total');
    GreatBox_Discount = document.getElementById('GreatBox_Discount');
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>    GreatBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty = document.getElementById('GreatBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty');
</xsl:text>
    </xsl:for-each>

    <xsl:text>
    UltraBox_Price = document.getElementById('UltraBox_Price');
    UltraBox_Total = document.getElementById('UltraBox_Total');
    UltraBox_Discount = document.getElementById('UltraBox_Discount');
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>    UltraBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty = document.getElementById('UltraBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty');
</xsl:text>
    </xsl:for-each>

    <xsl:text>
    OtherBox_Price = document.getElementById('OtherBox_Price');
    OtherBox_Total = document.getElementById('OtherBox_Total');
    OtherBox_Discount = document.getElementById('OtherBox_Discount');
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>    OtherBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty = document.getElementById('OtherBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty');
</xsl:text>
    </xsl:for-each>}
    <xsl:text>

// Reset all of the fields.
//  (If clearCache, also reset the cookies.)
function Reset(clearCache) {
    if (clearCache) {
        ClearCookieSettings(CookieSettings);
    }

    //InitializeChecks();

    ApplyCookie();

    OnCheckChanged(null);
}

// Set default state of which Items should be included in calculations. 
function InitializeChecks() {
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>    InitialCheck(</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check, '</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>', </xsl:text>
      <xsl:value-of select="@default_check" />
      <xsl:text>);
</xsl:text>
    </xsl:for-each>
    <xsl:text>
    UpdateAllItemsCheck();
}

// Set the default state of a single checkbox, disabling rows that aren't used.
function InitialCheck(checkbox, index, checkDefault) {
    if (CommunityBox[index] === 0 </xsl:text>
    <xsl:value-of select="concat($amp,$amp)" disable-output-escaping="yes" />
    <xsl:text> SpecialBox[index] === 0 </xsl:text>
    <xsl:value-of select="concat($amp,$amp)" disable-output-escaping="yes" />
    <xsl:text> GreatBox[index] === 0 </xsl:text>
    <xsl:value-of select="concat($amp,$amp)" disable-output-escaping="yes" />
    <xsl:text> UltraBox[index] === 0 </xsl:text> 
    <xsl:value-of select="concat($amp,$amp)" disable-output-escaping="yes" />
      <xsl:text> OtherBox[index] === 0) {
        checkbox.checked = false;
        checkbox.parentNode.classList.add('DISABLED');
    } else {
        checkbox.checked = checkDefault;
    }
}

// Updates the state of the AllItems checkbox.
function UpdateAllItemsCheck() {
    if (true</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>
        </xsl:text>
      <xsl:value-of select="concat($amp,$amp)" disable-output-escaping="yes" />
      <xsl:text> </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked</xsl:text>
    </xsl:for-each>
    <xsl:text>) {
        AllItems_Check.indeterminate = false;
        AllItems_Check.checked = true;
    } else if (true</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>
        </xsl:text>
      <xsl:value-of select="concat($amp,$amp)" disable-output-escaping="yes" />
      <xsl:text> !</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked</xsl:text>
    </xsl:for-each>
    <xsl:text>) {
        AllItems_Check.indeterminate = false;
        AllItems_Check.checked = false;
    } else {
        AllItems_Check.indeterminate = true;
    }
}

// Called when any of the value fields are updated.
// It recalculates the Total Value and Discount for each box.
function OnValueChanged(field) {
    try {
        // This field changed, so update the cookie.
        if (field !== undefined </xsl:text>
    <xsl:value-of select="concat($amp,$amp)" disable-output-escaping="yes" />
    <xsl:text> field !== null) {
            UpdateCookieSetting(field.id);
        }

        // Calculate the Value
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>        if (GetCookieSetting('</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value') === null)
            </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value = </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:choose>
        <xsl:when test="@assumed">
          <xsl:text>_AssumedValue;
</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>_Price.value / </xsl:text>
          <xsl:value-of select="@item" />
          <xsl:text>_Qty.value;
</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:text>
        // Calculate the amount in each of the Box's Value column.
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>        if (</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked) {
            if (CommunityBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value !== '') {
                CommunityBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value = CommunityBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value * </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value;
            }
            if (SpecialBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value !== '') {
                SpecialBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value = SpecialBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value * </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value;
            }
            if (GreatBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value !== '') {
                GreatBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value = GreatBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value * </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value;
            }
            if (UltraBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value !== '') {
                UltraBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value = UltraBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value * </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value;
            }
            if (OtherBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value !== '') {
                OtherBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value = OtherBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Qty.value * </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value;
            }
        }
</xsl:text>
    </xsl:for-each>
    <xsl:text>
        // Calculate the Total Value for each box.
        CommunityBox_Total.value = 0</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>
            + (</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked ? Number(CommunityBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value) : 0)</xsl:text>
    </xsl:for-each>
    <xsl:text>;

        SpecialBox_Total.value = 0</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>
            + (</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked ? Number(SpecialBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value) : 0)</xsl:text>
    </xsl:for-each>
    <xsl:text>;

        GreatBox_Total.value = 0</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>
            + (</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked ? Number(GreatBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value) : 0)</xsl:text>
    </xsl:for-each>
    <xsl:text>;

        UltraBox_Total.value = 0</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>
            + (</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked ? Number(UltraBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value) : 0)</xsl:text>
    </xsl:for-each>
    <xsl:text>;

        OtherBox_Total.value = 0</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>
            + (</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked ? Number(OtherBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.value) : 0)</xsl:text>
    </xsl:for-each>
    <xsl:text>;

      // Calculate the Discount.
      var value = Math.round((1 - (Number(CommunityBox_Price.value) / Number(CommunityBox_Total.value))) * 100);
      CommunityBox_Discount.innerText = value + '%';
      if (value </xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text> 0) {
            CommunityBox_Discount.classList.remove('GOOD');
            CommunityBox_Discount.classList.add('BAD');
        } else {
            CommunityBox_Discount.classList.remove('BAD');
            CommunityBox_Discount.classList.add('GOOD');
        }

      var value = Math.round((1 - (Number(SpecialBox_Price.value) / Number(SpecialBox_Total.value))) * 100);
      SpecialBox_Discount.innerText = value + '%';
      if (value </xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text> 0) {
            SpecialBox_Discount.classList.remove('GOOD');
            SpecialBox_Discount.classList.add('BAD');
        } else {
            SpecialBox_Discount.classList.remove('BAD');
            SpecialBox_Discount.classList.add('GOOD');
        }

        value = Math.round((1 - (Number(GreatBox_Price.value) / Number(GreatBox_Total.value))) * 100);
        GreatBox_Discount.innerText = value + '%';
        if (value </xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text> 0) {
            GreatBox_Discount.classList.remove('GOOD');
            GreatBox_Discount.classList.add('BAD');
        } else {
            GreatBox_Discount.classList.remove('BAD');
            GreatBox_Discount.classList.add('GOOD');
        }

        value = Math.round((1 - (Number(UltraBox_Price.value) / Number(UltraBox_Total.value))) * 100);
        UltraBox_Discount.innerText = value + '%';
        if (value </xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text> 0) {
            UltraBox_Discount.classList.remove('GOOD');
            UltraBox_Discount.classList.add('BAD');
        } else {
            UltraBox_Discount.classList.remove('BAD');
            UltraBox_Discount.classList.add('GOOD');
        }

        value = Math.round((1 - (Number(OtherBox_Price.value) / Number(OtherBox_Total.value))) * 100);
        OtherBox_Discount.innerText = value + '%';
        if (value </xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text> 0) {
            OtherBox_Discount.classList.remove('GOOD');
            OtherBox_Discount.classList.add('BAD');
        } else {
            OtherBox_Discount.classList.remove('BAD');
            OtherBox_Discount.classList.add('GOOD');
        }
    } catch (err) {
        ShowError(err);
    }
}

// Called when one of the Item's checkbox it toggled.
// It enables/disables the Qty, Price and Value fields for the row and disables the corresponding row in the Boxes, then calls OnValueChanged() to recalculate.
function OnCheckChanged(checkbox) {
    try {
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>        if (</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked) {
            </xsl:text>
      <xsl:if test="not(@assumed)">
        <xsl:value-of select="@item" />
        <xsl:text>_Qty.parentNode.classList.remove('DISABLED');
            </xsl:text>
        <xsl:value-of select="@item" />
        <xsl:text>_Price.parentNode.classList.remove('DISABLED');
            </xsl:text>
      </xsl:if>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.classList.remove('DISABLED');
            CommunityBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.classList.remove('DISABLED');
            SpecialBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.parentNode.classList.remove('DISABLED');
            GreatBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.parentNode.classList.remove('DISABLED');
            UltraBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.parentNode.classList.remove('DISABLED');
            OtherBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.parentNode.classList.remove('DISABLED');
        } else {
            </xsl:text>
      <xsl:if test="not(@assumed)">
        <xsl:value-of select="@item" />
        <xsl:text>_Qty.parentNode.classList.add('DISABLED');
            </xsl:text>
        <xsl:value-of select="@item" />
        <xsl:text>_Price.parentNode.classList.add('DISABLED');
            </xsl:text>
      </xsl:if>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.classList.add('DISABLED');
            CommunityBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.classList.add('DISABLED');
            SpecialBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.parentNode.classList.add('DISABLED');
            GreatBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.parentNode.classList.add('DISABLED');
            UltraBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.parentNode.classList.add('DISABLED');
            OtherBox_</xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Value.parentNode.parentNode.classList.add('DISABLED');
        }

</xsl:text>
    </xsl:for-each>
    <xsl:text>        UpdateAllItemsCheck();

        OnValueChanged(checkbox);
    } catch (err) {
        ShowError(err);
    }
}

// Called when the Parent checkbox is toggled.
function OnAllItemsCheckChanged() {
    try {
        var unused
</xsl:text>
    <xsl:for-each select="ShoppingBoxes/ItemValue">
      <xsl:text>            = </xsl:text>
      <xsl:value-of select="@item" />
      <xsl:text>_Check.checked
</xsl:text>
    </xsl:for-each>
    <xsl:text>
            = AllItems_Check.checked;

        OnCheckChanged();
    } catch (err) {
        ShowError(err);
    }
}
</xsl:text>
    <!-- #endregion Static Code -->
  </xsl:template>

  <!-- ===================================================================-->
  <!-- Template to output code for initializing variables for calculating value of a single item. -->
  <!-- ===================================================================-->
  <xsl:template match="ItemValue">
    <xsl:choose>
      <xsl:when test="@assumed">
        <xsl:choose>
          <xsl:when test="@price">
            <xsl:value-of select="@item" />
            <xsl:text>_AssumedValue = </xsl:text>
            <xsl:value-of select="@price" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="base" select="@base" />
            <xsl:choose>
              <xsl:when test="../ItemValue[@item=$base and not(@assumed)]">
                <xsl:value-of select="@item" />
                <xsl:text>_AssumedValue = </xsl:text>
                <xsl:value-of select="@base" />
                <xsl:text>_Value_Price / </xsl:text>
                <xsl:value-of select="@base" />
                <xsl:text>_Value_Qty</xsl:text>
                <xsl:if test="@adjustment">
                  <xsl:text> + </xsl:text>
                  <xsl:value-of select="@adjustment" />
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@item" />
                <xsl:text>_AssumedValue = </xsl:text>
                <xsl:value-of select="@base" />
                <xsl:text>_AssumedValue</xsl:text>
                <xsl:if test="@adjustment">
                  <xsl:text> + </xsl:text>
                  <xsl:value-of select="@adjustment" />
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@item" />
        <xsl:text>_Value_Qty = </xsl:text>
        <xsl:value-of select="@quantity" />
        <xsl:text>; </xsl:text>
        <xsl:value-of select="@item" />
        <xsl:text>_Value_Price = </xsl:text>
        <xsl:value-of select="@price" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>;
</xsl:text>
  </xsl:template>

</xsl:stylesheet>