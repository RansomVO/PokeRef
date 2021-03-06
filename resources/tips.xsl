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

        <title>Pokemon GO Tips</title>
        <style>
          th, td {
          white-space: nowrap;
          }
        </style>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon GO Tips
        </h1>
        <p>
          There are a lot of secrets that Niantic doesn't document, but have been found and shared by other trainers.
          <br />This page outlines a selection of those secrets.
        </p>

        <br />
        <hr />
        <h2 id="anchor_searchterms">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'ADVANCED_SEARCH'" />
          </xsl:call-template>
          <xsl:text>Advanced Search Terms</xsl:text>
        </h2>
        <div id="ADVANCED_SEARCH" class="INDENT">
          <p>
            When looking at the Pokemon in your box, there is the ability to search.
            This allows you to easily find Pokemon by species, or by the nickname you have given them.
            <br /><span class="EMPHASIS">But wait! There's more!!!</span>
          </p>
          <p>
            There are some secret terms and modifiers that can be used:
          </p>

          <table class="INDENT" border="1">
            <tr>
              <th>INPUT</th>
              <th>Description</th>
              <th>Examples</th>
              <th>Results</th>
            </tr>
            <tr>
              <th rowspan="4">Text</th>
              <td>
                <b>If a species name, Pokemon of that species.</b>
              </td>
              <td>"Squirtle"</td>
              <td>Squirtles</td>
            </tr>
            <tr>
              <td>
                <b>If a Pokemon type, Pokemon of that type.</b>
              </td>
              <td>"fire"</td>
              <td>
                Fire-type Pokemon <span class="NOTE">E.G. Magmar, Flareon, etc.</span>
              </td>
            </tr>
            <tr>
              <td>
                <b>If a nickname, Pokemon with that nickname.</b>
              </td>
              <td>"Foxy"</td>
              <td>Pokemon with the nickname "Foxy"</td>
            </tr>
            <tr>
              <td>
                <b>If a sub-string, Pokemon whose species or nickname have that beginning.</b>
              </td>
              <td>"Sun"</td>
              <td>Sunkerns, Sunfloras and Pokemon with nicknames like "Sunny"</td>
            </tr>
            <tr>
              <th rowspan="4">Special Words</th>
              <td rowspan="4">
                <b>Pokemon of a special category</b>
              </td>
              <td>"evolve"</td>
              <td>Pokemon you have sufficient candies to evolve</td>
            </tr>
            <tr>
              <td>"defender"</td>
              <td>Pokemon that are currently in gyms</td>
            </tr>
            <tr>
              <td>"legendary"</td>
              <td>Pokemon that are designated as Legendary</td>
            </tr>
            <tr>
              <td>"mythical"</td>
              <td>Pokemon that are designated as Mythic</td>
            </tr>
            <tr>
              <th rowspan="3">Number</th>
              <td>
                <b>ID of Pokemon</b>
              </td>
              <td>"3"</td>
              <td>
                Pokemon with the ID 3 <span class="NOTE">I.E. Venusaur</span>
              </td>
            </tr>
            <tr>
              <td>
                <b>CP of Pokemon</b>
              </td>
              <td>"cp100"</td>
              <td>Pokemon with a CP of 100</td>
            </tr>
            <tr>
              <td>
                <b>HP of Pokemon</b>
              </td>
              <td>"hp42"</td>
              <td>Pokemon with an HP of 42</td>
            </tr>
            <tr>
              <th rowspan="3">-</th>
              <td rowspan="3">
                <b>Specifies a range.</b>
              </td>
              <td>"1-10"</td>
              <td>Pokemon with IDs between 1 and 10</td>
            </tr>
            <tr>
              <td>"cp3000-"</td>
              <td>Pokemon with a CP of 3000 or higher</td>
            </tr>
            <tr>
              <td>"hp-20"</td>
              <td>Pokemon with an HP of 20 or lower</td>
            </tr>
            <tr>
              <th rowspan="2">@</th>
              <td rowspan="2">
                <b>Move or Move Type</b>
              </td>
              <td>"@ice"</td>
              <td>
                Pokemon with an Ice-type move <span class="NOTE">E.G. Avalanche, Blizzard, etc.</span>
              </td>
            </tr>
            <tr>
              <td>"@bite"</td>
              <td>Pokemon with the move Bite</td>
            </tr>
            <tr>
              <th rowspan="4">+</th>
              <td rowspan="4">
                <b>Expanded Family Results</b>
              </td>
              <td>"+clefairy"</td>
              <td>
                Pokemon in the Clefairy family <span class="NOTE">I.E. Clefairy, Clefable and Cleffa</span>
              </td>
            </tr>
            <tr>
              <td>"+jolteon"</td>
              <td>
                Pokemon in the same family as Jolteon. <span class="NOTE">E.G. Eevee, Flareon, etc.</span>
              </td>
            </tr>
            <tr>
              <td>"+Foxy"</td>
              <td>Pokemon in the same family as the one named "Foxy"</td>
            </tr>
            <tr>
              <td>"+flying"</td>
              <td>
                Pokemon in the a family that contains a member that is flying-type<br /><span class="NOTE">E.G. It would include Magikarp since Gyrados (in the Magikarp family) are Flying-type.</span>
              </td>
            </tr>
            <tr>
              <th>,</th>
              <td>
                <b>Merge Results</b>
              </td>
              <td>"posion,steel"</td>
              <td>
                Pokemon that are either Poison-type or Steel-type. <span class="NOTE">(Good against Fairies)</span>
              </td>
            </tr>
            <tr>
              <th>&amp;</th>
              <td>
                <b>Refine Results</b>
              </td>
              <td>"evolve&amp;+dragon"</td>
              <td>Pokemon that you can evolve that are in a family with a member that is Dragon-type</td>
            </tr>
          </table>
        </div>

        <br />
        <hr />
        <h2 id="anchor_eeveelutions">
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'EEVEELUTIONS'" />
          </xsl:call-template>
          <xsl:text>Eevee Evolving</xsl:text>
        </h2>
        <div id="EEVEELUTIONS" class="INDENT">
          <p>
            There are "Easter Egg" tricks in Pokemon GO that will allow you to control what an Eevee will evolve into.
          </p>

          <hr class="SEPARATOR_BORDER" />
          <h3>Naming Trick</h3>
          <div class="INDENT">
            <p>
              The Naming trick allows you to specify what the Eevee will evolve into by renaming it before evolving.
              <br /><span class="SIGNIFICANT EMPHASIS INDENT" style="font-size:larger; background-color:yellow;">THIS WILL ONLY WORK ONCE PER NAME!!!</span>
              <span class="NOTE">
                (Make sure you use it on a <span class="EMPHASIS">good</span> Eevee!)
              </span>
            </p>

            <h4>Process:</h4>
            <div class="INDENT">
              <ol class="PADDED_LIST PARENT">
                <li>Set the Nickname for the Eevee to the one desired from the table below.</li>
                <li>Evolve the Eevee.</li>
              </ol>
              <p class="EMPHASIS CHILD">
                That's it!
              </p>

              <table class="INDENT" border="1">
                <tr>
                  <th>Evolution</th>
                  <th>Name</th>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Vaporeon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>Rainer</td>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Jolteon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>Sparky</td>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Flareon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>Pyro</td>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Espeon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>Sakura</td>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Umbreon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>Tamao</td>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Leafeon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>
                    <span class="TODO">?</span>
                  </td>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Glaceon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>
                    <span class="TODO">?</span>
                  </td>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Sylveon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>
                    <span class="TODO">?</span>
                  </td>
                </tr>
              </table>
            </div>
          </div>
          <br />
          <hr class="SEPARATOR_BORDER" />
          <h3>Gen 2 Timing Trick</h3>
          <div class="INDENT">
            <p class="PARENT">
              The Timing trick can be used to evolve the Eevee into the Gen 2 evolution you want.
              <br /><b>BONUS</b>: It can be used multiple times!
            </p>

            <h4>Process:</h4>
            <div class="INDENT">
              <ol class="PADDED_LIST">
                <li>Make the Eevee your buddy.</li>
                <li>
                  Walk at least 10 Km with him as your buddy
                  <br /><span class="INDENT SIGNIFICANT EMPHASIS">AND</span>
                  <br /><span class="EMPHASIS"> make sure he has found 2 Eevee Candies.</span>
                </li>
                <li>While the Eevee is still your buddy, evolve it a the time desired from the table below.</li>
              </ol>

              <table class="INDENT" border="1">
                <tr>
                  <th>Evolution</th>
                  <th>Timing</th>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Espeon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>Daytime</td>
                </tr>
                <tr>
                  <xsl:apply-templates select="/Root/PokeStats/Pokemon[@name='Umbreon']" mode="Cell">
                    <xsl:with-param name="Settings">
                      <Show small="true" hide_type_icons="true" hide_special_icons="true" />
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <td>Nightime</td>
                </tr>
              </table>
            </div>
          </div>
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
