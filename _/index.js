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

// ==============================================================================================
// Called when page is loaded to perform up-front work.
// ==============================================================================================
// NOTE: This .js MUST be specified BEFORE any other <script> nodes in the <html> <head> so that 
//          the window.onnload() from the other scripts have the opportunity to overload this.
window.onload = function () {
    ApplyCookie();
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

