// #region Common

// ============================================================================
// ===== Cookies
// ============================================================================
// #region Cookies

// ================================================================================================
// Fields that should be saved in cookies, with their default values.
var CookieSettings = {
    'FieldResearch_Slider_OrderBy': 'false',
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
    Slider = document.getElementById('FieldResearch_Slider_OrderBy');
    ByTask = document.getElementById('ByTask');
    ByEncounter = document.getElementById('ByEncounter');
}

// Called when the chart slider is toggled.
function ToggleChart() {
    if (Slider.checked) {
        ByTask.style.display = 'none';
        ByEncounter.style.display = 'table';
    } else {
        ByTask.style.display = 'table';
        ByEncounter.style.display = 'none';
    }

    UpdateCookieSettings(CookieSettings);
}

// Called when any of the Selection Criteria changes.
function OnCriteriaChanged() {

}
