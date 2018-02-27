// #region Common

// ============================================================================
// ===== Global Variables
// ============================================================================
// #region Global Variables
var FilterScriptIdsMarker = '{0}';
var FilterScript = 'javascript:var show=[' + FilterScriptIdsMarker + '];for(i=1;i<1000;i++){localStorage.setItem(i,"0");};for(i=0;i<show.length;i++){localStorage.setItem(show[i],"1");};location.reload();';
var CheckIdPrefix = 'Check_';
var CellIdPrefix = 'Cell_';
var PokemonCheckDefault = 'false';
// #endregion Global Variables

// #region Variables that need to be updated when SEAPokeMap makes changes.
var SeaPokeMap_Disabled = [
    'Hoothoot',
    'Hoppip',
    'Krabby',
    'Ledyba',
    'Murkrow',
    'Natu',
    'Paras',
    'Pidgey',
    'Rattata',
    'Seedot',
    'Skitty',
    'Spearow',
    'Spheal',
    'Spinarak',
    'Swinub',
    'Venonat',
    'Weedle',
    'Zigzagoon',
    'Zubat',
];
var SeaPokeMap_HaveIV = [
    'Abra',
    'Aerodactyl',
    'Alakazam',
    'Ampharos',
    'Arcanine',
    'Blastoise',
    'Blaziken',
    'Blissey',
    'Chansey',
    'Charizard',
    'Clefable',
    'Cloyster',
    'Combusken',
    'Crawdaunt',
    'Delibird',
    'Dewgong',
    'Donphan',
    'Dragonair',
    'Dragonite',
    'Dratini',
    'Exeggutor',
    'Feebas',
    'Feraligatr',
    'Flaaffy',
    'Flareon',
    'Gardevoir',
    'Gengar',
    'Geodude',
    'Golem',
    'Graveler',
    'Grovyle',
    'Gyarados',
    'Haunter',
    'Hitmonchan',
    'Hitmonlee',
    'Hitmontop',
    'Houndoom',
    'Houndour',
    'Jolteon',
    'Kabutops',
    'Kadabra',
    'Kirlia',
    'Lapras',
    'Larvitar',
    'Lickitung',
    'Lombre',
    'Lotad',
    'Ludicolo',
    'Machamp',
    'Machoke',
    'Machop',
    'Mareep',
    'Marshtomp',
    'Meganium',
    'Mightyena',
    'Milotic',
    'Muk',
    'Nidoking',
    'Nidoqueen',
    'Ninetales',
    'Omastar',
    'Piloswine',
    'Poliwrath',
    'Porygon',
    'Primeape',
    'Pupitar',
    'Ralts',
    'Rapidash',
    'Rhydon',
    'Rhyhorn',
    'Sceptile',
    'Scyther',
    'Seadra',
    'Sealeo',
    'Sharpedo',
    'Slaking',
    'Slakoth',
    'Snorlax',
    'Swampert',
    'Togetic',
    'Typhlosion',
    'Tyranitar',
    'Unown',
    'Ursaring',
    'Vaporeon',
    'Venusaur',
    'Victreebel',
    'Vigoroth',
    'Vileplume',
    'Wailmer',
    'Wailord',
    'Walrein',
    'Whiscash',
    'Wigglytuff',
    'Aggron',
    'Armaldo',
    'Aron',
    'Cacturne',
    'Camerupt',
    'Claydol',
    'Cradily',
    'Exploud',
    'Flygon',
    'Lairon',
    'Loudred',
    'Lunatone',
    'Solrock',
    'Torkoal',
    'Vibrava',
];
// #endregion Variables that need to be updated when SEAPokeMap makes changes.

// ============================================================================
// ===== Cookies
// ============================================================================
// #region Cookies

var CookieSettings = {
    'Check_Icons': 'false',
    'Check_IVOnly': 'false',
    'Input_MinIV': '0',
}

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    ApplyCookieSettings(CookieSettings);
    GenerateFilter(null);
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
        DoSeaPokeMapDisable();
        ApplyCookie();
    } catch (err) {
        ShowError(err);
    }
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

