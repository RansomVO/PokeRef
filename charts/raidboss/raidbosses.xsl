<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:pokeref="urn:pokeref"
>

  <xsl:variable name="columnsMax" select="10" />

  <!-- Templates to output RaidBoss Chart-->
  <xsl:template match="RaidBosses">
    <xsl:param name="Settings" />
    <xsl:param name="legacy" select="false()" />

    <table class="INDENT UNUSED" border="1" style="text-align:center;">
      <xsl:apply-templates select="." mode="Tiers">
        <xsl:with-param name="Settings" select="$Settings" />
        <xsl:with-param name="legacy" select="$legacy" />
      </xsl:apply-templates>
    </table>
  </xsl:template>

  <xsl:template match="RaidBosses" mode="Tiers">
    <xsl:param name="Settings" />
    <xsl:param name="legacy" />
    <xsl:param name="tier" select="5" />

    <xsl:call-template name="Tier">
      <xsl:with-param name="Settings" select="$Settings" />
      <xsl:with-param name="legacy" select="$legacy" />
      <xsl:with-param name="tier" select="$tier" />
    </xsl:call-template>

    <xsl:if test="$tier > 1 or ($tier = 1 and not($legacy))">
      <xsl:apply-templates select="." mode="Tiers">
        <xsl:with-param name="Settings" select="$Settings" />
        <xsl:with-param name="legacy" select="$legacy" />
        <xsl:with-param name="tier" select="$tier - 1" />
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>

  <xsl:template name="Tier">
    <xsl:param name="Settings" />
    <xsl:param name="legacy" />
    <xsl:param name="tier" />

    <xsl:variable name="count" select="count(RaidBoss[(@current != $legacy and @tier = $tier) or ($tier = 0 and not(@tier))])" />
    
    <tr>
      <th>
        <xsl:attribute name="style">
          <xsl:text>background-color:white; </xsl:text>
          <xsl:if test="count(exslt:node-set($Settings)/*/@small) > 0">font-size:smaller; </xsl:if>
        </xsl:attribute>
        <xsl:attribute name="rowspan">
          <xsl:value-of select="(($count + $columnsMax - 1) div $columnsMax) + 1" />
        </xsl:attribute>

        <xsl:choose>
          <xsl:when test="$tier = 0">
            <xsl:text>?</xsl:text>
            <br />
            <xsl:text>Future</xsl:text>
            <br />
            <xsl:text>?</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Tier</xsl:text>
            <br />
            <xsl:value-of select="$tier" disable-output-escaping="yes" />
            <xsl:if test="$tier=5">
              <br />
              <span class="NOTE">(including EX)</span>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </th>
    </tr>

    <xsl:apply-templates select="RaidBoss[(@current != $legacy and @tier = $tier) or ($tier = 0 and not(@tier))][1]" mode="Rows">
      <xsl:sort select="@EX" data-type="text" order="descending" />
      <xsl:sort select="@id" data-type="number" order="descending" />
      <xsl:with-param name="Settings" select="$Settings" />
      <xsl:with-param name="legacy" select="$legacy" />
      <xsl:with-param name="tier" select="$tier" />
    </xsl:apply-templates>
  </xsl:template>

  <!-- Template to recursively output all of the rows in a tier. -->
  <xsl:template match="RaidBoss" mode="Rows">
    <xsl:param name="Settings" />
    <xsl:param name="legacy" />
    <xsl:param name="tier" />

    <tr>
      <xsl:apply-templates select="." mode="Cells">
        <xsl:with-param name="Settings" select="$Settings" />
        <xsl:with-param name="legacy" select="$legacy" />
        <xsl:with-param name="tier" select="$tier" />
      </xsl:apply-templates>
    </tr>

    <!-- if there are more bosses in this tier, call recursively to do next row -->
    <xsl:apply-templates select="following-sibling::RaidBoss[(@current != $legacy and @tier = $tier) or ($tier = 0 and not(@tier))][$columnsMax]" mode="Rows">
      <xsl:with-param name="Settings" select="$Settings" />
      <xsl:with-param name="legacy" select="$legacy" />
      <xsl:with-param name="tier" select="$tier" />
    </xsl:apply-templates>
  </xsl:template>

  <!-- Template to recursively output all of the cells in a row. -->
  <xsl:template match="RaidBoss" mode="Cells">
    <xsl:param name="Settings" />
    <xsl:param name="legacy" />
    <xsl:param name="tier" />
    <xsl:param name="column" select="1" />

    <xsl:variable name="name" select="@name" />
    <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name = $name][1]" mode="Cell">
      <!-- Add @href to the Settings. -->
      <xsl:with-param name="Settings">
        <xsl:apply-templates select="exslt:node-set($Settings)/*" mode="AddSetting">
          <xsl:with-param name="Setting" select="'href'" />
          <xsl:with-param name="Value">
            <xsl:text>/charts/raidboss/raidboss.</xsl:text>
            <xsl:value-of select="pokeref:ToLower($name)" />
            <xsl:text>.html</xsl:text>
          </xsl:with-param>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:apply-templates>

    <xsl:if test="$columnsMax > $column">
      <xsl:apply-templates select="following-sibling::RaidBoss[(@current != $legacy and @tier = $tier) or ($tier = 0 and not(@tier))][1]" mode="Cells">
        <xsl:with-param name="Settings" select="$Settings" />
        <xsl:with-param name="legacy" select="$legacy" />
        <xsl:with-param name="tier" select="$tier" />
        <xsl:with-param name="column" select="$column+1" />
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
