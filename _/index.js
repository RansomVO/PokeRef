// #region Common

// ============================================================================
// ===== Global Variables
// ============================================================================
// #region Global Variables
// #endregion Global Variables

// ============================================================================
// ===== Cookies
// ============================================================================
// #region Cookies

var CookieSettings = {
    //'Field': 'DefaultValue',
};

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    try {
        ApplyCookieSettings(CookieSettings);
    }
    catch (err) {
        ShowError(err);
    }
}

// #endregion Cookies

// ============================================================================
// ===== LocalScript (Called when page is loaded to perform any initial work.)
// ============================================================================
function LocalScript() {
    ApplyCookie();
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

