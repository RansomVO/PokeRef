<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>

  <!-- ************************************************************************************************************************ -->
  <!-- #region Templates to output Common Selection Criteria -->
  <!-- ************************************************************************************************************************ -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Type Selection Control -->

  <xsl:template name="OutputTypeSelection">
    <xsl:param name="Callback" />
    <xsl:param name="Title" select="'Types'" />

    <table id="CONTROLS_PokeType_Selector" border="1" style="white-space:nowrap;">
      <xsl:attribute name="callbackName">
        <xsl:value-of select="$Callback" />
      </xsl:attribute>
      <tr>
        <th colspan="2">
          <xsl:value-of select="$Title" disable-output-escaping="yes" />
          <br />
          <input id="CONTROLS_PokeType_All_Check" type="checkbox" onchange="OnToggleAllPokeTypes();" />
        </th>
      </tr>
      <tr>
        <td valign="top">
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Bug'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Dark'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Dragon'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Electric'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Fairy'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Fighting'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Fire'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Flying'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Ghost'" />
          </xsl:call-template>
        </td>
        <td valign="top">
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Grass'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Ground'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Ice'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Normal'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Poison'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Psychic'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Rock'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Steel'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputTypeCheckbox">
            <xsl:with-param name="Type" select="'Water'" />
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="OutputTypeCheckbox">
    <xsl:param name="Type" />
    <input type="checkbox" onchange="OnTogglePokeType(this);">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('CONTROLS_PokeType_', pokeref:Replace($Type, ' ', ''), '_Check')"/>
      </xsl:attribute>
    </input>
    <xsl:call-template name="OutputTypeIcon">
      <xsl:with-param name="Type" select="$Type" />
    </xsl:call-template>
    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
    <xsl:value-of select="$Type" />
  </xsl:template>

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Weather Selection Control -->

  <xsl:template name="OutputWeatherSelection">
    <xsl:param name="Callback" />
    <xsl:param name="Title" select="'Weather'" />

    <table id="CONTROLS_Weather_Selector" border="1" style="white-space:nowrap;">
      <xsl:attribute name="callbackName">
        <xsl:value-of select="$Callback" />
      </xsl:attribute>
      <tr>
        <th>
          <xsl:value-of select="$Title" disable-output-escaping="yes" />
          <br />
          <input id="CONTROLS_Weather_All_Check" type="checkbox" onchange="OnToggleAllWeather();" />
        </th>
      </tr>
      <tr>
        <td valign="top">
          <xsl:call-template name="OutputWeatherCheckbox">
            <xsl:with-param name="Weather" select="'Sunny'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputWeatherCheckbox">
            <xsl:with-param name="Weather" select="'Windy'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputWeatherCheckbox">
            <xsl:with-param name="Weather" select="'Cloudy'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputWeatherCheckbox">
            <xsl:with-param name="Weather" select="'Partly Cloudy'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputWeatherCheckbox">
            <xsl:with-param name="Weather" select="'Fog'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputWeatherCheckbox">
            <xsl:with-param name="Weather" select="'Rainy'" />
          </xsl:call-template>
          <br />
          <xsl:call-template name="OutputWeatherCheckbox">
            <xsl:with-param name="Weather" select="'Snow'" />
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="OutputWeatherCheckbox">
    <xsl:param name="Weather" />

    <input type="checkbox" onchange="OnToggleWeather(this);">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('CONTROLS_Weather_', pokeref:Replace($Weather, ' ', ''), '_Check')"/>
      </xsl:attribute>
    </input>
    <xsl:call-template name="OutputWeatherIcon">
      <xsl:with-param name="Weather" select="$Weather" />
    </xsl:call-template>
    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
    <xsl:value-of select="$Weather" />
    <xsl:if test="$Weather = 'Sunny'">/Clear</xsl:if>
  </xsl:template>

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Filter by Name/ID Control -->

  <xsl:template name="OutputFilterPokemonNameID">
    <xsl:param name="Callback" />

    <input id="CONTROLS_Filter_NameID" type="text" onkeyup="OnFilterNameIDChanged()">
      <xsl:attribute name="callbackName">
        <xsl:value-of select="$Callback" />
      </xsl:attribute>
    </input>
  </xsl:template>

  <!-- #endregion -->
  
  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Collapser template -->
  <!-- ************************************************************************************************************************ -->

  <xsl:template name="Collapser">
    <xsl:param name="CollapseeID" />

    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
    <div style="display:inline-block; cursor:pointer;">
      <span class="COLLAPSER BUTTON" style="transform:rotate(-90deg);">
        <xsl:attribute name="id">
          <xsl:value-of select="concat($CollapseeID, '_COLLAPSER')" />
        </xsl:attribute>
        <xsl:text>&#9001;</xsl:text>
      </span>
    </div>
  </xsl:template>

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Template for having a Loading screen. -->
  <!-- ************************************************************************************************************************ -->

  <xsl:template name="LoadingNotice">
    <xsl:param name="LoadedContent" />

    <!-- TODO QZX: It would be nice to have this be an animation. -->
    <div id="GLOBAL_LoadingNotice">
      <xsl:attribute name="formTarget">
        <xsl:value-of select="$LoadedContent" />
      </xsl:attribute>
      <h1>Loading...</h1>
    </div>
  </xsl:template>

  <!-- #endregion -->


</xsl:stylesheet>