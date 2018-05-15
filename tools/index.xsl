<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:exslt="http://exslt.org/common"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:pokeref="urn:pokeref"
>
  <xsl:output method="html" encoding="utf-8" omit-xml-declaration="yes" standalone="no" indent="yes" />
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html lang="en-us">
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

        <script src="/js/global.js?cacherefresh={$CurrentDate}"></script>
        <link type="text/css" rel="stylesheet" href="index.css?cacherefresh={$CurrentDate}" />

        <title>Tools</title>
      </head>
      <body>
        <img class="FLOAT_RIGHT" style="margin:1em; max-height:100%; max-width:45%;" src="/images/humor/TrappedWeedle.png" />
        <h1>
          <xsl:call-template name="HomePageLink" />
          Tools
        </h1>
        <p>
          Sometimes I want to figure out something that is specific to me.
          As such, I have created some tools where you can specify you own input and get what you want.
        </p>

        <br />
        <hr />
        <h2 id="anchor_shoppingboxes">
          <a href="shoppingboxes.html">Shopping Box Values</a>
        </h2>
        <div class="INDENT">
          <p>
            When there are Events in
            Pokemon GO, they usually have some sort of special package deals in the Shop.
            Ever wonder how much one of those boxes is worth <span class="EMPHASIS">to you</span>?
            <br />
            Use this tool to find out.
          </p>
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
