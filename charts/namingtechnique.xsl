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
            <xsl:text>index.css?cacherefresh=</xsl:text>
            <xsl:value-of select="$CurrentDate"/>
          </xsl:attribute>
        </link>

        <title>Pokemon Naming Technique</title>

        <style>
          th {
          white-space: nowrap;
          }

          .INNER_BORDER {
          text-align: center;
          border: 1px solid;
          height: 1.7em;
          }
        </style>
      </head>
      <body>
        <h1>
          <xsl:call-template name="HomePageLink" />
          Pokemon Naming Technique
        </h1>
        <p>
          Many people have seen the advantage of setting their Pokemon names so that sorting alphabetically will put certain ones before others.
          For example, if you have a team you want to be able to quickly select for a raid, you might want to make it so that sorting alphabetically moves the team members to the top.
          <br />
          However, I tend to have a bunch of categories, so I wanted to know what chars would work best for me.
          I have searched and found several posts/sites that have some good information, but none that had everything I wanted.
        </p>
        <p>
          So, I went to the effort of figuring out how the whole thing works and made my own reference.
          <br />I hope it helps you too.
        </p>

        <br />
        <hr />
        <h2 id="anchor_sortorderandroid">
          <xsl:text>Sort Order for Names in Pokemon Go on Android</xsl:text>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'NAMING_SORT_ORDER'" />
          </xsl:call-template>
        </h2>
        <div id="NAMING_SORT_ORDER" class="INDENT">
          <p>
            Of course you need to know what chars will end up where when you sort.
            I used my Android Galaxy Tab E tablet, which has a small amount of chars more than on my Galaxy Edge S7 phone.
          </p>
          <table class="INDENT">
            <tr>
              <td id="anchor_sortorderandroidspecialchars" rowspan="100%" valign="top">
                <table style="width:100%; border:1px solid; vertical-align:top;">
                  <tr>
                    <th colspan="2" style="border: 1px solid;">
                      <span style="font-size:x-large">#1</span><br />Special Chars on<br />Standard Android<br />Keyboard
                    </th>
                  </tr>
                  <tr>
                    <td style="vertical-align:top; margin:0px; padding:0px;">
                      <table style="width:100%;">
                        <tr>
                          <td class="INNER_BORDER">!</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">&quot;</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">#</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">$</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">%</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">&amp;</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">(</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">)</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">*</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">,</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">.</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">/</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">:</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">;</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">?</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">@</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">[</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">\</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">]</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">^</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">_</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">`</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">{</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">|</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">}</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">~</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">¡</td>
                        </tr>
                      </table>
                    </td>
                    <td style="vertical-align:top; margin:0px; padding:0px;">
                      <table style="width:100%;">
                        <tr>
                          <td class="INNER_BORDER">¿</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">《</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">》</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">⊙</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">&lt;</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">=</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">&gt;</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">×</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">÷</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">■</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">□</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">▪</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">◇</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">○</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">●</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">£</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">¤</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">¥</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">§</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">°</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">•</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">₩</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">☆</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">♡</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">♤</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">♧</td>
                        </tr>
                        <tr>
                          <td class="INNER_BORDER">€</td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
              <td comment="(spacing column)" width="25" rowspan="100%"></td>
              <td id="anchor_sortorderandroidnumerics" valign="top">
                <table border="1" style="width:100%">
                  <tr>
                    <th colspan="3">
                      <span style="font-size:x-large">#2</span><br />Numerical Chars
                    </th>
                  </tr>
                  <tr>
                    <th>Chars</th>
                    <th>Note</th>
                    <th>Example</th>
                  </tr>
                  <tr>
                    <td>0-9</td>
                    <td>Sorted Alphabetically</td>
                    <td>
                      "1" &lt; "13" &lt; "2"
                    </td>
                  </tr>
                </table>
                <br />
                <table id="anchor_sortorderandroidalphabetics" border="1" style="width:100%">
                  <tr>
                    <th colspan="3">
                      <span style="font-size:x-large">#3</span><br />Alphabetical Chars
                    </th>
                  </tr>
                  <tr>
                    <th>Rule</th>
                    <th>Example</th>
                  </tr>
                  <tr>
                    <td>Base letters are sorted alphabetically.</td>
                    <td>
                      "a" &lt; "b"
                    </td>
                  </tr>
                  <tr>
                    <td>When all else is equal, decorated letters (with accents, etc.) come after base.</td>
                    <td>
                      "as" &lt; "ás" &lt; "at"
                    </td>
                  </tr>
                  <tr>
                    <td>When all else is equal, capital letters come after lower case.</td>
                    <td>
                      "ao" &lt; "Ao" &lt; "aó"
                    </td>
                  </tr>
                  <tr>
                    <td>
                      Some special chars come <span class="EMPHASIZE">BEFORE</span> their similar base.
                    </td>
                    <td>
                      "r" &lt; "ß" &lt; "s"
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td valign="bottom">
                <table id="anchor_sortorderandroidspecialcases" border="1" style="width:100%">
                  <tr>
                    <th colspan="2">
                      <span style="font-size:x-large">Special Cases</span>
                    </th>
                  </tr>
                  <tr>
                    <th align="center" width="50px">Char</th>
                    <th>Issue</th>
                  </tr>
                  <tr>
                    <td align="center">Space</td>
                    <td>Trimmed</td>
                  </tr>
                  <tr>
                    <td align="center">-</td>
                    <td>Ignored</td>
                  </tr>
                  <tr>
                    <td align="center">+</td>
                    <td>Ignored</td>
                  </tr>
                  <tr>
                    <td align="center">'</td>
                    <td>Ignored</td>
                  </tr>
                </table>
                <br />
                <table id="anchor_sortorderandroidnotes" border="1" style="width:100%">
                  <tr>
                    <th colspan="2">
                      <span style="font-size:x-large">Notes</span>
                    </th>
                  </tr>
                  <tr>
                    <td align="center" width="50px">§</td>
                    <td>Accessed by pressing and holding S key</td>
                  </tr>
                  <tr>
                    <td align="center">ß</td>
                    <td>
                      Accessed by pressing and holding S key<br />
                      <span class="NOTE">
                        <b>Note</b>: More or less, the ß is a capital "sz" in German.
                      </span>
                    </td>
                  </tr>
                  <tr>
                    <td align="center">Unicode outside ANSI</td>
                    <td>Can appear anywhere and must be tested 1-by-1.</td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </div>

        <br />
        <hr />
        <h2 id="anchor_numerics">
          <xsl:text>Numerics</xsl:text>
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'NAMING_NUMERICS'" />
          </xsl:call-template>
        </h2>
        <div id="NAMING_NUMERICS" class="INDENT">
          <p>
            There are some neato Unicode chars, that can be used to combine a couple of digits into a single char. (Like for IV scores.)
          </p>
          <p>
            Unfortunately, at this time they only have 0-50, so it can't be used effectively for IV scores.
            <br />
            Also, some of the Unicode chars won't display in Pokemon GO.
            But there are enough that it can be a great help.
          </p>

          <p class="NOTE">
            <b>Note</b>:
            I am not aware of a way to input these characters using the keyboard on the device.
            Instead, you'll need to copy and paste them.
          </p>
          <table class="INDENT" border="1" style="word-wrap:unset; text-align:center;">
            <tr comment="DIGIT (0030-0039)">
              <th align="left">DIGIT</th>
              <td class="CHARS">&#x0030;</td>
              <td class="CHARS">&#x0031;</td>
              <td class="CHARS">&#x0032;</td>
              <td class="CHARS">&#x0033;</td>
              <td class="CHARS">&#x0034;</td>
              <td class="CHARS">&#x0035;</td>
              <td class="CHARS">&#x0036;</td>
              <td class="CHARS">&#x0037;</td>
              <td class="CHARS">&#x0038;</td>
              <td class="CHARS">&#x0039;</td>
            </tr>
            <tr comment="CIRCLED (24EA, 2460-2473, 3251-325F, 32B1-32BF)">
              <th align="left">CIRCLED</th>
              <td class="CHARS">&#x24EA;</td>
              <td class="CHARS">&#x2460;</td>
              <td class="CHARS">&#x2461;</td>
              <td class="CHARS">&#x2462;</td>
              <td class="CHARS">&#x2463;</td>
              <td class="CHARS">&#x2464;</td>
              <td class="CHARS">&#x2465;</td>
              <td class="CHARS">&#x2466;</td>
              <td class="CHARS">&#x2467;</td>
              <td class="CHARS">&#x2468;</td>
              <td class="CHARS">&#x2469;</td>
              <td class="CHARS">&#x246A;</td>
              <td class="CHARS">&#x246B;</td>
              <td class="CHARS">&#x246C;</td>
              <td class="CHARS">&#x246D;</td>
              <td class="CHARS">&#x246E;</td>
              <td class="CHARS">&#x246F;</td>
              <td class="CHARS">&#x2470;</td>
              <td class="CHARS">&#x2471;</td>
              <td class="CHARS">&#x2472;</td>
              <td class="CHARS">&#x2473;</td>
              <td class="CHARS">&#x3251;</td>
              <td class="CHARS">&#x3252;</td>
              <td class="CHARS">&#x3253;</td>
              <td class="CHARS">&#x3254;</td>
              <td class="CHARS">&#x3255;</td>
              <td class="CHARS">&#x3256;</td>
              <td class="CHARS">&#x3257;</td>
              <td class="CHARS">&#x3258;</td>
              <td class="CHARS">&#x3259;</td>
              <td class="CHARS">&#x325A;</td>
              <td class="CHARS">&#x325B;</td>
              <td class="CHARS">&#x325C;</td>
              <td class="CHARS">&#x325E;</td>
              <td class="CHARS">&#x325F;</td>
              <td class="CHARS">&#x32B1;</td>
              <td class="CHARS">&#x32B2;</td>
              <td class="CHARS">&#x32B3;</td>
              <td class="CHARS">&#x32B4;</td>
              <td class="CHARS">&#x32B5;</td>
              <td class="CHARS">&#x32B6;</td>
              <td class="CHARS">&#x32B7;</td>
              <td class="CHARS">&#x32B8;</td>
              <td class="CHARS">&#x32B9;</td>
              <td class="CHARS">&#x32BA;</td>
              <td class="CHARS">&#x32BB;</td>
              <td class="CHARS">&#x32BC;</td>
              <td class="CHARS">&#x32BD;</td>
              <td class="CHARS">&#x32BE;</td>
              <td class="CHARS">&#x32BF;</td>
            </tr>
            <tr comment="DINGBAT CIRCLED SANS-SERIF (2780-2789)">
              <th align="left">
                DINGBAT<br />CIRCLED SANS-SERIF
              </th>
              <td class="CHARS">
                &#x1F10B;<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger" disable-output-escaping="yes"/>
                  </sup>
                </a>
              </td>
              <td class="CHARS">&#x2780;</td>
              <td class="CHARS">&#x2781;</td>
              <td class="CHARS">&#x2782;</td>
              <td class="CHARS">&#x2783;</td>
              <td class="CHARS">&#x2784;</td>
              <td class="CHARS">&#x2785;</td>
              <td class="CHARS">&#x2786;</td>
              <td class="CHARS">&#x2787;</td>
              <td class="CHARS">&#x2788;</td>
              <td class="CHARS">&#x2789;</td>
            </tr>
            <tr comment="DOUBLE CIRCLED (24F5-24FE)">
              <th align="left">DOUBLE CIRCLED</th>
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS">&#x24F5;</td>
              <td class="CHARS">&#x24F6;</td>
              <td class="CHARS">&#x24F7;</td>
              <td class="CHARS">&#x24F8;</td>
              <td class="CHARS">&#x24F9;</td>
              <td class="CHARS">&#x24FA;</td>
              <td class="CHARS">&#x24FB;</td>
              <td class="CHARS">&#x24FC;</td>
              <td class="CHARS">&#x24FD;</td>
              <td class="CHARS">&#x24FE;</td>
            </tr>
            <tr comment="NEGATIVE CIRCLED (24FF, 2776-2777F, 24EB-24F4)">
              <th align="left">NEGATIVE CIRCLED</th>
              <td class="CHARS">&#x24FF;</td>
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS">&#x24EB;</td>
              <td class="CHARS">&#x24EC;</td>
              <td class="CHARS">&#x24ED;</td>
              <td class="CHARS">&#x24EE;</td>
              <td class="CHARS">&#x24EF;</td>
              <td class="CHARS">&#x24F0;</td>
              <td class="CHARS">&#x24F1;</td>
              <td class="CHARS">&#x24F2;</td>
              <td class="CHARS">&#x24F3;</td>
              <td class="CHARS">&#x24F4;</td>
            </tr>
            <tr comment="DINGBAT NEGATIVE CIRCLED (2776-277F)">
              <th align="left">
                DINGBAT<br />NEGATIVE CIRCLED
              </th>
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS">&#x2776;</td>
              <td class="CHARS">&#x2777;</td>
              <td class="CHARS">&#x2778;</td>
              <td class="CHARS">&#x2779;</td>
              <td class="CHARS">&#x277A;</td>
              <td class="CHARS">&#x277B;</td>
              <td class="CHARS">&#x277C;</td>
              <td class="CHARS">&#x277D;</td>
              <td class="CHARS">&#x277E;</td>
              <td class="CHARS">&#x277F;</td>
            </tr>
            <tr comment="DINGBAT NEGATIVE CIRCLED SANS-SERIF (278A-2793)">
              <th align="left">
                DINGBAT<br />NEGATIVE CIRCLED SANS-SERIF
              </th>
              <td class="CHARS">
                &#x1F10C;<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </td>
              <td class="CHARS">&#x278A;</td>
              <td class="CHARS">&#x278B;</td>
              <td class="CHARS">&#x278C;</td>
              <td class="CHARS">&#x278D;</td>
              <td class="CHARS">&#x278E;</td>
              <td class="CHARS">&#x278F;</td>
              <td class="CHARS">&#x2790;</td>
              <td class="CHARS">&#x2791;</td>
              <td class="CHARS">&#x2792;</td>
              <td class="CHARS">&#x2793;</td>
            </tr>
            <tr comment="SUPERSCRIPT (2070, 00B9, 00B2-00B3, 2074-2079)">
              <th align="left">SUPERSCRIPT</th>
              <td class="CHARS">&#x2070;</td>
              <td class="CHARS">&#x00B9;</td>
              <td class="CHARS">&#x00B2;</td>
              <td class="CHARS">&#x00B3;</td>
              <td class="CHARS">&#x2074;</td>
              <td class="CHARS">&#x2075;</td>
              <td class="CHARS">&#x2076;</td>
              <td class="CHARS">&#x2077;</td>
              <td class="CHARS">&#x2078;</td>
              <td class="CHARS">&#x2079;</td>
            </tr>
            <tr comment="SUBSCRIPT (2080-2089)">
              <th align="left">SUBSCRIPT</th>
              <td class="CHARS">&#x2080;</td>
              <td class="CHARS">&#x2081;</td>
              <td class="CHARS">&#x2082;</td>
              <td class="CHARS">&#x2083;</td>
              <td class="CHARS">&#x2084;</td>
              <td class="CHARS">&#x2085;</td>
              <td class="CHARS">&#x2086;</td>
              <td class="CHARS">&#x2087;</td>
              <td class="CHARS">&#x2088;</td>
              <td class="CHARS">&#x2089;</td>
            </tr>
            <tr comment="PARENTHESIZED (2474-2487)">
              <th align="left">PARENTHESIZED</th>
              <td class="CHARS" bgcolor="lightgrey" />
              <td class="CHARS">&#x2474;</td>
              <td class="CHARS">&#x2475;</td>
              <td class="CHARS">&#x2476;</td>
              <td class="CHARS">&#x2477;</td>
              <td class="CHARS">&#x2478;</td>
              <td class="CHARS">&#x2479;</td>
              <td class="CHARS">&#x247A;</td>
              <td class="CHARS">&#x247B;</td>
              <td class="CHARS">&#x247C;</td>
              <td class="CHARS">&#x247D;</td>
              <td class="CHARS">&#x247E;</td>
              <td class="CHARS">&#x247F;</td>
              <td class="CHARS">&#x2480;</td>
              <td class="CHARS">&#x2481;</td>
              <td class="CHARS">&#x2482;</td>
              <td class="CHARS">&#x2483;</td>
              <td class="CHARS">&#x2484;</td>
              <td class="CHARS">&#x2485;</td>
              <td class="CHARS">&#x2486;</td>
              <td class="CHARS">&#x2487;</td>
            </tr>
            <tr comment="FULL STOP (2488-249B)">
              <th align="left">FULL STOP</th>
              <td class="CHARS">
                &#x1F100;<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </td>
              <td class="CHARS">&#x2488;</td>
              <td class="CHARS">&#x2489;</td>
              <td class="CHARS">&#x248A;</td>
              <td class="CHARS">&#x248B;</td>
              <td class="CHARS">&#x248C;</td>
              <td class="CHARS">&#x248D;</td>
              <td class="CHARS">&#x248E;</td>
              <td class="CHARS">&#x248F;</td>
              <td class="CHARS">&#x2490;</td>
              <td class="CHARS">&#x2491;</td>
              <td class="CHARS">&#x2492;</td>
              <td class="CHARS">&#x2493;</td>
              <td class="CHARS">&#x2494;</td>
              <td class="CHARS">&#x2495;</td>
              <td class="CHARS">&#x2496;</td>
              <td class="CHARS">&#x2497;</td>
              <td class="CHARS">&#x2498;</td>
              <td class="CHARS">&#x2499;</td>
              <td class="CHARS">&#x249A;</td>
              <td class="CHARS">&#x249B;</td>
            </tr>
            <tr comment="FULLWIDTH (FF10-FF19)">
              <th align="left">FULLWIDTH</th>
              <td class="CHARS">&#xFF10;</td>
              <td class="CHARS">&#xFF11;</td>
              <td class="CHARS">&#xFF12;</td>
              <td class="CHARS">&#xFF13;</td>
              <td class="CHARS">&#xFF14;</td>
              <td class="CHARS">&#xFF15;</td>
              <td class="CHARS">&#xFF16;</td>
              <td class="CHARS">&#xFF17;</td>
              <td class="CHARS">&#xFF18;</td>
              <td class="CHARS">&#xFF19;</td>
            </tr>
            <tr comment="MATHEMATICAL BOLD (1D7CE-1D7D7)">
              <th align="left">
                MATHEMATICAL<br />BOLD<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </th>
              <td class="CHARS">&#x1D7CE;</td>
              <td class="CHARS">&#x1D7CF;</td>
              <td class="CHARS">&#x1D7D0;</td>
              <td class="CHARS">&#x1D7D1;</td>
              <td class="CHARS">&#x1D7D2;</td>
              <td class="CHARS">&#x1D7D3;</td>
              <td class="CHARS">&#x1D7D4;</td>
              <td class="CHARS">&#x1D7D5;</td>
              <td class="CHARS">&#x1D7D6;</td>
              <td class="CHARS">&#x1D7D7;</td>
            </tr>
            <tr comment="MATHEMATICAL DOUBLE-STRUCK (1D7D8-1D7E1)">
              <th align="left">
                MATHEMATICAL<br />DOUBLE-STRUCK<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </th>
              <td class="CHARS">&#x1D7D8;</td>
              <td class="CHARS">&#x1D7D9;</td>
              <td class="CHARS">&#x1D7DA;</td>
              <td class="CHARS">&#x1D7DB;</td>
              <td class="CHARS">&#x1D7DC;</td>
              <td class="CHARS">&#x1D7DD;</td>
              <td class="CHARS">&#x1D7DE;</td>
              <td class="CHARS">&#x1D7DF;</td>
              <td class="CHARS">&#x1D7E0;</td>
              <td class="CHARS">&#x1D7E1;</td>
            </tr>
            <tr comment="MATHEMATICAL SANS-SERIF (1D7E2-1D7EB)">
              <th align="left">
                MATHEMATICAL<br />SANS-SERIF<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </th>
              <td class="CHARS">&#x1D7E2;</td>
              <td class="CHARS">&#x1D7E3;</td>
              <td class="CHARS">&#x1D7E4;</td>
              <td class="CHARS">&#x1D7E5;</td>
              <td class="CHARS">&#x1D7E6;</td>
              <td class="CHARS">&#x1D7E7;</td>
              <td class="CHARS">&#x1D7E8;</td>
              <td class="CHARS">&#x1D7E9;</td>
              <td class="CHARS">&#x1D7EA;</td>
              <td class="CHARS">&#x1D7EB;</td>
            </tr>
            <tr comment="MATHEMATICAL SANS-SERIF BOLD (1D7EC-1D7F5)">
              <th align="left">
                MATHEMATICAL<br />SANS-SERIF BOLD<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </th>
              <td class="CHARS">&#x1D7EC;</td>
              <td class="CHARS">&#x1D7ED;</td>
              <td class="CHARS">&#x1D7EE;</td>
              <td class="CHARS">&#x1D7EF;</td>
              <td class="CHARS">&#x1D7F0;</td>
              <td class="CHARS">&#x1D7F1;</td>
              <td class="CHARS">&#x1D7F2;</td>
              <td class="CHARS">&#x1D7F3;</td>
              <td class="CHARS">&#x1D7F4;</td>
              <td class="CHARS">&#x1D7F5;</td>
            </tr>
            <tr comment="MATHEMATICAL MONOSPACE (1D7F6-1D7FF)">
              <th align="left">
                MATHEMATICAL<br />MONOSPACE<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </th>
              <td class="CHARS">&#x1D7F6;</td>
              <td class="CHARS">&#x1D7F7;</td>
              <td class="CHARS">&#x1D7F8;</td>
              <td class="CHARS">&#x1D7F9;</td>
              <td class="CHARS">&#x1D7FA;</td>
              <td class="CHARS">&#x1D7FB;</td>
              <td class="CHARS">&#x1D7FC;</td>
              <td class="CHARS">&#x1D7FD;</td>
              <td class="CHARS">&#x1D7FE;</td>
              <td class="CHARS">&#x1D7FF;</td>
            </tr>
            <tr comment="COMMA  (1F101-1F10A)">
              <th align="left">
                COMMA<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </th>
              <td class="CHARS">&#x1F101;</td>
              <td class="CHARS">&#x1F102;</td>
              <td class="CHARS">&#x1F103;</td>
              <td class="CHARS">&#x1F104;</td>
              <td class="CHARS">&#x1F105;</td>
              <td class="CHARS">&#x1F106;</td>
              <td class="CHARS">&#x1F107;</td>
              <td class="CHARS">&#x1F108;</td>
              <td class="CHARS">&#x1F109;</td>
              <td class="CHARS">&#x1F10A;</td>
            </tr>
            <tr comment="(spacing row)" style="height:.25em" />
            <tr comment="FRACTIONS  (002F, 00BC-00BE, 2044, 2150-215F, 2189)">
              <th align="left">FRACTIONS</th>
              <td class="CHARS">&#x002F;</td>
              <td class="CHARS">&#x00BC;</td>
              <td class="CHARS">&#x00BD;</td>
              <td class="CHARS">&#x00BE;</td>
              <td class="CHARS">&#x2044;</td>
              <td class="CHARS">&#x2150;</td>
              <td class="CHARS">&#x2151;</td>
              <td class="CHARS">&#x2152;</td>
              <td class="CHARS">&#x2153;</td>
              <td class="CHARS">&#x2154;</td>
              <td class="CHARS">&#x2155;</td>
              <td class="CHARS">&#x2156;</td>
              <td class="CHARS">&#x2157;</td>
              <td class="CHARS">&#x2158;</td>
              <td class="CHARS">&#x2159;</td>
              <td class="CHARS">&#x215A;</td>
              <td class="CHARS">&#x215B;</td>
              <td class="CHARS">&#x215C;</td>
              <td class="CHARS">&#x215D;</td>
              <td class="CHARS">&#x215E;</td>
              <td class="CHARS">&#x215F;</td>
              <td class="CHARS">&#x2189;</td>
            </tr>
            <tr comment="CIRCLED ON BLACK SQUARE (3248-324F)">
              <th align="left">
                CIRCLED<br />ON BLACK SQUARE
              </th>
              <td class="CHARS">&#x3248;</td>
              <td class="CHARS">&#x3249;</td>
              <td class="CHARS">&#x324A;</td>
              <td class="CHARS">&#x324B;</td>
              <td class="CHARS">&#x324C;</td>
              <td class="CHARS">&#x324D;</td>
              <td class="CHARS">&#x324E;</td>
              <td class="CHARS">&#x324F;</td>
            </tr>
            <tr comment="Various">
              <th align="left">Various</th>
              <td class="CHARS">&#xA698;</td>
              <td class="CHARS">&#xA699;</td>
              <td class="CHARS">
                &#x1F51E;<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </td>
              <td class="CHARS">
                &#x1F51F;<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </td>
              <td class="CHARS">
                &#x1F4AF;<a href="#noshow">
                  <sup style="font-size:initial; color:red;">
                    <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
                  </sup>
                </a>
              </td>
            </tr>
          </table>
          <p id="anchor_noshow">
            <sup style="font-size:initial; color:red;">
              <xsl:value-of select="$dagger"  disable-output-escaping="yes"/>
            </sup>Characters outside the base 16-bit chars. <span class="NOTE">(I don't think any of these would show up in Pokemon Go's font.)</span>
          </p>
        </div>

        <br />
        <hr />
        <h2 id="anchor_examples">
          Examples:
          <xsl:call-template name="Collapser">
            <xsl:with-param name="CollapseeID" select="'NAMING_EXAMPLES'" />
          </xsl:call-template>
        </h2>
        <div id="NAMING_EXAMPLES">
          <table>
            <tr>
              <td class="CHARS" style="text-align:left;">&#x277F;&#x24FF;</td>
              <td>-</td>
              <td>Pokemon with Perfect IV (100%)</td>
            </tr>
            <tr>
              <td class="CHARS" style="text-align:left;">82&#x246C;&#x246A;&#x246D;</td>
              <td>-</td>
              <td>Pokemon with Attack=13 / Defense=11 / HP=14</td>
            </tr>
            <tr>
              <td class="CHARS" style="text-align:left;">86-91</td>
              <td>-</td>
              <td>Pokemon with IV in Range of 86% to 91%</td>
            </tr>
          </table>
          <br />
          <div class="NOTE_BLOCK INDENT">
            <p>
              <b>NOTE</b>:
              I use GoIV to calculate the IV scores for my Pokemon.
              (More info <a href="/resources/index.html#GOIV">here</a>.)
              I have set it to create the basic pattern and copy it to the clipboard:
            </p>
            <div class="INDENT">
              <img class="IMAGE_HALF_WIDTH" src="/images/GoIV-Clipboard_Multiple.png" />
              <img class="IMAGE_HALF_WIDTH" src="/images/GoIV-Clipboard_Single.png" />
            </div>
            <p>
              I then paste it on the front of the Pokemon's name.
              <br />For example, if I caught a Snorlax, its name would end up something like "98&#x246E;&#x246D;&#x246E;Snorlax".
            </p>
          </div>
        </div>

        <xsl:value-of select="concat($lt, '!-- This script is defined in /js/global.js --', $gt)" disable-output-escaping="yes" />
        <script>WriteFooter();</script>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
