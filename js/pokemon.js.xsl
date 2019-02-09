<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:output omit-xml-declaration="yes" />
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <!-- #region Global Variables -->
    <xsl:text>// ==============================================================================================
// #region Global Variables
// ==============================================================================================
    
// Variables that tells how many generations of Pokemon there are.
TotalGens = </xsl:text>
    <xsl:value-of select="$TotalGens" />
    <xsl:text>;
ReleasedGens = </xsl:text>
    <xsl:value-of select="$ReleasedGens" />
    <xsl:text>;
// #endregion
</xsl:text>
    <!-- #endregion -->

    <!-- #region Code for converting a Pokemon's ID to its Name and vice-versa -->
    <xsl:text>
// ==============================================================================================
// #region Code for converting a Pokemon's ID to its Name and vice-versa
// ==============================================================================================
</xsl:text>
    <!-- #region Lookup Tables. -->
    <xsl:text>

// ***** NOTE: There are two arrays to make look-up as fast as possible.

// #region Array of Pokemon where index = ID.
var PokemonListById = [ "",
</xsl:text>
    <xsl:apply-templates select="PokeStats/Pokemon" mode="IdDictionary">
      <xsl:sort select="@id" data-type="number" order="ascending" />
    </xsl:apply-templates>
    <xsl:text>];
// #endregion

// #region Associative Array (Dictionary) where Key is Pokemon Name and Value is the ID
var PokemonNameToIdDictionary = { 
</xsl:text>
    <xsl:apply-templates select="PokeStats/Pokemon" mode="NameDictionary">
      <xsl:sort select="@name" data-type="text" order="ascending" />
    </xsl:apply-templates>
    <xsl:text>};
// #endregion
</xsl:text>
    <!-- #endregion -->
    <xsl:text>
// Function to get the Pokemon's ID from its Name.
function PokemonNameToId(name) {
  return PokemonNameToIdDictionary[name];
}

// Function to get the Pokemon's Name from its ID.
function PokemonIdToName(id) {
  return PokemonListById[id];
}

// #endregion
</xsl:text>

    <!-- #endregion -->

    <!-- #region Functions to get data from a Pokemon Icon. -->
    <xsl:text>
// ==============================================================================================
// #region Functions to get data from a Pokemon Icon.
// ==============================================================================================
<!-- #region Global Vars -->

// #region 2-Dimensional Associative Array (Dictionary) of Effectiveness of Moves against Pokemon and a key to the meaning of the values.
//  NOTE: Array is accessed via EffectivenessDictionary[PokemonType][MoveType]
var EffectivenessDictionary = {
</xsl:text>
    <xsl:for-each select="MoveEffectiveness/Moves/Pokemon">
      <xsl:variable name="Type" select="@type" />
      <xsl:text>    '</xsl:text>
      <xsl:value-of select="$Type" />
      <xsl:text>':</xsl:text>
      <xsl:value-of select="substring('        ', string-length($Type))" />
      <xsl:text>{</xsl:text>
      <xsl:for-each select="/Root/MoveEffectiveness/Moves/Pokemon[@type=$Type]">
        <xsl:text> '</xsl:text>
        <xsl:value-of select="../@type" />
        <xsl:text>': '</xsl:text>
        <xsl:value-of select="@value" />
        <xsl:text>',</xsl:text>
      </xsl:for-each>
      <xsl:text> },
</xsl:text>
    </xsl:for-each>
    <xsl:text>};
var EffectivenessKey = {
</xsl:text>
    <xsl:for-each select="MoveEffectiveness/Key/*">
      <xsl:text>    '</xsl:text>
      <xsl:value-of select="name()" />
      <xsl:text>': '</xsl:text>
      <xsl:value-of select="@symbol" />
      <xsl:text>',
</xsl:text>
    </xsl:for-each>
    <xsl:text>};
// #endregion
<!-- #endregion -->

