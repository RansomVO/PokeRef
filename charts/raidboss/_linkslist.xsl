<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:include href="/xsl/global.xsl"/>
  <xsl:include href="raidbosses.xsl"/>

  <xsl:template match="/Root">
    <!-- Trick to allow non-list to be displayed in navigation bar. -->
    <xsl:value-of select="concat($lt, '/ul', $gt)" disable-output-escaping="yes" />
    
    <xsl:apply-templates select="RaidBosses">
      <xsl:with-param name="Settings">
        <Show small="true" show_disabled="true" hide_name="true" hide_type_icons="true" hide_special_icons="true" />
      </xsl:with-param>
    </xsl:apply-templates>
    
    <!-- Trick to allow non-list to be displayed in navigation bar. -->
    <xsl:value-of select="concat($lt, 'ul', $gt)" disable-output-escaping="yes" />
  </xsl:template>

</xsl:stylesheet>
