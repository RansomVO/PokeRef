<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:output omit-xml-declaration="yes" />
  <xsl:include href="/xsl/global.xsl" />

    <xsl:template match="Root">
    <xsl:text>
// ==============================================================================================
//  Code for converting a Pokemon's ID to its Name and vice-versa
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
</xsl:text>
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
