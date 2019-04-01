<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>
  <!-- For Images, check out: -->
  <!--
    - http://pokemongo.wikia.com/wiki/Category:Pok%C3%A9mon_sprites/
    - http://pokemongo.wikia.com/wiki/List_of_Pok%C3%A9mon/
    - https://rankedboost.com/pokemon-go/pokedex/ (No shinies)
    - https://github.com/PokeAPI/sprites/
    - https://pocketmonsters.net/
    - https://pokemondb.net/sprites/
  -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Templates to output Pokemon image -->
  <!-- ************************************************************************************************************************ -->

  <!-- Template to Output a Pokemon. -->
  <!--
    Settings parameter:
      @small
          false: DEFAULT Use standard sized icon.
          true: Use reduced size icon.
      @boxed
          false: DEFAULT Have Pokmeon expand to fill parent container.
          true: Put the Pokemon in a box that can be displayed inline.
      @hide_special_icons
          false: DEFAULT Display Special Icons. (Shiny, Ditto, Ecounters, etc.)
          true: Do not display Special Icons.
      @hide_type_icons
          false: DEFAULT Display Type and Boost icons.
          true: Do not display Type and Boost icons.
      @hide_name
          false: DEFAULT Display the Name of the Pokemon.
          true: Do not display the Name of the Pokemon.
      @show_disabled
          false: DEFAULT Display unreleased Pokemon as disabled.
          true: Display unreleased Pokemon as enabled. (Will still draw disabled if base stats are 1-1-1)
          
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

    <xsl:variable name="name" select="@name" />
    <xsl:variable name="form" select="@form" />
    <xsl:variable name="pokemon" select="/Root/PokeStats/Pokemon[@name = $name and ((not($form) and not(@form)) or @form = $form)]" />
    <xsl:variable name="egg" select="/Root/Traits/Eggs/Egg[Pokemon/@current and Pokemon/@name = $name and (not($form) or Pokemon/@form = $form)]/@type" />
    <xsl:variable name="raidboss" select="count(/Root/RaidBosses/RaidBoss[@name = $name and @current and @tier]) != 0" />

    <!-- If @href is specified, use this trick to wrap it up in a <a> (Which is closed in similar segement below. -->
    <xsl:if test="exslt:node-set($Settings)/*/@href">
      <xsl:value-of select="concat($lt, 'a ')" disable-output-escaping="yes" />
      <xsl:value-of select="concat('href=', $quot, exslt:node-set($Settings)/*/@href, $quot)" disable-output-escaping="yes" />
      <xsl:text> class="CELL_FILLER SPRITE_LINK</xsl:text>
      <xsl:if test="$pokemon/Stats/BaseIV/@attack = 1 and $pokemon/Stats/BaseIV/@defense = 1 and $pokemon/Stats/BaseIV/@stamina = 1">
        <xsl:text> DISABLED</xsl:text>
      </xsl:if>
      <xsl:value-of select="concat($quot, $gt)" disable-output-escaping="yes" />
    </xsl:if>

    <div>
      <xsl:attribute name="class">
        <xsl:text>SPRITE_FILLER </xsl:text>
        <xsl:choose>
          <xsl:when test="exslt:node-set($Settings)/*/@boxed">SPRITE_BOXED </xsl:when>
          <xsl:otherwise>CELL_FILLER </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="$pokemon/@rarity = $Rarity_Legendary">LEGENDARY </xsl:when>
          <xsl:when test="$pokemon/@rarity = $Rarity_Mythic">MYTHIC </xsl:when>
          <xsl:when test="$pokemon/@rarity = $Rarity_UltraBeast">ULTRA_BEAST </xsl:when>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="contains(@availability,$Availability_RaidBossOnly_EX)">
            <xsl:text>RAIDBOSS_ONLY_EX </xsl:text>
          </xsl:when>
          <xsl:when test="contains(@availability,$Availability_RaidBossOnly)">
            <xsl:text>RAIDBOSS_ONLY </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="$pokemon/../@gen = 1">GEN1 </xsl:when>
              <xsl:when test="$pokemon/../@gen = 2">GEN2 </xsl:when>
              <xsl:when test="$pokemon/../@gen = 3">GEN3 </xsl:when>
              <xsl:when test="$pokemon/../@gen = 4">GEN4 </xsl:when>
              <xsl:when test="$pokemon/../@gen = 5">GEN5 </xsl:when>
              <xsl:when test="$pokemon/../@gen = 6">GEN6 </xsl:when>
              <xsl:when test="$pokemon/../@gen = 7">GEN7 </xsl:when>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <!-- #region Attributes for PokeStats -->
      <xsl:attribute name="title">
        <xsl:apply-templates select="$pokemon" mode="DisplayName" />
      </xsl:attribute>
      <xsl:attribute name="name">
        <xsl:apply-templates select="$pokemon" mode="DisplayName" />
      </xsl:attribute>
      <xsl:attribute name="gen">
        <xsl:value-of select="$pokemon/../@gen" />
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="$pokemon/@id" />
      </xsl:attribute>
      <xsl:attribute name="type1">
        <xsl:value-of select="$pokemon/Type/@primary" />
      </xsl:attribute>
      <xsl:attribute name="type2">
        <xsl:value-of select="$pokemon/Type/@secondary" />
      </xsl:attribute>
      <xsl:attribute name="family">
        <xsl:value-of select="$pokemon/@family" />
      </xsl:attribute>
      <xsl:attribute name="evolvesFrom">
        <xsl:value-of select="$pokemon/EvolvesFrom/@id" />
      </xsl:attribute>
      <xsl:attribute name="special">
        <xsl:value-of select="$pokemon/EvolvesFrom/@special" />
      </xsl:attribute>
      <xsl:attribute name="shiny">
        <xsl:value-of select="$pokemon/@shiny" />
      </xsl:attribute>
      <xsl:attribute name="availability">
        <xsl:value-of select="$pokemon/@availability" />
      </xsl:attribute>
      <xsl:attribute name="rarity">
        <xsl:value-of select="$pokemon/@rarity" />
      </xsl:attribute>
      <xsl:attribute name="boost1">
        <xsl:variable name="Type" select="$pokemon/Type/@primary" />
        <xsl:value-of select="/Root/Constants/Mappings/WeatherBoost[@type=$Type]/@boost" />
      </xsl:attribute>
      <xsl:attribute name="boost2">
        <xsl:variable name="Type" select="$pokemon/Type/@secondary" />
        <xsl:value-of select="/Root/Constants/Mappings/WeatherBoost[@type=$Type]/@boost" />
      </xsl:attribute>
      <xsl:attribute name="genderRatio">
        <xsl:value-of select="$pokemon/@gender_ratio" />
      </xsl:attribute>
      <xsl:attribute name="maxCP">
        <xsl:value-of select="$pokemon/Stats/Max/@cp" />
      </xsl:attribute>
      <xsl:attribute name="maxHP">
        <xsl:value-of select="$pokemon/Stats/Max/@hp" />
      </xsl:attribute>
      <xsl:attribute name="buddyKM">
        <xsl:value-of select="$pokemon/@buddy_km" />
      </xsl:attribute>
      <xsl:attribute name="baseAttack">
        <xsl:value-of select="$pokemon/Stats/BaseIV/@attack" />
      </xsl:attribute>
      <xsl:attribute name="baseDefense">
        <xsl:value-of select="$pokemon/Stats/BaseIV/@defense" />
      </xsl:attribute>
      <xsl:attribute name="baseStamina">
        <xsl:value-of select="$pokemon/Stats/BaseIV/@stamina" />
      </xsl:attribute>
      <xsl:attribute name="captureRate">
        <xsl:value-of select="$pokemon/Stats/Rates/@capture" />
      </xsl:attribute>
      <xsl:attribute name="fleeRate">
        <xsl:value-of select="$pokemon/Stats/Rates/@flee" />
      </xsl:attribute>
      <xsl:attribute name="egg">
        <xsl:value-of select="$egg" />
      </xsl:attribute>
      <xsl:attribute name="raidboss">
        <xsl:value-of select="$raidboss" />
      </xsl:attribute>

      <!-- Not using these at this time.
      <xsl:attribute name="heightStandard">
        <xsl:value-of select="Stats/Height/@standard" />
      </xsl:attribute>
      <xsl:attribute name="heightDeviation">
        <xsl:value-of select="Stats/Height/@deviation" />
      </xsl:attribute>
      <xsl:attribute name="weightStandard">
        <xsl:value-of select="Stats/Weight/@standard" />
      </xsl:attribute>
      <xsl:attribute name="weightDeviation">
        <xsl:value-of select="Stats/Weight/@deviation" />
      </xsl:attribute>
      <xsl:attribute name="probabilityAttack">
        <xsl:value-of select="Stats/Rates/@attack" />
      </xsl:attribute>
      <xsl:attribute name="probabilityDodge">
        <xsl:value-of select="Stats/Rates/@dodge" />
      </xsl:attribute>
-->

      <xsl:if test="count(exslt:node-set($CustomAttributes)) != 0">
        <xsl:for-each select="exslt:node-set($CustomAttributes)/*/@*">
          <xsl:attribute name="{name()}">
            <xsl:value-of select="." />
          </xsl:attribute>
        </xsl:for-each>
      </xsl:if>

      <!-- #endregion Attributes -->

      <div>
        <xsl:attribute name="class">
          <xsl:text>SPRITE_FRAME </xsl:text>
          <xsl:choose>
            <xsl:when test="exslt:node-set($Settings)/*/@valign = 'top'">
              <xsl:text>SPRITE_ALIGN_TOP</xsl:text>
            </xsl:when>
            <xsl:when test="exslt:node-set($Settings)/*/@valign = 'bottom'">
              <xsl:text>SPRITE_ALIGN_BOTTOM</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>SPRITE_ALIGN_MIDDLE</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <table>
          <xsl:if test="$Header != ''">
            <tr>
              <td id="Pokemon_Header_Field" align="center">
                <xsl:copy-of select="$Header" />
              </td>
            </tr>
          </xsl:if>
          <tr>
            <td align="center">
              <div>
                <xsl:attribute name="class">
                  <xsl:text>SPRITE_FRAME </xsl:text>
                  <xsl:choose>
                    <xsl:when test="exslt:node-set($Settings)/*/@valign = 'top'">
                      <xsl:text>SPRITE_ALIGN_TOP</xsl:text>
                    </xsl:when>
                    <xsl:when test="exslt:node-set($Settings)/*/@valign = 'bottom'">
                      <xsl:text>SPRITE_ALIGN_BOTTOM</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>SPRITE_ALIGN_MIDDLE</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>

                <!-- Add Special Icons -->
                <xsl:if test="count(exslt:node-set($Settings)/*/@hide_special_icons) = 0">

                  <!-- Shiny Icon -->
                  <xsl:if test="$pokemon/@shiny">
                    <xsl:call-template name="Sprite">
                      <xsl:with-param name="id" select="'Shiny'" />
                      <xsl:with-param name="Settings">
                        <Show>
                          <xsl:attribute name="sprite_class">
                            <xsl:text>LEFT_ICON</xsl:text>
                            <xsl:if test="contains($pokemon/@availability,'Hatch Only')">
                              <xsl:text> TODO_QZX_TOP_MARGIN</xsl:text>
                            </xsl:if>
                          </xsl:attribute>
                        </Show>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:if>

                  <!-- Egg Icon -->
                  <xsl:if test="$egg != ''">
                    <div>
                      <xsl:choose>
                        <xsl:when test="contains($pokemon/@availability,'Hatch Only')">
                          <xsl:attribute name="class">RIGHT_ICON ICON_WRAPPER</xsl:attribute>
                          <xsl:attribute name="style">background-image:url('/images/game/hatchonly.png');</xsl:attribute>
                        </xsl:when>
                      </xsl:choose>

                      <xsl:call-template name="OutputInfoWrapper">
                        <xsl:with-param name="Wrapped">
                          <xsl:call-template name="Sprite">
                            <xsl:with-param name="id">
                              <xsl:value-of select="concat('Egg', $egg, 'K')" />
                            </xsl:with-param>
                            <xsl:with-param name="Settings">
                              <Show>
                                <xsl:attribute name="sprite_class">
                                  <xsl:choose>
                                    <xsl:when test="contains($pokemon/@availability,'Hatch Only')">WRAPPED_ICON</xsl:when>
                                    <xsl:otherwise>RIGHT_ICON</xsl:otherwise>
                                  </xsl:choose>
                                </xsl:attribute>
                              </Show>
                            </xsl:with-param>
                          </xsl:call-template>
                        </xsl:with-param>
                        <xsl:with-param name="Info">
                          <table style="width:15em;">
                            <tr>
                              <th style="width:1px; white-space:nowrap;">Egg:</th>
                              <td >
                                <xsl:choose>
                                  <xsl:when test="$pokemon/@availability = 'Hatch Only'">
                                    <xsl:text>Only Hatches From </xsl:text>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:text>May Hatch From </xsl:text>
                                  </xsl:otherwise>
                                </xsl:choose>
                                <xsl:value-of select="$egg" />
                                <xsl:text>K Egg</xsl:text>
                              </td>
                            </tr>
                          </table>
                        </xsl:with-param>
                      </xsl:call-template>
                    </div>
                  </xsl:if>

                </xsl:if>

                <!-- Add the Image -->
                <xsl:apply-templates select="$pokemon" mode="Sprite">
                  <xsl:with-param name="Settings" select="$Settings" />
                </xsl:apply-templates>

                <!-- Add Type/Boost Icons -->
                <xsl:if test="count(exslt:node-set($Settings)/*/@hide_type_icons) = 0">
                  <div id="Pokemon_Type_Icons_Field" style="text-align:center;">
                    <xsl:apply-templates select="$pokemon/Type" mode="icons" />
                  </div>
                </xsl:if>

                <!-- Add ID/Name -->
                <xsl:if test="count(exslt:node-set($Settings)/*/@hide_name) = 0">
                  <div id="Pokemon_Name_Field" style="white-space:nowrap;">
                    <xsl:if test="contains(@availability,$Availability_RaidBossOnly_EX)">
                      <xsl:attribute name="class">RAIDBOSS_ONLY_EX</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="concat($pokemon/@id, $nbsp, '-', $nbsp)" disable-output-escaping="yes" />
                    <xsl:apply-templates select="$pokemon" mode="DisplayName" />
                  </div>
                </xsl:if>
              </div>
            </td>
          </tr>
          <xsl:if test="$Footer != ''">
            <tr>
              <td id="Pokemon_Footer_Field" align="center">
                <xsl:copy-of select="$Footer" />
              </td>
            </tr>
          </xsl:if>
        </table>
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

    <td class="CELL_FILLED">
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

    <xsl:variable name="id" select="@id" />
    <xsl:variable name="form" select="@form" />
    <xsl:variable name="pokemon" select="/Root/PokeStats/Pokemon[@id=$id and ((@form=$form or (not(@form) and not($form))))]" />

    <img>
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="count(exslt:node-set($Settings)/*/@small) > 0">
            <xsl:text>SPRITE_SMALL </xsl:text>
          </xsl:when>
          <xsl:when test="count(exslt:node-set($Settings)/*/@large) > 0">
            <xsl:text>SPRITE_LARGE </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>SPRITE </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="contains($pokemon/@availability,'Hatch Only')">
          <xsl:text>SPRITE_WITH_WRAPPED_ICON </xsl:text>
        </xsl:if>
        <xsl:if test="contains($pokemon/@availability,$Availability_Regional)">
          <xsl:text>REGIONAL </xsl:text>
        </xsl:if>
        <xsl:if test="(count(exslt:node-set($Settings)/*/@show_disabled) = 0 and contains($pokemon/@availability,$Availability_Unreleased)) or ($pokemon/Stats/BaseIV/@attack = 1 and $pokemon/Stats/BaseIV/@defense = 1 and $pokemon/Stats/BaseIV/@stamina = 1)">
          <xsl:text>DISABLED </xsl:text>
        </xsl:if>
      </xsl:attribute>

      <xsl:attribute name="src">
        <!-- Figure out where image should be located. -->
        <xsl:apply-templates select="$pokemon" mode="SpriteURL" />
      </xsl:attribute>

      <xsl:attribute name="alt">
        <xsl:apply-templates select="$pokemon" mode="DisplayName" />
      </xsl:attribute>
    </img>
  </xsl:template>

  <xsl:template match="Pokemon" mode="SpriteURL">
    <!-- TODO QZX: Add support for Shinies -->
    <!-- TODO QZX: Add support for Genders -->
    <!-- TODO QZX: Add support for Special features (E.G. Pikachu with a hat) -->
    <xsl:value-of select="@sprite" />
  </xsl:template>

  <xsl:template match="Pokemon" mode="DisplayName">
    <xsl:value-of select="@name" />
    <xsl:if test="@form">
      <xsl:value-of select="concat(' (', @form, ')')" />
    </xsl:if>
  </xsl:template>

  <!-- #region Templates to Output icons for Pokemon Type/Boost. -->
  <xsl:template match="Type" mode="icons">
      <table class="TABLE_ARRANGER">
        <tr>
          <td style="margin:0; padding:0">
            <xsl:call-template name="OutputTypeIcon">
              <xsl:with-param name="Type" select="@primary" />
            </xsl:call-template>
          </td>
          <xsl:if test="@secondary">
            <td>
              <xsl:call-template name="OutputTypeIcon">
                <xsl:with-param name="Type" select="@secondary" />
              </xsl:call-template>
            </td>
          </xsl:if>
          <td class="SPACER_ICON" />
          <td>
            <xsl:call-template name="OutputWeatherBoostIcon">
              <xsl:with-param name="Type" select="@primary" />
            </xsl:call-template>
          </td>
          <xsl:if test="@secondary">
            <td>
              <xsl:call-template name="OutputWeatherBoostIcon">
                <xsl:with-param name="Type" select="@secondary" />
              </xsl:call-template>
            </td>
          </xsl:if>
        </tr>
      </table>
  </xsl:template>

  <xsl:template name="OutputTypeIcon">
    <xsl:param name="Type" />
    <xsl:param name="Settings" />

    <xsl:if test="$Type != ''">
      <xsl:call-template name="OutputInfoWrapper">
        <xsl:with-param name="Wrapped">
          <xsl:call-template name="Sprite">
            <xsl:with-param name="id" select="$Type" />
            <xsl:with-param name="Settings">
              <Show>
                <xsl:attribute name="sprite_class">
                  <xsl:choose>
                    <xsl:when test="exslt:node-set($Settings)/*/@size = 'small'">TAG_ICON_SMALL</xsl:when>
                    <xsl:when test="exslt:node-set($Settings)/*/@size = 'large'">TAG_ICON_LARGE</xsl:when>
                    <xsl:otherwise>TAG_ICON_REGULAR</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
              </Show>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="Info">
          <table style="width:5em;">
            <tr>
              <th style="width:1px; white-space:nowrap;">Type:</th>
              <td>
                <xsl:value-of select="$Type" />
              </td>
            </tr>
          </table>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="OutputWeatherBoostIcon">
    <xsl:param name="Type" />
    <xsl:param name="Settings" />

    <xsl:if test="$Type != ''">
      <xsl:call-template name="OutputWeatherIcon">
        <xsl:with-param name="Weather" select="/Root/Constants/Mappings/WeatherBoost[@type=$Type]/@boost" />
        <xsl:with-param name="Settings" select="$Settings" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="OutputWeatherIcon">
    <xsl:param name="Weather" />
    <xsl:param name="Settings" />

    <xsl:call-template name="OutputInfoWrapper">
      <xsl:with-param name="Wrapped">
        <xsl:call-template name="Sprite">
          <xsl:with-param name="id" select="pokeref:Replace($Weather, ' ', '')" />
          <xsl:with-param name="Settings">
            <Show>
              <xsl:attribute name="sprite_class">
                <xsl:choose>
                  <xsl:when test="exslt:node-set($Settings)/*/@size = 'small'">TAG_ICON_SMALL</xsl:when>
                  <xsl:when test="exslt:node-set($Settings)/*/@size = 'large'">TAG_ICON_LARGE</xsl:when>
                  <xsl:otherwise>TAG_ICON_REGULAR</xsl:otherwise>
                </xsl:choose>
                <xsl:if test="exslt:node-set($Settings)/*/@overlap = 'true'"> TAG_ICON_OVERLAP</xsl:if>
              </xsl:attribute>
            </Show>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="Info">
        <table style="width:12em;">
          <tr>
            <th style="width:1px; white-space:nowrap;">Weather:</th>
            <td>
              <xsl:value-of select="/Root/Images/Image[@id=$Weather]/@title" />
            </td>
          </tr>
        </table>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="OutputTypeIconWithBoost">
    <xsl:param name="Type" />
    <xsl:param name="Settings" />

    <div style="position:relative; display:inline-block;">
      <xsl:if test="not(exslt:node-set($Settings)/*/@size = 'large')">
        <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
      </xsl:if>
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
            <xsl:if test="not(exslt:node-set($Settings)/*/@size = 'large')">
              <xsl:attribute name="size">small</xsl:attribute>
            </xsl:if>
          </Show>
        </xsl:with-param>
      </xsl:call-template>
    </div>
  </xsl:template>
  <!-- #endregion Templates to Output icons for Pokemon Type/Boost. -->

  <xsl:template name="PokemonImageKey">
    <xsl:param name="Title" />

    <div class="FLOWING_TABLE_WRAPPER">
      <table id="POKEMON_IMAGE_KEY" class="KEY_TABLE" border="1">
        <xsl:if test="$Title != ''">
          <tr>
            <th colspan="2">
              <span style="font-size:larger;">
                <xsl:value-of select="$Title" />
              </span>
            </th>
          </tr>
        </xsl:if>

        <comment commment="Limited Availablility">
          <tr>
            <th rowspan="2">Limited Availability</th>
            <td>
              <div class="REGIONAL">Regional Availability</div>
            </td>
          </tr>
          <tr>
            <td class="UNRELEASED">Unreleased</td>
          </tr>
        </comment>

        <comment commment="Limited Origin">
          <tr>
            <th rowspan="2">Limited Origin</th>
            <td class="RAIDBOSS_ONLY">Available As Raid Boss Only</td>
          </tr>
          <tr>
            <td class="RAIDBOSS_ONLY_EX">Available As EX Raid Boss Only</td>
          </tr>
        </comment>

        <comment commment="Rarity">
          <tr>
            <th rowspan="3">Rarity</th>
            <td class="LEGENDARY">Legendary</td>
          </tr>
          <tr>
            <td class="MYTHIC">Mythic</td>
          </tr>
          <tr>
            <td class="ULTRA_BEAST">Ultra Beast</td>
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