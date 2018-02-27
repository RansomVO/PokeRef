// #region Common

// ============================================================================
// #region Global Variables
// ============================================================================

var filterNameID = null;

// #endregion

// ============================================================================
// #region Cookies
// ============================================================================

var CookieSettings = {
    'Evolution_AnyOrAll_Gens_Slider': 'false',
    'Gen1_Check': 'true',
    'Gen2_Check': 'true',
    'Gen3_Check': 'true',
    'Gen4_Check': 'false',
    'Gen5_Check': 'false',
    'Gen6_Check': 'false',
    'Gen7_Check': 'false',
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
    Evolution_AnyOrAll_Gens_Slider = document.getElementById('Evolution_AnyOrAll_Gens_Slider');
    Gen1_Check = document.getElementById('Gen1_Check');
    Gen2_Check = document.getElementById('Gen2_Check');
    Gen3_Check = document.getElementById('Gen3_Check');
    Gen4_Check = document.getElementById('Gen4_Check');
    Gen5_Check = document.getElementById('Gen5_Check');
    Gen6_Check = document.getElementById('Gen6_Check');
    Gen7_Check = document.getElementById('Gen7_Check');
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

        var genAll = GetFieldValue(Evolution_AnyOrAll_Gens_Slider);
        var gen1 = GetFieldValue(Gen1_Check);
        var gen2 = GetFieldValue(Gen2_Check);
        var gen3 = GetFieldValue(Gen3_Check);
        var gen4 = GetFieldValue(Gen4_Check);
        var gen5 = GetFieldValue(Gen5_Check);
        var gen6 = GetFieldValue(Gen6_Check);
        var gen7 = GetFieldValue(Gen7_Check);

        var found = 0;
        var table = document.getElementById('Evolutions');
        if ((gen1 || gen2 || gen3 || gen4 || gen5 || gen6 || gen7)) {
            for (var i = 0, length = table.rows.length; i < length; i += table.rows[i].cells[0].rowSpan) {
                var row = table.rows[i];
                var gens = row.attributes['gens'].value;

                // Check the criteria
                var display = true;
                if (genAll) {
                    if ((gen1 && !gens.contains('1 '))
                        || (gen2 && !gens.contains('2 '))
                        || (gen3 && !gens.contains('3 '))
                        || (gen4 && !gens.contains('4 '))
                        || (gen5 && !gens.contains('5 '))
                        || (gen6 && !gens.contains('6 '))
                        || (gen7 && !gens.contains('7 '))) {
                        display = false;
                    }
                } else if ((!gen1 || !gens.contains('1 '))
                    && (!gen2 || !gens.contains('2 '))
                    && (!gen3 || !gens.contains('3 '))
                    && (!gen4 || !gens.contains('4 '))
                    && (!gen5 || !gens.contains('5 '))
                    && (!gen6 || !gens.contains('6 '))
                    && (!gen7 || !gens.contains('7 '))) {
                    display = false;
                }

                // If it hasn't been filtered out yet, see if any Pokémon in the family match the criteria.
                if (display && filterNameID !== null) {
                    display = false;
                    for (var r = i + table.rows[i].cells[0].rowSpan - 1; r >= i && !display; r--) {
                        for (var c = table.rows[r].cells.length - 1; c >= 0 && !display; c--) {
                            if (MatchFilterPokemonNameID(table.rows[r].cells[c], filterNameID)) {
                                display = true;
                                found++;
                            }
                        }
                    }
                }

                // Show/hide the family's Rows.
                for (var r = i + table.rows[i].cells[0].rowSpan - 1; r >= i ; r--) {
                    table.rows[r].style.display = display ? '' : 'none';
                }
            }
        }

        // If nothing fit the criteria, hide the entire table.
        table.style.display = found === 0 ? 'none' : '';
    } catch (err) {
        ShowError(err);
    }
}

// Called the Pokémon Name/ID filter changes.
function OnPokemonNameIDChanged(filter) {
    filterNameID = filter;
    OnFilterCriteriaChanged();
}

// Called when Criteria's Reset button is selected.
function OnResetCriteriaClicked() {
    try {
        ClearCookieSettings(CookieSettings);
        ApplyCookie();
        ClearFilterNameID();
    } catch (err) {
        ShowError(err);
    }
}