<!-- #region GetPokemon() -->
// The value passed to the other GetPokemon*() methods may pass in the table cell instead of the actual Pokemon, so get the Pokemon
function GetPokemon(pokemon) {
    if (pokemon.tagName === 'TD') {
        </xsl:text>
    <!-- Need to do this or the '>' gets turned into a &gt; -->
    <xsl:value-of select="'for (var i = pokemon.childNodes.length - 1; i >= 0; i--)'" disable-output-escaping="yes" />
    <xsl:text> {
            if (pokemon.childNodes[i].nodeName === 'DIV' </xsl:text>
    <!-- Need to do this because XSLT doesn't like the "&&" -->
    <xsl:value-of select="concat($amp, $amp)" disable-output-escaping="yes" />
    <xsl:text> pokemon.childNodes[i].classList.contains('SPRITE_FILLER')) {
                return pokemon.childNodes[i];
            }
        }
    }

    return pokemon;
}
<!-- #endregion -->
<!-- #region GetPokemonID() -->
function GetPokemonID(pokemon) {
    return Number(GetPokemon(pokemon).attributes['id'].value);
}
<!-- #endregion -->
<!-- #region GetPokemonName() -->
function GetPokemonName(pokemon) {
    return GetPokemon(pokemon).attributes['name'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonIDName() -->
function GetPokemonIDName(pokemon) {
    return GetPokemonID(pokemon) + '</xsl:text>
    <xsl:value-of select="concat($nbsp, '-', $nbsp)" disable-output-escaping="yes" />
    <xsl:text>' + GetPokemonName(pokemon);
}
<!-- #endregion -->
<!-- #region GetPokemonGeneration() -->
function GetPokemonGeneration(pokemon) {
    return Number(GetPokemon(pokemon).attributes['gen'].value);
}
<!-- #endregion -->
<!-- #region GetPokemonFamily() -->
function GetPokemonFamily(pokemon) {
    return GetPokemon(pokemon).attributes['family'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonType1() -->
// Do Type1 and Type2 separately so caller can combine them any way they want.
function GetPokemonType1(pokemon) {
    return GetPokemon(pokemon).attributes['type1'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonType2() -->
// Do Type1 and Type2 separately so caller can combine them any way they want.
//  (E.G. If this returns empty, hide the field.)
function GetPokemonType2(pokemon) {
    return GetPokemon(pokemon).attributes['type2'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonBoost1() -->
// Do Boost1 and Boost2 separately so caller can combine them any way they want.
function GetPokemonBoost1(pokemon) {
    return GetPokemon(pokemon).attributes['boost1'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonBoost2() -->
// Do Boost1 and Boost2 separately so caller can combine them any way they want.
//  (E.G. If this returns null, hide the field.)
function GetPokemonBoost2(pokemon, icon) {
    return GetPokemon(pokemon).attributes['boost2'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonGenderRatio() -->
function GetPokemonGenderRatio(pokemon) {
    var genderRatio = GetPokemon(pokemon).attributes['genderRatio'].value;
    return genderRatio === '' ? '???' : genderRatio;
}
<!-- #endregion -->
<!-- #region GetPokemonEgg() -->
function GetPokemonEgg(pokemon) {
    return GetPokemon(pokemon).attributes['egg'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonEgg() -->
function GetPokemonSpecialItem(pokemon) {
    return GetPokemon(pokemon).attributes['special'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonShiny() -->
function GetPokemonShiny(pokemon) {
    return GetPokemon(pokemon).attributes['shiny'].value !== '';
}
<!-- #endregion -->
<!-- #region GetPokemonAvailability() -->
function GetPokemonAvailability(pokemon) {
    return GetPokemon(pokemon).attributes['availability'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonRarity() -->
function GetPokemonRarity(pokemon) {
    return GetPokemon(pokemon).attributes['rarity'].value;
}
<!-- #endregion -->
<!-- #region GetPokemonMax_CP() -->
function GetPokemonMax_CP(pokemon) {
    return Number(GetPokemon(pokemon).attributes['maxCP'].value);
}
<!-- #endregion -->
<!-- #region GetPokemonMax_HP() -->
function GetPokemonMax_HP(pokemon) {
    return Number(GetPokemon(pokemon).attributes['maxHP'].value);
}
<!-- #endregion -->
<!-- #regionGetPokemonBuddyKM () -->
function GetPokemonBuddyKM(pokemon) {
    var buddyKM = GetPokemon(pokemon).attributes['buddyKM'].value;
    return buddyKM === '' ? '???' : buddyKM;
}
<!-- #endregion -->
<!-- #region GetPokemonBaseAttack() -->
function GetPokemonBaseAttack(pokemon) {
    var baseAttack = GetPokemon(pokemon).attributes['baseAttack'].value;

    return (baseAttack === '' ? '???' : baseAttack);
}
<!-- #endregion -->
<!-- #region GetPokemonBaseDefense() -->
function GetPokemonBaseDefense(pokemon) {
    var baseDefense = GetPokemon(pokemon).attributes['baseDefense'].value;

    return (baseDefense === '' ? '???' : baseDefense);
}
<!-- #endregion -->
<!-- #region GetPokemonBaseStamina() -->
function GetPokemonBaseStamina(pokemon) {
    var baseStamina = GetPokemon(pokemon).attributes['baseStamina'].value;

    return (baseStamina === '' ? '???' : baseStamina);
}
<!-- #endregion -->
<!-- #region GetPokemonCaptureRate() -->
function GetPokemonCaptureRate(pokemon) {
    // STUPID BUG: 0.07 * 100 = 7.000000000000001 due to "non-exact nature of floating point values".
    // As such, we need to use ".toFixed()" to correct it.
    return (GetPokemon(pokemon).attributes['captureRate'].value * 100).toFixed() + '%';
}
<!-- #endregion -->
<!-- #region GetPokemonFleeRate() -->
function GetPokemonFleeRate(pokemon) {
    // STUPID BUG: 0.07 * 100 = 7.000000000000001 due to "non-exact nature of floating point values".
    // As such, we need to use ".toFixed()" to correct it.
    return (GetPokemon(pokemon).attributes['fleeRate'].value * 100).toFixed() + '%';
}
<!-- #endregion -->
<!-- #region GetPokemonWeakAgainst() -->
// Returns a list of the Move Types against which the Pokemon is weak.
function GetPokemonWeakAgainst(pokemon) {
  return GetPokemonEffectivenessAgainst(pokemon, 'SuperEffective');
}
<!-- #endregion -->
<!-- #region GetPokemonNeutralAgainst() -->
// Returns a list of the Move Types against which the Pokemon is neutral.
function GetPokemonNeutralAgainst(pokemon) {
  return GetPokemonEffectivenessAgainst(pokemon, 'Neutral');
}
<!-- #endregion -->
<!-- #region GetPokemonStrongAgainst() -->
// Returns a list of the Move Types against which the Pokemon is strong.
function GetPokemonStrongAgainst(pokemon) {
  return GetPokemonEffectivenessAgainst(pokemon, 'NotVeryEffective');
}
<!-- #endregion -->
<!-- #region GetPokemonImmuneAgainst() -->
// Returns a list of the Move Types to which the Pokemon is "Immune".
function GetPokemonImmuneAgainst(pokemon) {
  return GetPokemonEffectivenessAgainst(pokemon, 'Immune');
}
<!-- #endregion -->
<!-- #region GetPokemonEffectivenessAgainst() -->
// Returns a list of the Move Types with the specified effectiveness against the Pokemon.
//  (Caller can then leverage GetPokemonType() to generate output if desired.)
function GetPokemonEffectivenessAgainst(pokemon, effectiveness) {
    var MoveTypes = [];

    var entry = EffectivenessDictionary[GetPokemonType1(pokemon)];
    for (var key in entry) {
        if (entry[key] === EffectivenessKey[effectiveness]) {
            MoveTypes.push(key);
        }
    }

    entry = EffectivenessDictionary[GetPokemonType2(pokemon)];
    for (key in entry) {
        if (entry[key] === EffectivenessKey[effectiveness]) {
            MoveTypes.push(key);
        }
    }

    return MoveTypes;
}
<!-- #endregion -->
<!-- #region GetAllTypes() -->
// Returns a list of all of the types. (Makes iteration through types easier.)
function GetAllTypes() {
    var Types = [];

    for (var key in EffectivenessDictionary) {
        Types.push(key);
    }

    return Types;
}
<!-- #endregion -->
<!-- #region GetPokemonRaidBossLink() -->
function GetPokemonRaidBossLink(pokemon) {
    try {
        if (pokemon.attributes['raidboss'].value === 'true') {
            return '/charts/raidboss/raidboss.' + GetPokemonName(pokemon).toLowerCase() + '.html';
        }
    } catch (err) { }

    return null;
}
<!-- #endregion -->
// #endregion
<!-- #endregion -->

    <!-- #region Functions to get descriptor icons. -->
// ==============================================================================================
// #region Functions to get descriptor icons.
// ==============================================================================================
<!-- #region GetPokemonShinyIcon() -->
function GetPokemonShinyIcon(pokemon) {
    return GetPokemonShiny(pokemon) ? 'No' : '</xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text>img class="TAG_ICON_REGULAR" src="/images/game/shiny.png" alt="Shiny" /</xsl:text>
    <xsl:value-of select="concat($gt, $nbsp)" disable-output-escaping="yes" />
    <xsl:text>Yes';
}
<!-- #endregion -->
<!-- #region GetPokemonType1Icon() -->
// Do Type1 and Type2 separately so caller can combine them any way they want.
function GetPokemonType1Icon(pokemon) {
    return GetPokemonTypeIcon(GetPokemonType1(pokemon));
}
<!-- #endregion -->
<!-- #region GetPokemonType2Icon() -->
// Do Type1 and Type2 separately so caller can combine them any way they want.
//  (E.G. If this returns null, hide the field.)
function GetPokemonType2Icon(pokemon) {
    return GetPokemonTypeIcon(GetPokemonType2(pokemon));
}
<!-- #endregion -->
<!-- #region GetPokemonTypeIcon() -->
function GetPokemonTypeIcon(type) {
    if (type === '') {
        return null;
    } else {
        return '</xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text>img class="TAG_ICON_REGULAR" src="/images/types/type_' + type.toLowerCase() + '.png" title="' + type + '" /</xsl:text>
    <xsl:value-of select="concat($gt, $nbsp)" disable-output-escaping="yes" />
    <xsl:text>' + type;
    }
}
<!-- #endregion -->
<!-- #region GetPokemonBoost1Icon() -->
// Do Boost1 and Boost2 separately so caller can combine them any way they want.
function GetPokemonBoost1Icon(pokemon) {
    return GetPokemonBoostIcon(GetPokemonBoost1(pokemon));
}
<!-- #endregion -->
<!-- #region GetPokemonBoost2Icon() -->
// Do Boost1 and Boost2 separately so caller can combine them any way they want.
//  (E.G. If this returns null, hide the field.)
function GetPokemonBoost2Icon(pokemon) {
    return GetPokemonBoostIcon(GetPokemonBoost2(pokemon));
}
<!-- #endregion -->
<!-- #region GetPokemonBoostIcon() -->
function GetPokemonBoostIcon(boost, icon) {
    if (boost === '') {
        return null;
    } else {
        return '</xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text>img class="TAG_ICON_REGULAR" src="/images/types/weather_' + boost.toLowerCase().replace(/ /g,'') + '.png" title="' + boost.replace(/ /g, '</xsl:text>
    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
    <xsl:text>') + '" /</xsl:text>
    <xsl:value-of select="concat($gt, $nbsp)" disable-output-escaping="yes" />
    <xsl:text>' + boost.replace(/ /g, '</xsl:text>
    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
    <xsl:text>')
    }
}
<!-- #endregion -->
// #endregion
</xsl:text>
    <!-- #endregion -->

    <!-- #region Functions to get a custom Pokemon Icon. -->
    <xsl:text>
// ==============================================================================================
// #region Functions to get a custom Pokemon Icon.
// ==============================================================================================
<!-- #region Global Vars -->
var MarkerSectionBeginOpen = '</xsl:text>
    <xsl:value-of select="concat($lt, 'div id=')" disable-output-escaping="yes" />
    <xsl:text>"';
var MarkerSectionBeginClose = '"</xsl:text>
    <xsl:value-of select="$gt" disable-output-escaping="yes" />
    <xsl:text>';
var MarkerSectionEnd = '</xsl:text>
    <xsl:value-of select="concat($lt, '/div', $gt)" disable-output-escaping="yes" />
    <xsl:text>';
<!-- #endregion -->

<!-- #region GetPokemonIcon() -->
function GetPokemonIcon(pokemon, remove) {
    // Make any info boxes start off closed.
    var pokemonHtml = GetPokemon(pokemon).outerHTML.replace('style="visibility: visible; opacity: 1;"', '');

    if (remove.header) {
        pokemonHtml = RemovePokemonSection(pokemonHtml, 'Pokemon_Header_Field');
    }

    if (remove.icons) {
        pokemonHtml = RemovePokemonSection(pokemonHtml, 'Pokemon_Icons_Field');
    }

    if (remove.name) {
        pokemonHtml = RemovePokemonSection(pokemonHtml, 'Pokemon_Name_Field');
    }

    if (remove.footer) {
        pokemonHtml = RemovePokemonSection(pokemonHtml, 'Pokemon_Footer_Field');
    }

    return pokemonHtml;
}
<!-- #endregion -->
<!-- #region RemovePokemonSection() -->
function RemovePokemonSection(pokemonHtml, id) {
    var beginIndex = pokemonHtml.indexOf(MarkerSectionBeginOpen + id + MarkerSectionBeginClose);
    var endIndex = pokemonHtml.indexOf(MarkerSectionEnd, beginIndex) + MarkerSectionEnd.length;
    return  pokemonHtml.substring(0, beginIndex) + pokemonHtml.substring(endIndex);
}
<!-- #endregion -->

// #endregion

<!-- #endregion -->
</xsl:text>
  </xsl:template>

  <!-- #region Templates for creating entries in dictionaries. -->

  <xsl:template match="Pokemon" mode="IdDictionary">
    <xsl:text>    "</xsl:text>
    <xsl:value-of select="@name" />
    <xsl:text>",
</xsl:text>
  </xsl:template>

  <xsl:template match="Pokemon" mode="NameDictionary">
    <!-- Using quotes here so that we don't have issues with "Farfetch'd" -->
    <xsl:text>    "</xsl:text>
    <xsl:value-of select="@name" />
    <xsl:text>": </xsl:text>
    <xsl:value-of select="@id" />
    <xsl:text>,
</xsl:text>
  </xsl:template>

  <xsl:template match="MoveEffectiveness" mode="Dictionary">
    <xsl:text>    '</xsl:text>
    <xsl:value-of select="MoveType" />
    <xsl:text>': {
</xsl:text>
    <xsl:for-each select="PokemonType/*">
      <xsl:text>        '</xsl:text>
      <xsl:value-of select="name()" />
      <xsl:text>': '</xsl:text>
      <xsl:value-of select="." />
      <xsl:text>',
</xsl:text>
    </xsl:for-each>
    <xsl:text>    },
</xsl:text>
  </xsl:template>

  <!-- #endregion -->

</xsl:stylesheet>