function GetFields() {
    var FilterResults = document.getElementById('FilterResults');

    for (var i = 1; i < 1000; i++) {
        var fieldId = CheckIdPrefix + i;
        if (document.getElementById(fieldId) != null) {
            CookieSettings[fieldId] = PokemonCheckDefault;
        }
    }
}


// Clear the cookie for the current Filter and Reset all of the fields.
function Reset() {
    try {
        ClearCookieSettings(CookieSettings);
        ApplyCookie();
    } catch (err) {
        ShowError(err);
    }
}

// Generate the filter using the settings 
function GenerateFilter(field) {
    var pokemonIds = '';

    if (field !== null) {
        UpdateCookieSetting(field.id, CookieSettings[field.id]);
    }

    for (var i = 1; i < 1000; i++) {
        var checkbox = document.getElementById(CheckIdPrefix + i);
        if (checkbox !== null && checkbox.checked) {
            pokemonIds += i + ',';
        }
    }

    if (pokemonIds === '') {
        FilterResults.innerHTML = '&nbsp;';
        FilterResults.classList.add('DISABLED');
    } else {
        FilterResults.innerText = FilterScript.replace(FilterScriptIdsMarker, pokemonIds);
        FilterResults.classList.remove('DISABLED');
    }
}

// Disable the fields that SEAPokeMap does.
function DoSeaPokeMapDisable() {
    SeaPokeMap_Disabled.forEach(function (name) {
        document.getElementById(CellIdPrefix + PokemonNameToId(name)).classList.add('DISABLED');
    });
}

// Called when one of the Pokemon's checkbox is toggled.
function OnPokemonCheckChanged(checkbox) {
    try {
        // Determine which column the checkbox is in.
        var column = parseInt(checkbox.name);

        // Determine what the state of the Column checkbox should be.
        var state = null;
        // TODO QZX: Loop through each row {
        //      if (state === null) { 
        //          state = row[column].checkbox.checked; 
        //      } else if (row[column].checkbox.checked !== state) {
        //          state = indeterminate;
        //          break;
        //      }
        //  }

        // Set the state of the Column checkbox.
        //  columnHeader[column].checkbox.checked = state;


        //  - If all of the checkboxes in the column (that are not disabled) are checked, set Column's checkbox checked
        //  - If all of the checkboxes in the column (that are not disabled) are unchecked, set Column's checkbox unchecked
        //  - If all of the checkboxes in the column (that are not disabled) are checked, set Column's checkbox to undetermined

        GenerateFilter(checkbox);
    } catch (err) {
        ShowError(err);
    }
}

function OnColumnCheckChanged(checkbox) {
    try {
        var state = checkbox.checked ? 'true' : 'false';

        checkbox.id.split(' ').forEach(function (id) {
            if (id !== '' && !document.getElementById(CellIdPrefix + id).classList.contains('DISABLED')) {
                var checkboxId = CheckIdPrefix + id;
                SetCookieSetting(checkboxId, state);
                ApplyCookieSetting(checkboxId, PokemonCheckDefault);
            }
        });

        GenerateFilter(null);
    } catch (err) {
        ShowError(err);
    }
}

function OnIVOnlyCheckChanged(checkbox) {
    for (var i = 1; i < 1000; i++) {
        // See if this ID is NOT one of those for which SEAPokeMap may show IV.
        if (!SeaPokeMap_HaveIV.contains(PokemonIdToName(i))) {
            var field = document.getElementById(CellIdPrefix + i);
            if (field !== null) {
                if (checkbox.checked) {
                    // Disable the cell
                    field.classList.add('DISABLED');

                    // Clear the Pokemon's checkbox.
                    SetCookieSetting(CheckIdPrefix + i, 'false');
                    ApplyCookieSetting(CheckIdPrefix + i, PokemonCheckDefault);
                } else {
                    // Enable the cell
                    field.classList.remove('DISABLED');
                }
            }
        }
    }

    // TODO QZX: Update the Column checkbox states.

    GenerateFilter(checkbox);
}
