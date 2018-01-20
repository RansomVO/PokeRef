﻿<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="settings.xsl"/>

  <!-- ************************************************************************************************************************ -->
  <!-- Global variables -->
  <!-- ************************************************************************************************************************ -->

  <!-- Variable that tells how many generations of Pokemon have been released. -->
  <xsl:variable name="Gens" select="3" />

  <!-- Constants -->
  <xsl:variable name="nbsp">
    <xsl:text>&#xA0;</xsl:text>
  </xsl:variable>
  <xsl:variable name="lt">
    <xsl:text>&#x3C;</xsl:text>
  </xsl:variable>
  <xsl:variable name="gt">
    <xsl:text>&#x3E;</xsl:text>
  </xsl:variable>


  <!-- ************************************************************************************************************************ -->
  <!-- Templates to output Pokemon image -->
  <!-- ************************************************************************************************************************ -->

  <!-- Template to Output a Pokemon. -->
  <xsl:template match="Pokemon">
    <xsl:param name="Settings" />
    <xsl:param name="Header" />
    <xsl:param name="Footer" />

    <div>
      <xsl:attribute name="class">
        <xsl:text>SPRITE_FILLER </xsl:text>
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
      <xsl:attribute name="title">
        <xsl:value-of select="Name" />
      </xsl:attribute>

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
          <xsl:copy-of select="$Header"/>
          <br />
        </xsl:if>

        <xsl:apply-templates select="." mode="Sprite">
          <xsl:with-param name="Settings" select="$Settings" />
        </xsl:apply-templates>

        <!-- Add Type Icons here. -->
        <xsl:if test="count(exslt:node-set($Settings)/*/@hide_icons) = 0">
          <br />
          <xsl:apply-templates select="Type" mode="icons" />
        </xsl:if>

        <xsl:if test="count(exslt:node-set($Settings)/*/@hide_name) = 0">
          <br />
          <xsl:value-of select="ID"/>
          <xsl:text>&#xA0;-&#xA0;</xsl:text>
          <xsl:value-of select="Name"/>
        </xsl:if>

        <xsl:if test="$Footer != ''">
          <br />
          <xsl:copy-of select="$Footer"/>
        </xsl:if>
      </div>
    </div>
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
          <xsl:when test="../Generation/ID &lt;= $Gens">
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

            <xsl:variable name="apos">'</xsl:variable>
            <xsl:value-of select="translate(Name, concat('ABCDEFGHIJKLMNOPQRSTUVWXYZ é:♀♂.',$apos), 'abcdefghijklmnopqrstuvwxyz-e')" />

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
        <xsl:text>(Missing Image For </xsl:text>
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

    <img style="width:.5em;" src="/images/blank.png" />

    <xsl:call-template name="OutputBoostIcon">
      <xsl:with-param name="Type" select="Primary" />
    </xsl:call-template>
    <xsl:call-template name="OutputBoostIcon">
      <xsl:with-param name="Type" select="Secondary" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="OutputTypeIcon">
    <xsl:param name="Type" />

    <xsl:if test="$Type != ''">
      <img style="width:1em;">
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

  <xsl:template name="OutputBoostIcon">
    <xsl:param name="Type" />

    <xsl:if test="$Type != ''">
      <xsl:variable name="Weather" select="/Root/Mappings/WeatherBoosts[Type=$Type]/Weather" />
      <img style="width:1em;">
        <xsl:attribute name="src">
          <xsl:text>/images/weather_</xsl:text>
          <xsl:value-of select="pokeref:ToLower(pokeref:Replace($Weather, ' ', ''))" />
          <xsl:text>.png</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="title">
          <xsl:value-of select="$Weather" />
        </xsl:attribute>
      </img>
    </xsl:if>
  </xsl:template>

  <!-- ************************************************************************************************************************ -->
  <!-- pokeref methods  (C#) -->
  <!-- ************************************************************************************************************************ -->

  <msxsl:script language="C#" implements-prefix="pokeref">
    <![CDATA[  
      public string Replace(string text, string oldValue, string newValue)
      {  
        return text.Replace(oldValue, newValue);
      }  

      public string ToLower(string text)
      {  
        return text.ToLower();
      }  

      public string ToUpper(string text)
      {  
        return text.ToUpper();
      }  
    ]]>

  </msxsl:script>


  <!-- ************************************************************************************************************************ -->
  <!-- DEBUGGING TEMPLATES -->
  <!-- ************************************************************************************************************************ -->

  <!-- Templates to output the contents of Node(s). -->
  <xsl:template name="DebugNode">
    <xsl:param name="Node" />

    <table border="1">
      <xsl:call-template name="DebugNodeFill">
        <xsl:with-param name="Node" select="$Node" />
      </xsl:call-template>
    </table>
  </xsl:template>
  <xsl:template name="DebugNodeFill">
    <tr>
      <td>
        <xsl:value-of select="name(.)" />
      </td>
      <td>
        <xsl:value-of select="count(.)" />
      </td>
    </tr>

    <xsl:if test="count(.) > 0">
      <xsl:for-each select="*">
        <xsl:call-template name="DebugNodeFill">
          <xsl:with-param name="Node" select="." />
        </xsl:call-template>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>