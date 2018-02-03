<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:output omit-xml-declaration="yes" />
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="Root">
    <!-- Region - Code for converting a Pokemon's ID to its Name and vice-versa -->
    <xsl:text>
// ==============================================================================================
// #region Code for converting a Pokemon's ID to its Name and vice-versa
// ==============================================================================================

// ***** NOTE: I assemble two arrays to make look-up as fast as possible.

// Array of Pokemon where index = ID.
var PokemonListById = [ "",
</xsl:text>
    <xsl:apply-templates select="PokemonStats/Pokemon" mode="IdDictionary">
      <xsl:sort select="ID" data-type="number" order="ascending"/>
    </xsl:apply-templates>
    <xsl:text>];

// Associative Array (Dictionary) where Key is Pokemon Name and Value is the ID
var PokemonListByName = { 
</xsl:text>
    <xsl:apply-templates select="PokemonStats/Pokemon" mode="NameDictionary">
      <xsl:sort select="Name" data-type="text" order="ascending"/>
    </xsl:apply-templates>
    <xsl:text>};

// Function to get the Pokemon's ID from its Name.
function PokemonNameToId(name) {
  return PokemonListByName[name];
}

// Function to get the Pokemon's Name from its ID.
function PokemonIdToName(id) {
  return PokemonListById[id];
}

// #endregion
</xsl:text>

    <!-- EndRegion -->

    <!-- Region - Code for converting a Pokemon's ID to its Name and vice-versa -->

    <xsl:text>
// ==============================================================================================
// #region Functions to get data from a Pokemon Icon.
// ==============================================================================================

var MarkerSectionBeginOpen = '</xsl:text>
    <xsl:value-of select="concat($lt, 'div id=')" disable-output-escaping="yes" />
    <xsl:text>"';
var MarkerSectionBeginClose = '"</xsl:text>
    <xsl:value-of select="$gt" disable-output-escaping="yes" />
    <xsl:text>';
var MarkerSectionEnd = '</xsl:text>
    <xsl:value-of select="concat($lt, '/div', $gt)" disable-output-escaping="yes" />
    <xsl:text>';

function GetPokemonName(pokemon) {
    return pokemon.attributes['id'].value + '</xsl:text>
    <xsl:value-of select="concat($nbsp, '-', $nbsp)" disable-output-escaping="yes" />
    <xsl:text>' + pokemon.attributes['name'].value;
}

