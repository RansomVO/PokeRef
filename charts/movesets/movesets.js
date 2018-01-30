// #region Common

// ============================================================================
// ===== Global Variables
// ============================================================================
// #region Global Variables

var SortBy_Name = 1;
var SortBy_Id = 2;
var SortBy_TrueDPS = 3;
var SortBy_Default = SortBy_Name;

// #endregion Global Variables

// #region FieldIDs

var ID_SortType_Combobox = 'SortType_Combobox';
var ID_Filter_Text_Move = 'Filter_Text_Move';
var ID_ShowOnlyReleased_Checkbox = 'ShowOnlyReleased_Checkbox';
var ID_Filter_Text_PokeStat = 'Filter_Text_PokeStat_' + document.URL.split('.')[1];

// #endregion FieldIDs

// ============================================================================
// ===== Cookies
// ============================================================================
// #region Cookies

var CookieSettings = {
    'SortType_Combobox': SortBy_Default,
    'Filter_Text_Move': '',
    'ShowOnlyReleased_Checkbox': 'false',
    //  'Filter_Text_PokeStat_GenX': '', // This will be added manually when the page loads so it is different for each generation.
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

// ============================================================================
// ===== LocalScript (Called when page is loaded to perform any initial work.)
// ============================================================================
function LocalScript() {
    CookieSettings[ID_Filter_Text_PokeStat] = '';   // Add this manually since it changes depending upon Gen.

    ApplyCookie();
    OnFilterCriteriaChanged();

    // Now that is it loaded, expose it.
    document.getElementById('Loading').classList.add('DIV_HIDDEN');
    document.getElementById('Loaded').classList.remove('DIV_HIDDEN');
    document.getElementById('Loaded').classList.add('DIV_SHOWN');
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

// TODO QZX: Figure out how to sort.
function OnFilterCriteriaChanged(field) {
    if (field !== undefined && field !== null) {
        UpdateCookieSetting(field.id);
    }

    var source = document.getElementById('MoveSetsSource');
    var target = document.getElementById('MoveSets');
    var sort = GetFieldValueById(ID_SortType_Combobox);

    // Delete moveset rows from target.
    for (var i = target.rows.length - 1; i >= 0; i--) {
        if (target.rows[i].classList.contains('Header')) {
            break;
        }
        target.removeChild(target.rows[i]);
    }

    // TODO QZX: Figure out how to sort.
    var found = 0;
    for (var i = 0, length = source.rows.length; i < length; i += source.rows[i].cells[0].rowSpan) {
        var row = source.rows[i];

        if (!FilteredOut(row)) {
            // Copy from the source to the target.
            target.appendChild(row.cloneNode(true));
            for (var j = 1; j < row.cells[0].rowSpan; j++)
                target.appendChild(source.rows[i + j].cloneNode(true));
            found++;
        }
    }

    // If nothing fit the criteria, hide the entire target.
    if (found === 0) {
        target.style.display = 'none';
    } else {
        target.style.display = 'table';
    }
}

// Determine whether the Pokemon in this row should be shown or not.
function FilteredOut(row) {
    // If Show Only Released is on, filter out any that are not released.
    var showOnlyReleased = GetFieldValueById(ID_ShowOnlyReleased_Checkbox);
    if (showOnlyReleased && row.classList.contains("UNAVAILABLE_ROW")) {
        return true;
    }

    // If there is a Filter by Pokémon Name or ID, filter out any that don't have that name or ID. 
    var filterPokeStat = GetFieldValueById(ID_Filter_Text_PokeStat);
    var filterPokeStatIsNumber = !isNaN(filterPokeStat);
    if (filterPokeStat !== '') {
        if (filterPokeStatIsNumber) {
            if (!row.getAttribute('id').startsWith(filterPokeStat)) {
                return true;
            } 
        } else {
            if (!row.getAttribute('name').toUpperCase().startsWith(filterPokeStat.toUpperCase())) {
                return true;
            } 
        }
    }

    // If there is a Move Name or Type, filter out any that don't have that a move with that name or type. 
    var filterMove = GetFieldValueById(ID_Filter_Text_Move);
    if (filterMove !== '' &&
        row.getAttribute('quickMoves').toUpperCase().indexOf(' ' + filterMove.toUpperCase()) === -1 &&
        row.getAttribute('chargedMoves').toUpperCase().indexOf(' ' + filterMove.toUpperCase()) === -1) {
        return true;
    }

    return false;
}
