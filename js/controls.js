// ==============================================================================================
// #region window.onload()  Called when page is loaded to perform up-front work.
// ==============================================================================================
// If there was already an window.onload specified, hold on to it and call it before we do our work.
var controlsOldOnLoad = window.onload;
window.onload = function () {
    try {
        SetCollapsers();

        if (controlsOldOnLoad != null) {
            controlsOldOnLoad();
        }

        // Call the initializer method for each control so that they can set themselves up if they are on the page.
        InitPokeTypeSelector();
        InitWeatherSelector()
    }
    catch (err) {
        ShowError(err);
    }
};

// #endregion

// ==============================================================================================
// #region Methods for Collapsers.
// ==============================================================================================

var CollapserMarker = '_COLLAPSER';
var StatusUp = 'UP';
var StatusDown = 'DOWN';

function SetCollapsers() {
    var collapsers = document.getElementsByClassName('COLLAPSER');
    for (var i = 0; i < collapsers.length; i++) {
        SetCollapser(collapsers[i]);
    }
}

function SetCollapser(collapser) {
    var collapsee = document.getElementById(collapser.id.slice(0, -CollapserMarker.length));

    if (collapsee !== null) {
        collapser.formTarget = collapsee.id;
        collapser.setAttribute('onclick', 'ToggleCollapser(event)');

        var state = GetCookieSetting(collapser.formTarget + CollapserMarker);
        SetCollapseState(state !== null ? state : StatusDown, collapser, collapsee);
    }
}

function ToggleCollapser(event) {
    var collapser = event.currentTarget;
    var collapseeFieldId = collapser.formTarget;
    var collapsee = document.getElementById(collapseeFieldId);

    // Find what new state should be.
    var state = collapser.value === StatusDown ? StatusUp : StatusDown;
    SetCollapseState(state, collapser, collapsee);

    SetCookieSetting(collapser.formTarget + '_COLLAPSER', state);
}

function SetCollapseState(state, collapser, collapsee) {
    if (state === StatusUp) {
        // Hide collapsee
        collapsee.style.display = 'none';

        // Update state.
        collapser.style.cssText = 'transform: rotate(90deg);';
        collapser.value = StatusUp;
    } else {
        // Show collapsee
        collapsee.style.display = 'block';

        // Update state.
        collapser.style.cssText = 'transform: rotate(-90deg);';
        collapser.value = StatusDown;
    }
}

// #endregion

// ============================================================================
// #region methods for Type Selection Control

// ---------------------------------------------------------------------------
// #region Pokemon Type Cookies
var PokeTypeCookieSettings = {
    'CONTROLS_PokeType_Bug_Check': 'true',
    'CONTROLS_PokeType_Dark_Check': 'true',
    'CONTROLS_PokeType_Dragon_Check': 'true',
    'CONTROLS_PokeType_Electric_Check': 'true',
    'CONTROLS_PokeType_Fairy_Check': 'true',
    'CONTROLS_PokeType_Fighting_Check': 'true',
    'CONTROLS_PokeType_Fire_Check': 'true',
    'CONTROLS_PokeType_Flying_Check': 'true',
    'CONTROLS_PokeType_Ghost_Check': 'true',
    'CONTROLS_PokeType_Grass_Check': 'true',
    'CONTROLS_PokeType_Ground_Check': 'true',
    'CONTROLS_PokeType_Ice_Check': 'true',
    'CONTROLS_PokeType_Normal_Check': 'true',
    'CONTROLS_PokeType_Poison_Check': 'true',
    'CONTROLS_PokeType_Psychic_Check': 'true',
    'CONTROLS_PokeType_Rock_Check': 'true',
    'CONTROLS_PokeType_Steel_Check': 'true',
    'CONTROLS_PokeType_Water_Check': 'true',
};

// Read the Cookie and apply it to the fields.
function ApplyPokeTypeCookies() {
    try {
        ApplyCookieSettings(PokeTypeCookieSettings);
    }
    catch (err) {
        ShowError(err);
    }
}

// #endregion

