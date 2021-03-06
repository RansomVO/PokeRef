﻿<xsl:stylesheet version="1.0"
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

        <title>Pokemon Resources</title>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon Resources
        </h1>
        <p>
          There are a lot of web sites, chat groups, reference data, etc. that provide a lot of resources.
          Here are a bunch of places that you might find useful.
        </p>

        <xsl:call-template name="WriteFeedbackNote" />

        <br />
        <hr />
        <h2 id="anchor_tips">
          <a href="tips.html">Pokemon GO Tips</a>
        </h2>
        <div class="INDENT">
          <p>
            There are a lot of secrets that Niantic doesn't document, but have been found and shared by other trainers.
            <br />This page outlines a selection of those secrets.
          </p>
        </div>

        <br />
        <hr />
        <h2 id="anchor_websites">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'WEB_SITES'" />
          </xsl:call-template>
          <xsl:text>Web Sites</xsl:text>
        </h2>
        <div id="WEB_SITES" class="INDENT">
          <p>
            There are a number of web sites out there that are geared for Pokemon GO trainers.
            <br />
            They are quite varied.
            Some are very basic. Some are extremely technical. And there are a bunch in between.
          </p>
          <p>
            This section provides links to the sites I value most.
          </p>

          <h3>Niantic</h3>
          <div class="INDENT">
            <p>
              Niantic is the maker of Pokemon GO.
              <br />They have a bunch of Official sites for Pokemon GO, as well as some general sites that include other work they do.
            </p>
            <ul>
              <li>
                <b>Pokemon GO Home Page</b>:<div class="INDENT_SMALL">
                  <a href="http://pokemongolive.com/">http://pokemongolive.com/</a>
                </div>
              </li>
              <li>
                <b>&quot;Updates&quot;</b> <span class="NOTE">(A list of links to announcements)</span>:<div class="INDENT_SMALL">
                  <a href="http://pokemongolive.com/en/post/">http://pokemongolive.com/en/post/</a>
                </div>
              </li>
              <li>
                <b>Pokemon GO Support Page</b>:<div class="INDENT_SMALL">
                  <a href="https://support.pokemongo.nianticlabs.com/hc/en-us">https://support.pokemongo.nianticlabs.com/hc/en-us</a>
                </div>
                <ul>
                  <li>
                    <b>Known Issues</b>:<div class="INDENT_SMALL">
                      <a href="https://support.pokemongo.nianticlabs.com/hc/en-us/articles/221958208-Known-Issues">https://support.pokemongo.nianticlabs.com/hc/en-us/articles/221958208-Known-Issues</a>
                    </div>
                  </li>
                  <li>
                    <b>Report a Bug</b>:<div class="INDENT_SMALL">
                      <a href="https://support.pokemongo.nianticlabs.com/hc/articles/229616327">https://support.pokemongo.nianticlabs.com/hc/articles/229616327</a>
                    </div>
                  </li>
                  <li>
                    <b>Submit a Request</b>:<div class="INDENT_SMALL">
                      <a href="https://support.pokemongo.nianticlabs.com/hc/articles/115008306667">https://support.pokemongo.nianticlabs.com/hc/articles/115008306667</a>
                    </div>
                  </li>
                </ul>
              </li>
              <li>
                <b>Niantic Home Page</b>:<br /><div class="INDENT_SMALL">
                  <a href="https://www.nianticlabs.com/">https://www.nianticlabs.com/</a>
                </div>
                <ul>
                  <li>
                    <b>Niantic Blog</b>:<div class="INDENT_SMALL">
                      <a href="https://nianticlabs.com/blog">https://nianticlabs.com/blog</a>
                    </div>
                  </li>
                </ul>
              </li>
              <li>
                <b>Niantic Support on Twitter</b>:<div class="INDENT_SMALL">
                  <a href="https://twitter.com/NianticHelp">https://twitter.com/NianticHelp</a>
                </div>
              </li>
            </ul>
          </div>

          <br />
          <h3 class="PARENT">Sylph Road</h3>
          <div class="INDENT CHILD">
            <p>
              Sylph Road is a group that analyzes what is going on in with Pokemon GO and tries to share the knowledge.
              <br />They have some technical stuff, but they also have a lot of tools and information that is helpful to even amateur trainers.
            </p>
            <ul>
              <li>
                <b>Web Site</b>:<div class="INDENT_SMALL">
                  <a href="https://thesilphroad.com/">https://thesilphroad.com/</a>
                </div>
                <ul>
                  <li>
                    <b>Nest Atlas</b>:<div class="INDENT_SMALL">
                      <a href="https://thesilphroad.com/atlas">https://thesilphroad.com/atlas</a>
                    </div>
                  </li>
                </ul>
              </li>
              <li>
                <b>Reddit</b>:<div class="INDENT_SMALL">
                  <a href="https://www.reddit.com/r/TheSilphRoad/">https://www.reddit.com/r/TheSilphRoad/</a>
                </div>
              </li>
              <li>
                <b>Twitter</b>:<div class="INDENT_SMALL">
                  <a href="https://twitter.com/TheSilphRoad">https://twitter.com/TheSilphRoad</a>
                </div>
              </li>
            </ul>
          </div>

          <br />
          <h3 class="PARENT">APK Mirror</h3>
          <div class="INDENT CHILD">
            <p>
              APK Mirror is a site that keeps the installation files for many Android apps.
              <br />In general, when Niantic announces a release, it is available here before it is in the Google Play Store.
            </p>
            <ul>
              <li>
                <b>Pokemon Releases</b>:<div class="INDENT_SMALL">
                  <a href="https://www.apkmirror.com/apk/niantic-inc/pokemon-go/">https://www.apkmirror.com/apk/niantic-inc/pokemon-go/</a>
                </div>
              </li>
            </ul>
            <p class="NOTE PARENT">
              <b>NOTE</b>: When you attempt to install APKs you have downloaded, Android requires you to specifically enable the ability to install "apps obtained from unknown sources".
              <br />All you have to do is:
            </p>
            <ol class="NOTE CHILD">
              <li>If the download doesn't attempt to install automatically, go to your download folder in My Files and click on the APK.</li>
              <li>A security dialog should be displayed. Click on the Settings button.</li>
              <li>On the LOCK SCREEN AND SECURITY settings screen, find the "Unknown sources" setting and type on it</li>
              <li>On the Unknown sources dialog, leave "Allow this installation only" turned on and click OK</li>
              <li>Proceed with the installation.</li>
            </ol>
          </div>

          <br />
          <h3 class="PARENT">Social Groups</h3>
          <div class="INDENT CHILD">
            <p>
              There are a lot of Social Groups out there that are constantly talking about the latest issues.
              <br />These are some of the best.
            </p>
            <b>
              <u>Twitter</u>
            </b>
            <ul>
              <li>
                <b>Pokemon GO News</b>:<div class="INDENT_SMALL">
                  <a href="https://twitter.com/PokemonGoNews">https://twitter.com/PokemonGoNews</a>
                </div>
              </li>
              <li>
                <b>The Sylph Road</b>:<div class="INDENT_SMALL">
                  <a href="https://twitter.com/TheSilphRoad">https://twitter.com/TheSilphRoad</a>
                </div>
              </li>
              <li>
                <b>Niantic</b>:<div class="INDENT_SMALL">
                  <a href="https://twitter.com/NianticLabs">https://twitter.com/NianticLabs</a>
                </div>
              </li>
              <li>
                <b>Niantic Support</b>:<div class="INDENT_SMALL">
                  <a href="https://twitter.com/NianticHelp">https://twitter.com/NianticHelp</a>
                </div>
              </li>
            </ul>

            <b>
              <u>Facebook</u>
            </b>
            <ul>
              <li>
                <b>Official Pokemon GO Page</b>:<div class="INDENT_SMALL">
                  <a href="https://www.facebook.com/PokemonGO/">https://www.facebook.com/PokemonGO/</a>
                </div>
              </li>
            </ul>
          </div>
        </div>

        <br />
        <hr />
        <h2 id="anchor_tools_android">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'ANDROID_TOOLS'" />
          </xsl:call-template>
          <xsl:text>Tools for Android</xsl:text>
        </h2>
        <div id="ANDROID_TOOLS" class="INDENT">
          <p>
            There are a number of tools available for use while playing Pokemon GO.
            <br />Here are some I use.
          </p>
          <p class="NOTE">
            <b>NOTE</b>: Some tools violate the Pokemon GO terms and using them is a good way to get yourself banned.
            These include tools for spoofing your location, or tools that log in as you to access your account.
            <br />I am totally against using any tools of that nature.
            <br />As far as I know, the ones listed here do not violate the terms.
          </p>
          <h3 id="anchor_goiv">
            <xsl:call-template name="Collapser">
              <xsl:with-param name="CollapseeID" select="'GOIV_TOOL'" />
            </xsl:call-template>
            <xsl:text>GoIV</xsl:text>
          </h3>
          <div id="GOIV_TOOL" class="INDENT" style="max-width:600px;">
            <p>
              GoIV is a tool for determining the IV score of your Pokemon.
              <br />The thing I like most about it is that it does screen scraping to get what it needs.
              Here's how it works:
            </p>
            <img class="FLOAT_LEFT IMAGE_HALF_WIDTH" src="/images/GoIV-Start.png" />
            <p>
              Go to your box, and select your Pokemon.
              Then, a button shows up on your screen.
            </p>
            <br class="FLOAT_END" />
            <br />
            <img class="FLOAT_RIGHT IMAGE_HALF_WIDTH" src="/images/GoIV-PrelimResult.png" />
            <p>
              It then shows you the possibilities by screen-scraping CP, HP and Level.
            </p>
            <br class="FLOAT_END" />
            <br />
            <img class="FLOAT_LEFT IMAGE_HALF_WIDTH" src="/images/GoIV-Refining.png" />
            <p>
              When you select the button, it pops up a dialog to allow you to refine the results.
              <br />At that point, you select appraisal and GoIV screen-scrapes what the team leader says and fills in the boxes for you.
            </p>
            <br class="FLOAT_END" />
            <br />
            <img class="FLOAT_RIGHT IMAGE_HALF_WIDTH" src="/images/GoIV-FinalResult.png" />
            <p>
              In the end, you get a full description of what it found out.
              <div class="NOTE">
                <b>NOTE</b>: Sometimes it can't narrow down the results to a single possibility.
                In that case it will show you the range, and you have to ability to see a list of all of the possibilities.
              </div>
            </p>
            <br class="FLOAT_END" />
            <p>
              And you can set it to copy what it discovered to the clipboard so you can easily paste it to the name.
            </p>
            <img class="FLOAT_RIGHT IMAGE_HALF_WIDTH" src="/images/GoIV-Renamed.png" />
            <img style="width:40%; max-width:256px;" src="/images/GoIV-Clipboard_Single.png" />
            <br />
            <br />
            <img style="width:40%; max-width:256px;" src="/images/GoIV-Clipboard_Multiple.png" />
            <br class="FLOAT_END" />
            <h4 class="PARENT">Links</h4>
            <ul class="CHILD">
              <li>
                <b>Reddit Page</b>: <a href="https://www.reddit.com/r/GoIV/">https://www.reddit.com/r/GoIV/</a>
              </li>
              <li>
                <b>Project Page</b>: <a href="https://github.com/farkam135/GoIV">https://github.com/farkam135/GoIV"</a>
              </li>
              <li>
                <b>APK Mirror</b>: <a href="https://www.apkmirror.com/apk/johan-swanberg/goiv-pokemon-iv-calculator/">https://www.apkmirror.com/apk/johan-swanberg/goiv-pokemon-iv-calculator/</a>
              </li>
            </ul>
          </div>

          <hr class="SEPARATOR_BORDER" />
          <h3 id="anchor_toolkit">
            <xsl:call-template name="Collapser">
              <xsl:with-param name="CollapseeID" select="'IV_TOOLKIT'" />
            </xsl:call-template>
            <xsl:text>IV &amp; ToolKit for Pokemon Go</xsl:text>
          </h3>
          <div id="IV_TOOLKIT" class="INDENT">
            <p class="PARENT">
              IV &amp; ToolKit for Pokemon Go is a multipurpose tool that has:
            </p>
            <ul class="CHILD PARENT">
              <li>IV Calculator</li>
              <li>CP Evolution Calculator</li>
              <li>Lucky Egg Calculator</li>
              <li>Stardust Calculator</li>
              <li>
                And stats and info regarding:
                <ul>
                  <li>Pokemon Types, CP, etc.</li>
                  <li>Type Weaknesses and Effectiveness</li>
                  <li>Move Sets</li>
                  <li>Eggs</li>
                  <li>Appraisals</li>
                  <il>Buddy Candies</il>
                </ul>
              </li>
            </ul>
            <p class="CHILD NOTE">
              (There is also a &quot;Premium&quot; (pay-for) version with more.)
            </p>
            <p>
              You can launch the app any time, but it also has a floating icon that allows you to launch the toolkit on top of Pokemon GO.
              This allows you to see the Pokemon's data while you enter it into the fields.
            </p>
            <p class="PARENT">
              One of my favorite features is that when you use the IV Calculator and it there isn't a single possible IV, you can scroll down and see how many times you have to power up to narrow down the results.
              You can also see how many Candies and how much Stardust it will take to get there.
            </p>
            <p class="CHILD NOTE">
              <b>NOTE</b>: Actually, it tells you how many Candies and how much Stardust it would take to max it out. You would have to note the values for the current state, then move up as many levels as you want, then do the math.
            </p>
            <h4 class="PARENT">Links</h4>
            <ul class="CHILD">
              <li>
                <b>Google Play Store</b>: <a href="https://play.google.com/store/apps/details?id=hqt.apps.poke">https://play.google.com/store/apps/details?id=hqt.apps.poke</a>
              </li>
            </ul>

          </div>
        </div>

        <br />
        <hr />
        <h2 id="anchor_seattlearea">
          <a href="seattlearea.html">Greater Seattle Area</a>
        </h2>
        <p>
          I live on the Eastside of the Greater Seattle area.
          <br />This page has some resources that are specific to that area.
        </p>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
