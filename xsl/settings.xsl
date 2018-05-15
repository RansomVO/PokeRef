<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>


  <!-- #region  ========== GAME_MASTER ========== -->

  <xsl:variable name="GAME_MASTER_Timestamp" select="*/Settings/GameMasterStats/@last_updated" />
  <xsl:variable name="TotalGens" select="*/Settings/GameMasterStats/@gens_total" />
  <xsl:variable name="ReleasedGens" select="*/Settings/GameMasterStats/@gens_released" />

  <!-- #region Pokemon Counts -->

  <xsl:variable name="PokeCount_Overall" select="*/Settings/GameMasterStats/PokemonCount[@gen=0]" />
  <xsl:variable name="PokeCount_Gen1" select="*/Settings/GameMasterStats/PokemonCount[@gen=1]" />
  <xsl:variable name="PokeCount_Gen2" select="*/Settings/GameMasterStats/PokemonCount[@gen=2]" />
  <xsl:variable name="PokeCount_Gen3" select="*/Settings/GameMasterStats/PokemonCount[@gen=3]" />
  <xsl:variable name="PokeCount_Gen4" select="*/Settings/GameMasterStats/PokemonCount[@gen=4]" />
  <xsl:variable name="PokeCount_Gen5" select="*/Settings/GameMasterStats/PokemonCount[@gen=5]" />
  <xsl:variable name="PokeCount_Gen6" select="*/Settings/GameMasterStats/PokemonCount[@gen=6]" />
  <xsl:variable name="PokeCount_Gen7" select="*/Settings/GameMasterStats/PokemonCount[@gen=7]" />

  <!-- #endregion Pokemon Counts -->

  <!-- #region MoveSet Stats -->
  
  <xsl:variable name="MoveSetStats_Overall" select="*/Settings/GameMasterStats/MoveSets[@gen=0]" />
  <xsl:variable name="MoveSetStats_Gen1" select="*/Settings/GameMasterStats/MoveSets[@gen=1]" />
  <xsl:variable name="MoveSetStats_Gen2" select="*/Settings/GameMasterStats/MoveSets[@gen=2]" />
  <xsl:variable name="MoveSetStats_Gen3" select="*/Settings/GameMasterStats/MoveSets[@gen=3]" />
  <xsl:variable name="MoveSetStats_Gen4" select="*/Settings/GameMasterStats/MoveSets[@gen=4]" />
  <xsl:variable name="MoveSetStats_Gen5" select="*/Settings/GameMasterStats/MoveSets[@gen=5]" />
  <xsl:variable name="MoveSetStats_Gen6" select="*/Settings/GameMasterStats/MoveSets[@gen=6]" />
  <xsl:variable name="MoveSetStats_Gen7" select="*/Settings/GameMasterStats/MoveSets[@gen=7]" />

  <xsl:template name="FormatMoveSetStatValue">
    <xsl:param name="value" />

    <xsl:value-of select="format-number($value, '#0.00')" />
  </xsl:template>

  <!-- #endregion MoveSet Stats -->

  <!-- #endregion  ========== GAME_MASTER ========== -->

  <!-- #region ========== Rating ========== -->
  
  <!-- Desirable -->
  <xsl:variable name="Desirable_IV" select="number(*/Settings/Desirable/@iv)" />
  <xsl:variable name="Desirable_Attack" select="number(*/Settings/Desirable/@attack)" />
  <xsl:variable name="Desirable_MaxCP" select="number(*/Settings/Desirable/@max_cp)" />
  <xsl:variable name="Desirable_BaseDPS" select="number(*/Settings/Desirable/@base_dps)" />

  <!-- MaxCP -->
  <xsl:variable name="CP_Great" select="number(*/Settings/MaxCP/@great)" />
  <xsl:variable name="CP_Good" select="number(*/Settings/MaxCP/@good)" />
  <xsl:variable name="CP_OK" select="number(*/Settings/MaxCP/@okay)" />

  <!-- MaxHP -->
  <xsl:variable name="HP_Great" select="number(*/Settings/MaxHP/@great)" />
  <xsl:variable name="HP_Good" select="number(*/Settings/MaxHP/@good)" />
  <xsl:variable name="HP_OK" select="number(*/Settings/MaxHP/@okay)" />

  <!-- DPSPercent -->
  <xsl:variable name="DPSPercentGreat" select="number(*/Settings/DPSPercent/@great)" />
  <xsl:variable name="DPSPercentGood" select="number(*/Settings/DPSPercent/@good)" />
  <xsl:variable name="DPSPercentOkay" select="number(*/Settings/DPSPercent/@okay)" />

  <!-- DPS -->
  <xsl:variable name="DPSGreat" select="number(*/Settings/DPS/@great)" />
  <xsl:variable name="DPSGood" select="number(*/Settings/DPS/@good)" />

  <!-- Capture -->
  <xsl:variable name="Capture_Easy" select="number(*/Settings/Capture/@easy)" />
  <xsl:variable name="Capture_Moderate" select="number(*/Settings/Capture/@moderate)" />
  <xsl:variable name="Capture_Difficult" select="number(*/Settings/Capture/@difficult)" />

  <!-- Flee -->
  <xsl:variable name="Flee_Bad" select="number(*/Settings/Flee/@bad)" />
  <xsl:variable name="Flee_Okay" select="number(*/Settings/Flee/@okay)" />
  <xsl:variable name="Flee_Nice" select="number(*/Settings/Flee/@nice)" />

  <!-- Attack -->
  <xsl:variable name="Attack_Bad" select="number(*/Settings/Attack/@bad)" />
  <xsl:variable name="Attack_Okay" select="number(*/Settings/Attack/@okay)" />
  <xsl:variable name="Attack_Nice" select="number(*/Settings/Attack/@nice)" />

  <!-- Dodge -->
  <xsl:variable name="Dodge_Bad" select="number(*/Settings/Dodge/@bad)" />
  <xsl:variable name="Dodge_Okay" select="number(*/Settings/Dodge/@okay)" />
  <xsl:variable name="Dodge_Nice" select="number(*/Settings/Dodge/@nice)" />

  <!-- #endregion Rating -->

</xsl:stylesheet>