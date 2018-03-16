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
  <!-- #region PokeType Selection Control -->

  <xsl:template name="OutputTypeSelection">
    <xsl:param name="CallbackName" />
    <xsl:param name="Title" select="'Types'" />
    <xsl:param name="SliderLabel" />
    <xsl:param name="SliderHelp" />

    <table id="CONTROLS_PokeType_Selector" border="1" style="white-space:nowrap;">
      <xsl:attribute name="callbackName">
        <xsl:value-of select="$CallbackName" />
      </xsl:attribute>
      <tr>
        <th colspan="2" width="0">
          <xsl:value-of select="$Title" disable-output-escaping="yes" />
          <br />
          <input id="CONTROLS_PokeType_All_Check" title="Toggle All" type="checkbox" onchange="OnToggleAllPokeTypes();" />
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
      <tr>
        <td colspan="2" align="center" style="font-size:small; font-weight:normal; ">
          <xsl:call-template name="OutputSliderButtonControl">
            <xsl:with-param name="Id" select="'CONTROLS_PokeType_AnyOrAll_Slider'" />
            <xsl:with-param name="Callback" select="'OnAnyOrAllTypeSliderChanged(this)'" />
            <xsl:with-param name="Title" select="$SliderLabel" />
            <xsl:with-param name="OffLabel" select="'Any'" />
            <xsl:with-param name="OnLabel" select="'All'" />
            <xsl:with-param name="Help" select="$SliderHelp" />
          </xsl:call-template>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="OutputTypeCheckbox">
    <xsl:param name="Type" />
    <input type="checkbox" onchange="OnTogglePokeType();">
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
    <xsl:param name="CallbackName" />
    <xsl:param name="Title" select="'Weather'" />
    <xsl:param name="SliderLabel" />
    <xsl:param name="SliderHelp" />

    <table id="CONTROLS_Weather_Selector" border="1" style="white-space:nowrap;">
      <xsl:attribute name="callbackName">
        <xsl:value-of select="$CallbackName" />
      </xsl:attribute>
      <tr>
        <th>
          <xsl:value-of select="$Title" disable-output-escaping="yes" />
          <br />
          <input id="CONTROLS_Weather_All_Check" title="Toggle All" type="checkbox" onchange="OnToggleAllWeather();" />
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
      <tr>
        <td align="center" style="font-size:small; font-weight:normal; ">
          <xsl:call-template name="OutputSliderButtonControl">
            <xsl:with-param name="Id" select="'CONTROLS_Weather_AnyOrAll_Slider'" />
            <xsl:with-param name="Callback" select="'OnAnyOrAllWeatherSliderChanged(this)'" />
            <xsl:with-param name="Title" select="$SliderLabel" />
            <xsl:with-param name="OffLabel" select="'Any'" />
            <xsl:with-param name="OnLabel" select="'All'" />
            <xsl:with-param name="Help" select="$SliderHelp" />
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
  <!-- #region Egg Selection Control-->

  <xsl:template name="OutputEggSelectionControl">
    <xsl:param name="CallbackName" />

    <div id="CONTROLS_Egg_Selector" class="PARENT">
      <xsl:attribute name="callbackName">
        <xsl:value-of select="$CallbackName" />
      </xsl:attribute>
      <input id="CONTROLS_Egg" type="checkbox" onchange="OnToggleEgg(this);" /> Eggs
    </div>
    <div id="CONTROLS_Egg_Options" class="INDENT CHILD">
      <input id="CONTROLS_Egg_2K" type="checkbox" onchange="OnToggleEgg(this);" /> Hatches from 2K
      <br /><input id="CONTROLS_Egg_5K" type="checkbox" onchange="OnToggleEgg(this);" /> Hatches from 5K
      <br /><input id="CONTROLS_Egg_10K" type="checkbox" onchange="OnToggleEgg(this);" /> Hatches from 10K
      <br /><input id="CONTROLS_Egg_HatchOnly" type="checkbox" onchange="OnToggleEgg(this);" /> Hatch Only
    </div>
  </xsl:template>

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Filter by Name/ID Control -->

  <xsl:template name="OutputFilterPokemonNameID">
    <xsl:param name="CallbackName" />

    <input id="CONTROLS_Filter_NameID" type="text" onkeyup="OnFilterNameIDChanged()">
      <xsl:attribute name="callbackName">
        <xsl:value-of select="$CallbackName" />
      </xsl:attribute>
    </input>
    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
    <xsl:call-template name="OutputHelpButton">
      <xsl:with-param name="Help">
        <table style="width:20em;">
          <tr>
          <th valign="top">-</th>
          <td>
            Specifies a range.
            <br />Examples:
            <ul>
              <li>
                <b>1-10</b>: All Pokemon with IDs between 1 and 10.
              </li>
              <li>
                <b>-3</b>: All Pokemon with IDs 3 or lower.
              </li>
              <li>
                <b>100-</b>: All Pokemon with IDs 100 or higher.
              </li>
            </ul>
          </td>
          </tr>
        <tr>
          <th valign="top">+</th>
          <td>
            Specifies a family.
            <br />Example:
            <ul>
              <li>
                <b>+pidgey</b>: All Pokemon in the Pidgey family.
                <br /><span class="NOTE">(I.E. Those that use Pidgey candies.)</span>
              </li>
            </ul>
          </td>
        
      </tr>
        <tr class="CONTROLS_INFO_ENTRY">
          <th valign="top">,</th>
          <td>
            Specifies to match one criteria OR another.
            <br />Example:
            <ul>
              <li>
                <b>1-10,BB</b>: All Pokemon with:
                <br />IDs between 1 and 10
                <br /><b>- OR -</b>
                <br />a name that contains BB.
                <span class="NOTE">(E.G. Krabby, Wobbeffet and Snubbull)</span>
              </li>
            </ul>
          </td>
        
      </tr>
          <tr class="CONTROLS_INFO_ENTRY">
            <th valign="top">&amp;</th>
          <td>
            Specifies one criteria AND another.
            <br />Example:
            <ul>
              <li>
                <b>1-10&amp;B</b>: All Pokemon with:
                <br />IDs between 1 and 10
                <br /><b>- AND -</b>
                <br />a name that contains BB.
              </li>
            </ul>
          </td>
        </tr>
        </table>
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

  <!-- #endregion -->

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Slider Button Control -->

  <xsl:template name="OutputSliderButtonControl">
    <xsl:param name="Callback" />
    <xsl:param name="Id" />
    <xsl:param name="Title" />
    <xsl:param name="OffLabel" select="Off" />
    <xsl:param name="OnLabel" select="On" />
    <xsl:param name="Help" />

    <xsl:if test="$Title != ''">
      <span style="margin-right:2em;">
        <xsl:copy-of select="$Title" />
      </span>
    </xsl:if>
    <xsl:value-of select="$OffLabel" />
    <label style="font-size:smaller; position:relative; display:inline-block; width:2em; height:1em; margin-left:.25em; margin-right:.25em;">
      <input type="checkbox" style="display:none;">
        <xsl:attribute name="id">
          <xsl:value-of select="$Id" />
        </xsl:attribute>
        <xsl:attribute name="onchange">
          <xsl:value-of select="$Callback" />
        </xsl:attribute>
      </input>
      <span class="CONTROLS_SLIDER_BUTTON" />
    </label>
    <xsl:value-of select="$OnLabel" />
    <xsl:if test="$Help != ''">
      <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      <xsl:call-template name="OutputHelpButton">
        <xsl:with-param name="Help">
          <xsl:copy-of select="$Help" />
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Help Button Control -->
  <xsl:template name="OutputHelpButton">
    <xsl:param name="Help" />

    <div class="CONTROLS_HELP">
      ?
      <span class="CONTROLS_INFO_CONTENT">
        <xsl:copy-of select="$Help" />
      </span>
    </div>
  </xsl:template>
  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Info Wrapper to display info about a field. -->
  <xsl:template name="OutputInfoWrapper">
    <xsl:param name="Wrapped" />
    <xsl:param name="Info" />

    <div class="CONTROLS_INFO">
      <xsl:copy-of select="$Wrapped" />
      <div class="CONTROLS_INFO_CONTENT">
        <xsl:copy-of select="$Info" />
      </div>
    </div>
  </xsl:template>
  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Reset Button Control -->
  <xsl:template name="OutputResetButton">
    <xsl:param name="Callback" />

    <div style="display:inline-block; vertical-align:middle;">
      <button type="button" style="font-weight:bold; margin-bottom:.2em; margin-top:.2em;" title="Reset">
        <xsl:attribute name="onclick">
          <xsl:value-of select="$Callback" />
        </xsl:attribute>
        <xsl:text>&#x21ba;</xsl:text>
      </button>
    </div>
  </xsl:template>
  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Collapser template -->
  <!-- ************************************************************************************************************************ -->

  <xsl:template name="Collapser">
    <xsl:param name="CollapseeID" />
    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
    <div style="display:inline-block; cursor:pointer; transform:scale(1,.5);">
      <div class="COLLAPSER">
        <xsl:attribute name="id">
          <xsl:value-of select="concat($CollapseeID, '_COLLAPSER')" />
        </xsl:attribute>
        <xsl:text>&#709;</xsl:text>
        <!--<xsl:text>&#x2335;</xsl:text>-->
      </div>
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