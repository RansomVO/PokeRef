<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="constants.xsl" />
  <xsl:include href="settings.xsl" />
  <xsl:include href="controls.xsl" />
  <xsl:include href="pokemon.xsl" />

  <!-- ************************************************************************************************************************ -->
  <!-- #region Global variables -->
  <!-- ************************************************************************************************************************ -->
  <xsl:variable name="CurrentDate" select="pokeref:CurrentDate()" />

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region Global templates -->
  <!-- ************************************************************************************************************************ -->

  <xsl:template name="AddHtmlHeader">
    <META http-equiv="Content-Type" http-content="text/html; charset=utf-8" />

    <!-- This is to make the font size consistent on mobile. -->
    <META name="viewport" content="width=device-width, initial-scale=1" />

    <!-- These tell the android to use the image for shortcut icons. (It's automatic for Apple.) -->
    <LINK rel="apple-touch-icon" href="/apple-touch-icon.png" />
    <LINK rel="apple-touch-icon-precomposed" href="/apple-touch-icon.png" />
  </xsl:template>

  <xsl:template name="HomePageLink">
    <a href="/" title="Go To PokeRef Home Page" style="text-decoration:none;">
      <xsl:call-template name="Logo" />
    </a>
  </xsl:template>

  <xsl:template name="Logo">
    <img src="/apple-touch-icon.png" width="64" />
  </xsl:template>

  <!--
    Settings parameter:
      @title_pos
          Where to position the title. (Default is to not show.)
          before: 
          after:
          above:
          below:
      @sprite_class
          Class(es) to apply to the Sprite.
      @sprite_width
          The width of the Sprite.
      @sprite_height
          The height of the Sprite.
  -->

  <xsl:template name="Sprite">
    <xsl:param name="id" />
    <xsl:param name="Settings" />

    <xsl:variable name="image" select="/Root/Images/Image[@id=$id]" />

    <xsl:choose>
      <xsl:when test="count($image)=0">
        <span class="TODO">
          <span class="SIGNIFICANT EMPHASIS">
            !!!<br />Unknown<br />Image<br />ID<br />!!!
          </span>
          <br />
          <xsl:value-of select="concat($quot, $id, $quot)" />
          <!--<xsl:value-of select="concat('alert(', $apos, 'Specified Image not found: ', $quot, $id, $quot, '!!!', $apos, ')')" />-->
        </span>
      </xsl:when>
      <xsl:otherwise>
        <div>
          <xsl:attribute name="style">
            <xsl:text>display:inline-block;</xsl:text>
            <xsl:if test="exslt:node-set($Settings)/*/@title_pos = 'above' or exslt:node-set($Settings)/*/@title_pos = 'below'"> text-align:center;</xsl:if>
            <xsl:if test="exslt:node-set($Settings)/*/@title_pos = 'before' or exslt:node-set($Settings)/*/@title_pos = 'after'"> vertical-align:middle;</xsl:if>
          </xsl:attribute>

          <xsl:if test="exslt:node-set($Settings)/*/@title_pos = 'before' or exslt:node-set($Settings)/*/@title_pos = 'above'">
            <xsl:value-of select="$image/@title" />
            <xsl:if test="exslt:node-set($Settings)/*/@title_pos = 'above'">
              <br />
            </xsl:if>
          </xsl:if>

          <xsl:call-template name="SpriteImage">
            <xsl:with-param name="id" select="$id" />
            <xsl:with-param name="Settings" select="$Settings" />
          </xsl:call-template>

          <xsl:if test="exslt:node-set($Settings)/*/@title_pos = 'below' or exslt:node-set($Settings)/*/@title_pos = 'after'">
            <xsl:if test="exslt:node-set($Settings)/*/@title_pos = 'below'">
              <br />
            </xsl:if>
            <xsl:value-of select="$image/@title" />
          </xsl:if>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="SpriteImage">
    <xsl:param name="id" />
    <xsl:param name="Settings" />
    
    <xsl:variable name="image" select="/Root/Images/Image[@id=$id]" />

    <img class="SPRITE">
      <xsl:attribute name="src">
        <xsl:value-of select="$image/@src" />
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:value-of select="$image/@title" disable-output-escaping="yes" />
      </xsl:attribute>
      <xsl:attribute name="style">
        <xsl:if test="exslt:node-set($Settings)/*/@max_width" >
          <xsl:value-of select="concat('max-width:', exslt:node-set($Settings)/*/@max_width, ';')" />
        </xsl:if>
        <xsl:if test="exslt:node-set($Settings)/*/@max_height" >
          <xsl:value-of select="concat('max-height:', exslt:node-set($Settings)/*/@max_height, ';')" />
        </xsl:if>
      </xsl:attribute>
      <xsl:if test="exslt:node-set($Settings)/*/@sprite_class" >
        <xsl:attribute name="class">
          <xsl:value-of select="exslt:node-set($Settings)/*/@sprite_class" />
        </xsl:attribute>
      </xsl:if>
    </img>
  </xsl:template>

  <xsl:template name="WriteContactInfo">
    <span class="NOTE CHILD">
      Just send me an e-mail at <a href="mailto:pokeeref@gmail.com">pokeeref@gmail.com</a> (The extra 'e' is not a typo. pokeref@gmail.com was already taken. <xsl:value-of select="$smiley" disable-output-escaping="yes" />)
    </span>
  </xsl:template>

  <xsl:template name="WriteFeedbackNote">
    <div class="NOTE">
      I would <span class="EMPHASIS">
        <u>LOVE</u>
      </span> to get your feedback!
      <br />
      <div class="INDENT">
        Let me know about typos, broken links, hard-to-understand (or badly worded) information, etc.
        <br />Also, let me know if there is something you would like for me to add or enhance.
      </div>
    </div>
    <xsl:call-template name="WriteContactInfo" />
  </xsl:template>

  <xsl:template name="WriteFooter">
    <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
    <script>WriteFooter();</script>
    <xsl:call-template name="WriteFeedbackNote" />
    <br />
    <br />
    <br />
  </xsl:template>
  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region pokeref methods  (C#) -->
  <!-- ************************************************************************************************************************ -->

  <msxsl:script language="C#" implements-prefix="pokeref">
    <![CDATA[  
       public string CurrentDate() 
       {  
         return DateTime.Now.ToString("yyyy-MM-dd");
       }  

      public string Replace(string text, string oldValue, string newValue)
      {  
        return text.Replace(oldValue, newValue);
      }
      
      public string FixURLTarget(string text)
      {
        text = text.Replace(' ', '_');
        foreach (char bad in "<>:\"/\\|?*;@&=+$,{}^[]`'")
          text = text.Replace(bad.ToString(), string.Empty);
        
        return text;
      }

      public string ToLower(string text)
      {  
        return text.ToLower();
      }  

      public string ToUpper(string text)
      {  
        return text.ToUpper();
      }  
      
      public bool Contains(string text, string search) 
      {  
        return text.Contains(search);
      }  
    ]]>

  </msxsl:script>

  <!-- #endregion -->

  <!-- ************************************************************************************************************************ -->
  <!-- #region DEBUGGING TEMPLATES -->
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

  <!-- #endregion -->

</xsl:stylesheet>