// Initialize the Pokemon Type Selection Control
function InitPokeTypeSelector() {
    if (document.getElementById('CONTROLS_PokeType_Selector') !== null) {
        GetPokeTypeFields();

        if (PokeType_Selector.attributes['callbackName'].value === null) {
            alert('Must specify "Callback" when using template "OutputTypeSelection".');
            return;
        }

        ApplyPokeTypeCookies();
        OnTogglePokeType();

        RegisterTristateCheckbox(PokeType_All_Check);   // This is to resolve an issue with IE.
    }
}

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetPokeTypeFields() {
    try {
        PokeType_Selector = document.getElementById('CONTROLS_PokeType_Selector');
        PokeType_All_Check = document.getElementById('CONTROLS_PokeType_All_Check');
        PokeType_Bug_Check = document.getElementById('CONTROLS_PokeType_Bug_Check');
        PokeType_Dark_Check = document.getElementById('CONTROLS_PokeType_Dark_Check');
        PokeType_Dragon_Check = document.getElementById('CONTROLS_PokeType_Dragon_Check');
        PokeType_Electric_Check = document.getElementById('CONTROLS_PokeType_Electric_Check');
        PokeType_Fairy_Check = document.getElementById('CONTROLS_PokeType_Fairy_Check');
        PokeType_Fighting_Check = document.getElementById('CONTROLS_PokeType_Fighting_Check');
        PokeType_Fire_Check = document.getElementById('CONTROLS_PokeType_Fire_Check');
        PokeType_Flying_Check = document.getElementById('CONTROLS_PokeType_Flying_Check');
        PokeType_Ghost_Check = document.getElementById('CONTROLS_PokeType_Ghost_Check');
        PokeType_Grass_Check = document.getElementById('CONTROLS_PokeType_Grass_Check');
        PokeType_Ground_Check = document.getElementById('CONTROLS_PokeType_Ground_Check');
        PokeType_Ice_Check = document.getElementById('CONTROLS_PokeType_Ice_Check');
        PokeType_Normal_Check = document.getElementById('CONTROLS_PokeType_Normal_Check');
        PokeType_Poison_Check = document.getElementById('CONTROLS_PokeType_Poison_Check');
        PokeType_Psychic_Check = document.getElementById('CONTROLS_PokeType_Psychic_Check');
        PokeType_Rock_Check = document.getElementById('CONTROLS_PokeType_Rock_Check');
        PokeType_Steel_Check = document.getElementById('CONTROLS_PokeType_Steel_Check');
        PokeType_Water_Check = document.getElementById('CONTROLS_PokeType_Water_Check');
    }
    catch (err) {
        ShowError(err);
    }
}

// If one of the type checkboxes changes, need to update the All checkbox then refilter.
function OnTogglePokeType(field) {
    try {
        if (PokeType_Bug_Check.checked == PokeType_Dark_Check.checked &&
            PokeType_Dark_Check.checked == PokeType_Dragon_Check.checked &&
            PokeType_Dragon_Check.checked == PokeType_Electric_Check.checked &&
            PokeType_Electric_Check.checked == PokeType_Fairy_Check.checked &&
            PokeType_Fairy_Check.checked == PokeType_Fighting_Check.checked &&
            PokeType_Fighting_Check.checked == PokeType_Fire_Check.checked &&
            PokeType_Fire_Check.checked == PokeType_Flying_Check.checked &&
            PokeType_Flying_Check.checked == PokeType_Ghost_Check.checked &&
            PokeType_Ghost_Check.checked == PokeType_Grass_Check.checked &&
            PokeType_Grass_Check.checked == PokeType_Ground_Check.checked &&
            PokeType_Ground_Check.checked == PokeType_Ice_Check.checked &&
            PokeType_Ice_Check.checked == PokeType_Normal_Check.checked &&
            PokeType_Normal_Check.checked == PokeType_Poison_Check.checked &&
            PokeType_Poison_Check.checked == PokeType_Psychic_Check.checked &&
            PokeType_Psychic_Check.checked == PokeType_Rock_Check.checked &&
            PokeType_Rock_Check.checked == PokeType_Steel_Check.checked &&
            PokeType_Steel_Check.checked == PokeType_Water_Check.checked) {
            PokeType_All_Check.indeterminate = false;
            PokeType_All_Check.checked = PokeType_Bug_Check.checked;
        } else {
            PokeType_All_Check.indeterminate = true;
        }

        OnPokeTypeSelectionChanged();
    }
    catch (err) {
        ShowError(err);
    }
}

// If the All checkbox is toggled, update all of the Type checkboxes.
function OnToggleAllPokeTypes() {
    try {
        PokeType_Bug_Check.checked = PokeType_All_Check.checked;
        PokeType_Dark_Check.checked = PokeType_All_Check.checked;
        PokeType_Dragon_Check.checked = PokeType_All_Check.checked;
        PokeType_Electric_Check.checked = PokeType_All_Check.checked;
        PokeType_Fairy_Check.checked = PokeType_All_Check.checked;
        PokeType_Fighting_Check.checked = PokeType_All_Check.checked;
        PokeType_Fire_Check.checked = PokeType_All_Check.checked;
        PokeType_Flying_Check.checked = PokeType_All_Check.checked;
        PokeType_Ghost_Check.checked = PokeType_All_Check.checked;
        PokeType_Grass_Check.checked = PokeType_All_Check.checked;
        PokeType_Ground_Check.checked = PokeType_All_Check.checked;
        PokeType_Ice_Check.checked = PokeType_All_Check.checked;
        PokeType_Normal_Check.checked = PokeType_All_Check.checked;
        PokeType_Poison_Check.checked = PokeType_All_Check.checked;
        PokeType_Psychic_Check.checked = PokeType_All_Check.checked;
        PokeType_Rock_Check.checked = PokeType_All_Check.checked;
        PokeType_Steel_Check.checked = PokeType_All_Check.checked;
        PokeType_Water_Check.checked = PokeType_All_Check.checked;

        OnPokeTypeSelectionChanged();
    }
    catch (err) {
        ShowError(err);
    }
}

