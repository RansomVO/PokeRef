﻿// #region Common

// ============================================================================
// ===== Global Variables
// ============================================================================
// #region Global Variables
var PartialTitleRaidBoss = '- RaidBoss Possible IVs';
// #endregion Global Variables

// ============================================================================
// ===== Cookies
// ============================================================================
// #region Cookies

// ================================================================================================
// Fields that should be saved in cookies, with their default values.
var CookieSettings = {
    'Checkbox_Boosted': 'false',
};

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    ApplyCookieSettings(CookieSettings);
    ToggleChart();
}

// #endregion Cookies

// ==============================================================================================
// Called when page is loaded to perform up-front work.
// ==============================================================================================
// NOTE: This .js MUST be specified BEFORE any other <script> nodes in the <html> <head> so that 
//          the window.onnload() from the other scripts have the opportunity to overload this.
window.onload = function () {
    try {
        GetFields();
        ApplyCookie();
    } catch (err) {
        ShowError(err);
    }
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetFields() {
    Regular = document.getElementById('Regular');
    Boosted = document.getElementById('Boosted');
}

// Called when the checkbox for Boosted is toggled.
function ToggleChart() {
    if (document.getElementById('Checkbox_Boosted').checked) {
        Regular.style.display = 'none';
        Boosted.style.display = 'table';
    } else {
        Regular.style.display = 'table';
        Boosted.style.display = 'none';
    }

    UpdateCookieSetting('Checkbox_Boosted', false);
}
