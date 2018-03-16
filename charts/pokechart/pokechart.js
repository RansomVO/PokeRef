// #region Common

// ==============================================================================================
// #region Global Variables
// ==============================================================================================

var selectionsTypes = null;
var selectionsBoosts = null;
var selectionsEgg = null;
var filterNameID = null;

// #endregion

// ============================================================================
// #region Cookies
// ============================================================================

var CookieSettings = {
    'ReleasedOnly_Check': 'false',
    'Shiny_Check': 'false',
    'Regional_Check': 'false',
    'RaidBoss_Check': 'false',
    'Legendary_Check': 'false',
};

// Read the Cookie and apply it to the fields.
function ApplyCookie() {
    ApplyCookieSettings(CookieSettings);

    OnFilterCriteriaChanged();
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
    } catch (err) {
        ShowError(err);
    }
}

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetFields() {
    ReleasedOnly_Check = document.getElementById('ReleasedOnly_Check');
    Regional_Check = document.getElementById('Regional_Check');
    RaidBoss_Check = document.getElementById('RaidBoss_Check');
    Legendary_Check = document.getElementById('Legendary_Check');
    Shiny_Check = document.getElementById('Shiny_Check');

    Collections = [null]
    for (var i = 1; i <= 7; i++) {
        Collections.push(document.getElementById('GEN' + i + '_Collection'));
    }

    Selected_Pokemon_Dialog = document.getElementById('Selected_Pokemon_Dialog');
    Selected_Pokemon_Title = document.getElementById('Selected_Pokemon_Title');
    Selected_Pokemon = document.getElementById('Selected_Pokemon');
    Selected_Pokemon_Generation = document.getElementById('Selected_Pokemon_Generation');
    Selected_Pokemon_Family = document.getElementById('Selected_Pokemon_Family');
    Selected_Pokemon_Types = document.getElementById('Selected_Pokemon_Types');
    Selected_Pokemon_Boosts = document.getElementById('Selected_Pokemon_Boosts');
    Selected_Pokemon_GenderRatio = document.getElementById('Selected_Pokemon_GenderRatio');
    Selected_Pokemon_Shiny = document.getElementById('Selected_Pokemon_Shiny');
    Selected_Pokemon_Availability = document.getElementById('Selected_Pokemon_Availability');
    Selected_Pokemon_Max_CP = document.getElementById('Selected_Pokemon_Max_CP');
    Selected_Pokemon_Max_HP = document.getElementById('Selected_Pokemon_Max_HP');
    Selected_Pokemon_BuddyKM = document.getElementById('Selected_Pokemon_BuddyKM');
    Selected_Pokemon_BaseIV_Attack = document.getElementById('Selected_Pokemon_BaseIV_Attack');
    Selected_Pokemon_BaseIV_Defense = document.getElementById('Selected_Pokemon_BaseIV_Defense');
    Selected_Pokemon_BaseIV_Stamina = document.getElementById('Selected_Pokemon_BaseIV_Stamina');
    Selected_Pokemon_CaptureRate = document.getElementById('Selected_Pokemon_CaptureRate');
    Selected_Pokemon_FleeRate = document.getElementById('Selected_Pokemon_FleeRate');
    Selected_Pokemon_Strengths = document.getElementById('Selected_Pokemon_Strengths');
    Selected_Pokemon_Weaknesses = document.getElementById('Selected_Pokemon_Weaknesses');
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
    if (filterNameID !== null && !MatchFilterPokemonNameID(pokemon, filterNameID)) {
        return false;
    }

    if (ReleasedOnly_Check.checked && GetPokemonAvailability(pokemon).contains('Unavailable')) {
        return false;
    }

    if (Regional_Check.checked && !GetPokemonAvailability(pokemon).contains('Regional')) {
        return false;
    }

    if (RaidBoss_Check.checked && (pokemon.attributes['raidboss'] === undefined || pokemon.attributes['raidboss'].value !== 'true')) {
        return false;
    }

    if (Legendary_Check.checked && !GetPokemonAvailability(pokemon).contains('Legendary') && !GetPokemonAvailability(pokemon).contains('Mythic')) {
        return false;
    }

    if (Shiny_Check.checked && !GetPokemonShiny(pokemon)) {
        return false;
    }

    if (!EggMatchesFilter(selectionsEgg, pokemon)) {
        return false;
    }

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

// Called when a Pokemon is selected.
function OnSelectPokemon(pokemon) {
    try {
        Selected_Pokemon_Title.innerHTML = GetPokemonIDName(pokemon);

        var remove = {};
        remove.name = true;
        Selected_Pokemon.innerHTML = GetPokemonIcon(pokemon, remove);

        // If Raidboss, link to Possible IVs.
        var raidBossLink = GetPokemonRaidBossLink(pokemon);
        Selected_Pokemon.innerHTML = raidBossLink !== null 
            ? Selected_Pokemon.innerHTML.replace('onclick="OnSelectPokemon(this)"', 'onclick="OnSelectRaidBoss(\'' + raidBossLink + '\')"')
            : Selected_Pokemon.innerHTML.replace('onclick="OnSelectPokemon(this)"', '').replace('style="cursor:pointer;"', '');

        Selected_Pokemon_Generation.innerHTML = GetPokemonGeneration(pokemon);
        Selected_Pokemon_Family.innerHTML = GetPokemonFamily(pokemon);

        var type1 = GetPokemonType1Icon(pokemon);
        var boost1 = GetPokemonBoost1Icon(pokemon);
        var type2 = GetPokemonType2Icon(pokemon);
        var boost2 = GetPokemonBoost2Icon(pokemon);
        if (type2 === null) {
            Selected_Pokemon_Types.innerHTML = type1;
            Selected_Pokemon_Boosts.innerHTML = boost1;
        } else {
            Selected_Pokemon_Types.innerHTML =
                '<table width="100%" style="white-space: nowrap"><tr><td width="50%">' + type1 + '</td><td width="50%">' + type2 + '</td><tr></table>';
            Selected_Pokemon_Boosts.innerHTML =
                '<table width="100%" style="white-space: nowrap"><tr><td width="50%">' + boost1 + '</td><td width="50%">' + boost2 + '</td><tr></table>';
        }

        Selected_Pokemon_GenderRatio.innerHTML = GetPokemonGenderRatio(pokemon);
        Selected_Pokemon_Shiny.innerHTML = GetPokemonShinyIcon(pokemon);
        Selected_Pokemon_Availability.innerHTML = GetPokemonAvailability(pokemon);
        Selected_Pokemon_Max_CP.innerHTML = GetPokemonMax_CP(pokemon);
        Selected_Pokemon_Max_HP.innerHTML = GetPokemonMax_HP(pokemon);
        Selected_Pokemon_BuddyKM.innerHTML = GetPokemonBuddyKM(pokemon);
        Selected_Pokemon_BaseIV_Attack.innerHTML = GetPokemonBaseAttack(pokemon);
        Selected_Pokemon_BaseIV_Defense.innerHTML = GetPokemonBaseDefense(pokemon);
        Selected_Pokemon_BaseIV_Stamina.innerHTML = GetPokemonBaseStamina(pokemon);
        Selected_Pokemon_CaptureRate.innerHTML = GetPokemonCaptureRate(pokemon);
        Selected_Pokemon_FleeRate.innerHTML = GetPokemonFleeRate(pokemon);

        var weaknesses = GetPokemonWeakAgainst(pokemon);
        var strengths = GetPokemonStrongAgainst(pokemon);
        var immunities = GetPokemonImmuneAgainst(pokemon);

        var counts = {}
        var types = GetAllTypes();
        for (var i = 0; i < types.length; i++) {
            counts[types[i]] = 0;
        }
        for (var i = 0; i < weaknesses.length; i++) {
            counts[weaknesses[i]] -= 1;
        }
        for (var i = 0; i < strengths.length; i++) {
            counts[strengths[i]] += 1;
        }
        for (var i = 0; i < immunities.length; i++) {
            counts[immunities[i]] += 2;
        }

        Selected_Pokemon_Strengths.innerHTML = '';
        Selected_Pokemon_Weaknesses.innerHTML = '';
        for (var key in counts) {
            if (counts[key] < 0) {
                Selected_Pokemon_Weaknesses.innerHTML += GetPokemonTypeIcon(key);
                if (counts[key] !== -1) {
                    Selected_Pokemon_Weaknesses.innerHTML += '&nbsp;&times;&nbsp;' + -counts[key];
                }
                Selected_Pokemon_Weaknesses.innerHTML += '<br />';
            } else if (counts[key] > 0) {
                Selected_Pokemon_Strengths.innerHTML += GetPokemonTypeIcon(key);
                if (counts[key] !== 1) {
                    Selected_Pokemon_Strengths.innerHTML += '&nbsp;&times;&nbsp;' + counts[key];
                }
                Selected_Pokemon_Strengths.innerHTML += '<br />';
            }
        }


        // TODO QZX: Evolutions (Row from Evolutions Chart)

        // TODO QZX: MoveSets (Rows from MoveSets chart)

        ShowPopup(Selected_Pokemon_Dialog);
    } catch (err) {
        ShowError(err);
    }
}

// Called when a Raidboss Pokemon is selected on the pop-up.
function OnSelectRaidBoss(url) {
    window.location.href = url;
}

// Called when any of the Egg checkboxes change.
function OnEggChanged(egg) {
    selectionsEgg = egg;
    OnFilterCriteriaChanged();
}

// Called the Pokemon Name/ID filter changes.
function OnPokemonNameIDChanged(filter) {
    filterNameID = filter;
    OnFilterCriteriaChanged();
}

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
        ClearEggSelector();
        ClearFilterNameID();
        ClearPokeTypeSelector();
        ClearWeatherSelector();
        ClearCookieSettings(CookieSettings);
        ApplyCookie();
        OnFilterCriteriaChanged();
    } catch (err) {
        ShowError(err);
    }
}

// #endregion