function GetPokemonIcon(pokemon, remove) {
    var pokemonHtml = pokemon.outerHTML;

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

function GetPokemonGeneration(pokemon) {
    return pokemon.attributes['gen'].value;
}

function GetPokemonFamily(pokemon) {
    // TODO QZX: Add these to gens 4-7.
    return pokemon.attributes['family'].value;
}

// Do Type1 and Type2 separately so caller can combine them any way they want.
function GetPokemonType1(pokemon, icon) {
    return GetPokemonType(pokemon.attributes['type1'].value, icon);
}

// Do Type1 and Type2 separately so caller can combine them any way they want.
//  (E.G. If this returns null, hide the field.)
function GetPokemonType2(pokemon, icon) {
    return GetPokemonType(pokemon.attributes['type2'].value, icon);
}

function GetPokemonType(type, icon) {
    if (type === '') {
        return null;
    } else {
        return (icon === undefined || !icon ? '' : '</xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text>img class="TAG_ICON" src="/images/type_' + type.toLowerCase() + '.png" title="' + type + '" /</xsl:text>
    <xsl:value-of select="concat($gt, '&amp;nbsp;')" disable-output-escaping="yes" />
    <xsl:text>') + type;
    }
}

// Do Boost1 and Boost2 separately so caller can combine them any way they want.
function GetPokemonBoost1(pokemon, icon) {
    return GetPokemonBoost(pokemon.attributes['boost1'].value, icon);
}

// Do Boost1 and Boost2 separately so caller can combine them any way they want.
//  (E.G. If this returns null, hide the field.)
function GetPokemonBoost2(pokemon, icon) {
    return GetPokemonBoost(pokemon.attributes['boost2'].value, icon);
}

function GetPokemonBoost(boost, icon) {
    if (boost === '') {
        return null;
    } else {
        return (icon === undefined || !icon ? '' : '</xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text>img class="TAG_ICON" src="/images/weather_' + boost.toLowerCase().replace(/ /g,'') + '.png" title="' + boost + '" /</xsl:text>
    <xsl:value-of select="concat($gt, '&amp;nbsp;')" disable-output-escaping="yes" />
    <xsl:text>') + boost;
    }
}

function GetPokemonGenderRatio(pokemon) {
    var value = pokemon.attributes['genderRatio'].value;
    return value === '' ? '???' : value;
}

function GetPokemonShiny(pokemon, icon) {
    return pokemon.attributes['shiny'].value === '' ? 'No' : (icon === undefined || !icon ? '' : '</xsl:text>
    <xsl:value-of select="$lt" disable-output-escaping="yes" />
    <xsl:text>img class="SHINY_ICON" src="/images/shiny.png" alt="Shiny" /</xsl:text>
    <xsl:value-of select="concat($gt, '&amp;nbsp;')" disable-output-escaping="yes" />
    <xsl:text>') + 'Yes';
}

function GetPokemonAvailability(pokemon) {
    return pokemon.attributes['availability'].value;
}

function GetPokemonMax_CP_HP(pokemon) {
    return pokemon.attributes['maxCP'].value + '</xsl:text>
    <xsl:value-of select="concat($nbsp, '/', $nbsp)"  disable-output-escaping="yes"/>
    <xsl:text>' + pokemon.attributes['maxHP'].value;
}

function GetPokemonBuddyKM(pokemon) {
    return pokemon.attributes['buddyKM'].value;
}

function GetPokemonBaseIV(pokemon) {
    return pokemon.attributes['baseAttack'].value + '</xsl:text>
    <xsl:value-of select="concat($nbsp, '/', $nbsp)" disable-output-escaping="yes" />
    <xsl:text>' + pokemon.attributes['baseDefense'].value + '</xsl:text>
    <xsl:value-of select="concat($nbsp, '/', $nbsp)" disable-output-escaping="yes" />
    <xsl:text>' + pokemon.attributes['baseStamina'].value;
}

function GetPokemonCaptureRate(pokemon) {
    // STUPID BUG: 0.07 * 100 = 7.000000000000001 due to "non-exact nature of floating point values".
    // As such, we need to use ".toFixed()" to correct it.
    return (pokemon.attributes['captureRate'].value * 100).toFixed() + '%';
}

function GetPokemonFleeRate(pokemon) {
    // STUPID BUG: 0.07 * 100 = 7.000000000000001 due to "non-exact nature of floating point values".
    // As such, we need to use ".toFixed()" to correct it.
    return (pokemon.attributes['fleeRate'].value * 100).toFixed() + '%';
}

function GetPokemonRaidBossLink(pokemon) {
    // TODO QZX
    return '';
}

function GetPokemonMoveSets(pokemon) {
    // TODO QZX
    return '';
}

function GetPokemonEvolutions(pokemon) {
    // TODO QZX
    return '';
}

function RemovePokemonSection(pokemonHtml, id) {
    var beginIndex = pokemonHtml.indexOf(MarkerSectionBeginOpen + id + MarkerSectionBeginClose);
    var endIndex = pokemonHtml.indexOf(MarkerSectionEnd, beginIndex) + MarkerSectionEnd.length;
    return  pokemonHtml.substring(0, beginIndex) + pokemonHtml.substring(endIndex);
}

// #endregion

</xsl:text>

    <!-- EndRegion -->

  </xsl:template>

  <xsl:template match="Pokemon" mode="IdDictionary">
    <xsl:text>    </xsl:text>
    <xsl:value-of select="concat('&quot;', Name, '&quot;')"/>
    <xsl:text>,
</xsl:text>
  </xsl:template>

  <xsl:template match="Pokemon" mode="NameDictionary">
    <xsl:text>    </xsl:text>
    <xsl:value-of select="concat('&quot;', Name, '&quot;')"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="ID"/>
    <xsl:text>,
</xsl:text>
  </xsl:template>

</xsl:stylesheet>
