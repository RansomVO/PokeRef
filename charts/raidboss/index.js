// ================================================================================================
var PartialTitleRaidBoss = '- RaidBoss Possible IVs';

// ================================================================================================
// Fields that should be saved in cookies, with their default values.
var CookieSettings = [
    ['Checkbox_Boosted', 'false'],
];


// Called when any non-value modifications should be done.
//  (E.G. Collapsers, javascript initial values/calculations, etc.)
function LocalScript() {
    try {
        if (document.title.indexOf(PartialTitleRaidBoss) >= 0) {
            GetFields();
            ApplyCookie();
        }
    } catch (err) {
        ShowError(err);
    }
}

// Get the fields we will be using multiple times.
//  (I think the vars need to be named with a capital letter first to be considered global.)
function GetFields() {
    try {
        var Regular = document.getElementById('Regular');
        var Boosted = document.getElementById('Boosted');
    }
    catch (err) {
        ShowError(err);
    }
}

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    try {
        ApplyCookieSettingsQZX(CookieSettings);
        ToggleChart();
    }
    catch (err) {
        ShowError(err);
    }
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
