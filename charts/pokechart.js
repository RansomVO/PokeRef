// #region Common

// ============================================================================
// ===== Cookies
// ============================================================================
// #region Cookies

var CookieSettings = {
    'Filter_Text': '',
    'ReleasedOnly_Check': 'false',
    'ShinyOnly_Check': 'false',
    'HatchOnly_Check': 'false',
    'RegionalOnly_Check': 'false',
    'RaidBossOnly_Check': 'false',
    'LegendaryOnly_Check': 'false',
    'Type_Bug_Check': 'true',
    'Type_Dark_Check': 'true',
    'Type_Dragon_Check': 'true',
    'Type_Electric_Check': 'true',
    'Type_Fairy_Check': 'true',
    'Type_Fighting_Check': 'true',
    'Type_Fire_Check': 'true',
    'Type_Flying_Check': 'true',
    'Type_Ghost_Check': 'true',
    'Type_Grass_Check': 'true',
    'Type_Ground_Check': 'true',
    'Type_Ice_Check': 'true',
    'Type_Normal_Check': 'true',
    'Type_Poison_Check': 'true',
    'Type_Psychic_Check': 'true',
    'Type_Rock_Check': 'true',
    'Type_Steel_Check': 'true',
    'Type_Water_Check': 'true',
    'Boost_Sunny_Check': 'true',
    'Boost_Windy_Check': 'true',
    'Boost_Cloudy_Check': 'true',
    'Boost_PartlyCloudy_Check': 'true',
    'Boost_Fog_Check': 'true',
    'Boost_Rainy_Check': 'true',
    'Boost_Snow_Check': 'true',
};

