<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:pokeref="urn:pokeref"
>

  <!-- Templates to output RaidBoss Chart-->
  <xsl:template match="RaidBosses">
    <xsl:param name="Settings" />

    <table class="INDENT UNUSED" border="1" style="text-align:center;">
      <xsl:apply-templates select="Tier">
        <xsl:with-param name="Settings" select="$Settings" />
      </xsl:apply-templates>
    </table>
  </xsl:template>

  <xsl:template match="Tier">
    <xsl:param name="Settings" />

    <tr>
      <th style="">
        <xsl:attribute name="style">
          <xsl:text>background-color:white; </xsl:text>
          <xsl:if test="count(exslt:node-set($Settings)/*/@small) > 0">font-size:smaller; </xsl:if>
        </xsl:attribute>
        <xsl:value-of select="pokeref:Replace(@name, ' ', concat($lt, 'br /', $gt))" disable-output-escaping="yes" />
      </th>
      <xsl:apply-templates select="RaidBoss">
        <xsl:with-param name="Settings" select="$Settings" />
      </xsl:apply-templates>
    </tr>
  </xsl:template>

  <xsl:template match="RaidBoss">
    <xsl:param name="Settings" />

    <xsl:variable name="Name" select="." />
    <xsl:variable name="Pokemon" select="/Root/PokemonStats/Pokemon[Name = $Name]" />

    <td height="1px" align="center">
      <xsl:choose>
        <xsl:when test=". = ''">
          <xsl:attribute name="class">UNUSED</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">CELL_FILLED</xsl:attribute>
          <a>
            <xsl:attribute name="class">
              <xsl:text>CELL_FILLER </xsl:text>
              <xsl:if test="$Pokemon/Stats/Base/Attack = 1 and $Pokemon/Stats/Base/Defense = 1 and $Pokemon/Stats/Base/Stamina = 1">
                <xsl:text>DISABLED </xsl:text>
              </xsl:if>
            </xsl:attribute>
            <xsl:attribute name="href">
              <xsl:text>/charts/raidboss/raidboss.</xsl:text>
              <xsl:value-of select="pokeref:ToLower(.)" />
              <xsl:text>.html</xsl:text>
            </xsl:attribute>

            <xsl:apply-templates select="$Pokemon">
              <xsl:with-param name="Settings" select="$Settings" />
            </xsl:apply-templates>
          </a>
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>


</xsl:stylesheet>
