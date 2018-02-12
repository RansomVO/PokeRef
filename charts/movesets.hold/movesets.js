// #region Common

// ============================================================================
// #region Global Variables
// ============================================================================

var SortBy_Name = 1;
var SortBy_Id = 2;
var SortBy_TrueDPS = 3;
var SortBy_Default = SortBy_Name;

// #endregion Global Variables

// ============================================================================
// #region Cookies
// ============================================================================

var CookieSettings = {
    'SortType_Combobox': SortBy_Default,
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

function GetFields() {
    var SortType_Combobox = document.getElementById('SortType_Combobox');
    var Filter_Text_NameId = document.getElementById('Filter_Text_NameId');
    var Filter_Text_Move = document.getElementById('Filter_Text_Move');
    var ShowOnlyReleased_Checkbox = document.getElementById('ShowOnlyReleased_Checkbox');
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
    var sort = SortType_Combobox.value;

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

        if (MatchesFilter(row)) {
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
function MatchesFilter(row) {
    // If Show Only Released is on, filter out any that are not released.
    var showOnlyReleased = ShowOnlyReleased_Checkbox.value;
    if (showOnlyReleased && row.classList.contains("UNAVAILABLE_ROW")) {
        return false;
    }

    // If there is a Filter by Pokémon Name or ID, filter out any that don't have that name or ID. 
    var filterPokeStat = GetFieldValue(Filter_Text_NameId);
    var filterPokeStatIsNumber = !isNaN(filterPokeStat);
    if (filterPokeStat !== '') {
        if (filterPokeStatIsNumber) {
            if (!row.getAttribute('id').startsWith(filterPokeStat)) {
                return false;
            } 
        } else {
            if (!row.getAttribute('name').toUpperCase().startsWith(filterPokeStat.toUpperCase())) {
                return false;
            } 
        }
    }

    // If there is a Move Name or Type, filter out any that don't have that a move with that name or type. 
    var filterMove = Filter_Text_Move.value;
    if (filterMove !== '' &&
        row.getAttribute('fastMoves').toUpperCase().indexOf(' ' + filterMove.toUpperCase()) === -1 &&
        row.getAttribute('chargedMoves').toUpperCase().indexOf(' ' + filterMove.toUpperCase()) === -1) {
        return false;
    }

    return true;
}
