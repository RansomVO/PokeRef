// #region Common

// ============================================================================
// #region Global Variables
// ============================================================================

var typeSelections = null;
var weatherSelections = null;

// #endregion

// ============================================================================
// #region Cookies
// ============================================================================

var CookieSettings = {
    'Filter_Text_NameId': '',
    'Filter_Text_Move': '',
    'ShowOnlyReleased_Checkbox': 'false',
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
    GetFields();
    ApplyCookie();
    OnFilterCriteriaChanged();
}

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetFields() {
    Filter_Text_NameId = document.getElementById('Filter_Text_NameId');
    Filter_Text_Move = document.getElementById('Filter_Text_Move');
    ShowOnlyReleased_Checkbox = document.getElementById('ShowOnlyReleased_Checkbox');

    MOVESET_TABLES = [null]
    for (var i = 1; i <= TotalGens; i++) {
        MOVESET_TABLES.push(document.getElementById('MOVESET_GEN_' + i));
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

    for (var i = 1; i < MOVESET_TABLES.length; i++) {
        if (MOVESET_TABLES[i] !== null) {
            FilterTable(MOVESET_TABLES[i]);
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
    return segmentMatches(GetFieldValue(Filter_Text_NameId), primaryRow);
}

function segmentMatches(segment, primaryRow) {
    filterSegment = segment.trim();
    if (filterSegment.length === 0) {
        return true;
    }

    // TODO QZX: Deal with parens.

    // Split the filter into sub-filters separated by ',' and treat it like ||
    var segments = filterSegment.split(',');
    if (segments.length > 1) {
        for (var i = segments.length - 1; i >= 0; i--) {
            if (segmentMatches(segments[i], primaryRow)) {
                return true;
            }
        }

        return false;
    }

    // Split the filter into sub-filters separated by '&' and treat it like &&
    segments = filterSegment.split('&');
    if (segments.length > 1) {
        for (var i = segments.length - 1; i >= 0; i--) {
            if (!segmentMatches(segments[i], primaryRow)) {
                return false;
            }
        }

        return true;
    }

    // If we made it here there are no sub-sections.
    var id = parseInt(primaryRow.getAttribute('id'));

    // Check for a range of IDs (E.G. "5-10", "5-10", "-10", "10-")
    var rangeSegments = filterSegment.split('-');
    if (rangeSegments.length === 2 &&
       (rangeSegments[0].trim().length === 0 || !isNaN(rangeSegments[0])) &&
       (rangeSegments[1].trim().length === 0 || !isNaN(rangeSegments[1]))) {
        var min = rangeSegments[0].trim().length === 0 ? 0 : rangeSegments[0];
        var max = rangeSegments[1].trim().length === 0 ? 9999 : rangeSegments[1];
        if (id >= min && id <= max) {
            return true;
        }
    }

    // Check to see if it is just a single ID;
    if (id == filterSegment) {
        return true;
    }

    // Check to see if it is a name.
    // TODO QZX: Enhance these checks to be similar to Pokemon GO.
    if (filterSegment.startsWith('+')) {
        if (primaryRow.getAttribute('family').toUpperCase().startsWith(filterSegment.substring(1).toUpperCase())) {
            return true;
        }
    } else if (primaryRow.getAttribute('name').toUpperCase().startsWith(filterSegment.toUpperCase())) {
        return true;
    }

    return false;
}

// Determine whether the MoveSet in this row should be shown or not.
function MoveSetMatchesFilter(movesetRow) {
    var fastMove = movesetRow.getAttribute('FastMove');
    var chargedMove = movesetRow.getAttribute('ChargedMove');

    // Include only MoveSets containing a Move of the selected types.
    if (typeSelections !== null &&
        !((typeSelections['Bug'] && (fastMove.indexOf('`Bug') >= 0 || chargedMove.indexOf('`Bug') >= 0)) ||
        (typeSelections['Dark'] && (fastMove.indexOf('`Dark') >= 0 || chargedMove.indexOf('`Dark') >= 0)) ||
        (typeSelections['Dragon'] && (fastMove.indexOf('`Dragon') >= 0 || chargedMove.indexOf('`Dragon') >= 0)) ||
        (typeSelections['Electric'] && (fastMove.indexOf('`Electric') >= 0 || chargedMove.indexOf('`Electric') >= 0)) ||
        (typeSelections['Fairy'] && (fastMove.indexOf('`Fairy') >= 0 || chargedMove.indexOf('`Fairy') >= 0)) ||
        (typeSelections['Fighting'] && (fastMove.indexOf('`Fighting') >= 0 || chargedMove.indexOf('`Fighting') >= 0)) ||
        (typeSelections['Fire'] && (fastMove.indexOf('`Fire') >= 0 || chargedMove.indexOf('`Fire') >= 0)) ||
        (typeSelections['Flying'] && (fastMove.indexOf('`Flying') >= 0 || chargedMove.indexOf('`Flying') >= 0)) ||
        (typeSelections['Ghost'] && (fastMove.indexOf('`Ghost') >= 0 || chargedMove.indexOf('`Ghost') >= 0)) ||
        (typeSelections['Grass'] && (fastMove.indexOf('`Grass') >= 0 || chargedMove.indexOf('`Grass') >= 0)) ||
        (typeSelections['Ground'] && (fastMove.indexOf('`Ground') >= 0 || chargedMove.indexOf('`Ground') >= 0)) ||
        (typeSelections['Ice'] && (fastMove.indexOf('`Ice') >= 0 || chargedMove.indexOf('`Ice') >= 0)) ||
        (typeSelections['Normal'] && (fastMove.indexOf('`Normal') >= 0 || chargedMove.indexOf('`Normal') >= 0)) ||
        (typeSelections['Poison'] && (fastMove.indexOf('`Poison') >= 0 || chargedMove.indexOf('`Poison') >= 0)) ||
        (typeSelections['Psychic'] && (fastMove.indexOf('`Psychic') >= 0 || chargedMove.indexOf('`Psychic') >= 0)) ||
        (typeSelections['Rock'] && (fastMove.indexOf('`Rock') >= 0 || chargedMove.indexOf('`Rock') >= 0)) ||
        (typeSelections['Steel'] && (fastMove.indexOf('`Steel') >= 0 || chargedMove.indexOf('`Steel') >= 0)) ||
        (typeSelections['Water'] && (fastMove.indexOf('`Water') >= 0 || chargedMove.indexOf('`Water') >= 0)))) {
        return false;
    }

    // Include only MoveSets containing a Move boosted by the selected weather.
    if (weatherSelections !== null &&
        !((weatherSelections['Sunny'] && (fastMove.indexOf('^Sunny') >= 0 || chargedMove.indexOf('^Sunny') >= 0)) ||
        (weatherSelections['Windy'] && (fastMove.indexOf('^Windy') >= 0 || chargedMove.indexOf('^Windy') >= 0)) ||
        (weatherSelections['Cloudy'] && (fastMove.indexOf('^Cloudy') >= 0 || chargedMove.indexOf('^Cloudy') >= 0)) ||
        (weatherSelections['PartlyCloudy'] && (fastMove.indexOf('^Partly Cloudy') >= 0 || chargedMove.indexOf('^Partly Cloudy') >= 0)) ||
        (weatherSelections['Fog'] && (fastMove.indexOf('^Fog') >= 0 || chargedMove.indexOf('^Fog') >= 0)) ||
        (weatherSelections['Rainy'] && (fastMove.indexOf('^Rainy') >= 0 || chargedMove.indexOf('^Rainy') >= 0)) ||
        (weatherSelections['Snow'] && (fastMove.indexOf('^Snow') >= 0 || chargedMove.indexOf('^Snow') >= 0)))) {
        return false;
    }

    return true;
}

// #endregion

// ============================================================================
// #region Callbacks
function OnTypesChanged(types) {
    typeSelections = types;
    OnFilterCriteriaChanged();
}

function OnWeatherChanged(weather) {
    weatherSelections = weather;
    OnFilterCriteriaChanged();
}

// #endregion
