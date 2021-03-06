﻿<?xml version="1.0" encoding="utf-8"?>
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

        <title>Charts</title>
      </head>
      <body>
        <img class="FLOAT_RIGHT" style="margin:1em; max-height:100%; max-width:45%;" src="/images/humor/404pokemon.png" />
        <h1>
          <xsl:call-template name="HomePageLink" />
          <xsl:text> Charts</xsl:text>
        </h1>
        <p>
          Everybody loves charts for quickly looking things up.
        </p>
        <p>
          Originally, I made spreadsheets and tried to open them on my phone while playing.
          But the tables became more and more complex, and took longer and longer to load.
          Eventually, while loading the spreadsheet the phone would shut down Pokemon GO to give memory to the spreadsheet app.
        </p>
        <p>
          In the end, I started converting my spreadsheets to content on this site.
          Then, I started having more and more ideas, and started sharing the link with other Trainers, until you have what is here now.
        </p>

        <br />
        <hr />
        <h2 id="anchor_pokemon" class="PARENT">
          <a href="pokechart/">Pokemon Chart</a>
        </h2>
        <div class="CHILD INDENT">
          <p class="PARENT CHILD">
            Interested in seeing what Pokemon there are?
            How about ones that aren't even released in Pokemon GO yet?
            <br />What about getting the basic information about each of the Pokemon that <span class="EMPHASIS">have</span> been released?
            <br />Check these out!
          </p>
          <script>InsertURL('pokechart/_linkslist.html?cacherefresh={$CurrentDate}')</script>
        </div>

        <br />
        <hr />
        <h2 id="anchor_pokequick" class="PARENT">
          <a href="pokequick.html">Pokemon Quick List</a>
        </h2>
        <div class="CHILD INDENT">
          <p class="PARENT CHILD">
            Sometimes you just want to see a list of the Pokemon that fit your criteria.
            For example, maybe you want to complete a Field Research that involves catching Poison type Pokemon.
            <br />This list should help you out.
          </p>
        </div>

        <br />
        <hr />
        <h2 id="anchor_raidbosses">
          <a href="raidboss/">Possible IVs for Raid Bosses</a>
        </h2>
        <div class="INDENT">
          <p>
            After you defeat a Raid Boss in a Raid, it is time to try to catch him.
            But how good is he?
          </p>
          <div class="INDENT">
            If you look at the CP of the Raid Boss, you can figure out what possible IVs it may have.
            <br />Click on any of the Raid Bosses below to see a chart of the possibilities.
            <script>InsertURL('raidboss/_linkslist.html?cacherefresh={$CurrentDate}')</script>
          </div>
        </div>

        <br />
        <hr />
        <h2 id="anchor_movesets">
          <a href="movesets/">Pokemon Move Sets</a>
        </h2>
        <div class="INDENT">
          <p>
            As mentioned above, there are Fast moves and Charged moves.
            Every Pokemon has only one of each.
            <br />
            Of course, some moves are more effective than others.
            These pages show lists of each possible combination for each type of Pokemon, which then tells how much damage it will do.
          </p>
          <p class="NOTE">
            <b>NOTE</b>: If you find you want to change the Move Set one of your Pokemons have, you can make use of "TMs" that can be one of the rewards you get from defeating a Raid Boss.
          </p>
          <p class="PARENT">
            I have created a chart for each generation of Pokemon:
          </p>
          <div class="INDENT CHILD">
            <script>InsertURL('movesets/_linkslist.html?cacherefresh={$CurrentDate}')</script>
          </div>
        </div>

        <br />
        <hr />
        <h2 id="anchor_fieldresearch">
          <a href="research/">Research</a>
          <span class="NOTE TODO">(Beta)</span>
        </h2>
        <div class="INDENT">
          <p>
            For Field Research, you perform a Task to get a Reward.
            But what Tasks match up with which Rewards?
          </p>
          <p>
            And sometimes the Reward is an Encounter with a Pokemon.
            But what Pokemon may be the reward for the Task?
          </p>
          <p>
            These charts can help.
          </p>
        </div>

        <br />
        <hr />
        <h2 id="anchor_effectiveness">
          <a href="effectiveness.html">
            <b>Move Effectiveness</b>
          </a>
        </h2>
        <p>
          When an Attack Move is used against a Pokemon, it may either be <img src="images/supereffective.png" style="height:1em;" alt="Super Effective" /> or <img src="images/notveryeffective.png" style="height:1em;" alt="Not Very Effective" />.
          This is based on the Type of the Attack Move being used vs. the Type of the Pokemon being attacked.
          <br />This page will help you to determine what Attack Moves will be most effective against a Pokemon in battle.
        </p>

        <br />
        <hr />
        <h2 id="anchor_evolutions" class="PARENT">
          <a href="evolutions.html">Evolutions Chart</a>
        </h2>
        <div class="CHILD INDENT">
          <p class="CHILD">
            One of the fun parts of Pokemon GO is Evolving.
            But what can turn into what?
            <br />This chart can help.
          </p>
        </div>

        <br />
        <hr />
        <h2 id="anchor_naming">
          <a href="namingtechnique.html">
            <b>Pokemon Naming Technique</b>
          </a>
        </h2>
        <div class="INDENT">
          <p class="CHILD">
            If you want to create groups of Pokemon that you can find easily, you can set the names of the Pokemon and then leverage sorting and searching to get to them rapidly.
          </p>
        </div>

        <xsl:call-template name="WriteFooter" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
