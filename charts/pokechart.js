// #region Common

// ==============================================================================================
// #region Global Variables
// ==============================================================================================

var boostsSelections = null;
var typeSelections = null;

// #endregion

// ============================================================================
// #region Cookies
// ============================================================================

var CookieSettings = {
    'Filter_Text': '',
    'ReleasedOnly_Check': 'false',
    'ShinyOnly_Check': 'false',
    'HatchOnly_Check': 'false',
    'RegionalOnly_Check': 'false',
    'RaidBossOnly_Check': 'false',
    'LegendaryOnly_Check': 'false',
};

// Read the Cookie and apply it to the fields.
function ApplyCookies() {
    try {
        ApplyCookieSettings(CookieSettings);
        //OnToggleType();
        //OnToggleBoost();
        OnFilterCriteriaChanged();
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
    ApplyCookies();
    GetFields();
}

// Get the fields we will be using multiple times.
//  NOTE: Do not use keyword "var" and the value will be global.
function GetFields() {
    try {
        Filter_Text = document.getElementById('Filter_Text');
        ReleasedOnly_Check = document.getElementById('ReleasedOnly_Check');
        RegionalOnly_Check = document.getElementById('RegionalOnly_Check');
        RaidBossOnly_Check = document.getElementById('RaidBossOnly_Check');
        LegendaryOnly_Check = document.getElementById('LegendaryOnly_Check');
        HatchOnly_Check = document.getElementById('HatchOnly_Check');
        ShinyOnly_Check = document.getElementById('ShinyOnly_Check');

        GEN1_Collection = document.getElementById('GEN1_Collection');
        GEN2_Collection = document.getElementById('GEN2_Collection');
        GEN3_Collection = document.getElementById('GEN3_Collection');
        GEN4_Collection = document.getElementById('GEN4_Collection');
        GEN5_Collection = document.getElementById('GEN5_Collection');
        GEN6_Collection = document.getElementById('GEN6_Collection');
        GEN7_Collection = document.getElementById('GEN7_Collection');

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
    catch (err) {
        ShowError(err);
    }
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

// Filter criteria changed, so refilter everything.
function OnFilterCriteriaChanged(field) {
    if (field !== undefined && field !== null) {
        UpdateCookieSetting(field.id);
    }

    FilterGeneration(GEN1_Collection);
    FilterGeneration(GEN2_Collection);
    FilterGeneration(GEN3_Collection);
    FilterGeneration(GEN4_Collection);
    FilterGeneration(GEN5_Collection);
    FilterGeneration(GEN6_Collection);
    FilterGeneration(GEN7_Collection);
}

// Filter specified generation of Pokemon.
function FilterGeneration(collection) {
    for (var i = 0; i < collection.children.length; i++) {
        if (MatchesFilter(collection.children[i])) {
            collection.children[i].style.display = '';
        } else {
            collection.children[i].style.display = 'none';
        }
    }
}

//Determine if a specific Pokemon matches the filters.
function MatchesFilter(pokemon) {
    if (Filter_Text.value != '' && !pokemon.attributes['name'].value.toUpperCase().startsWith(Filter_Text.value.toUpperCase())) {
        return false;
    }

    if (ReleasedOnly_Check.checked && pokemon.attributes['availability'].value.indexOf('Unavailable') >= 0) {
        return false;
    }

    if (RegionalOnly_Check.checked && pokemon.attributes['availability'].value.indexOf('Regional') < 0) {
        return false;
    }

    if (RaidBossOnly_Check.checked && (pokemon.attributes['raidboss'] === undefined || pokemon.attributes['raidboss'].value !== 'true')) {
        return false;
    }

    if (LegendaryOnly_Check.checked && pokemon.attributes['availability'].value.indexOf('Legendary') < 0) {
        return false;
    }

    if (HatchOnly_Check.checked && pokemon.attributes['availability'].value.indexOf('Hatch Only') < 0) {
        return false;
    }

    if (ShinyOnly_Check.checked && pokemon.attributes['shiny'].value === '') {
        return false;
    }

    if (typeSelections !== null) {
        var types = pokemon.attributes['type1'].value + ' ' + pokemon.attributes['type2'].value;
        if (!((typeSelections['Bug'] && types.indexOf('Bug') >= 0) ||
            (typeSelections['Dark'] && types.indexOf('Dark') >= 0) ||
            (typeSelections['Dragon'] && types.indexOf('Dragon') >= 0) ||
            (typeSelections['Electric'] && types.indexOf('Electric') >= 0) ||
            (typeSelections['Fairy'] && types.indexOf('Fairy') >= 0) ||
            (typeSelections['Fighting'] && types.indexOf('Fighting') >= 0) ||
            (typeSelections['Fire'] && types.indexOf('Fire') >= 0) ||
            (typeSelections['Flying'] && types.indexOf('Flying') >= 0) ||
            (typeSelections['Ghost'] && types.indexOf('Ghost') >= 0) ||
            (typeSelections['Grass'] && types.indexOf('Grass') >= 0) ||
            (typeSelections['Ground'] && types.indexOf('Ground') >= 0) ||
            (typeSelections['Ice'] && types.indexOf('Ice') >= 0) ||
            (typeSelections['Normal'] && types.indexOf('Normal') >= 0) ||
            (typeSelections['Poison'] && types.indexOf('Poison') >= 0) ||
            (typeSelections['Psychic'] && types.indexOf('Psychic') >= 0) ||
            (typeSelections['Rock'] && types.indexOf('Rock') >= 0) ||
            (typeSelections['Steel'] && types.indexOf('Steel') >= 0) ||
            (typeSelections['Water'] && types.indexOf('Water') >= 0))) {
            return false;
        }
    }

    if (boostsSelections !== null) {
        // Using the '~' so we don't get Partly Cloudy when Cloudy is true.
        var boosts = '~' + pokemon.attributes['boost1'].value + '~' + pokemon.attributes['boost2'].value;
        if (!((boostsSelections['Sunny'] && boosts.indexOf('~Sunny') >= 0) ||
            (boostsSelections['Windy'] && boosts.indexOf('~Windy') >= 0) ||
            (boostsSelections['PartlyCloudy'] && boosts.indexOf('~Partly Cloudy') >= 0) ||
            (boostsSelections['Cloudy'] && boosts.indexOf('~Cloudy') >= 0) ||
            (boostsSelections['Fog'] && boosts.indexOf('~Fog') >= 0) ||
            (boostsSelections['Rainy'] && boosts.indexOf('~Rainy') >= 0) ||
            (boostsSelections['Snow'] && boosts.indexOf('~Snow') >= 0))) {
            return false;
        }
    }

    return true;
}

function OnTypesChanged(types) {
    typeSelections = types;
    OnFilterCriteriaChanged();
}

function OnWeatherChanged(weather) {
    boostsSelections = weather;
    OnFilterCriteriaChanged();
}

// Called when a Pokemon is selected.
function OnSelectPokemon(pokemon) {
    Selected_Pokemon_Title.innerHTML = GetPokemonName(pokemon);

    var remove = {};
    remove.name = true;
    Selected_Pokemon.innerHTML = GetPokemonIcon(pokemon, remove).replace('onclick="OnSelectPokemon(this)"', '').replace('style="cursor:pointer;"', '');
    Selected_Pokemon_Generation.innerHTML = GetPokemonGeneration(pokemon);
    Selected_Pokemon_Family.innerHTML = GetPokemonFamily(pokemon);

    var type1 = GetPokemonType1(pokemon, true);
    var boost1 = GetPokemonBoost1(pokemon, true);
    var type2 = GetPokemonType2(pokemon, true);
    var boost2 = GetPokemonBoost2(pokemon, true);
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
    Selected_Pokemon_Shiny.innerHTML = GetPokemonShiny(pokemon, true);
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
            Selected_Pokemon_Weaknesses.innerHTML += GetPokemonType(key, true);
            if (counts[key] !== -1) {
                Selected_Pokemon_Weaknesses.innerHTML += '&nbsp;&times;&nbsp;' + -counts[key];
            }
            Selected_Pokemon_Weaknesses.innerHTML += '<br />';
        } else if (counts[key] > 0) {
            Selected_Pokemon_Strengths.innerHTML += GetPokemonType(key, true);
            if (counts[key] !== 1) {
                Selected_Pokemon_Strengths.innerHTML += '&nbsp;&times;&nbsp;' + counts[key];
            }
            Selected_Pokemon_Strengths.innerHTML += '<br />';
        }
    }

    // TODO QZX: If Raidboss, link to Possible IVs.

    // TODO QZX: Evolutions (Row from Evolutions Chart) +
    // TODO QZX:    # Name Candies Special

    // TODO QZX: MoveSets (Rows from MoveSets chart)

    ShowPopup(Selected_Pokemon_Dialog);
}

