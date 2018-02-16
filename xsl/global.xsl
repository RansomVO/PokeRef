<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="settings.xsl" />
  <xsl:include href="controls.xsl" />
  <xsl:include href="pokemon.xsl" />

  <!-- ************************************************************************************************************************ -->
  <!-- #region Global variables -->
  <!-- ************************************************************************************************************************ -->
  <xsl:variable name="CurrentDate" select="pokeref:CurrentDate()"/>

  <!-- Constants (Needed because XSL doesn't like them raw in select statements, etc.)-->
  <xsl:variable name="quot">"</xsl:variable>
  <xsl:variable name="apos">'</xsl:variable>

  <!-- ===================================================== -->
  <!-- Must use disable-output-escaping="yes" with the rest. -->
  <!-- ===================================================== -->
  <!-- Need these because xml/xsl/html throws a total fit if you try to include '<' inside a string. -->
  <xsl:variable name="lt">&#x003C;</xsl:variable>
  <xsl:variable name="gt">&#x003E;</xsl:variable>

  <!-- Need these because they are commonly used chars but not recognized by XSLT processor. -->
  <xsl:variable name="nbsp">&amp;nbsp;</xsl:variable>
  <xsl:variable name="times">&amp;times;</xsl:variable>
  <xsl:variable name="dagger">&amp;dagger;</xsl:variable>

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