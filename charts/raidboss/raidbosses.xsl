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
    <xsl:choose>
      <xsl:when test="$Name = ''">
        <td style="border:none;"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="/Root/PokemonStats/Pokemon[Name = $Name]" mode="Cell">
          <!-- Add @href to the Settings. -->
          <xsl:with-param name="Settings">
            <xsl:apply-templates select="exslt:node-set($Settings)/*" mode="AddSetting">
              <xsl:with-param name="Setting" select="'href'" />
              <xsl:with-param name="Value">
                <xsl:text>/charts/raidboss/raidboss.</xsl:text>
                <xsl:value-of select="pokeref:ToLower(.)" />
                <xsl:text>.html</xsl:text>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:with-param>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
