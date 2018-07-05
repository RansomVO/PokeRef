<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <!-- #region Global Variables -->
  <xsl:variable name="RewardTypeEncounter" select="'Encounter'" />
  <xsl:variable name="RewardTypeItem" select="'Item'" />
  <xsl:variable name="RewardItems">
    <Reward>BerryRazz</Reward>
    <Reward>BerryNanab</Reward>
    <Reward>BerryPinap</Reward>
    <Reward>BallRegular</Reward>
    <Reward>BallGreat</Reward>
    <Reward>BallUltra</Reward>
    <Reward>Revive</Reward>
    <Reward>ReviveMax</Reward>

    <Reward>Potion</Reward>
    <Reward>PotionSuper</Reward>
    <Reward>PotionHyper</Reward>
    <Reward>PotionMax</Reward>
    <Reward>TMFast</Reward>
    <Reward>TMCharged</Reward>
    <Reward>Stardust</Reward>
    <Reward>CandyRare</Reward>
    <Reward>XP</Reward>
  </xsl:variable>
  <!-- #endregion Global Variables -->

  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>fieldresearch.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/pokemon.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/controls.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/global.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </script>
        <link type="text/css" rel="stylesheet" >
          <xsl:attribute name="href">
            <xsl:text>index.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate" />
          </xsl:attribute>
        </link>

        <title>Field Research</title>

        <style>
          li {
          margin: 1em 0;
          }
        </style>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Field Research <span class="NOTE TODO">(Beta)</span>
        </h1>
        <div class="INDENT">
          <p>
            When spinning a PokeStop you can get "Field Research" which is a task you perform, that will give you a reward when completed.
            There are a lot of Research tasks, and each task may have a bunch of rewards.
          </p>
          <p>
            Although these charts list all of the possible rewards <span class="NOTE">(as best as I can find)</span>, it will be the most use to help discover which "Encounter" is associated with a Research task.
          </p>
          <p>
            <span class="EMPHASIS">ALSO...</span>
            <br />For Encounters, you can click on the Pokemon to see a CP to IV reference chart.
          </p>
        </div>
        <p class="NOTE TODO">
          <span class="EMPHASIS">NOTE</span>:
          <br />I have been trying to find a reliable source for Rewards.
          I think I have the Encounters correct, but I have no faith in the Items, so I am excluding them for now.
          <br />Please let me know if you find any errors.
        </p>

        <br />
        <hr />
        <xsl:call-template name="CreateKey" />

        <br />
        <hr />
        <xsl:call-template name="CreateCriteria" />

        <br />
        <hr />
        <div id="ByTask" style="display:none;">
          <xsl:apply-templates select="FieldResearch" mode="ByTask" />
        </div>
        <div id="ByReward" style="display:none;">
          <xsl:apply-templates select="FieldResearch" mode="ByReward" />
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

  <!-- Template to write the Key for the table. -->
  <xsl:template name="CreateKey">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'POKEMON_IMAGE_KEY'" />
      </xsl:call-template>
      <xsl:text>Key</xsl:text>
    </h2>
    <br />
    <xsl:call-template name="PokemonImageKey" />
  </xsl:template>

  <!-- #region Templates to write the Criteria. -->
  <xsl:template name="CreateCriteria">
    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="'FIELD_RESEARCH_CRITERIA'" />
      </xsl:call-template>
      <xsl:text>Criteria</xsl:text>
    </h2>
    <br />
    <div id="FIELD_RESEARCH_CRITERIA">
      <div class="FLOWING_TABLE_WRAPPER">
        <table class="CRITERIA_TABLE DIV_HIDDEN QZX" border="1">
          <tr>
            <th colspan="2">
              <xsl:text>Rewards</xsl:text>
              <br />
              <input id="Rewards_All_Check" title="Toggle All" type="checkbox" onchange="OnToggleAllRewards();" />
            </th>
          </tr>
          <tr>
            <td valign="top">
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="$RewardTypeEncounter" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[1]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[2]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[3]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[4]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[5]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[6]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[7]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[8]" />
              </xsl:call-template>
            </td>
            <td valign="top">
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[9]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[10]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[11]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[12]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[13]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[14]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[15]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[16]" />
              </xsl:call-template>
              <br />
              <xsl:call-template name="OutputRewardCheckbox">
                <xsl:with-param name="id" select="exslt:node-set($RewardItems)/Reward[17]" />
              </xsl:call-template>
            </td>
          </tr>
        </table>
      </div>

      <!-- TODO QZX
        <xsl:call-template name="OutputGenerationSelection">
          <xsl:with-param name="Settings">
            <Show hide_slider="true" released_only="true" />
          </xsl:with-param>
          <xsl:with-param name="CallbackName" select="'OnCriteriaChanged'" />
        </xsl:call-template>
        <br />
    -->
      <table border="1" class="CRITERIA_TABLE">
        <tr>
          <td>
            <xsl:call-template name="OutputSliderButtonControl">
              <xsl:with-param name="Id" select="'FieldResearch_Slider_OrderBy'" />
              <xsl:with-param name="Callback" select="'ToggleChart(this)'" />
              <xsl:with-param name="Title" select="'Look up by:'" />
              <xsl:with-param name="OffLabel" select="'Task'" />
              <xsl:with-param name="OnLabel" select="'Reward'" />
              <xsl:with-param name="Help">
                <table style="width:20em;">
                  <tr>
                    <th width="1px;">Task</th>
                    <td>Put the Tasks in the first column, then show all the Rewards for that task.</td>
                  </tr>
                  <tr>
                    <th>Reward</th>
                    <td>Put the potential Rewards in the first column, then show all the Tasks that can give that Reward.</td>
                  </tr>
                </table>
              </xsl:with-param>
            </xsl:call-template>
          </td>
        </tr>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="OutputRewardCheckbox">
    <xsl:param name="id" />
    <xsl:variable name="image" select="/Root/Images/Image[@id=$id]" />
    <input type="checkbox" onchange="OnToggleReward();">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('Reward_', $image/@id)" />
      </xsl:attribute>
    </input>
    <xsl:call-template name="Sprite">
      <xsl:with-param name="id" select="$id" />
      <xsl:with-param name="Settings">
        <Show sprite_class="TAG_ICON_REGULAR" title_pos="after" />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- #endregion Templates to write the Selection/ListBy Criteria. -->

  <!-- #region Templates to output the tables by Task -->
  <xsl:template match="FieldResearch" mode="ByTask">
    <xsl:for-each select="Category[not(contains(@type, '?'))]">
      <h2>
        <xsl:call-template name="Collapser">
          <xsl:with-param name="CollapseeID" select="concat('CATEGORY_', @type)" />
        </xsl:call-template>
        <xsl:value-of select="@type" />
      </h2>
      <div style="margin-top:.5em;">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('CATEGORY_', @type)" />
        </xsl:attribute>
        <table border="1">
          <tr>
            <th>Task</th>
            <th>Encounters</th>
            <!-- TODO QZX: Omit Items until I can get a reliable source.
            <th>Items</th>
