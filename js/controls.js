// ==============================================================================================
// #region window.onload()  Called when page is loaded to perform up-front work.
// ==============================================================================================
// If there was already an window.onload specified, hold on to it and call it before we do our work.
var controlsOldOnLoad = window.onload;
window.onload = function () {
    try {
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

// ============================================================================
// #region methods for Type Selection Control

// ---------------------------------------------------------------------------
// #region Pokemon Type Cookies
var PokeTypeCookieSettings = {
    'PokeType_Bug_Check': 'true',
    'PokeType_Dark_Check': 'true',
    'PokeType_Dragon_Check': 'true',
    'PokeType_Electric_Check': 'true',
    'PokeType_Fairy_Check': 'true',
    'PokeType_Fighting_Check': 'true',
    'PokeType_Fire_Check': 'true',
    'PokeType_Flying_Check': 'true',
    'PokeType_Ghost_Check': 'true',
    'PokeType_Grass_Check': 'true',
    'PokeType_Ground_Check': 'true',
    'PokeType_Ice_Check': 'true',
    'PokeType_Normal_Check': 'true',
    'PokeType_Poison_Check': 'true',
    'PokeType_Psychic_Check': 'true',
    'PokeType_Rock_Check': 'true',
    'PokeType_Steel_Check': 'true',
    'PokeType_Water_Check': 'true',
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
    if (document.getElementById('PokeType_Selector') !== null) {
        GetPokeTypeFields();
        ApplyPokeTypeCookies();
        OnTogglePokeType();
    }
}

// Get the fields we will be using multiple times.
function GetPokeTypeFields() {
    try {
        var PokeType_Selector = document.getElementById('PokeType_Selector');
        var PokeType_All_Check = document.getElementById('PokeType_All_Check');
        var PokeType_Bug_Check = document.getElementById('PokeType_Bug_Check');
        var PokeType_Dark_Check = document.getElementById('PokeType_Dark_Check');
        var PokeType_Dragon_Check = document.getElementById('PokeType_Dragon_Check');
        var PokeType_Electric_Check = document.getElementById('PokeType_Electric_Check');
        var PokeType_Fairy_Check = document.getElementById('PokeType_Fairy_Check');
        var PokeType_Fighting_Check = document.getElementById('PokeType_Fighting_Check');
        var PokeType_Fire_Check = document.getElementById('PokeType_Fire_Check');
        var PokeType_Flying_Check = document.getElementById('PokeType_Flying_Check');
        var PokeType_Ghost_Check = document.getElementById('PokeType_Ghost_Check');
        var PokeType_Grass_Check = document.getElementById('PokeType_Grass_Check');
        var PokeType_Ground_Check = document.getElementById('PokeType_Ground_Check');
        var PokeType_Ice_Check = document.getElementById('PokeType_Ice_Check');
        var PokeType_Normal_Check = document.getElementById('PokeType_Normal_Check');
        var PokeType_Poison_Check = document.getElementById('PokeType_Poison_Check');
        var PokeType_Psychic_Check = document.getElementById('PokeType_Psychic_Check');
        var PokeType_Rock_Check = document.getElementById('PokeType_Rock_Check');
        var PokeType_Steel_Check = document.getElementById('PokeType_Steel_Check');
        var PokeType_Water_Check = document.getElementById('PokeType_Water_Check');
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
    'Weather_Sunny_Check': 'true',
    'Weather_Windy_Check': 'true',
    'Weather_Cloudy_Check': 'true',
    'Weather_PartlyCloudy_Check': 'true',
    'Weather_Fog_Check': 'true',
    'Weather_Rainy_Check': 'true',
    'Weather_Snow_Check': 'true',
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
    if (document.getElementById('Weather_Selector') !== null) {
        GetWeatherFields();
        ApplyWeatherCookies();
        OnToggleWeather();
    }
}

// Get the fields we will be using multiple times.
function GetWeatherFields() {
    try {
        var Weather_Selector = document.getElementById('Weather_Selector');
        var Weather_All_Check = document.getElementById('Weather_All_Check');
        var Weather_Sunny_Check = document.getElementById('Weather_Sunny_Check');
        var Weather_Windy_Check = document.getElementById('Weather_Windy_Check');
        var Weather_Cloudy_Check = document.getElementById('Weather_Cloudy_Check');
        var Weather_PartlyCloudy_Check = document.getElementById('Weather_PartlyCloudy_Check');
        var Weather_Fog_Check = document.getElementById('Weather_Fog_Check');
        var Weather_Rainy_Check = document.getElementById('Weather_Rainy_Check');
        var Weather_Snow_Check = document.getElementById('Weather_Snow_Check');
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
