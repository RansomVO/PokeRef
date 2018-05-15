// #region Common

// ============================================================================
// #region Global Variables
// ============================================================================

var selectionsEgg = null;
var selectionsGenerations = null;
var filterNameID = null;

// #endregion

// ============================================================================
// #region Cookies
// ============================================================================

var CookieSettings = {
    'Shiny_Check': 'false',
};

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    ApplyCookieSettings(CookieSettings);
    OnFilterCriteriaChanged();
}

// #endregion Cookies

// ============================================================================
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

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetFields() {
    Shiny_Check = document.getElementById('Shiny_Check');
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

function OnFilterCriteriaChanged(field) {
    try {
        if (field !== undefined && field !== null) {
            UpdateCookieSetting(field.id);
        }

        // Iterate through each family.
        var found = 0;
        var table = document.getElementById('Evolutions');
        for (var f = 0, fEnd = table.rows.length; f < fEnd; f += table.rows[f].cells[0].rowSpan) {
            var rowFamilyBegin = f;
            var rowFamilyEnd = rowFamilyBegin + table.rows[f].cells[0].rowSpan;

            // Collect all of the pokemon in the family.
            var family = [];
            for (var r = rowFamilyBegin; r < rowFamilyEnd; r++) {
                for (var c = 0, cLen = table.rows[r].cells.length - 1; c <= cLen; c++) {
                    var pokemon = table.rows[r].cells[c];
                    family.push(pokemon);
                }
            }

            // Evaluate the criteria to see if the row should be displayed.
            var matchName = filterNameID === null;
            var matchShiny = !Shiny_Check.checked;
            var matchEgg = false;
            var matchesGenerations = GenerationsMatchesFilter(selectionsGenerations, family);
            if (matchesGenerations) {
                for (var i = 0, iEnd = family.length; i < iEnd && (!matchName || !matchShiny || !matchEgg); i++) {
                    if (!matchName && MatchFilterPokemonNameID(family[i], filterNameID)) {
                        matchName = true;
                    }
                    if (!matchShiny && GetPokemonShiny(family[i])) {
                        matchShiny = true;
                    }
                    if (!matchEgg && EggMatchesFilter(selectionsEgg, family[i])) {
                        matchEgg = true;
                    }
                }
            }

            if (matchName && matchShiny && matchEgg && matchesGenerations) {
                display = true;
                found++;
            } else {
                display = false;
            }

            // Show/hide the family's Rows.
            for (var r = rowFamilyBegin; r < rowFamilyEnd; r++) {
                table.rows[r].style.display = display ? '' : 'none';
            }
        }

        // If nothing fit the criteria, hide the entire table.
        table.style.display = found === 0 ? 'none' : '';
    } catch (err) {
        ShowError(err);
    }
}

// ============================================================================
// #region Callbacks
// ============================================================================

// Called when any of the Generation checkboxes change.
function OnGenChanged(gen) {
    selectionsGenerations = gen;
    OnFilterCriteriaChanged();
}

// Called when any of the Egg checkboxes change.
function OnEggChanged(egg) {
    selectionsEgg = egg;
    OnFilterCriteriaChanged();
}

// Called when the Pokemon Name/ID filter changes.
function OnPokemonNameIDChanged(filter) {
    filterNameID = filter;
    OnFilterCriteriaChanged();
}

// Called when Criteria's Reset button is selected.
function OnResetCriteriaClicked() {
    try {
        ClearEggSelector();
        ClearGenerationsSelector();
        ClearFilterNameID();
        ClearCookieSettings(CookieSettings);
        ApplyCookie();
        OnFilterCriteriaChanged();
    } catch (err) {
        ShowError(err);
    }
}

// #endregion Callbacks
