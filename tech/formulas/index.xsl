<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl" />

  <xsl:template match="/Root">
    <html>
      <head>
        <!-- Adds the general META and LINK statements. -->
        <xsl:call-template name="AddHtmlHeader" />

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

        <title>Technical Formulas</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Technical Formulas
        </h1>
        <div class="INDENT">
          <p>
            Behind the scenes, Pokemon GO does a <span class="SIGNIFICANT EMPHASIS">LOT</span> of math.
            Being very geeky, I decided to get into what the formulas were for a lot of stuff.
            A large amount of the data on this site is calculated using these formulas.
          </p>
          <p>
            I have included them here in case you are geeky too.
          </p>
        </div>

        <hr />
        <h2 id="anchor_cphpformulas">
          <a href="cphp.html">
            <b>CP and HP Formulas</b>
          </a>
        </h2>
        <div class="INDENT">
          <p>
            Pokemon have scores called "CP" and "HP".
            But what do they mean?
            <br />This page tells you about them and shows the formulas used to calculate them.
          </p>
        </div>

        <h2 id="anchor_movesetformulas">
          <a href="movesetdamage.html">
            <b>Move Set Damage Formulas</b>
          </a>
        </h2>
        <div class="INDENT">
          <p>
            Want to know how to figure out the DPS for a Pokemon's Move Set?
            <br />This page goes into detail of describing the formulas used to figure that out.
          </p>
        </div>

        <h2 id="anchor_cpm">
          <a href="cpm.html">
            <b>CP Modifiers</b>
          </a>
        </h2>
        <div class="INDENT">
          <p>
            When calculating how much damage a Pokemon will do, Pokemon GO takes into account the Level of the Pokemon.
            It does this by multiplying the Pokemon's BaseAttack and Attack IV by a constant corresponding to the Pokemon's level.
            <br />This page lists the CPM values.
          </p>
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