// Update the cookie with the new selection, then call the specified callback with the latest settings.
function OnPokeTypeSelectionChanged() {
    UpdateCookieSettings(PokeTypeCookieSettings);

    var callbackName = PokeType_Selector.attributes['callbackName'].value;
    if (callbackName != null) {
        var pokeTypes = {};
        pokeTypes['Bug'] = PokeType_Bug_Check.checked;
        pokeTypes['Dark'] = PokeType_Dark_Check.checked;
        pokeTypes['Dragon'] = PokeType_Dragon_Check.checked;
        pokeTypes['Electric'] = PokeType_Electric_Check.checked;
        pokeTypes['Fairy'] = PokeType_Fairy_Check.checked;
        pokeTypes['Fighting'] = PokeType_Fighting_Check.checked;
        pokeTypes['Fire'] = PokeType_Fire_Check.checked;
        pokeTypes['Flying'] = PokeType_Flying_Check.checked;
        pokeTypes['Ghost'] = PokeType_Ghost_Check.checked;
        pokeTypes['Grass'] = PokeType_Grass_Check.checked;
        pokeTypes['Ground'] = PokeType_Ground_Check.checked;
        pokeTypes['Ice'] = PokeType_Ice_Check.checked;
        pokeTypes['Normal'] = PokeType_Normal_Check.checked;
        pokeTypes['Poison'] = PokeType_Poison_Check.checked;
        pokeTypes['Psychic'] = PokeType_Psychic_Check.checked;
        pokeTypes['Rock'] = PokeType_Rock_Check.checked;
        pokeTypes['Steel'] = PokeType_Steel_Check.checked;
        pokeTypes['Water'] = PokeType_Water_Check.checked;

        window[callbackName](pokeTypes);
    }
}

// #endregion

// ============================================================================
// #region methods for Weather Selection Control

// ---------------------------------------------------------------------------
// #region Weather Cookies
var WeatherCookieSettings = {
    'CONTROLS_Weather_Sunny_Check': 'true',
    'CONTROLS_Weather_Windy_Check': 'true',
    'CONTROLS_Weather_Cloudy_Check': 'true',
    'CONTROLS_Weather_PartlyCloudy_Check': 'true',
    'CONTROLS_Weather_Fog_Check': 'true',
    'CONTROLS_Weather_Rainy_Check': 'true',
    'CONTROLS_Weather_Snow_Check': 'true',
};

// Read the Cookie and apply it to the fields.
function ApplyWeatherCookies() {
    try {
        ApplyCookieSettings(WeatherCookieSettings);
    }
    catch (err) {
        ShowError(err);
    }
}
// #endregion

// Initialize the Weather Selection Control
function InitWeatherSelector() {
    if (document.getElementById('CONTROLS_Weather_Selector') !== null) {
        GetWeatherFields();
        ApplyWeatherCookies();
        OnToggleWeather();

        RegisterTristateCheckbox(Weather_All_Check);   // This is to resolve an issue with IE.
    }
}

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetWeatherFields() {
    try {
        Weather_Selector = document.getElementById('CONTROLS_Weather_Selector');
        Weather_All_Check = document.getElementById('CONTROLS_Weather_All_Check');
        Weather_Sunny_Check = document.getElementById('CONTROLS_Weather_Sunny_Check');
        Weather_Windy_Check = document.getElementById('CONTROLS_Weather_Windy_Check');
        Weather_Cloudy_Check = document.getElementById('CONTROLS_Weather_Cloudy_Check');
        Weather_PartlyCloudy_Check = document.getElementById('CONTROLS_Weather_PartlyCloudy_Check');
        Weather_Fog_Check = document.getElementById('CONTROLS_Weather_Fog_Check');
        Weather_Rainy_Check = document.getElementById('CONTROLS_Weather_Rainy_Check');
        Weather_Snow_Check = document.getElementById('CONTROLS_Weather_Snow_Check');
    }
    catch (err) {
        ShowError(err);
    }
}

