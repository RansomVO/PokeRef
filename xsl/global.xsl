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
  <xsl:variable name="CurrentDate" select="pokeref:CurrentDate()"/>

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

  <xsl:template name="Sprite">
    <xsl:param name="id" />
    <xsl:param name="width" />
    <xsl:param name="height" />
    <xsl:param name="class" />

    <xsl:variable name="image" select="/Root/Images/Image[@id=$id]"/>
    <xsl:choose>
      <xsl:when test="count($image)=0">
        <span class="TODO">
          <span class="SIGNIFICANT EMPHASIS">
            !!!<br />Unknown<br />Image<br />ID<br />!!!
          </span>
          <br />
          <xsl:value-of select="concat($quot, $id, $quot)" />
          <script>
            alert('Specified Image not found: ' + <xsl:value-of select="concat('*', $id, '*')" /> + '!!!')
          </script>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <img class="SPRITE">
          <xsl:attribute name="src">
            <xsl:value-of select="$image/@src" />
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:value-of select="$image/@title" disable-output-escaping="yes" />
          </xsl:attribute>
          <xsl:attribute name="style">
            <xsl:if test="$width" >
              <xsl:value-of select="concat('max-width:', $width, ';')" />
            </xsl:if>
            <xsl:if test="$height" >
              <xsl:value-of select="concat('max-height:', $height, ';')" />
            </xsl:if>
          </xsl:attribute>
          <xsl:if test="$class" >
            <xsl:attribute name="class">
              <xsl:value-of select="$class" />
            </xsl:attribute>
          </xsl:if>
        </img>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="WriteContactInfo">
    <span class="NOTE CHILD">
      Just send me an e-mail at <a href="mailto:pokeeref@gmail.com">pokeeref@gmail.com</a> (The extra 'e' is not a typo. pokeref@gmail.com was already taken. &#x1F601;)
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
         return DateTime.Now.ToString("yyyy-MM-dd_HH:mm:ss");;
       }  

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