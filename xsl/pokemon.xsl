<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>

  <!-- ************************************************************************************************************************ -->
  <!-- #region Global variables -->
  <!-- ************************************************************************************************************************ -->

  <!-- Variable that tells how many generations of Pokemon have been released. -->
  <xsl:variable name="TotalGens" select="7" />
  <xsl:variable name="ReleasedGens" select="3" />

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Templates to output Pokemon image -->
  <!-- ************************************************************************************************************************ -->

  <!-- Template to Output a Pokemon. -->
  <!--
    Settings parameter:
      @small
          0: DEFAULT Use standard sized icon.
          1: Use reduced size icon.
      @boxed
          0: DEFAULT Have Pokmeon expand to fill parent container.
          1: Put the Pokemon in a box that can be displayed inline.
          
      @hide_icons (Default: 0)
          0: DEFAULT Display Type, Boost and shiny icons.
          1: Do not display Type, Boost and shiny icons.
      @hide_name
          0: DEFAULT Display the Name of the Pokemon.
          1: Do not display the Name of the Pokemon.
      @show_disabled
          0: DEFAULT Display unreleased Pokemon as disabled.
          1: Display unreleased Pokemon as enabled. (Will still draw disabled if base stats are 1-1-1)
          
      @href
          Make the Image a link to the specified href
      @valign
          vertical alignment of the image within the box. ("top", "bottom", "middle", etc.)
  -->
  <xsl:template match="Pokemon">
    <xsl:param name="Settings" />
    <xsl:param name="CustomAttributes" />
    <xsl:param name="Header" />
    <xsl:param name="Footer" />

    <xsl:variable name="Name" select="." />
    <xsl:variable name="Pokemon" select="/Root/PokemonStats/Pokemon[Name = $Name]" />

    <!-- If @href is specified, use this trick to wrap it up in a <a> (Which is closed in similar segement below. -->
    <xsl:if test="exslt:node-set($Settings)/*/@href">
      <xsl:value-of select="concat($lt, 'a href=', $quot, exslt:node-set($Settings)/*/@href, $quot,' style=',$quot, 'text-decoration:none;', $quot, ' class=', $quot, 'CELL_FILLER')" disable-output-escaping="yes" />
      <xsl:if test="Stats/Base/Attack = 1 and Stats/Base/Defense = 1 and Stats/Base/Stamina = 1">
        <xsl:text> DISABLED</xsl:text>
      </xsl:if>
      <xsl:value-of select="concat($quot, $gt)" disable-output-escaping="yes" />
    </xsl:if>

    <div>
      <!-- #region Attributes -->
      <xsl:attribute name="title">
        <xsl:value-of select="Name" />
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="exslt:node-set($Settings)/*/@boxed">
            <xsl:text>SPRITE_BOXED </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>SPRITE_FILLER </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="contains(Availability,$Availability_HatchOnly_2K)">
            <xsl:text>HATCH_ONLY_2K </xsl:text>
          </xsl:when>
          <xsl:when test="contains(Availability,$Availability_HatchOnly_5K)">
            <xsl:text>HATCH_ONLY_5K </xsl:text>
          </xsl:when>
          <xsl:when test="contains(Availability,$Availability_HatchOnly_10K)">
            <xsl:text>HATCH_ONLY_10K </xsl:text>
          </xsl:when>
          <!-- $Availability_RaidBossOnly_EX test MUST come before $Availability_RaidBossOnly test! -->
          <xsl:when test="contains(Availability,$Availability_RaidBossOnly_EX)">
            <xsl:text>RAIDBOSS_ONLY_EX </xsl:text>
          </xsl:when>
          <xsl:when test="contains(Availability,$Availability_RaidBossOnly)">
            <xsl:text>RAIDBOSS_ONLY </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="../Generation/ID = 1">GEN1 </xsl:when>
              <xsl:when test="../Generation/ID = 2">GEN2 </xsl:when>
              <xsl:when test="../Generation/ID = 3">GEN3 </xsl:when>
              <xsl:when test="../Generation/ID = 4">GEN4 </xsl:when>
              <xsl:when test="../Generation/ID = 5">GEN5 </xsl:when>
              <xsl:when test="../Generation/ID = 6">GEN6 </xsl:when>
              <xsl:when test="../Generation/ID = 7">GEN7 </xsl:when>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="name">
        <xsl:value-of select="Name" />
      </xsl:attribute>
      <xsl:attribute name="gen">
        <xsl:value-of select="../Generation/ID" />
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="ID" />
      </xsl:attribute>
      <xsl:attribute name="type1">
        <xsl:value-of select="Type/Primary" />
      </xsl:attribute>
      <xsl:attribute name="type2">
        <xsl:value-of select="Type/Secondary" />
      </xsl:attribute>
      <xsl:attribute name="family">
        <xsl:value-of select="CandyType" />
      </xsl:attribute>
      <xsl:attribute name="evolvesFrom">
        <xsl:value-of select="EvolvesFrom/Pokemon/ID" />
      </xsl:attribute>
      <xsl:attribute name="shiny">
        <xsl:value-of select="ShinyAvailable" />
      </xsl:attribute>
      <xsl:attribute name="availability">
        <xsl:value-of select="Availability" />
      </xsl:attribute>
      <xsl:attribute name="boost1">
        <xsl:variable name="Type" select="Type/Primary" />
        <xsl:value-of select="/Root/Mappings/WeatherBoosts[Type=$Type]/Weather" />
      </xsl:attribute>
      <xsl:attribute name="boost2">
        <xsl:variable name="Type" select="Type/Secondary" />
        <xsl:value-of select="/Root/Mappings/WeatherBoosts[Type=$Type]/Weather" />
      </xsl:attribute>
      <xsl:attribute name="genderRatio">
        <xsl:value-of select="GenderRatio" />
      </xsl:attribute>
      <xsl:attribute name="maxCP">
        <xsl:value-of select="Max/CP" />
      </xsl:attribute>
      <xsl:attribute name="maxHP">
        <xsl:value-of select="Max/HP" />
      </xsl:attribute>
      <xsl:attribute name="buddyKM">
        <xsl:value-of select="BuddyKM" />
      </xsl:attribute>
      <xsl:attribute name="baseAttack">
        <xsl:value-of select="Stats/Base/Attack" />
      </xsl:attribute>
      <xsl:attribute name="baseDefense">
        <xsl:value-of select="Stats/Base/Defense" />
      </xsl:attribute>
      <xsl:attribute name="baseStamina">
        <xsl:value-of select="Stats/Base/Stamina" />
      </xsl:attribute>
      <xsl:attribute name="captureRate">
        <xsl:value-of select="Stats/Rates/Capture" />
      </xsl:attribute>
      <xsl:attribute name="fleeRate">
        <xsl:value-of select="Stats/Rates/Flee" />
      </xsl:attribute>

      <!-- Not using these at this time.
      <xsl:attribute name="heightStandard">
        <xsl:value-of select="Stats/Height/Standard" />
      </xsl:attribute>
      <xsl:attribute name="heightDeviation">
        <xsl:value-of select="Stats/Height/Deviation" />
      </xsl:attribute>
      <xsl:attribute name="weightStandard">
        <xsl:value-of select="Stats/Weight/Standard" />
      </xsl:attribute>
      <xsl:attribute name="weightDeviation">
        <xsl:value-of select="Stats/Weight/Deviation" />
      </xsl:attribute>
      <xsl:attribute name="probabilityAttack">
        <xsl:value-of select="Stats/Probability/Attack" />
      </xsl:attribute>
      <xsl:attribute name="probabilityDodge">
        <xsl:value-of select="Stats/Probability/Dodge" />
      </xsl:attribute>
-->

      <xsl:if test="count(exslt:node-set($CustomAttributes)) != 0">
        <xsl:for-each select="exslt:node-set($CustomAttributes)/*/@*">
          <xsl:attribute name="{name()}">
            <xsl:value-of select="."/>
          </xsl:attribute>
        </xsl:for-each>
      </xsl:if>
      
      <!-- #endregion Attributes -->

      <div>
        <xsl:attribute name="style">
          <xsl:text>vertical-align:</xsl:text>
          <xsl:choose>
            <xsl:when test="count(exslt:node-set($Settings)/*/@valign) != 0">
              <xsl:value-of select="exslt:node-set($Settings)/*/@valign" />
            </xsl:when>
            <xsl:otherwise>middle</xsl:otherwise>
          </xsl:choose>
          <xsl:text>; </xsl:text>
        </xsl:attribute>
        <xsl:attribute name="class">
          <xsl:text>SPRITE_DIV_FILLER </xsl:text>
          <xsl:if test="contains(Availability,$Availability_Legendary)">LEGENDARY </xsl:if>
        </xsl:attribute>

        <xsl:if test="$Header != ''">
          <div id="Pokemon_Header_Field">
            <xsl:copy-of select="$Header"/>
          </div>
        </xsl:if>

        <!-- Add Shiny Icon here. -->
        <xsl:if test="count(exslt:node-set($Settings)/*/@hide_icons) = 0 and ShinyAvailable">
          <img class="SHINY_ICON" src="/images/shiny.png" alt="Shiny" />
        </xsl:if>

        <xsl:apply-templates select="." mode="Sprite">
          <xsl:with-param name="Settings" select="$Settings" />
        </xsl:apply-templates>

        <!-- Add Type/Boost Icons here. -->
        <xsl:if test="count(exslt:node-set($Settings)/*/@hide_icons) = 0">
          <div id="Pokemon_Icons_Field">
            <xsl:apply-templates select="Type" mode="icons" />
          </div>
        </xsl:if>

        <xsl:if test="count(exslt:node-set($Settings)/*/@hide_name) = 0">
          <div id="Pokemon_Name_Field">
            <xsl:value-of select="concat(ID, $nbsp, '-', $nbsp, Name)" disable-output-escaping="yes" />
          </div>
        </xsl:if>

        <xsl:if test="$Footer != ''">
          <div id="Pokemon_Footer_Field">
            <xsl:copy-of select="$Footer"/>
          </div>
        </xsl:if>
      </div>
    </div>

    <xsl:if test="exslt:node-set($Settings)/*/@href">
      <xsl:value-of select="concat($lt, '/a', $gt)" disable-output-escaping="yes" />
    </xsl:if>

  </xsl:template>

  <!-- Template to output the Pokemon in a Table cell -->
  <xsl:template match="Pokemon" mode="Cell">
    <xsl:param name="Settings" />
    <xsl:param name="CustomAttributes" />
    <xsl:param name="Header" />
    <xsl:param name="Footer" />

    <td height="1px" align="center" class="CELL_FILLED">
      <xsl:apply-templates select=".">
        <xsl:with-param name="Settings" select="$Settings" />
        <xsl:with-param name="CustomAttributes" select="$CustomAttributes" />
        <xsl:with-param name="Header" select="$Header" />
        <xsl:with-param name="Footer" select="$Footer" />
      </xsl:apply-templates>
    </td>
  </xsl:template>

  <!-- Template to create the image of the specified Pokemon -->
  <xsl:template match="Pokemon" mode="Sprite">
    <xsl:param name="Settings" />

    <img style="vertical-align:middle;">
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="count(exslt:node-set($Settings)/*/@small) > 0">
            <xsl:text>SPRITE_SMALL </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>SPRITE </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="(count(exslt:node-set($Settings)/*/@show_disabled) = 0 and contains(Availability,$Availability_Unavailable)) or (Stats/Base/Attack = 1 and Stats/Base/Defense = 1 and Stats/Base/Stamina = 1)">
          <xsl:text>DISABLED </xsl:text>
        </xsl:if>
      </xsl:attribute>

      <xsl:attribute name="src">
        <!-- TODO QZX: For right now I have to use 2 sources for icons. If this changes in the future only the contents of the first <xsl:when> is necessary. -->
        <xsl:choose>
          <xsl:when test="../Generation/ID &lt;= $ReleasedGens">
            <xsl:text>https://pkmref.com/images/set_1/</xsl:text>
            <xsl:value-of select="ID"/>
            <xsl:text>.png</xsl:text>
          </xsl:when>

          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="../Generation/ID = 7">
                <xsl:text>https://img.pokemondb.net/sprites/sun-moon/dex/normal/</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>https://img.pokemondb.net/sprites/x-y/normal/</xsl:text>
              </xsl:otherwise>
            </xsl:choose>

            <xsl:value-of select="translate(Name, concat('ABCDEFGHIJKLMNOPQRSTUVWXYZ é:♀♂.', $apos), 'abcdefghijklmnopqrstuvwxyz-e')" disable-output-escaping="yes" />

            <xsl:choose>
              <xsl:when test="ID = 29">
                <xsl:text>-f</xsl:text>
              </xsl:when>
              <xsl:when test="ID = 32">
                <xsl:text>-m</xsl:text>
              </xsl:when>
              <xsl:when test="ID = 669">
                <xsl:text>-red</xsl:text>
              </xsl:when>
              <xsl:when test="ID = 741">
                <xsl:text>-baile</xsl:text>
              </xsl:when>
              <xsl:when test="ID = 745">
                <xsl:text>-midday</xsl:text>
              </xsl:when>
              <xsl:when test="ID = 746">
                <xsl:text>-school</xsl:text>
              </xsl:when>
              <xsl:when test="ID = 774">
                <xsl:text>-core</xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:text>.png</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:attribute name="alt">
        <xsl:text>(</xsl:text>
        <xsl:value-of select="Name" />
        <xsl:text>)</xsl:text>
      </xsl:attribute>
    </img>
  </xsl:template>

  <!-- Template to Output icons for Pokemon Type/Boost. -->
  <xsl:template match="Type" mode="icons">
    <xsl:call-template name="OutputTypeIcon">
      <xsl:with-param name="Type" select="Primary" />
    </xsl:call-template>
    <xsl:call-template name="OutputTypeIcon">
      <xsl:with-param name="Type" select="Secondary" />
    </xsl:call-template>

    <img class="SPACER_ICON" src="/images/blank.png" />

    <xsl:call-template name="OutputWeatherBoostIcon">
      <xsl:with-param name="Type" select="Primary" />
    </xsl:call-template>
    <xsl:call-template name="OutputWeatherBoostIcon">
      <xsl:with-param name="Type" select="Secondary" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="OutputTypeIcon">
    <xsl:param name="Type" />
    <xsl:param name="Settings" />

    <xsl:if test="$Type != ''">
      <img>
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="exslt:node-set($Settings)/*/@size = 'small'">TAG_ICON_SMALL</xsl:when>
            <xsl:when test="exslt:node-set($Settings)/*/@size = 'large'">TAG_ICON_LARGE</xsl:when>
            <xsl:otherwise>TAG_ICON_REGULAR</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="src">
          <xsl:text>/images/type_</xsl:text>
          <xsl:value-of select="pokeref:ToLower($Type)" />
          <xsl:text>.png</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="title">
          <xsl:value-of select="$Type" />
        </xsl:attribute>
      </img>
    </xsl:if>
  </xsl:template>

  <xsl:template name="OutputWeatherBoostIcon">
    <xsl:param name="Type" />
    <xsl:param name="Settings" />

    <xsl:if test="$Type != ''">
      <xsl:call-template name="OutputWeatherIcon">
        <xsl:with-param name="Weather" select="/Root/Mappings/WeatherBoosts[Type=$Type]/Weather" />
        <xsl:with-param name="Settings" select="$Settings" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="OutputWeatherIcon">
    <xsl:param name="Weather" />
    <xsl:param name="Settings" />

    <img>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="exslt:node-set($Settings)/*/@size = 'small'">TAG_ICON_SMALL</xsl:when>
          <xsl:when test="exslt:node-set($Settings)/*/@size = 'large'">TAG_ICON_LARGE</xsl:when>
          <xsl:otherwise>TAG_ICON_REGULAR</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="exslt:node-set($Settings)/*/@overlap = 'true'"> TAG_ICON_OVERLAP</xsl:if>
      </xsl:attribute>
      <xsl:attribute name="src">
        <xsl:text>/images/weather_</xsl:text>
        <xsl:value-of select="pokeref:ToLower(pokeref:Replace($Weather, ' ', ''))" />
        <xsl:text>.png</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:value-of select="$Weather" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template name="OutputTypeIconWithBoost">
    <xsl:param name="Type" />
    <xsl:param name="Settings" />

    <div style="position:relative; display:inline-block">
      <xsl:call-template name="OutputTypeIcon">
        <xsl:with-param name="Type" select="$Type" />
        <xsl:with-param name="Settings">
          <xsl:if test="exslt:node-set($Settings)/*/@size = 'large'">
            <Show size="large" />
          </xsl:if>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="OutputWeatherBoostIcon">
        <xsl:with-param name="Type" select="$Type" />
        <xsl:with-param name="Settings">
          <Show overlap="true">
            <xsl:if test="exslt:node-set($Settings)/*/@size != 'large'">
              <xsl:attribute name="size">small</xsl:attribute>
            </xsl:if>
          </Show>
        </xsl:with-param>
      </xsl:call-template>
    </div>
  </xsl:template>

  <xsl:template name="PokemonImageKey">
    <div id="POKEMON_IMAGE_KEY">
      <table border="1">
        <comment commment="Limited Availablility">
          <tr>
            <th rowspan="2">Limited Availability</th>
            <td class="REGIONAL">Regional Availability</td>
          </tr>
          <tr>
            <td class="UNAVAILABLE">Unavailable</td>
          </tr>
        </comment>

        <comment commment="Limited Origin">
          <tr>
            <th rowspan="5">Limited Origin</th>
            <td class="HATCH_ONLY_2K">Available From 2K Egg Only</td>
          </tr>
          <tr>
            <td class="HATCH_ONLY_5K">Available From 5K Egg Only</td>
          </tr>
          <tr>
            <td class="HATCH_ONLY_10K">Available From 10K Egg Only</td>
          </tr>
          <tr>
            <td class="RAIDBOSS_ONLY">Available As Raid Boss Only</td>
          </tr>
          <tr>
            <td class="RAIDBOSS_ONLY_EX">Available As EX Raid Boss Only</td>
          </tr>
        </comment>

        <comment commment="Special">
          <tr>
            <th>Special</th>
            <td class="LEGENDARY">Legendary</td>
          </tr>
        </comment>

        <tr>
          <td colspan="2" class="NOTE">
            May combine one from each section.
          </td>
        </tr>
      </table>
    </div>
  </xsl:template>

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Support Templates -->
  <!-- ************************************************************************************************************************ -->

  <xsl:template match="*" mode="AddSetting">
    <xsl:param name="Setting" />
    <xsl:param name="Value" />

    <xsl:copy>
      <!-- Copy the existing attributes -->
      <xsl:for-each select="@*">
        <xsl:attribute name="{name(.)}">
          <xsl:value-of select="." />
        </xsl:attribute>
      </xsl:for-each>

      <!-- Add the new attribute -->
      <xsl:attribute name="{$Setting}">
        <xsl:value-of select="$Value" />
      </xsl:attribute>
    </xsl:copy>
  </xsl:template>

  <!-- #endregion -->

</xsl:stylesheet>