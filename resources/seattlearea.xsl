<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
>
  <xsl:include href="/xsl/global.xsl"/>
  
  <xsl:template match="Root">
    <html>
      <head>
        <!-- This is to make the font size consistent on mobile. -->
        <meta name="viewport" content="width=device-width, initial-scale=1" />

        <script>
          <xsl:attribute name="src">
            <xsl:text>/js/global.js?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </script>
        <link type="text/css" rel="stylesheet" >
          <xsl:attribute name="href">
            <xsl:text>index.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </link>

        <title>Seattle Area Resources</title>

        <style>
          th {
          white-space: nowrap;
          }

          td {
          vertical-align: top;
          }

          td > ol {
          padding-left: 1em;
          }
        </style>
      </head>
      <body>
        <h1>Seattle Area Resources</h1>
        <p>
          I live on the Eastside of the Greater Seattle area and here are some of the resources that are available specifically for this area.
        </p>
        <script>WriteFeedbackNote();</script>

        <hr />
        <h2 id="Discord">
          <xsl:text>Discord</xsl:text>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'SEATTLE_DISCORD'" />
          </xsl:call-template>
        </h2>
        <div id="SEATTLE_DISCORD" class="INDENT">
          <p>
            <a href="https://discordapp.com/">Discord</a> is a service that is used by gamers to communicate with each other.
          </p>
          <h3>Groups</h3>
          <div class="INDENT">
            <p class="PARENT">
              In the Greater Seattle area, there a bunch of Discord groups people use to announce Pokemon in the area, coordinate Raid Battles, etc.
              Here are some of the ones I am aware of.
            </p>
            <ul class="CHILD">
              <li>
                <b>SeaPokeMap</b>:<div class="INDENT">Many channels sharing Pokemon sightings in the Seattle area.</div>
              </li>
              <li>
                <b>SeattlePokeMaps (SPM)</b>:<div class="INDENT">Many channels sharing Pokemon sightings all over the Greater Seattle area.</div>
              </li>
              <li>
                <b>RainCityMaps</b>:<div class="INDENT">Trainers that coordinate raids, etc. in the Kirkland, Redmond and Bellevue area.</div>
              </li>
              <li>
                <b>Issaquah PokemonGO Trainers</b>:<div class="INDENT">Trainers that coordinate raids, etc. in the Issaquah area.</div>
              </li>
              <!--<li class="DISABLED"><b>Bellevue?</b>:<span class="NOTE"></span></li>-->
            </ul>
            <p>
              In order to join a Discord group, you have to get an invitation, so the best thing to do is to ask other people at a raid if they can give you one.
            </p>
          </div>

          <hr class="SEPARATOR_BORDER" />
          <h3>Searches</h3>
          <div class="INDENT">
            <p>
              Many Discord "servers" have multiple channels you would like to see.
              Sometimes it becomes a bit of an overload to check just what you are interested in.
              <br />This table contains searches that can help find the specific recent results you are interested in.
              <br /><span class="NOTE">
                <b>NOTE</b>: There is a limit of 512 chars in the search field.<br />
              </span>
            </p>
            <table border="1">
              <tr>
                <th colspan="3" style="font-size:x-large;">Discord Searches</th>
              </tr>
              <tr>
                <th>Site</th>
                <th>Description</th>
                <th style="min-width:90em;">Filter</th>
              </tr>
              <tr>
                <th rowspan="1">SeaPokeMap</th>
                <th>
                  All Sitings<br />(No Raids)
                </th>
                <td>in:iv100 in:iv90 in:cp2500 in:tyranitar in:dragonite in:blissey in:chansey in:lapras in:snorlax in:unown in:ampharos in:aerodactyl in:alakazam in:arcanine in:blastoise in:charizard in:donphan in:exeggutor in:feraligatr in:flaaffy in:flareon in:forretress in:gengar in:golem in:gyarados in:hitmonchan in:hitmonlee in:hitmontop in:jolteon in:larvitar in:lickitung in:machamp in:mareep in:meganium in:miltank in:muk in:porygon in:pupitar in:rhydon in:togetic in:typhlosion in:vaporeon in:venusaur</td>
              </tr>
              <tr>
                <th rowspan="1">SeattlePokeMaps</th>
                <th>
                  All Sitings<br />(No Raids)
                </th>
                <td>in:lake-stevens in:snohomish in:everett in:lynnwood-edmonds-millcreek in:kenmore-bothell-woodinville in:shoreline in:seattle in:north-seattle in:south-seattle in:west-seattle in:mercer-island in:burien in:des-moines in:sea-tac in:kent in:renton in:newcastle in:issaquah in:bellevue in:redmond in:kirkland</td>
              </tr>
            </table>
          </div>
        </div>

        <br />
        <hr />
        <h2 id="Maps">
          <xsl:text>Maps</xsl:text>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'SEATTLE_MAPS'" />
          </xsl:call-template>
        </h2>
        <div id="SEATTLE_MAPS" class="INDENT">
          <p>Some websites have been created to show maps of where Pokemon can be found.</p>

          <h3 id="SEAPokeMap">SEAPokeMap</h3>
          <div class="INDENT">
            <p class="PARENT">
              SEAPokeMap runs a couple of maps in addition to its Discord group:
            </p>
            <ul class="CHILD">
              <li>
                <b>Pokemon Map</b>: <a href="https://seapokemap.com">https://seapokemap.com</a>
              </li>
              <li>
                <b>Raid Map</b>: <a href="https://seapokemap.com/gym.html">https://seapokemap.com/gym.html</a>
              </li>
              <li>
                <b>Twitter Feed</b>: <a href="https://twitter.com/seapokemap">https://twitter.com/seapokemap</a>
              </li>
            </ul>

            <!-- TODO QZX: When ready, uncomment this and delete everything between the next 2 TODO QZX
            <h4><a href="seapokemapfilter.html">SEAPokeMap Filter Generator</a> <span class="TODO">(Beta)</span></h4>
            <div class="INDENT CHILD">
                <p>
                    To keep costs down, SEAPokeMap doesn't supply icons on their maps.
                    <br />However, by using javascript to manipulate site's cookies you can get the map to use icons you supply.
                    <span class="NOTE">(This is <b>intentionally</b> not documented!)</span>
                </p>
                <p>
                    You can also use javascript to manipulate the cookies to quickly set the other search criteria, such as Minimum IV and which Pokemon to show.
                    <br />For example, if I am sitting at home I may want to see a lot of Pokemon, but if I am at work I may only want to see a few <i>really</i> desirable ones.
                </p>
                <p>
                    As such, I have created this tool so you can create multiple javascript filters that you can easily apply instead of having to check and uncheck each Pokemon 1 at a time, etc.
                </p>
            </div>
            -->

            <!-- TODO QZX: When SEAPokeMap Filter Generator is ready, delete everyting from here to the next TODO QZX. -->
            <p>
              To keep costs down, SEAPokeMap doesn't supply icons on their maps.
              <br />
              However, by using javascript to manipulate site's cookies you can get the map to use icons you supply.
              <span class="NOTE">
                (This is <b>intentionally</b> not documented!)
              </span>
            </p>
            <p>
              Here are some javascript scripts that will manipulate the cache to set icons and/or other useful information.
            </p>

            <div class="INDENT CHILD">
              <table border="1">
                <tr>
                  <th />
                  <th>JavaScript</th>
                </tr>
                <tr>
                  <th align="right" rowspan="2">Set Icons</th>
                  <td style="min-width:50em;">
                    <code>
                      javascript:var url='<b>
                        <i>https://pkmref.com/images/set_1/</i>
                      </b>';for(i=1;i&lt;1000;i++){localStorage.setItem('icon'+i,url+i+'.png');};location.reload();
                    </code>
                  </td>
                </tr>
                <tr>
                  <td class="NOTE">
                    Set the <code>url</code> to be a path to the icons. Each icon needs to be named after the Pokemon's ID.
                    <br />For example, the icon for the bulbasaur would be <code>1.png</code>
                  </td>
                </tr>
                <tr>
                  <th align="right" rowspan="2">
                    Show only Pokemon<br />that <i>may</i> have<br />IV available.
                  </th>
                  <td>
                    <code>javascript:var show=[3,6,9,31,34,36,38,40,45,57,59,62,63,64,65,66,67,68,71,74,75,76,78,87,89,91,93,94,103,106,107,108,111,112,113,117,123,130,131,134,135,136,137,139,141,142,143,147,148,149,154,157,160,176,179,180,181,201,217,221,228,229,232,237,242,246,247,248];for(i=1;i&lt;1000;i++){localStorage.setItem(i,'0');};for(i =0;i&lt;show.length;i++){localStorage.setItem(show[i],'1');};localStorage.setItem('min_iv2',1);location.reload();</code>
                  </td>
                </tr>
                <tr>
                  <td class="NOTE">
                    <b>NOTE</b>: List updated 16 October 2017.
                  </td>
                </tr>
                <tr>
                  <th align="right" rowspan="2">
                    Toggle IV of Pokemon<br />to be shown.
                  </th>
                  <td>
                    <code>
                      javascript:var iv=<b>
                        <i>90</i>
                      </b>;if(localStorage.getItem('min_iv2')!=iv){localStorage.setItem('min_iv2',iv);}else{localStorage.setItem('min_iv2','0');};location.reload();
                    </code>
                  </td>
                </tr>
                <tr>
                  <td class="NOTE">
                    Set the <code>iv</code> to be the score you want.
                    <br />For example, you could change the 90 to 100 to show only Pokemon with a perfect IV score.
                  </td>
                </tr>
              </table>
              <p class="NOTE">
                <b>NOTES</b>:
                <br />You can combine multiple scripts into a single script that does multiple things.
                Just remove the "<code>javascript:</code>" from all but the first one.
                <br />In all cases, when pasting scripts make sure the "<code>javascript:</code>" is retained on the front.
                Many browsers automatically cut it off as a security precaution.
              </p>
            </div>
            <p class="PARENT">
              Follow the instructions below for your environment:
            </p>
            <div class="INDENT CHILD">
              <table border="1">
                <tr style="font-size:x-large;">
                  <th style="width:0px;">Environment</th>
                  <th>Setup</th>
                  <th>Use</th>
                </tr>
                <tr>
                  <th>Desktop</th>
                  <td>
                    <ol>
                      <li>Create a new shortcut in your browser.</li>
                      <li>Edit the shortcut.</li>
                      <li>Copy and paste the desired script from the table above into the URL field and save it.</li>
                    </ol>
                  </td>
                  <td>
                    <ol>
                      <li>Open seapokemap.com.</li>
                      <li>Click on the shortcut created in Setup.</li>
                    </ol>
                  </td>
                </tr>
                <tr>
                  <th>Android</th>
                  <td>
                    Copy and paste the scripts from the table above to a location convenient for your device.
                  </td>
                  <td>
                    <ol>
                      <li>Open seapokemap.com.</li>
                      <li>Copy and paste the desired script address bar and click Go.</li>
                    </ol>
                  </td>
                </tr>
                <tr>
                  <th rowspan="2">Apple</th>
                  <td colspan="2">
                    <div class="NOTE">
                      <b>NOTE</b>: I do not have an Apple device, so I have not personally verified this works.
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>
                    <ol>
                      <li>Open browser.</li>
                      <li>Add a bookmark.</li>
                      <li>Open bookmark list.</li>
                      <li>Go to edit mode.</li>
                      <li>
                        Select the bookmark and edit the 2<sup>nd</sup> field to the desired script from the table above.
                      </li>
                    </ol>
                  </td>
                  <td>
                    <ol>
                      <li>Open seapokemap.com.</li>
                      <li>Click on the shortcut created in Setup.</li>
                      <li>
                        Refresh.
                        <br /><span class="NOTE">(I am not sure if this step is necessary because the javascript I have supplied should do it for you.)</span>
                      </li>
                    </ol>
                  </td>
                </tr>
              </table>
            </div>
            <!-- TODO QZX: When SEAPokeMap Filter Generator is ready, delete everyting from here to the previous TODO QZX. -->
          </div>

          <h3>SeattlePokeMaps (SPM)</h3>
          <div class="INDENT">
            <p class="PARENT">
              SeattlePokeMaps also runs a couple of maps in addition to its Discord group:
            </p>
            <ul class="CHILD">
              <li>
                <b>Pokemon Map</b>: <a href="https://seattlepokemaps.com">https://seattlepokemaps.com</a>
                <p class="NOTE INDENT">
                  <b>NOTE</b>: You will need to log in using your Discord account to access this site.
                </p>
              </li>
              <li>
                <b>Raid Map</b>: <a href="https://seattlepokemaps.com/raids/">https://seattlepokemaps.com/raids/</a>
              </li>
              <li>
                <b>Facebook</b>: <a href="https://www.facebook.com/groups/seattlepokemaps/">https://www.facebook.com/groups/seattlepokemaps/</a>
              </li>
            </ul>
            <p>
              Be aware that SPM gives basic info for free.
              However, you can get more info and notifications if you get one of their paid memberships.
              <br /><span class="INDENT NOTE">(FYI: Currently, I have not spent any money on Pokemon GO and I don't intend to.)</span>
            </p>
          </div>
        </div>

        <br />
        <hr />
        <h2 id="Social">
          <xsl:text>Social Groups</xsl:text>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'SEATTLE_SOCIAL'" />
          </xsl:call-template>
        </h2>
        <div id="SEATTLE_SOCIAL" class="INDENT">
          <p>
            There are a lot of Social Groups out there that are constantly talking about the latest issues.
            <br />These are some of the best.
          </p>
          <b>
            <u>Twitter</u>
          </b>
          <br />
          <span class="TODO">(TODO)</span>
          <ul></ul>

          <br />
          <b>
            <u>Facebook</u>
          </b>
          <ul>
            <li>
              <b>Pokemon Go Seattle</b>:<div class="INDENT_SMALL">
                <a href="https://www.facebook.com/groups/PokemonGoSeattleWashington/">https://www.facebook.com/groups/PokemonGoSeattleWashington/</a>
              </div>
            </li>
          </ul>
        </div>

        <!-- This script is defined in /js/global.js -->
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
