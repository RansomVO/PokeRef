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

    <div class="FLOWING_TABLE_WRAPPER">
      <table id="CONTROLS_PokeType_Selector" class="CRITERIA_TABLE" border="1">
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
          <!-- Split entries into 2 columns. -->
          <xsl:variable name="types" select="/Root/Constants/Types/*[not(.='Other')]" />
          <xsl:variable name="mid" select="count($types) div 2" />
          <td valign="top">
            <xsl:for-each select="$types[position() &lt;= $mid]">
              <xsl:call-template name="OutputTypeCheckbox">
                <xsl:with-param name="Type" select="." />
              </xsl:call-template>
              <br />
            </xsl:for-each>
          </td>
          <td valign="top">
            <xsl:for-each select="$types[$mid &lt; position()]">
              <xsl:call-template name="OutputTypeCheckbox">
                <xsl:with-param name="Type" select="." />
              </xsl:call-template>
              <br />
            </xsl:for-each>
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
    </div>
  </xsl:template>

  <xsl:template name="OutputTypeCheckbox">
    <xsl:param name="Type" />
    <input type="checkbox" onchange="OnTogglePokeType();">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('CONTROLS_PokeType_', pokeref:Replace($Type, ' ', ''), '_Check')" />
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

    <div class="FLOWING_TABLE_WRAPPER">
      <table id="CONTROLS_Weather_Selector" class="CRITERIA_TABLE" border="1">
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
            <xsl:for-each select="/Root/Constants/Weathers/*[not(.='Unknown')]">
              <xsl:sort order="ascending" data-type="text" select="." />
              <xsl:call-template name="OutputWeatherCheckbox">
                <xsl:with-param name="Weather" select="." />
              </xsl:call-template>
              <br />
            </xsl:for-each>
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
    </div>
  </xsl:template>

  <xsl:template name="OutputWeatherCheckbox">
    <xsl:param name="Weather" />

    <input type="checkbox" onchange="OnToggleWeather(this);">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('CONTROLS_Weather_', pokeref:Replace($Weather, ' ', ''), '_Check')" />
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
  <!-- #region Generation Selection Control -->

  <xsl:template name="OutputGenerationSelection">
    <xsl:param name="Settings" />
    <xsl:param name="CallbackName" />
    <xsl:param name="Title" select="'Generations'" />
    <xsl:param name="SliderLabel" />
    <xsl:param name="SliderHelp" />

    <div class="FLOWING_TABLE_WRAPPER">
      <table id="CONTROLS_Generations_Selector" class="CRITERIA_TABLE" border="1">
        <xsl:attribute name="callbackName">
          <xsl:value-of select="$CallbackName" />
        </xsl:attribute>
        <tr>
          <th>
            <xsl:value-of select="$Title" disable-output-escaping="yes" />
            <br />
            <input id="CONTROLS_Generations_All_Check" title="Toggle All" type="checkbox" onchange="OnToggleAllGenerations();" />
          </th>
        </tr>
        <tr>
          <td valign="top" style="padding-bottom:.25em; padding-left:.5em">
            <div>
              <xsl:if test="exslt:node-set($Settings)/*/@released_only and 1 > /Root/Settings/GameMasterStats/@gens_released">
                <xsl:attribute name="style">display:none;</xsl:attribute>
              </xsl:if>
              <xsl:call-template name="OutputGenCheckbox">
                <xsl:with-param name="Gen" select="1" />
              </xsl:call-template>
            </div>
            <div>
              <xsl:if test="exslt:node-set($Settings)/*/@released_only and 2 > /Root/Settings/GameMasterStats/@gens_released">
                <xsl:attribute name="style">display:none;</xsl:attribute>
              </xsl:if>
              <xsl:call-template name="OutputGenCheckbox">
                <xsl:with-param name="Gen" select="2" />
              </xsl:call-template>
            </div>
            <div>
              <xsl:if test="exslt:node-set($Settings)/*/@released_only and 3 > /Root/Settings/GameMasterStats/@gens_released">
                <xsl:attribute name="style">display:none;</xsl:attribute>
              </xsl:if>
              <xsl:call-template name="OutputGenCheckbox">
                <xsl:with-param name="Gen" select="3" />
              </xsl:call-template>
            </div>
            <div>
              <xsl:if test="exslt:node-set($Settings)/*/@released_only and 4 > /Root/Settings/GameMasterStats/@gens_released">
                <xsl:attribute name="style">display:none;</xsl:attribute>
              </xsl:if>
              <xsl:call-template name="OutputGenCheckbox">
                <xsl:with-param name="Gen" select="4" />
              </xsl:call-template>
            </div>
            <div>
              <xsl:if test="exslt:node-set($Settings)/*/@released_only and 5 > /Root/Settings/GameMasterStats/@gens_released">
                <xsl:attribute name="style">display:none;</xsl:attribute>
              </xsl:if>
              <xsl:call-template name="OutputGenCheckbox">
                <xsl:with-param name="Gen" select="5" />
              </xsl:call-template>
            </div>
            <div>
              <xsl:if test="exslt:node-set($Settings)/*/@released_only and 6 > /Root/Settings/GameMasterStats/@gens_released">
                <xsl:attribute name="style">display:none;</xsl:attribute>
              </xsl:if>
              <xsl:call-template name="OutputGenCheckbox">
                <xsl:with-param name="Gen" select="6" />
              </xsl:call-template>
            </div>
            <div>
              <xsl:if test="exslt:node-set($Settings)/*/@released_only and 7 > /Root/Settings/GameMasterStats/@gens_released">
                <xsl:attribute name="style">display:none;</xsl:attribute>
              </xsl:if>
              <xsl:call-template name="OutputGenCheckbox">
                <xsl:with-param name="Gen" select="7" />
              </xsl:call-template>
            </div>
          </td>
        </tr>
        <tr>
          <xsl:if test="exslt:node-set($Settings)/*/@hide_slider">
            <xsl:attribute name="class">DIV_HIDDEN</xsl:attribute>
          </xsl:if>
          <td align="center" style="font-size:small; font-weight:normal; ">
            <xsl:call-template name="OutputSliderButtonControl">
              <xsl:with-param name="Id" select="'CONTROLS_Generations_AnyOrAll_Slider'" />
              <xsl:with-param name="Callback" select="'OnToggleGenType();'" />
              <xsl:with-param name="Title" select="$SliderLabel" />
              <xsl:with-param name="OffLabel" select="'Any'" />
              <xsl:with-param name="OnLabel" select="'All'" />
              <xsl:with-param name="Help" select="$SliderHelp" />
            </xsl:call-template>
          </td>
        </tr>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="OutputGenCheckbox">
    <xsl:param name="Gen" />
    <input type="checkbox" onchange="OnToggleGeneration();">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('CONTROLS_Generations_Gen', $Gen, '_Check')" />
      </xsl:attribute>
    </input>
    <xsl:text>Gen</xsl:text>
    <xsl:value-of select="concat($nbsp, $Gen, ':', $nbsp)" disable-output-escaping="yes" />
    <xsl:choose>
      <xsl:when test="$Gen = 1">
        <xsl:value-of select="/Root/Constants/Regions/@Gen1"/>
      </xsl:when>
      <xsl:when test="$Gen = 2">
        <xsl:value-of select="/Root/Constants/Regions/@Gen2"/>
      </xsl:when>
      <xsl:when test="$Gen = 3">
        <xsl:value-of select="/Root/Constants/Regions/@Gen3"/>
      </xsl:when>
      <xsl:when test="$Gen = 4">
        <xsl:value-of select="/Root/Constants/Regions/@Gen4"/>
      </xsl:when>
      <xsl:when test="$Gen = 5">
        <xsl:value-of select="/Root/Constants/Regions/@Gen5"/>
      </xsl:when>
      <xsl:when test="$Gen = 6">
        <xsl:value-of select="/Root/Constants/Regions/@Gen6"/>
      </xsl:when>
      <xsl:when test="$Gen = 7">
        <xsl:value-of select="/Root/Constants/Regions/@Gen7"/>
      </xsl:when>
      <xsl:when test="$Gen = 8">
        <xsl:value-of select="/Root/Constants/Regions/@Gen8"/>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="concat($nbsp, 'Region')" disable-output-escaping="yes" />
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
      <input id="CONTROLS_Egg_2K" type="checkbox" onchange="OnToggleEgg(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'Egg2K'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <input id="CONTROLS_Egg_5K" type="checkbox" onchange="OnToggleEgg(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'Egg5K'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <input id="CONTROLS_Egg_7K" type="checkbox" onchange="OnToggleEgg(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'Egg7K'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <input id="CONTROLS_Egg_10K" type="checkbox" onchange="OnToggleEgg(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'Egg10K'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <input id="CONTROLS_Egg_HatchOnly" type="checkbox" onchange="OnToggleEgg(this);" />
      Hatch Only
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

  <xsl:template name="OutputFilterPokemonNameIDLabel">
    <xsl:value-of select="concat('Pokemon Name or ID:', $nbsp)" disable-output-escaping="yes" />
  </xsl:template>

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Filter by Special Item Control -->

  <xsl:template name="OutputSpecialItemSelectionControl" >
    <xsl:param name="CallbackName" />

    <div id="CONTROLS_Special_Item_Selector" class="PARENT">
      <xsl:attribute name="callbackName">
        <xsl:value-of select="$CallbackName" />
      </xsl:attribute>
      <input id="CONTROLS_Special_Item" type="checkbox" onchange="OnToggleSpecialItem(this);" /> Special Items
    </div>

    <div id="CONTROLS_Special_Item_Options" class="INDENT CHILD">
      <input id="CONTROLS_Special_Item_SunStone" type="checkbox" onchange="OnToggleSpecialItem(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'SunStone'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <input id="CONTROLS_Special_Item_KingsRock" type="checkbox" onchange="OnToggleSpecialItem(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'KingsRock'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <input id="CONTROLS_Special_Item_MetalCoat" type="checkbox" onchange="OnToggleSpecialItem(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'MetalCoat'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <input id="CONTROLS_Special_Item_DragonScale" type="checkbox" onchange="OnToggleSpecialItem(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'DragonScale'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <input id="CONTROLS_Special_Item_UpGrade" type="checkbox" onchange="OnToggleSpecialItem(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'UpGrade'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <input id="CONTROLS_Special_Item_SinnohStone" type="checkbox" onchange="OnToggleSpecialItem(this);" />
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="'SinnohStone'" />
        <xsl:with-param name="Settings">
          <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
        </xsl:with-param>
      </xsl:call-template>
    </div>

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
      <span style="margin-right:2em; font-weight:bold;">
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

    <div class="CONTROLS_HELP" onmouseover="Controls_ShowInfo(this)" onmouseleave="Controls_HideInfo(this)">
      ?
      <span class="CONTROLS_INFO_CONTENT" onmouseleave="Controls_CloseInfo(this)">
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

    <div class="CONTROLS_INFO" onmouseover="Controls_ShowInfo(this)" onmouseleave = "Controls_HideInfo(this)">
      <xsl:copy-of select="$Wrapped" />
      <div class="CONTROLS_INFO_CONTENT" onmouseleave = "Controls_CloseInfo(this)">
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
    <div style="display:inline-block; cursor:pointer; transform:scale(1,.5);">
      <div class="COLLAPSER">
        <xsl:attribute name="id">
          <xsl:value-of select="concat($CollapseeID, '_COLLAPSER')" />
        </xsl:attribute>
        <xsl:text>&#709;</xsl:text>
        <!--<xsl:text>&#x2335;</xsl:text>-->
      </div>
    </div>
    <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
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
      <img src="/images/loading.gif" />
    </div>
  </xsl:template>

  <!-- #endregion -->

</xsl:stylesheet>