-->
          </tr>
          <!-- TODO QZX: Omit Items until I can get a reliable source.
          <xsl:apply-templates select="Research[*]" mode="ByTask" />
          -->
          <xsl:apply-templates select="Research[Encounter]" mode="ByTask" />
        </table>
      </div>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="Research" mode="ByTask">
    <tr>
      <td>
        <xsl:value-of select="@task" disable-output-escaping="yes" />
      </td>
      <td style="white-space:nowrap">
        <xsl:choose>
          <xsl:when test="count(Encounter)=0">
            <xsl:attribute name="class">UNUSED</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="Encounter" />
          </xsl:otherwise>
        </xsl:choose>
      </td>
      <!-- TODO QZX: Omit Items until I can get a reliable source.
      <td style="white-space:nowrap">
        <xsl:choose>
          <xsl:when test="count(Item)=0">
            <xsl:attribute name="class">UNUSED</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="Item" />
          </xsl:otherwise>
        </xsl:choose>
      </td>
      -->
    </tr>
  </xsl:template>

  <xsl:template match="Encounter">
    <xsl:variable name="name" select="@name" />
    <div style="display:inline-block; border:1px solid black; margin:4px">
      <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name = $name and not(@form)]">
        <xsl:with-param name="Settings">
          <Show hide_type_icons="true" hide_special_icons="true">
            <xsl:attribute name="href">
              <xsl:value-of select="concat('encounter.', pokeref:ToLower($name), '.html')" />
            </xsl:attribute>
          </Show>
        </xsl:with-param>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <xsl:template match="Item">
    <div style="display:inline-block; text-align:center; margin:4px;">
      <xsl:call-template name="Sprite">
        <xsl:with-param name="id" select="@id" />
        <xsl:with-param name="Settings">
          <Show max_width="2.5em" />
        </xsl:with-param>
      </xsl:call-template>
      <br />
      <xsl:value-of select="concat('x', @amount)" disable-output-escaping="yes" />
    </div>
  </xsl:template>
  <!-- #endregion Templates to output the tables by Task -->

  <!-- #region Templates to output the tables by Reward -->
  <xsl:template match="FieldResearch" mode="ByReward">
    <xsl:call-template name="RewardSection">
      <xsl:with-param name="research" select="Category/Research[Encounter]" />
      <xsl:with-param name="rewardType" select="$RewardTypeEncounter" />
    </xsl:call-template>

    <!-- TODO QZX: Omit Items until I can get a reliable source.
    <xsl:call-template name="RewardSection">
      <xsl:with-param name="research" select="Category/Research[Item]" />
      <xsl:with-param name="rewardType" select="$RewardTypeItem" />
    </xsl:call-template>
    -->
  </xsl:template>

  <xsl:template name="RewardSection">
    <xsl:param name="research" />
    <xsl:param name="rewardType" />

    <h2>
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="concat('SECTION_', $rewardType)" />
      </xsl:call-template>
      <xsl:value-of select="$rewardType" />
    </h2>
    <div style="margin-top:.5em;">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('SECTION_', $rewardType)" />
      </xsl:attribute>
      <table border="1">
        <xsl:choose>
          <xsl:when test="$rewardType=$RewardTypeEncounter">
            <xsl:call-template name="ResearchByEncounter">
              <xsl:with-param name="research" select="$research" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="ResearchByItem">
              <xsl:with-param name="research" select="$research" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="ResearchByEncounter">
    <xsl:param name="id" select="1" />
    <xsl:param name="research" />

    <xsl:if test="1000 > $id">
      <xsl:if test="count($research/Encounter[@id=$id]) > 0">
        <xsl:variable name="name" select="($research/Encounter[@id=$id]/@name)[1]" />
        <tr>
          <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name=$name and not(@form)]" mode="Cell">
            <xsl:with-param name="Settings">
              <Show hide_type_icons="true" hide_special_icons="true">
                <xsl:attribute name="href">
                  <xsl:value-of select="concat('encounter.', pokeref:ToLower($name), '.html')" />
                </xsl:attribute>
              </Show>
            </xsl:with-param>
          </xsl:apply-templates>
          <td>
            <xsl:for-each select="$research[Encounter/@id=$id]">
              <xsl:value-of select="@task" disable-output-escaping="yes" />

              <xsl:variable name="task" select="@task" />
              <xsl:variable name="count" select="count($research[@task=$task]/Encounter)" />
              <xsl:if test="$count != 1">
                <span class="EMPHASIS">
                  <xsl:value-of select="concat($nbsp, '(1', $nbsp, 'of', $nbsp, $count, $nbsp, 'possibilities)')" disable-output-escaping="yes" />
                </span>
              </xsl:if>
              <br />
            </xsl:for-each>
          </td>
        </tr>
      </xsl:if>
      <xsl:call-template name="ResearchByEncounter">
        <xsl:with-param name="id" select="$id+1" />
        <xsl:with-param name="research" select="$research" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="ResearchByItem">
    <xsl:param name="index" select="1" />
    <xsl:param name="research" />

    <xsl:if test="count(exslt:node-set($RewardItems)/*) >= $index">
      <xsl:variable name="id" select="exslt:node-set($RewardItems)/*[$index]" />
      <xsl:if test="count($research/Item[@id=$id]) > 0">
        <tr>
          <td>
            <xsl:call-template name="Sprite">
              <xsl:with-param name="id" select="$id" />
              <xsl:with-param name="Settings">
                <Show max_width="5em" />
              </xsl:with-param>
            </xsl:call-template>
          </td>
          <td>
            <xsl:for-each select="$research/Item[@id=$id]">
              <span class="EMPHASIS">
                <xsl:value-of select="concat('(Qty:', $nbsp, @amount, ')')" disable-output-escaping="yes" />
              </span>
              <xsl:value-of select="$nbsp" disable-output-escaping="yes" />
              <xsl:value-of select="../@task" disable-output-escaping="yes" />
              <br />
            </xsl:for-each>
          </td>
        </tr>
      </xsl:if>
      <xsl:call-template name="ResearchByItem">
        <xsl:with-param name="index" select="$index+1" />
        <xsl:with-param name="research" select="$research" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- #endregion Templates to output the tables by Reward -->
</xsl:stylesheet>
