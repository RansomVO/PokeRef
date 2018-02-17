// #region Common

// ============================================================================
// #region Global Variables
// ============================================================================

var selectionsTypes = null;
var selectionsWeather = null;
var filterNameID = null;

// #endregion

// ============================================================================
// #region Cookies
// ============================================================================

var CookieSettings = {
    'Filter_Text_Move': '',
    'ShowOnlyReleased_Checkbox': 'false',
};

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    ApplyCookieSettings(CookieSettings);
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
        OnFilterCriteriaChanged();
    } catch (err) {
        ShowError(err);
    }
}

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetFields() {
    Filter_Text_NameId = document.getElementById('Filter_Text_NameId');
    Filter_Text_Move = document.getElementById('Filter_Text_Move');
    ShowOnlyReleased_Checkbox = document.getElementById('ShowOnlyReleased_Checkbox');

    MoveSets = [null]
    for (var i = 1; i <= 7; i++) {
        MoveSets.push(document.getElementById('MOVESET_GEN_' + i));
    }
}

// #endregion

// ============================================================================
// #region Functions specific to this page.
// ============================================================================

// Called when any of the Filter criteria changes.
function OnFilterCriteriaChanged(field) {
    if (field !== undefined && field !== null) {
        UpdateCookieSetting(field.id);
    }

    for (var i = 1; i < MoveSets.length; i++) {
        if (MoveSets[i] !== null) {
            FilterTable(MoveSets[i]);
        }
    }
}

// Filter the table and hide any Pokemon/MoveSets that don't match the filter.
function FilterTable(table) {
    // Iterate throw all of the Pokemon in the table.
    var displayTable = false;
    var primaryRows = table.getElementsByClassName('PRIMARY_ROW');
    for (var i = primaryRows.length - 1; i >= 0; i--) {
        var primaryRow = primaryRows[i];
        var pokemonRows = [primaryRow];
        for (var j = parseInt(primaryRow.getAttribute('movesetCount')) ; j > 0; j--) {
            pokemonRows.push(table.rows[primaryRow.rowIndex + j]);
        }
        if (FilterPokemon(pokemonRows) > 0) {
            displayTable = true;
        }
    }

    // If there are no matches in the the entire table, hide the whole thing.
    table.style.display = displayTable ? 'table' : 'none';
}

// Filter the Pokemon and its MoveSets and hide what doesn't match the filter.
function FilterPokemon(pokemonRows) {
    // See if this Pokemon should be filtered out.
    var hidePokemon = !PokemonMatchesFilter(pokemonRows[0]);

    // Iterate through all of the MoveSets and show/hide the rows appropriately.
    var movesetsFound = 0;
    for (var i = pokemonRows.length - 1; i > 0; i--) {
        if (hidePokemon || !MoveSetMatchesFilter(pokemonRows[i])) {
            pokemonRows[i].style.display = 'none';
        } else {
            pokemonRows[i].style.display = '';
            movesetsFound++;
        }
    }

    if (movesetsFound === 0) {
        pokemonRows[0].style.display = 'none';
    } else {
        pokemonRows[0].style.display = '';
        for (var i = 0; i < pokemonRows[0].cells.length; i++) {
            if (!pokemonRows[0].cells[i].classList.contains('HIDDEN_CONVENIENCE_ROW')) {
                pokemonRows[0].cells[i].rowSpan = movesetsFound + 1;
            }
        }
    }

    return movesetsFound;
}

// Determine whether the Pokemon in this row should be shown or not.
function PokemonMatchesFilter(primaryRow) {
    // If Show Only Released is on, filter out any that are not released.
    if (GetFieldValue(ShowOnlyReleased_Checkbox) && primaryRow.classList.contains("UNAVAILABLE_ROW")) {
        return false;
    }

    // If there is a Filter by Pokemon Name or ID, filter out any that don't have that name or ID.
    if (filterNameID === null) {
        return true;
    }

    return MatchFilterPokemonNameID(primaryRow.cells[0], filterNameID);
}

