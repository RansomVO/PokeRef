<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>

  <!-- **************************************************************************************************** -->
  <!-- ******************** Settings - Global Variables *************************************************** -->
  <!-- **************************************************************************************************** -->
  <xsl:variable name="Availability_Unavailable" select="/Root/Settings/Availability/Unavailable" />
  <xsl:variable name="Availability_General" select="/Root/Settings/Availability/General" />
  <xsl:variable name="Availability_Legendary" select="/Root/Settings/Availability/Legendary" />
  <xsl:variable name="Availability_Regional" select="/Root/Settings/Availability/Regional" />
  <xsl:variable name="Availability_RaidBossOnly" select="/Root/Settings/Availability/RaidBossOnly" />
  <xsl:variable name="Availability_RaidBossOnly_EX" select="/Root/Settings/Availability/RaidBossOnly_EX" />
  <xsl:variable name="Availability_HatchOnly_2K" select="/Root/Settings/Availability/HatchOnly_2K" />
  <xsl:variable name="Availability_HatchOnly_5K" select="/Root/Settings/Availability/HatchOnly_5K" />
  <xsl:variable name="Availability_HatchOnly_10K" select="/Root/Settings/Availability/HatchOnly_10K" />


  <!-- **************************************************************************************************** -->
  <!-- ******************** Settings - Hard-Coded ********************************************************* -->
  <!-- **************************************************************************************************** -->
  <xsl:template name="IV_SCORE">
    <xsl:param name="Value"/>

    <span style="font-size:x-large">
      <xsl:choose>
        <xsl:when test="$Value = 0">&#x24EA;</xsl:when>
        <xsl:when test="$Value = 1">&#x2460;</xsl:when>
        <xsl:when test="$Value = 2">&#x2461;</xsl:when>
        <xsl:when test="$Value = 3">&#x2462;</xsl:when>
        <xsl:when test="$Value = 4">&#x2463;</xsl:when>
        <xsl:when test="$Value = 5">&#x2464;</xsl:when>
        <xsl:when test="$Value = 6">&#x2465;</xsl:when>
        <xsl:when test="$Value = 7">&#x2466;</xsl:when>
        <xsl:when test="$Value = 8">&#x2467;</xsl:when>
        <xsl:when test="$Value = 9">&#x2468;</xsl:when>
        <xsl:when test="$Value = 10">&#x2469;</xsl:when>
        <xsl:when test="$Value = 11">&#x246A;</xsl:when>
        <xsl:when test="$Value = 12">&#x246B;</xsl:when>
        <xsl:when test="$Value = 13">&#x246C;</xsl:when>
        <xsl:when test="$Value = 14">&#x246D;</xsl:when>
        <xsl:when test="$Value = 15">&#x246E;</xsl:when>
      </xsl:choose>
    </span>
  </xsl:template>


  <!-- **************************************************************************************************** -->
  <!-- ******************** Settings - State ************************************************************* -->
  <!-- **************************************************************************************************** -->

  <xsl:variable name="GameMaster_TimeStamp" select="*/Settings/GAME_MASTER_TimeStamp" />


  <!-- **************************************************************************************************** -->
  <!-- ******************** Settings - Ranges ************************************************************* -->
  <!-- **************************************************************************************************** -->

  <!-- ========== Desirable ========== -->
  <xsl:variable name="Desirable_IV" select="number(*/Settings/Ranges/Desirable/IV)" />
  <xsl:variable name="Desirable_Attack" select="number(*/Settings/Ranges/Desirable/Attack)" />
  <xsl:variable name="Desirable_MaxCP" select="number(*/Settings/Ranges/Desirable/MaxCP)" />
  <xsl:variable name="Desirable_BaseDPS" select="number(*/Settings/Ranges/Desirable/BaseDPS)" />

  <!-- ========== MaxCP ========== -->
  <xsl:variable name="CP_Great" select="number(*/Settings/Ranges/MaxCP/Great)" />
  <xsl:variable name="CP_Good" select="number(*/Settings/Ranges/MaxCP/Good)" />
  <xsl:variable name="CP_OK" select="number(*/Settings/Ranges/MaxCP/OK)" />

  <!-- ========== MaxHP ========== -->
  <xsl:variable name="HP_Great" select="number(*/Settings/Ranges/MaxHP/Great)" />
  <xsl:variable name="HP_Good" select="number(*/Settings/Ranges/MaxHP/Good)" />
  <xsl:variable name="HP_OK" select="number(*/Settings/Ranges/MaxHP/OK)" />

  <!-- ========== DPSPercent ========== -->
  <xsl:variable name="DPSPercentGreat" select="number(*/Settings/Ranges/DPSPercent/Great)" />
  <xsl:variable name="DPSPercentGood" select="number(*/Settings/Ranges/DPSPercent/Good)" />
  <xsl:variable name="DPSPercentOkay" select="number(*/Settings/Ranges/DPSPercent/Okay)" />

  <!-- ========== DPS ========== -->
  <xsl:variable name="DPSGreat" select="number(*/Settings/Ranges/DPS/Great)" />
  <xsl:variable name="DPSGood" select="number(*/Settings/Ranges/DPS/Good)" />

  <!-- ========== Capture ========== -->
  <xsl:variable name="Capture_Easy" select="number(*/Settings/Ranges/Capture/Easy)" />
  <xsl:variable name="Capture_Moderate" select="number(*/Settings/Ranges/Capture/Moderate)" />
  <xsl:variable name="Capture_Difficult" select="number(*/Settings/Ranges/Capture/Difficult)" />

  <!-- ========== Flee ========== -->
  <xsl:variable name="Flee_Bad" select="number(*/Settings/Ranges/Flee/Bad)" />
  <xsl:variable name="Flee_Okay" select="number(*/Settings/Ranges/Flee/Okay)" />
  <xsl:variable name="Flee_Nice" select="number(*/Settings/Ranges/Flee/Nice)" />

  <!-- ========== Attack ========== -->
  <xsl:variable name="Attack_Bad" select="number(*/Settings/Ranges/Attack/Bad)" />
  <xsl:variable name="Attack_Okay" select="number(*/Settings/Ranges/Attack/Okay)" />
  <xsl:variable name="Attack_Nice" select="number(*/Settings/Ranges/Attack/Nice)" />

  <!-- ========== Dodge ========== -->
  <xsl:variable name="Dodge_Bad" select="number(*/Settings/Ranges/Dodge/Bad)" />
  <xsl:variable name="Dodge_Okay" select="number(*/Settings/Ranges/Dodge/Okay)" />
  <xsl:variable name="Dodge_Nice" select="number(*/Settings/Ranges/Dodge/Nice)" />

  <!-- **************************************************************************************************** -->
  <!-- ******************** Settings - Constants ********************************************************** -->
  <!-- **************************************************************************************************** -->


  <!-- ******************** Settings - Evaluation ********************************************************* -->
  <!-- ========== Overall IV ========== -->
  <xsl:variable name="IV_NotGreat_Min" select="0" />
  <xsl:variable name="IV_NotGreat_Max" select="number(*/Settings/Evaluation/IV/NotGreat)" />
  <xsl:variable name="IV_Decent_Min" select="$IV_NotGreat_Max + 1" />
  <xsl:variable name="IV_Decent_Max" select="number(*/Settings/Evaluation/IV/Decent)" />
  <xsl:variable name="IV_Strong_Min" select="$IV_Decent_Max + 1" />
  <xsl:variable name="IV_Strong_Max" select="number(*/Settings/Evaluation/IV/Strong)" />
  <xsl:variable name="IV_Amaze_Min" select="$IV_Strong_Max + 1" />
  <xsl:variable name="IV_Amaze_Max" select="number(*/Settings/Evaluation/IV/Amaze)" />

  <!-- ========== Best IV Attribute========== -->
  <xsl:variable name="IV_Attribute_NotGreatness_Min" select="0" />
  <xsl:variable name="IV_Attribute_NotGreatness_Max" select="number(*/Settings/Evaluation/IV_Attrbute/NotGreatness)" />
  <xsl:variable name="IV_Attribute_Strong_Min" select="$IV_Attribute_NotGreatness_Max + 1" />
  <xsl:variable name="IV_Attribute_Strong_Max" select="number(*/Settings/Evaluation/IV_Attrbute/Strong)" />
  <xsl:variable name="IV_Attribute_Excellent_Min" select="$IV_Attribute_Strong_Max + 1" />
  <xsl:variable name="IV_Attribute_Excellent_Max" select="number(*/Settings/Evaluation/IV_Attrbute/Excellent)" />
  <xsl:variable name="IV_Attribute_Wow_Min" select="$IV_Attribute_Excellent_Max + 1" />
  <xsl:variable name="IV_Attribute_Wow_Max" select="number(*/Settings/Evaluation/IV_Attrbute/Wow)" />


  <!-- **************************************************************************************************** -->
  <!-- ******************** Settings - Visual ************************************************************* -->
  <!-- **************************************************************************************************** -->

  <!-- ========== Gender ========== -->
  <xsl:variable name="Gender_Male" select="string(*/Settings/Gender/Male)" />
  <xsl:variable name="Gender_Female" select="string(*/Settings/Gender/Female)" />
  <xsl:variable name="Gender_Neutral" select="string(*/Settings/Gender/Neutral)" />

</xsl:stylesheet>