// Read the Cookie and apply it to the fields.
function ApplyCookies() {
    try {
        ApplyCookieSettings(CookieSettings);
        OnToggleType();
        OnToggleBoost();
        OnFilterCriteriaChanged();
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
    ApplyCookies();
    GetFields();
}

// #endregion Common

// ============================================================================
// ===== Functions specific to this page.
// ============================================================================

// Get the fields we will be using multiple times.
//  (I think the vars need to be named with a capital letter first to be considered global.)
function GetFields() {
    try {
        var Filter_Text = document.getElementById('Filter_Text');
        var ReleasedOnly_Check = document.getElementById('ReleasedOnly_Check');
        var RegionalOnly_Check = document.getElementById('RegionalOnly_Check');
        var RaidBossOnly_Check = document.getElementById('RaidBossOnly_Check');
        var LegendaryOnly_Check = document.getElementById('LegendaryOnly_Check');
        var HatchOnly_Check = document.getElementById('HatchOnly_Check');
        var ShinyOnly_Check = document.getElementById('ShinyOnly_Check');

        var Type_All_Check = document.getElementById('Type_All_Check');
        var Type_Bug_Check = document.getElementById('Type_Bug_Check');
        var Type_Dark_Check = document.getElementById('Type_Dark_Check');
        var Type_Dragon_Check = document.getElementById('Type_Dragon_Check');
        var Type_Electric_Check = document.getElementById('Type_Electric_Check');
        var Type_Fairy_Check = document.getElementById('Type_Fairy_Check');
        var Type_Fighting_Check = document.getElementById('Type_Fighting_Check');
        var Type_Fire_Check = document.getElementById('Type_Fire_Check');
        var Type_Flying_Check = document.getElementById('Type_Flying_Check');
        var Type_Ghost_Check = document.getElementById('Type_Ghost_Check');
        var Type_Grass_Check = document.getElementById('Type_Grass_Check');
        var Type_Ground_Check = document.getElementById('Type_Ground_Check');
        var Type_Ice_Check = document.getElementById('Type_Ice_Check');
        var Type_Normal_Check = document.getElementById('Type_Normal_Check');
        var Type_Poison_Check = document.getElementById('Type_Poison_Check');
        var Type_Psychic_Check = document.getElementById('Type_Psychic_Check');
        var Type_Rock_Check = document.getElementById('Type_Rock_Check');
        var Type_Steel_Check = document.getElementById('Type_Steel_Check');
        var Type_Water_Check = document.getElementById('Type_Water_Check');

        var Boost_All_Check = document.getElementById('Boost_All_Check');
        var Boost_Sunny_Check = document.getElementById('Boost_Sunny_Check');
        var Boost_Windy_Check = document.getElementById('Boost_Windy_Check');
        var Boost_Cloudy_Check = document.getElementById('Boost_Cloudy_Check');
        var Boost_PartlyCloudy_Check = document.getElementById('Boost_PartlyCloudy_Check');
        var Boost_Fog_Check = document.getElementById('Boost_Fog_Check');
        var Boost_Rainy_Check = document.getElementById('Boost_Rainy_Check');
        var Boost_Snow_Check = document.getElementById('Boost_Snow_Check');

        var GEN1_Collection = document.getElementById('GEN1_Collection');
        var GEN2_Collection = document.getElementById('GEN2_Collection');
        var GEN3_Collection = document.getElementById('GEN3_Collection');
        var GEN4_Collection = document.getElementById('GEN4_Collection');
        var GEN5_Collection = document.getElementById('GEN5_Collection');
        var GEN6_Collection = document.getElementById('GEN6_Collection');
        var GEN7_Collection = document.getElementById('GEN7_Collection');

        var Selected_Pokemon = document.getElementById('Selected_Pokemon');
    }
    catch (err) {
        ShowError(err);
    }
}

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

    if (!((Type_Bug_Check.checked && pokemon.attributes['type'].value.indexOf('Bug') >= 0) ||
        (Type_Dark_Check.checked && pokemon.attributes['type'].value.indexOf('Dark') >= 0) ||
        (Type_Dragon_Check.checked && pokemon.attributes['type'].value.indexOf('Dragon') >= 0) ||
        (Type_Electric_Check.checked && pokemon.attributes['type'].value.indexOf('Electric') >= 0) ||
        (Type_Fairy_Check.checked && pokemon.attributes['type'].value.indexOf('Fairy') >= 0) ||
        (Type_Fighting_Check.checked && pokemon.attributes['type'].value.indexOf('Fighting') >= 0) ||
        (Type_Fire_Check.checked && pokemon.attributes['type'].value.indexOf('Fire') >= 0) ||
        (Type_Flying_Check.checked && pokemon.attributes['type'].value.indexOf('Flying') >= 0) ||
        (Type_Ghost_Check.checked && pokemon.attributes['type'].value.indexOf('Ghost') >= 0) ||
        (Type_Grass_Check.checked && pokemon.attributes['type'].value.indexOf('Grass') >= 0) ||
        (Type_Ground_Check.checked && pokemon.attributes['type'].value.indexOf('Ground') >= 0) ||
        (Type_Ice_Check.checked && pokemon.attributes['type'].value.indexOf('Ice') >= 0) ||
        (Type_Normal_Check.checked && pokemon.attributes['type'].value.indexOf('Normal') >= 0) ||
        (Type_Poison_Check.checked && pokemon.attributes['type'].value.indexOf('Poison') >= 0) ||
        (Type_Psychic_Check.checked && pokemon.attributes['type'].value.indexOf('Psychic') >= 0) ||
        (Type_Rock_Check.checked && pokemon.attributes['type'].value.indexOf('Rock') >= 0) ||
        (Type_Steel_Check.checked && pokemon.attributes['type'].value.indexOf('Steel') >= 0) ||
        (Type_Water_Check.checked && pokemon.attributes['type'].value.indexOf('Water') >= 0))) {
        return false;
    }

    if (!((Boost_Sunny_Check.checked && pokemon.attributes['boost'].value.indexOf('-Sunny') >= 0) ||
        (Boost_Windy_Check.checked && pokemon.attributes['boost'].value.indexOf('-Windy') >= 0) ||
        (Boost_Cloudy_Check.checked && pokemon.attributes['boost'].value.indexOf('-Cloudy') >= 0) ||
        (Boost_PartlyCloudy_Check.checked && pokemon.attributes['boost'].value.indexOf('-Partly Cloudy') >= 0) ||
        (Boost_Fog_Check.checked && pokemon.attributes['boost'].value.indexOf('-Fog') >= 0) ||
        (Boost_Rainy_Check.checked && pokemon.attributes['boost'].value.indexOf('-Rainy') >= 0) ||
        (Boost_Snow_Check.checked && pokemon.attributes['boost'].value.indexOf('-Snow') >= 0))) {
        return false;
    }

    return true;
}

