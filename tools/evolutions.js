var GenFilterType_Combobox_Default = 1; // 'Any of Selected Gens'

function LocalScript() {
    ApplyCookies();

    document.getElementById('Loading').style.display = 'none';
    document.getElementById('Loaded').style.display = '';
}

// ****************************************************************************************************************
// Functions for Evolutions Chart
// ****************************************************************************************************************

// TODO QZX: Add a Reset button that clears the cache and sets the defaults.

var CookieFieldIds = [
    ['Gen1_Check', 'true'],
    ['Gen2_Check', 'true'],
    ['Gen3_Check', 'true'],
    ['Gen4_Check', 'false'],
    ['Gen5_Check', 'false'],
    ['Gen6_Check', 'false'],
    ['Gen7_Check', 'false'],
    ['GenFilterType_Combobox', GenFilterType_Combobox_Default],
    ['Filter_Text', ''],
];

function OnFilterCriteriaChanged(field) {
    if (field !== undefined && field !== null) {
        UpdateCookieSetting(field.id);
    }

    var genFilterType = document.getElementById('GenFilterType_Combobox').value;
    var gen1 = document.getElementById('Gen1_Check').checked;
    var gen2 = document.getElementById('Gen2_Check').checked;
    var gen3 = document.getElementById('Gen3_Check').checked;
    var gen4 = document.getElementById('Gen4_Check').checked;
    var gen5 = document.getElementById('Gen5_Check').checked;
    var gen6 = document.getElementById('Gen6_Check').checked;
    var gen7 = document.getElementById('Gen7_Check').checked;
    var filter = document.getElementById('Filter_Text').value;
    var isNumber = !isNaN(filter);

    var found = 0;
    var table = document.getElementById('Evolutions');
    if ((gen1 || gen2 || gen3 || gen4 || gen5 || gen6 || gen7)) {
        for (var i = 0, length = table.rows.length; i < length; i += table.rows[i].cells[0].rowSpan) {
            var row = table.rows[i];
            var gens = row.attributes['gens'].value;

            // Check the criteria
            var display;
            if (
                (
                    (genFilterType === '1' &&
                        ((gen1 && gens.indexOf('1 ') >= 0)
                        || (gen2 && gens.indexOf('2 ') >= 0)
                        || (gen3 && gens.indexOf('3 ') >= 0)
                        || (gen4 && gens.indexOf('4 ') >= 0)
                        || (gen5 && gens.indexOf('5 ') >= 0)
                        || (gen6 && gens.indexOf('6 ') >= 0)
                        || (gen7 && gens.indexOf('7 ') >= 0))
                    ) || (genFilterType === '2'
                        && (!gen1 || gens.indexOf('1 ') >= 0)
                        && (!gen2 || gens.indexOf('2 ') >= 0)
                        && (!gen3 || gens.indexOf('3 ') >= 0)
                        && (!gen4 || gens.indexOf('4 ') >= 0)
                        && (!gen5 || gens.indexOf('5 ') >= 0)
                        && (!gen6 || gens.indexOf('6 ') >= 0)
                        && (!gen7 || gens.indexOf('7 ') >= 0))
                ) && (
                    filter.length === 0
                    || (isNumber && row.attributes['ids'].value.indexOf(' ' + filter + ' ') >= 0)
                    || (!isNumber &&  row.attributes['names'].value.toUpperCase().indexOf(filter.toUpperCase()) >= 0)
                )
            ) {
                display = '';
                found++;
            } else {
                display = 'none';
            }

            // Show/hide the family's Rows.
            for (var r = 0; r < table.rows[i].cells[0].rowSpan; r++) {
                table.rows[i + r].style.display = display;
            }
        }
    }

    // If nothing fit the criteria, hide the entire table.
    if (found === 0) {
        table.style.display = 'none';
    } else {
        table.style.display = '';
    }
}

// Read the Cookie and apply it to the fields.
function ApplyCookies() {
    try {
        ApplyCookieSettingsQZX(CookieFieldIds);
        OnFilterCriteriaChanged();
    }
    catch (err) {
        ShowError(err);
    }
}
