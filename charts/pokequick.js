// #region Common

// ==============================================================================================
// #region Global Variables
// ==============================================================================================

var selectionsTypes = null;
var selectionsBoosts = null;

// #endregion

// ==============================================================================================
// Called when page is loaded to perform up-front work.
// ==============================================================================================
// NOTE: This .js MUST be specified BEFORE any other <script> nodes in the <html> <head> so that 
//          the window.onnload() from the other scripts have the opportunity to overload this.
window.onload = function () {
    try {
        GetFields();
    } catch (err) {
        ShowError(err);
    }
}

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetFields() {
    Collections = [null]
    for (var i = 1; i <= 7; i++) {
        Collections.push(document.getElementById('GEN' + i + '_Collection'));
    }
}

// #endregion Common

// ============================================================================
// #region Functions specific to this page.
// ============================================================================

// Filter criteria changed, so refilter everything.
function OnFilterCriteriaChanged(field) {
    if (field !== undefined && field !== null) {
        UpdateCookieSetting(field.id);
    }

    for (var i = Collections.length - 1; i >= 0; i--) {
        FilterGeneration(Collections[i]);
    }
}

// Filter specified generation of Pokemon.
function FilterGeneration(collection) {
    if (collection !== undefined && collection !== null) {
        for (var i = 0; i < collection.children.length; i++) {
            if (MatchesFilter(collection.children[i])) {
                collection.children[i].style.display = '';
            } else {
                collection.children[i].style.display = 'none';
            }
        }
    }
}

//Determine if a specific Pokemon matches the filters.
function MatchesFilter(pokemon) {
    if (!PokeTypeMatchesFilter(selectionsTypes, [pokemon.getAttribute('type1'), pokemon.getAttribute('type2')])) {
        return false;
    }

    if (!WeatherMatchesFilter(selectionsBoosts, [pokemon.getAttribute('boost1'), pokemon.getAttribute('boost2')])) {
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
    selectionsBoosts = weather;
    OnFilterCriteriaChanged();
}

// Called when Criteria's Reset button is selected.
function OnResetCriteriaClicked() {
    try {
        //ClearFilterNameID();
        ClearPokeTypeSelector();
        ClearWeatherSelector();
        OnFilterCriteriaChanged();
    } catch (err) {
        ShowError(err);
    }
}

// #endregion
