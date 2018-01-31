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
    <xsl:value-of select="concat($nbsp, '-', $nbsp)" />
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
function GetPokemonType1(pokemon) {
    // TODO QZX: Add icon
    return pokemon.attributes['type1'].value;
}

// Do Type1 and Type2 separately so caller can combine them any way they want.
//  (E.G. If this returns null, hide the field.)
function GetPokemonType2(pokemon) {
    var type = pokemon.attributes['type2'].value;
    if (type === '') {
        return null;
    } else {
        // TODO QZX: Add icon
        return type;
    }
}

// Do Boost1 and Boost2 separately so caller can combine them any way they want.
function GetPokemonBoost1(pokemon) {
    // TODO QZX: Add icon
    return pokemon.attributes['boost1'].value;
}

// Do Boost1 and Boost2 separately so caller can combine them any way they want.
//  (E.G. If this returns null, hide the field.)
function GetPokemonBoost2(pokemon) {
    var boost = pokemon.attributes['boost2'].value;
    if (boost === '') {
        return null;
    } else {
        // TODO QZX: Add icon
        return boost;
    }
}

function GetPokemonGenderRatio(pokemon) {
    var value = pokemon.attributes['genderRatio'].value;
    return value === '' ? '???' : value;
}

function GetPokemonShiny(pokemon) {
    // TODO QZX: Add icon
    return pokemon.attributes['shiny'].value === '' ? 'No' : 'Yes';
}

function GetPokemonAvailability(pokemon) {
    return pokemon.attributes['availability'].value;
}

function GetPokemonMax_CP_HP(pokemon) {
    return 'TODO QZX';
}

function GetPokemonBuddyKM(pokemon) {
    return 'TODO QZX';
}

function GetPokemonBaseIV(pokemon) {
    return 'TODO QZX';
}

function GetPokemonCaptureRate(pokemon) {
    return 'TODO QZX';
}

function GetPokemonFleeRate(pokemon) {
    return 'TODO QZX';
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