// If one of the type checkboxes changes, need to update the All checkbox then refilter.
function OnToggleWeather() {
    try {
        if (Weather_Sunny_Check.checked == Weather_Windy_Check.checked &&
            Weather_Windy_Check.checked == Weather_Cloudy_Check.checked &&
            Weather_Cloudy_Check.checked == Weather_PartlyCloudy_Check.checked &&
            Weather_PartlyCloudy_Check.checked == Weather_Fog_Check.checked &&
            Weather_Fog_Check.checked == Weather_Rainy_Check.checked &&
            Weather_Rainy_Check.checked == Weather_Snow_Check.checked) {
            Weather_All_Check.indeterminate = false;
            Weather_All_Check.checked = Weather_Sunny_Check.checked;
        } else {
            Weather_All_Check.indeterminate = true;
        }

        OnWeatherSelectionChanged();
    }
    catch (err) {
        ShowError(err);
    }
}

// If the All checkbox is toggled, update all of the Type checkboxes.
function OnToggleAllWeather() {
    try {
        Weather_Sunny_Check.checked = Weather_All_Check.checked;
        Weather_Windy_Check.checked = Weather_All_Check.checked;
        Weather_Cloudy_Check.checked = Weather_All_Check.checked;
        Weather_PartlyCloudy_Check.checked = Weather_All_Check.checked;
        Weather_Fog_Check.checked = Weather_All_Check.checked;
        Weather_Rainy_Check.checked = Weather_All_Check.checked;
        Weather_Snow_Check.checked = Weather_All_Check.checked;

        OnWeatherSelectionChanged();
    }
    catch (err) {
        ShowError(err);
    }
}

// Update the cookie with the new selection, then call the specified callback with the latest settings.
function OnWeatherSelectionChanged() {
    UpdateCookieSettings(WeatherCookieSettings);

    var callbackName = Weather_Selector.attributes['callbackName'].value;
    if (callbackName != null) {
        var weather = {};
        weather['Sunny'] = Weather_Sunny_Check.checked;
        weather['Windy'] = Weather_Windy_Check.checked;
        weather['Cloudy'] = Weather_Cloudy_Check.checked;
        weather['PartlyCloudy'] = Weather_PartlyCloudy_Check.checked;
        weather['Fog'] = Weather_Fog_Check.checked;
        weather['Rainy'] = Weather_Rainy_Check.checked;
        weather['Snow'] = Weather_Snow_Check.checked;

        window[callbackName](weather);
    }
}

// #endregion

// ==============================================================================================
// #region Code for Pop-ups
// ==============================================================================================

var Popup = null;
var OriginalPos = {};

// Applies a single cookie setting to the field with the specified fieldId.
//  (If there is no cookie setting, the set the field to the defaultValue.)
function ShowPopup(popup) {
    try {
        // If they are just refreshing the current popup, just proceed.
        if (popup !== Popup) {
            // If there is a Popup already open, close it
            if (Popup !== null) {
                OnClosePopup(Popup);
            }
            Popup = popup;

            // Hook up the header (or whole pop-up if there isn't one) to allow moving.
            var header = document.getElementById(Popup.id + '_Header');
            header = header ? header : Popup;
            header.onmousedown = PopupMouseDown;
        }

        // If the pop-up hasn't been shown before, set it to be in the middle of the screen.
        if (window.getComputedStyle(Popup).left.startsWith('-1')) {
            // Set it to be off the screen, then "display" it so we get the real dimensions.
            Popup.style.left = -100000;
            Popup.style.display = 'table';

            // No move it into view at the center.
            Popup.style.left = (window.innerWidth - Popup.offsetWidth) / 2;
            Popup.style.top = (window.innerHeight - Popup.offsetHeight) / 2;
        }
        else {
            Popup.style.display = 'table';
        }
    }
    catch (err) {
        ShowError(err);
    }
}

function PopupMouseDown(e) {
    OriginalPos['PopupLeft'] = Popup.offsetLeft;
    OriginalPos['PopupTop'] = Popup.offsetTop;
    OriginalPos['MouseX'] = e.clientX;
    OriginalPos['MouseY'] = e.clientY;

    document.onmousemove = PopupDrag;
    document.onmouseup = PopupMouseUp;
}

function PopupDrag(e) {
    Popup.style.left = OriginalPos['PopupLeft'] - (OriginalPos['MouseX'] - e.clientX);
    Popup.style.top = OriginalPos['PopupTop'] - (OriginalPos['MouseY'] - e.clientY);
}

function PopupMouseUp(e) {
    document.onmouseup = null;
    document.onmousemove = null;
}

function OnClosePopup() {
    Popup.style.display = 'none';
    Popup = null;
}

// #endregion

// ==============================================================================================
// #region Functions for Loading screen. -->
// ==============================================================================================

// Function to expose content after it has been loaded and initialized.
function ExposeLoaded() {
    var loading = document.getElementById('GLOBAL_LoadingNotice');
    if (loading != null) {
        loading.classList.add('DIV_HIDDEN');
        document.getElementById(loading.attributes['formTarget'].value).classList.remove('DIV_HIDDEN');
    }
}

// #endregion