// Determine whether the MoveSet in this row should be shown or not.
function MoveSetMatchesFilter(movesetRow) {
    var fastMove = movesetRow.getAttribute('FastMove');
    var chargedMove = movesetRow.getAttribute('ChargedMove');

    // Include only MoveSets containing a Move of the selected types.
    if (selectionsTypes !== null &&
        !((selectionsTypes['Bug'] && (fastMove.indexOf('`Bug') >= 0 || chargedMove.indexOf('`Bug') >= 0)) ||
        (selectionsTypes['Dark'] && (fastMove.indexOf('`Dark') >= 0 || chargedMove.indexOf('`Dark') >= 0)) ||
        (selectionsTypes['Dragon'] && (fastMove.indexOf('`Dragon') >= 0 || chargedMove.indexOf('`Dragon') >= 0)) ||
        (selectionsTypes['Electric'] && (fastMove.indexOf('`Electric') >= 0 || chargedMove.indexOf('`Electric') >= 0)) ||
        (selectionsTypes['Fairy'] && (fastMove.indexOf('`Fairy') >= 0 || chargedMove.indexOf('`Fairy') >= 0)) ||
        (selectionsTypes['Fighting'] && (fastMove.indexOf('`Fighting') >= 0 || chargedMove.indexOf('`Fighting') >= 0)) ||
        (selectionsTypes['Fire'] && (fastMove.indexOf('`Fire') >= 0 || chargedMove.indexOf('`Fire') >= 0)) ||
        (selectionsTypes['Flying'] && (fastMove.indexOf('`Flying') >= 0 || chargedMove.indexOf('`Flying') >= 0)) ||
        (selectionsTypes['Ghost'] && (fastMove.indexOf('`Ghost') >= 0 || chargedMove.indexOf('`Ghost') >= 0)) ||
        (selectionsTypes['Grass'] && (fastMove.indexOf('`Grass') >= 0 || chargedMove.indexOf('`Grass') >= 0)) ||
        (selectionsTypes['Ground'] && (fastMove.indexOf('`Ground') >= 0 || chargedMove.indexOf('`Ground') >= 0)) ||
        (selectionsTypes['Ice'] && (fastMove.indexOf('`Ice') >= 0 || chargedMove.indexOf('`Ice') >= 0)) ||
        (selectionsTypes['Normal'] && (fastMove.indexOf('`Normal') >= 0 || chargedMove.indexOf('`Normal') >= 0)) ||
        (selectionsTypes['Poison'] && (fastMove.indexOf('`Poison') >= 0 || chargedMove.indexOf('`Poison') >= 0)) ||
        (selectionsTypes['Psychic'] && (fastMove.indexOf('`Psychic') >= 0 || chargedMove.indexOf('`Psychic') >= 0)) ||
        (selectionsTypes['Rock'] && (fastMove.indexOf('`Rock') >= 0 || chargedMove.indexOf('`Rock') >= 0)) ||
        (selectionsTypes['Steel'] && (fastMove.indexOf('`Steel') >= 0 || chargedMove.indexOf('`Steel') >= 0)) ||
        (selectionsTypes['Water'] && (fastMove.indexOf('`Water') >= 0 || chargedMove.indexOf('`Water') >= 0)))) {
        return false;
    }

    // Include only MoveSets containing a Move boosted by the selected weather.
    if (selectionsWeather !== null &&
        !((selectionsWeather['Sunny'] && (fastMove.indexOf('^Sunny') >= 0 || chargedMove.indexOf('^Sunny') >= 0)) ||
        (selectionsWeather['Windy'] && (fastMove.indexOf('^Windy') >= 0 || chargedMove.indexOf('^Windy') >= 0)) ||
        (selectionsWeather['Cloudy'] && (fastMove.indexOf('^Cloudy') >= 0 || chargedMove.indexOf('^Cloudy') >= 0)) ||
        (selectionsWeather['PartlyCloudy'] && (fastMove.indexOf('^Partly Cloudy') >= 0 || chargedMove.indexOf('^Partly Cloudy') >= 0)) ||
        (selectionsWeather['Fog'] && (fastMove.indexOf('^Fog') >= 0 || chargedMove.indexOf('^Fog') >= 0)) ||
        (selectionsWeather['Rainy'] && (fastMove.indexOf('^Rainy') >= 0 || chargedMove.indexOf('^Rainy') >= 0)) ||
        (selectionsWeather['Snow'] && (fastMove.indexOf('^Snow') >= 0 || chargedMove.indexOf('^Snow') >= 0)))) {
        return false;
    }

    return true;
}

// #endregion

// ============================================================================
// #region Callbacks
// ============================================================================

// Called the selection changes in the Types Selector.
function OnTypesChanged(types) {
    selectionsTypes = types;
    OnFilterCriteriaChanged();
}

// Called the selection changes in the Weather Selector.
function OnWeatherChanged(weather) {
    selectionsWeather = weather;
    OnFilterCriteriaChanged();
}

// Called the Pokemon Name/ID filter changes.
function OnPokemonNameIDChanged(filter) {
    filterNameID = filter;
    OnFilterCriteriaChanged();
}

// #endregion
