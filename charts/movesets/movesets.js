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

// Process any paramters passed in on the URL.
function ProcessParameter(name, value) {
    switch (name) {
        case 'name':
            if (value === undefined) {
                alert('Parameter "name" requires a value');
            } else {
                SetFilterNameID(value);
                // This automatically triggers the changed event, so just return now.
                return;
            }
            break;

        case 'move':
            if (value === undefined) {
                alert('Parameter "move" requires a value');
            } else {
                SetFieldValue(Filter_Text_Move, value);
            }
            break;

        case 'released':
            if (value === undefined) {
                value = 'true';
            }
            SetFieldValue(ShowOnlyReleased_Checkbox, value);
            break;
    }

    OnFilterCriteriaChanged();
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
    var moveNameFilter = GetFieldValue(Filter_Text_Move);
    if (!GetFieldValue(Filter_Text_Move).startsWith(moveNameFilter) && !GetFieldValue(Filter_Text_Move).startsWith(moveNameFilter)) {
        return false;
    }

    if (!PokeTypeMatchesFilter(selectionsTypes, [movesetRow.getAttribute('fastMoveType'), movesetRow.getAttribute('chargedMoveType')])) {
        return false;
    }

    if (!WeatherMatchesFilter(selectionsWeather, [movesetRow.getAttribute('fastMoveBoost'), movesetRow.getAttribute('chargedMoveBoost')])) {
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

// Called when Criteria's Reset button is selected.
function OnResetCriteriaClicked() {
    try {
        ClearCookieSettings(CookieSettings);
        ApplyCookie();
        ClearPokeTypeSelector();
        ClearWeatherSelector();
        ClearFilterNameID();
    } catch (err) {
        ShowError(err);
    }
}

// #endregion
