<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>

  <!-- ************************************************************************************************************************ -->
  <!-- #region Global variables -->
  <!-- ************************************************************************************************************************ -->
  <!-- Constants (Needed because XSL doesn't like them raw in select statements, etc.)-->
  <xsl:variable name="quot">"</xsl:variable>
  <xsl:variable name="apos">'</xsl:variable>
  <xsl:variable name="amp">&amp;</xsl:variable>

  <!-- ===================================================== -->
  <!-- Must use disable-output-escaping="yes" with the rest. -->
  <!-- ===================================================== -->
  <!-- Need these because xml/xsl/html throws a total fit if you try to include '<' inside a string. -->
  <xsl:variable name="lt">&#x003C;</xsl:variable>
  <xsl:variable name="gt">&#x003E;</xsl:variable>

  <!-- Need these because they are commonly used chars but not recognized by XSLT processor. -->
  <xsl:variable name="nbsp">&amp;nbsp;</xsl:variable>
  <xsl:variable name="times">&amp;times;</xsl:variable>
  <xsl:variable name="dagger">&amp;dagger;</xsl:variable>

  <!-- There are just for convenience. -->
  <xsl:variable name="smiley">&#x1F601;</xsl:variable>
  
  <!-- #endregion -->

  <!-- #region  ========== Gender ========== -->

  <xsl:variable name="Gender_Male" select="*/Constants/Gender/@male" />
  <xsl:variable name="Gender_Female" select="*/Constants/Gender/@female" />
  <xsl:variable name="Gender_Neutral" select="*/Constants/Gender/@neutral" />

  <!-- #endregion  ========== Gender ========== -->

  <!-- #region ========== Availability ==========-->

  <xsl:variable name="Availability_Unreleased" select="*/Constants/Availability/@Unreleased" />
  <xsl:variable name="Availability_General" select="*/Constants/Availability/@General" />
  <xsl:variable name="Availability_Regional" select="*/Constants/Availability/@Regional" />
  <xsl:variable name="Availability_RaidBossOnly" select="*/Constants/Availability/@RaidBossOnly" />
  <xsl:variable name="Availability_RaidBossOnly_EX" select="*/Constants/Availability/@RaidBossOnly_EX" />
  <xsl:variable name="Availability_HatchOnly_2K" select="*/Constants/Availability/@HatchOnly_2K" />
  <xsl:variable name="Availability_HatchOnly_5K" select="*/Constants/Availability/@HatchOnly_5K" />
  <xsl:variable name="Availability_HatchOnly_10K" select="*/Constants/Availability/@HatchOnly_10K" />

  <!-- #endregion Availability-->

  <!-- #region ========== Rarity ==========-->

  <xsl:variable name="Rarity_Legendary" select="*/Constants/Rarity/@Legendary" />
  <xsl:variable name="Rarity_Mythic" select="*/Constants/Rarity/@Mythic" />
  <xsl:variable name="Rarity_UltraBeast" select="*/Constants/Rarity/@UltraBeast" />

  <!-- #endregion ========== Rarity ==========-->

  <!-- #region  ========== IV ========== -->

  <!-- Overall IV -->
  <xsl:variable name="IV_Max" select="number(*/Constants/IV_Evaluation/Overall/@max)" />
  <xsl:variable name="IV_NotGreat_Min" select="number(*/Constants/IV_Evaluation/Overall/NotGreat/@min)" />
  <xsl:variable name="IV_NotGreat_Max" select="number(*/Constants/IV_Evaluation/Overall/NotGreat/@max)" />
  <xsl:variable name="IV_Decent_Min" select="number(*/Constants/IV_Evaluation/Overall/Decent/@min)" />
  <xsl:variable name="IV_Decent_Max" select="number(*/Constants/IV_Evaluation/Overall/Decent/@max)" />
  <xsl:variable name="IV_Strong_Min" select="number(*/Constants/IV_Evaluation/Overall/Strong/@min)" />
  <xsl:variable name="IV_Strong_Max" select="number(*/Constants/IV_Evaluation/Overall/Strong/@max)" />
  <xsl:variable name="IV_Amazes_Min" select="number(*/Constants/IV_Evaluation/Overall/Amazes/@min)" />
  <xsl:variable name="IV_Amazes_Max" select="number(*/Constants/IV_Evaluation/Overall/Amazes/@max)" />

  <!-- Attribute IV -->
  <xsl:variable name="IV_Attribute_Max" select="number(*/Constants/IV_Evaluation/Attribute/@max)" />
  <xsl:variable name="IV_Attribute_NotGreatness_Min" select="number(*/Constants/IV_Evaluation/Attribute/NotGreatness/@min)" />
  <xsl:variable name="IV_Attribute_NotGreatness_Max" select="number(*/Constants/IV_Evaluation/Attribute/NotGreatness/@max)" />
  <xsl:variable name="IV_Attribute_JobDone_Min" select="number(*/Constants/IV_Evaluation/Attribute/JobDone/@min)" />
  <xsl:variable name="IV_Attribute_JobDone_Max" select="number(*/Constants/IV_Evaluation/Attribute/JobDone/@max)" />
  <xsl:variable name="IV_Attribute_Excellent_Min" select="number(*/Constants/IV_Evaluation/Attribute/Excellent/@min)" />
  <xsl:variable name="IV_Attribute_Excellent_Max" select="number(*/Constants/IV_Evaluation/Attribute/Excellent/@max)" />
  <xsl:variable name="IV_Attribute_Wow_Min" select="number(*/Constants/IV_Evaluation/Attribute/Wow/@min)" />
  <xsl:variable name="IV_Attribute_Wow_Max" select="number(*/Constants/IV_Evaluation/Attribute/Wow/@max)" />

  <!-- #endregion  ========== IV ========== -->

  <!-- #region ========== Mappings ========== -->

  <xsl:template name="WeatherBoost">
    <xsl:param name="type" />

      <xsl:value-of select="*/Constants/Mappings/WeatherBoost[@type=$type]/@boost"/>
  </xsl:template>

  <!-- #endRegion ========== Mappings ========== -->
  
  <!-- #region  ========== NumericChar ========== -->

  <xsl:template name="NumericChar">
    <xsl:param name="number" />

    <span style="font-size:x-large">
      <xsl:value-of select="*/Constants/NumericChars/NumericChar[@number=$number]/@character"/>
    </span>
  </xsl:template>

  <!-- #endregion  ========== NumericChar ========== -->

  <!-- #region  ========== CPM ========== -->

  <xsl:template name="CMP">
    <xsl:param name="level"/>

    <xsl:value-of select="*/Constants/CPMultipliers/CPM[@level=$level]/@value "/>
  </xsl:template>

  <!-- #endregion  ========== CPM ========== -->

</xsl:stylesheet>