// If one of the type checkboxes changes, need to update the All checkbox then refilter.
function OnToggleType(field) {
    if (Type_Bug_Check.checked == Type_Dark_Check.checked &&
        Type_Dark_Check.checked == Type_Dragon_Check.checked &&
        Type_Dragon_Check.checked == Type_Electric_Check.checked &&
        Type_Electric_Check.checked == Type_Fairy_Check.checked &&
        Type_Fairy_Check.checked == Type_Fighting_Check.checked &&
        Type_Fighting_Check.checked == Type_Fire_Check.checked &&
        Type_Fire_Check.checked == Type_Flying_Check.checked &&
        Type_Flying_Check.checked == Type_Ghost_Check.checked &&
        Type_Ghost_Check.checked == Type_Grass_Check.checked &&
        Type_Grass_Check.checked == Type_Ground_Check.checked &&
        Type_Ground_Check.checked == Type_Ice_Check.checked &&
        Type_Ice_Check.checked == Type_Normal_Check.checked &&
        Type_Normal_Check.checked == Type_Poison_Check.checked &&
        Type_Poison_Check.checked == Type_Psychic_Check.checked &&
        Type_Psychic_Check.checked == Type_Rock_Check.checked &&
        Type_Rock_Check.checked == Type_Steel_Check.checked &&
        Type_Steel_Check.checked == Type_Water_Check.checked) {
        Type_All_Check.indeterminate = false;
        Type_All_Check.checked = Type_Bug_Check.checked;
    } else {
        Type_All_Check.indeterminate = true;
    }

    if (field !== undefined && field !== null) {
        OnFilterCriteriaChanged(field);
    }
}

// If the All checkbox is toggled, update all of the Type checkboxes.
function OnToggleAllTypes() {
    Type_Bug_Check.checked = Type_All_Check.checked;
    Type_Dark_Check.checked = Type_All_Check.checked;
    Type_Dragon_Check.checked = Type_All_Check.checked;
    Type_Electric_Check.checked = Type_All_Check.checked;
    Type_Fairy_Check.checked = Type_All_Check.checked;
    Type_Fighting_Check.checked = Type_All_Check.checked;
    Type_Fire_Check.checked = Type_All_Check.checked;
    Type_Flying_Check.checked = Type_All_Check.checked;
    Type_Ghost_Check.checked = Type_All_Check.checked;
    Type_Grass_Check.checked = Type_All_Check.checked;
    Type_Ground_Check.checked = Type_All_Check.checked;
    Type_Ice_Check.checked = Type_All_Check.checked;
    Type_Normal_Check.checked = Type_All_Check.checked;
    Type_Poison_Check.checked = Type_All_Check.checked;
    Type_Psychic_Check.checked = Type_All_Check.checked;
    Type_Rock_Check.checked = Type_All_Check.checked;
    Type_Steel_Check.checked = Type_All_Check.checked;
    Type_Water_Check.checked = Type_All_Check.checked;

    OnFilterCriteriaChanged();
}

// If one of the type checkboxes changes, need to update the All checkbox then refilter.
function OnToggleBoost(field) {
    if (Boost_Sunny_Check.checked == Boost_Windy_Check.checked &&
        Boost_Windy_Check.checked == Boost_Cloudy_Check.checked &&
        Boost_Cloudy_Check.checked == Boost_PartlyCloudy_Check.checked &&
        Boost_PartlyCloudy_Check.checked == Boost_Fog_Check.checked &&
        Boost_Fog_Check.checked == Boost_Rainy_Check.checked &&
        Boost_Rainy_Check.checked == Boost_Snow_Check.checked) {
        Boost_All_Check.indeterminate = false;
        Boost_All_Check.checked = Boost_Sunny_Check.checked;
    } else {
        Boost_All_Check.indeterminate = true;
    }

    if (field !== undefined && field !== null) {
        OnFilterCriteriaChanged(field);
    }
}

// If the All checkbox is toggled, update all of the Type checkboxes.
function OnToggleAllBoosts() {
    Boost_Sunny_Check.checked = Boost_All_Check.checked;
    Boost_Windy_Check.checked = Boost_All_Check.checked;
    Boost_Cloudy_Check.checked = Boost_All_Check.checked;
    Boost_PartlyCloudy_Check.checked = Boost_All_Check.checked;
    Boost_Fog_Check.checked = Boost_All_Check.checked;
    Boost_Rainy_Check.checked = Boost_All_Check.checked;
    Boost_Snow_Check.checked = Boost_All_Check.checked;

    OnFilterCriteriaChanged();
}

// Called when a Pokemon is selected.
function SelectPokemon(pokemon) {
    Selected_Pokemon.innerHTML = pokemon.outerHTML;

    // Generation
    // Gender Ratio
    // Max CP/HP
    // Buddy KM for Candy
    // Shiny
    // Availability
    // If Raidboss, link to Possible IVs.


    // Base IV
    //      Attack Defense Stamina
    // Capture Rate
    // Flee Rate

    // Evolutions (Row from Evolutions Chart) +
    //      # Name Candies Special
    // MoveSets (Rows from MoveSets chart)

    /*
    id="1" 
    name="Bulbasaur" 
    type="Grass Poison" 
    boost = "&#xA;        -Sunny &#xA;        -Cloudy"

    gen="1" 
    family="Bulbasaur" 
    evolvesFrom="" 
    shiny="" 
    availability = "General"
*/
}