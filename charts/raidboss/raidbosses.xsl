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

    <xsl:variable name="countEX">
      <xsl:choose>
        <xsl:when test="count(RaidBoss[$tier = 5 and @current != $legacy and @tier = 'EX']) = 0">0</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="count(RaidBoss[$tier = 5 and @current != $legacy and @tier = 'EX']) + 1"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="count" select="$countEX + count(RaidBoss[(@current != $legacy and @tier = $tier) or ($tier = 0 and not(@tier))])" />

    <tr>
      <th>
        <xsl:attribute name="style">
          <xsl:text>background-color:white; </xsl:text>
          <xsl:if test="count(exslt:node-set($Settings)/*/@small) > 0">font-size:smaller; </xsl:if>
        </xsl:attribute>
        <xsl:attribute name="rowspan">
          <xsl:text>2</xsl:text>
          <!-- TODO QZX: Use this when we split tiers into multiple rows:   <xsl:value-of select="(($count + 9) div 10) + 1" />-->
        </xsl:attribute>

        <xsl:text>Tier</xsl:text>
        <br />
        <xsl:value-of select="$tier" disable-output-escaping="yes" />
        <xsl:if test="$tier=5">
          <br />
          <span class="NOTE">(including EX)</span>
        </xsl:if>
      </th>
    </tr>
    <!-- TODO QZX: Figure out how to split this into rows of $columnsMax cells or less. -->
    <tr>
      <xsl:if test="$countEX > 0">
        <xsl:apply-templates select="RaidBoss[@current != $legacy and @tier = 'EX']">
          <xsl:with-param name="Settings" select="$Settings" />
        </xsl:apply-templates>
        <td />
      </xsl:if>
      <xsl:apply-templates select="RaidBoss[(@current != $legacy and @tier = $tier) or ($tier = 0 and not(@tier))]">
        <xsl:sort order="ascending" data-type="number" select="@id" />
        <xsl:with-param name="Settings" select="$Settings" />
      </xsl:apply-templates>
    </tr>
  </xsl:template>

  <xsl:template match="RaidBoss">
    <xsl:param name="Settings" />

    <xsl:variable name="Name" select="@name" />
    <xsl:choose>
      <xsl:when test="not($Name)">
        <td style="border:none;" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name = $Name][1]" mode="Cell">
          <!-- Add @href to the Settings. -->
          <xsl:with-param name="Settings">
            <xsl:apply-templates select="exslt:node-set($Settings)/*" mode="AddSetting">
              <xsl:with-param name="Setting" select="'href'" />
              <xsl:with-param name="Value">
                <xsl:text>/charts/raidboss/raidboss.</xsl:text>
                <xsl:value-of select="pokeref:ToLower($Name)" />
                <xsl:text>.html</xsl:text>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:with-param>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
