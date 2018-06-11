<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:sitemap="http://schemas.microsoft.com/AspNet/SiteMap-File-1.0"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html lang="en-us" manifest="/pokeref.appcache">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/controls.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/global.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <link type="text/css" rel="stylesheet" >
          <xsl:attribute name="href">
            <xsl:text>local.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </link>

        <style>
          li {
          margin-top: .5em;
          }
        </style>

        <title>PokeRef Site Map</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          <xsl:text> PokeRef Site Map</xsl:text>
        </h1>
        <p>
          Sometimes you just can't figure out where the page you need is.
          This page has links to everything.
          <br /><span class="NOTE">(It will also give you a good idea of the organization.)</span>
        </p>

        <xsl:apply-templates select="sitemap:siteMap" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="sitemap:siteMap">
    <div style="font-size:1.5em;">
      <xsl:apply-templates select="sitemap:siteMapNode" />
    </div>
  </xsl:template>

  <xsl:template match="sitemap:siteMapNode">
    <xsl:param name="level" select="1" />
    
    <xsl:if test="count(sitemap:siteMapNode[contains(@url, '#')]) != 0 or count(sitemap:siteMapNode[not(contains(@url, '#'))]) != 0">
      <xsl:call-template name="Collapser">
        <xsl:with-param name="CollapseeID" select="@url" />
      </xsl:call-template>
    </xsl:if>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@url" />
      </xsl:attribute>
      <b>
        <xsl:value-of select="@title" />
      </b>
    </a>
    <div class="CHILD">
      <xsl:attribute name="id">
        <xsl:value-of select="@url"/>
      </xsl:attribute>
      <xsl:if test="@description != '' and @description != 'Home Page'">
        <span class="CHILD" style="font-size:medium">
          <xsl:value-of select="@description" />
        </span>
      </xsl:if>
      <xsl:if test="count(sitemap:siteMapNode[contains(@url, '#')]) != 0">
        <br />
        <div class="INDENT" style="font-size:smaller;">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="concat(@url, '_ANCHORS')" />
          </xsl:call-template>
          <span class="SITE_MAP_SECTION">Anchors On Page</span>
          <ul>
            <xsl:attribute name="id">
              <xsl:value-of select="concat(@url, '_ANCHORS')"/>
            </xsl:attribute>

            <xsl:apply-templates select="sitemap:siteMapNode[contains(@url, '#')]" mode="child">
              <xsl:with-param name="level" select="$level + 1" />
            </xsl:apply-templates>
          </ul>
        </div>
      </xsl:if>
      <xsl:if test="count(sitemap:siteMapNode[not(contains(@url, '#'))]) != 0">
        <br />
        <div class="INDENT" style="font-size:smaller;">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="concat(@url, '_SUBPAGE')" />
          </xsl:call-template>
          <span class="SITE_MAP_SECTION">Sub Pages</span>
          <ul>
            <xsl:attribute name="id">
              <xsl:value-of select="concat(@url, '_SUBPAGE')" />
            </xsl:attribute>

            <xsl:apply-templates select="sitemap:siteMapNode[not(contains(@url, '#'))]" mode="child">
              <xsl:with-param name="level" select="$level + 1" />
            </xsl:apply-templates>
          </ul>
        </div>
      </xsl:if>
    </div>

  </xsl:template>

  <xsl:template match="sitemap:siteMapNode" mode="child">
    <xsl:param name="level" select="1" />
    <li>
      <xsl:apply-templates select="." />
    </li>
  </xsl:template>

</xsl:stylesheet>