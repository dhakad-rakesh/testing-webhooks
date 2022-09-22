module GoalServe
  module Feed
    class MarketList
      def call
        response
      end

      private

      def response
        '<?xml version="1.0" encoding="UTF-8"?>
          <scores sport="soccer" ts="1557739490">
              <category name="South America: Copa América" gid="1039" id="1039">
                  <matches>
                      <match status="00:30" date="Jun 15" formatted_date="15.06.2019" time="00:30" venue="Estádio Cícero Pompeu de Toledo" static_id="2581642" fix_id="3077138" id="3141448">
                          <localteam name="Brazil" goals="?" id="7084" />
                          <visitorteam name="Bolivia" goals="?" id="6979" />
                          <events />
                          <ht score="" />
                          <odds ts="1557739490">
                              <type value="Match Winner" stop="False" id="1">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.14" g="{O:\'2011465518\',OF:\'1/7\'}" id="277721843115681568" />
                                      <odd name="Draw" value="7.00" g="{O:\'2011465519\',OF:\'6/1\'}" id="277721843115701570" />
                                      <odd name="Away" value="21.00" g="{O:\'2011465520\',OF:\'20/1\'}" id="277721843115711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home/Away" stop="False" id="2">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.02" g="{O:\'2012003155\',OF:\'1/40\'}" id="277721843215681568" />
                                      <odd name="Away" value="17.00" g="{O:\'2012003156\',OF:\'16/1\'}" id="277721843215711571" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Winner" stop="False" id="3">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.30" g="{O:\'2012004205\',OF:\'3/10\'}" id="277721843315681568" />
                                      <odd name="Draw" value="3.40" g="{O:\'2012004206\',OF:\'12/5\'}" id="277721843315701570" />
                                      <odd name="Away" value="15.00" g="{O:\'2012004208\',OF:\'14/1\'}" id="277721843315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap" stop="False" id="4">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-0.25" stop="True">
                                          <odd name="Home" value="1.11" g="{O:\'2018021257\',OF:\'11/100\'}" id="277721843415261526" />
                                          <odd name="Away" value="6.60" g="{O:\'2018021258\',OF:\'28/5\'}" id="277721843415281528" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="1.15" g="{O:\'2018021255\',OF:\'3/20\'}" id="277721843415321532" />
                                          <odd name="Away" value="5.50" g="{O:\'2018021256\',OF:\'9/2\'}" id="277721843415341534" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="1.17" g="{O:\'2018021253\',OF:\'17/100\'}" id="277721843415381538" />
                                          <odd name="Away" value="5.00" g="{O:\'2018021254\',OF:\'4/1\'}" id="277721843415401540" />
                                      </handicap>
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="1.20" g="{O:\'2018021251\',OF:\'1/5\'}" id="277721843415441544" />
                                          <odd name="Away" value="4.40" g="{O:\'2018021252\',OF:\'17/5\'}" id="277721843415461546" />
                                      </handicap>
                                      <handicap name="-1.5" stop="False">
                                          <odd name="Home" value="1.47" g="{O:\'2018021247\',OF:\'19/40\'}" id="277721843415501550" />
                                          <odd name="Away" value="2.60" g="{O:\'2018021248\',OF:\'8/5\'}" id="277721843415521552" />
                                      </handicap>
                                      <handicap name="-1.25" stop="False">
                                          <odd name="Home" value="1.32" g="{O:\'2018021249\',OF:\'13/40\'}" id="277721843415561556" />
                                          <odd name="Away" value="3.30" g="{O:\'2018021250\',OF:\'23/10\'}" id="277721843415581558" />
                                      </handicap>
                                      <handicap name="-1.75" stop="False">
                                          <odd name="Home" value="1.57" g="{O:\'2018021234\',OF:\'23/40\'}" id="277721843415591559" />
                                          <odd name="Away" value="2.35" g="{O:\'2018021236\',OF:\'27/20\'}" id="277721843415611561" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="1.78" g="{O:\'2011465523\',OF:\'39/50\'}" id="277721843417021702" />
                                          <odd name="Away" value="2.13" g="{O:\'2011465524\',OF:\'9/8\'}" id="277721843417051705" />
                                      </handicap>
                                      <handicap name="-3" stop="False">
                                          <odd name="Home" value="3.10" g="{O:\'2018021173\',OF:\'21/10\'}" id="277721843417061706" />
                                          <odd name="Away" value="1.35" g="{O:\'2018021174\',OF:\'7/20\'}" id="277721843417091709" />
                                      </handicap>
                                      <handicap name="-2.5" stop="False">
                                          <odd name="Home" value="2.20" g="{O:\'2018021201\',OF:\'6/5\'}" id="277721843417671767" />
                                          <odd name="Away" value="1.65" g="{O:\'2018021203\',OF:\'13/20\'}" id="277721843417691769" />
                                      </handicap>
                                      <handicap name="-2.25" stop="False">
                                          <odd name="Home" value="2.00" g="{O:\'2018021218\',OF:\'1/1\'}" id="277721843417701770" />
                                          <odd name="Away" value="1.80" g="{O:\'2018021220\',OF:\'4/5\'}" id="277721843417721772" />
                                      </handicap>
                                      <handicap name="-2.75" stop="False">
                                          <odd name="Home" value="2.50" g="{O:\'2018021185\',OF:\'6/4\'}" id="277721843417731773" />
                                          <odd name="Away" value="1.50" g="{O:\'2018021187\',OF:\'1/2\'}" id="277721843417751775" />
                                      </handicap>
                                      <handicap name="-3.25" stop="False">
                                          <odd name="Home" value="3.55" g="{O:\'2018021163\',OF:\'51/20\'}" id="277721843420312031" />
                                          <odd name="Away" value="1.27" g="{O:\'2018021165\',OF:\'11/40\'}" id="277721843420332033" />
                                      </handicap>
                                      <handicap name="-3.75" stop="False">
                                          <odd name="Home" value="4.80" g="{O:\'2018021132\',OF:\'19/5\'}" id="277721843420712071" />
                                          <odd name="Away" value="1.17" g="{O:\'2018021133\',OF:\'7/40\'}" id="277721843420732073" />
                                      </handicap>
                                      <handicap name="-4" stop="False">
                                          <odd name="Home" value="6.80" g="{O:\'2018021076\',OF:\'29/5\'}" id="277721843420742074" />
                                          <odd name="Away" value="1.10" g="{O:\'2018021077\',OF:\'21/200\'}" id="277721843420762076" />
                                      </handicap>
                                      <handicap name="-3.5" stop="False">
                                          <odd name="Home" value="3.80" g="{O:\'2018021147\',OF:\'14/5\'}" id="277721843420802080" />
                                          <odd name="Away" value="1.25" g="{O:\'2018021149\',OF:\'1/4\'}" id="277721843420822082" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under" stop="False" id="5">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="2.62" g="{O:\'2012003763\',OF:\'13/8\'}" id="277721843515721572" />
                                          <odd name="Under" value="1.50" g="{O:\'2012003765\',OF:\'1/2\'}" id="277721843515741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="1.20" g="{O:\'2012003746\',OF:\'1/5\'}" id="277721843515751575" />
                                          <odd name="Under" value="4.50" g="{O:\'2012003747\',OF:\'7/2\'}" id="277721843515771577" />
                                      </total>
                                      <total name="4.5" stop="False">
                                          <odd name="Over" value="4.50" g="{O:\'2012003792\',OF:\'7/2\'}" id="277721843515781578" />
                                          <odd name="Under" value="1.20" g="{O:\'2012003794\',OF:\'1/5\'}" id="277721843515801580" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="1.61" g="{O:\'2011465521\',OF:\'8/13\'}" id="277721843515811581" />
                                          <odd name="Under" value="2.30" g="{O:\'2011465522\',OF:\'13/10\'}" id="277721843515831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.05" g="{O:\'2012003744\',OF:\'1/20\'}" id="277721843515841584" />
                                          <odd name="Under" value="12.00" g="{O:\'2012003745\',OF:\'11/1\'}" id="277721843515861586" />
                                      </total>
                                      <total name="5.5" stop="False">
                                          <odd name="Over" value="9.00" g="{O:\'2012003826\',OF:\'8/1\'}" id="277721843515961596" />
                                          <odd name="Under" value="1.07" g="{O:\'2012003828\',OF:\'1/14\'}" id="277721843515981598" />
                                      </total>
                                      <total name="2.25" stop="False">
                                          <odd name="Over" value="1.45" g="{O:\'2018021320\',OF:\'9/20\'}" id="277721843515991599" />
                                          <odd name="Under" value="2.67" g="{O:\'2018021321\',OF:\'67/40\'}" id="277721843516011601" />
                                      </total>
                                      <total name="3.25" stop="False">
                                          <odd name="Over" value="2.25" g="{O:\'2018021326\',OF:\'5/4\'}" id="277721843516021602" />
                                          <odd name="Under" value="1.62" g="{O:\'2018021327\',OF:\'5/8\'}" id="277721843516041604" />
                                      </total>
                                      <total name="2.75" stop="False">
                                          <odd name="Over" value="1.80" g="{O:\'2011465525\',OF:\'4/5\'}" id="277721843516051605" />
                                          <odd name="Under" value="2.10" g="{O:\'2011465526\',OF:\'11/10\'}" id="277721843516071607" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="1.11" g="{O:\'2018021293\',OF:\'23/200\'}" id="277721843516081608" />
                                          <odd name="Under" value="6.40" g="{O:\'2018021294\',OF:\'27/5\'}" id="277721843516101610" />
                                      </total>
                                      <total name="4.25" stop="False">
                                          <odd name="Over" value="4.00" g="{O:\'2018021334\',OF:\'3/1\'}" id="277721843516111611" />
                                          <odd name="Under" value="1.23" g="{O:\'2018021335\',OF:\'23/100\'}" id="277721843516131613" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="1.22" g="{O:\'2018021316\',OF:\'11/50\'}" id="277721843516141614" />
                                          <odd name="Under" value="4.15" g="{O:\'2018021317\',OF:\'63/20\'}" id="277721843516161616" />
                                      </total>
                                      <total name="3.75" stop="False">
                                          <odd name="Over" value="2.85" g="{O:\'2018021330\',OF:\'37/20\'}" id="277721843516171617" />
                                          <odd name="Under" value="1.40" g="{O:\'2018021331\',OF:\'2/5\'}" id="277721843516191619" />
                                      </total>
                                      <total name="4.75" stop="False">
                                          <odd name="Over" value="5.75" g="{O:\'2018021338\',OF:\'19/4\'}" id="277721843516201620" />
                                          <odd name="Under" value="1.14" g="{O:\'2018021339\',OF:\'7/50\'}" id="277721843516221622" />
                                      </total>
                                      <total name="6.5" stop="False">
                                          <odd name="Over" value="17.00" g="{O:\'2012003851\',OF:\'16/1\'}" id="277721843516231623" />
                                          <odd name="Under" value="1.02" g="{O:\'2012003853\',OF:\'1/40\'}" id="277721843516251625" />
                                      </total>
                                      <total name="3.0" stop="False">
                                          <odd name="Over" value="2.00" g="{O:\'2018021324\',OF:\'1/1\'}" id="277721843515901590" />
                                          <odd name="Under" value="1.80" g="{O:\'2018021325\',OF:\'4/5\'}" id="2777218435210052210052" />
                                      </total>
                                      <total name="2.0" stop="False">
                                          <odd name="Over" value="1.26" g="{O:\'2018021318\',OF:\'13/50\'}" id="277721843515871587" />
                                          <odd name="Under" value="3.70" g="{O:\'2018021319\',OF:\'27/10\'}" id="2777218435210055210055" />
                                      </total>
                                      <total name="4.0" stop="False">
                                          <odd name="Over" value="3.70" g="{O:\'2018021332\',OF:\'27/10\'}" id="277721843515931593" />
                                          <odd name="Under" value="1.26" g="{O:\'2018021333\',OF:\'13/50\'}" id="2777218435210058210058" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 1st Half" stop="False" id="6">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="15.00" g="{O:\'2012004115\',OF:\'14/1\'}" id="277721843615721572" />
                                          <odd name="Under" value="1.03" g="{O:\'2012004117\',OF:\'1/33\'}" id="277721843615741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.37" g="{O:\'2012004090\',OF:\'11/8\'}" id="277721843615751575" />
                                          <odd name="Under" value="1.53" g="{O:\'2012004092\',OF:\'8/15\'}" id="277721843615771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="5.50" g="{O:\'2012004103\',OF:\'9/2\'}" id="277721843615811581" />
                                          <odd name="Under" value="1.14" g="{O:\'2012004105\',OF:\'1/7\'}" id="277721843615831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.28" g="{O:\'2012004077\',OF:\'2/7\'}" id="277721843615841584" />
                                          <odd name="Under" value="3.50" g="{O:\'2012004079\',OF:\'5/2\'}" id="277721843615861586" />
                                      </total>
                                      <total name="2.25" stop="False">
                                          <odd name="Over" value="4.65" g="{O:\'2018021636\',OF:\'73/20\'}" id="277721843615991599" />
                                          <odd name="Under" value="1.18" g="{O:\'2018021637\',OF:\'9/50\'}" id="277721843616011601" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="1.97" g="{O:\'2011465529\',OF:\'39/40\'}" id="277721843616081608" />
                                          <odd name="Under" value="1.82" g="{O:\'2011465530\',OF:\'33/40\'}" id="277721843616101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="2.85" g="{O:\'2018021632\',OF:\'37/20\'}" id="277721843616141614" />
                                          <odd name="Under" value="1.40" g="{O:\'2018021633\',OF:\'2/5\'}" id="277721843616161616" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.37" g="{O:\'2018021578\',OF:\'3/8\'}" id="277721843616841684" />
                                          <odd name="Under" value="3.00" g="{O:\'2018021579\',OF:\'2/1\'}" id="277721843616861686" />
                                      </total>
                                      <total name="2.0" stop="False">
                                          <odd name="Over" value="4.15" g="{O:\'2018021634\',OF:\'63/20\'}" id="277721843615871587" />
                                          <odd name="Under" value="1.22" g="{O:\'2018021635\',OF:\'11/50\'}" id="2777218436210055210055" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="1.55" g="{O:\'2018021585\',OF:\'11/20\'}" id="277721843616811681" />
                                          <odd name="Under" value="2.37" g="{O:\'2018021587\',OF:\'11/8\'}" id="2777218436210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 2nd Half" stop="False" id="7">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="9.00" g="{O:\'2012004226\',OF:\'8/1\'}" id="277721843715721572" />
                                          <odd name="Under" value="1.07" g="{O:\'2012004227\',OF:\'1/14\'}" id="277721843715741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="1.83" g="{O:\'2012004222\',OF:\'5/6\'}" id="277721843715751575" />
                                          <odd name="Under" value="1.83" g="{O:\'2012004223\',OF:\'5/6\'}" id="277721843715771577" />
                                      </total>
                                      <total name="4.5" stop="False">
                                          <odd name="Over" value="21.00" g="{O:\'2012004228\',OF:\'20/1\'}" id="277721843715781578" />
                                          <odd name="Under" value="1.01" g="{O:\'2012004229\',OF:\'1/66\'}" id="277721843715801580" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="3.75" g="{O:\'2012004224\',OF:\'11/4\'}" id="277721843715811581" />
                                          <odd name="Under" value="1.25" g="{O:\'2012004225\',OF:\'1/4\'}" id="277721843715831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.18" g="{O:\'2012004213\',OF:\'2/11\'}" id="277721843715841584" />
                                          <odd name="Under" value="4.50" g="{O:\'2012004215\',OF:\'7/2\'}" id="277721843715861586" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="HT/FT Double" stop="False" id="12">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw/Bolivia" value="34.00" g="{O:\'2012003145\',OF:\'33/1\'}" id="27772184312112422112422" />
                                      <odd name="Bolivia/Draw" value="34.00" g="{O:\'2012003147\',OF:\'33/1\'}" id="27772184312112424112424" />
                                      <odd name="Bolivia/Bolivia" value="41.00" g="{O:\'2012003148\',OF:\'40/1\'}" id="27772184312112425112425" />
                                      <odd name="Draw/Draw" value="9.50" g="{O:\'2012003144\',OF:\'17/2\'}" id="2777218431216761676" />
                                      <odd name="Bolivia/Brazil" value="29.00" g="{O:\'2012003146\',OF:\'28/1\'}" id="27772184312288397288397" />
                                      <odd name="Brazil/Bolivia" value="81.00" g="{O:\'2012003142\',OF:\'80/1\'}" id="27772184312288398288398" />
                                      <odd name="Brazil/Brazil" value="1.50" g="{O:\'2012003140\',OF:\'1/2\'}" id="277721843125700857008" />
                                      <odd name="Brazil/Draw" value="29.00" g="{O:\'2012003141\',OF:\'28/1\'}" id="277721843125700957009" />
                                      <odd name="Draw/Brazil" value="3.50" g="{O:\'2012003143\',OF:\'5/2\'}" id="277721843125701157011" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Home" stop="False" id="13">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.40" g="{O:\'2012004362\',OF:\'2/5\'}" id="2777218431316291629" />
                                      <odd name="No" value="2.75" g="{O:\'2012004363\',OF:\'7/4\'}" id="2777218431316301630" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Away" stop="False" id="14">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="11.00" g="{O:\'2012004366\',OF:\'10/1\'}" id="2777218431416291629" />
                                      <odd name="No" value="1.05" g="{O:\'2012004367\',OF:\'1/20\'}" id="2777218431416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score" stop="False" id="15">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="3.00" g="{O:\'2012004411\',OF:\'2/1\'}" id="2777218431516291629" />
                                      <odd name="No" value="1.36" g="{O:\'2012004412\',OF:\'4/11\'}" id="2777218431516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result" stop="False" id="79">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="1.44" g="{O:\'2012004022\',OF:\'4/9\'}" id="2777218437915441544" />
                                          <odd name="Away" value="6.00" g="{O:\'2012004025\',OF:\'5/1\'}" id="2777218437915461546" />
                                          <odd name="Draw" value="4.33" g="{O:\'2012004024\',OF:\'10/3\'}" id="2777218437917011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.01" g="{O:\'2012004035\',OF:\'1/66\'}" id="2777218437915471547" />
                                          <odd name="Away" value="51.00" g="{O:\'2012004038\',OF:\'50/1\'}" id="2777218437915491549" />
                                          <odd name="Draw" value="23.00" g="{O:\'2012004036\',OF:\'22/1\'}" id="2777218437916961696" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="2.10" g="{O:\'2012003943\',OF:\'11/10\'}" id="2777218437917021702" />
                                          <odd name="Draw" value="3.75" g="{O:\'2012003944\',OF:\'11/4\'}" id="2777218437917041704" />
                                          <odd name="Away" value="2.60" g="{O:\'2012003945\',OF:\'8/5\'}" id="2777218437917051705" />
                                      </handicap>
                                      <handicap name="-3" stop="False">
                                          <odd name="Home" value="3.75" g="{O:\'2012004010\',OF:\'11/4\'}" id="2777218437917061706" />
                                          <odd name="Draw" value="4.50" g="{O:\'2012004012\',OF:\'7/2\'}" id="2777218437917081708" />
                                          <odd name="Away" value="1.61" g="{O:\'2012004013\',OF:\'8/13\'}" id="2777218437917091709" />
                                      </handicap>
                                      <handicap name="-4" stop="False">
                                          <odd name="Home" value="7.00" g="{O:\'2012003969\',OF:\'6/1\'}" id="2777218437920742074" />
                                          <odd name="Away" value="1.22" g="{O:\'2012003991\',OF:\'2/9\'}" id="2777218437920762076" />
                                          <odd name="Draw" value="6.50" g="{O:\'2012003975\',OF:\'11/2\'}" id="2777218437920862086" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Correct Score" stop="False" id="81">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="7.00" g="{O:\'2012003097\',OF:\'6/1\'}" id="2777218438116311631" />
                                      <odd name="2:0" value="5.00" g="{O:\'2012003098\',OF:\'4/1\'}" id="2777218438116321632" />
                                      <odd name="2:1" value="13.00" g="{O:\'2012003099\',OF:\'12/1\'}" id="2777218438116331633" />
                                      <odd name="3:0" value="5.50" g="{O:\'2012003100\',OF:\'9/2\'}" id="2777218438116341634" />
                                      <odd name="3:1" value="13.00" g="{O:\'2012003101\',OF:\'12/1\'}" id="2777218438116351635" />
                                      <odd name="3:2" value="51.00" g="{O:\'2012003102\',OF:\'50/1\'}" id="2777218438116361636" />
                                      <odd name="4:0" value="8.00" g="{O:\'2012003103\',OF:\'7/1\'}" id="2777218438116371637" />
                                      <odd name="4:1" value="19.00" g="{O:\'2012003104\',OF:\'18/1\'}" id="2777218438116381638" />
                                      <odd name="4:2" value="67.00" g="{O:\'2012003105\',OF:\'66/1\'}" id="2777218438116391639" />
                                      <odd name="4:3" value="351.00" g="{O:\'2012003106\',OF:\'350/1\'}" id="2777218438116401640" />
                                      <odd name="5:0" value="13.00" g="{O:\'2012003107\',OF:\'12/1\'}" id="2777218438116411641" />
                                      <odd name="5:1" value="34.00" g="{O:\'2012003108\',OF:\'33/1\'}" id="2777218438116421642" />
                                      <odd name="5:2" value="101.00" g="{O:\'2012003109\',OF:\'100/1\'}" id="2777218438116431643" />
                                      <odd name="6:0" value="29.00" g="{O:\'2012003110\',OF:\'28/1\'}" id="2777218438116461646" />
                                      <odd name="6:1" value="51.00" g="{O:\'2012003111\',OF:\'50/1\'}" id="2777218438116471647" />
                                      <odd name="6:2" value="201.00" g="{O:\'2012003113\',OF:\'200/1\'}" id="2777218438116481648" />
                                      <odd name="0:0" value="12.00" g="{O:\'2012003120\',OF:\'11/1\'}" id="2777218438116491649" />
                                      <odd name="1:1" value="15.00" g="{O:\'2012003121\',OF:\'14/1\'}" id="2777218438116501650" />
                                      <odd name="2:2" value="41.00" g="{O:\'2012003122\',OF:\'40/1\'}" id="2777218438116511651" />
                                      <odd name="3:3" value="201.00" g="{O:\'2012003123\',OF:\'200/1\'}" id="2777218438116521652" />
                                      <odd name="0:1" value="34.00" g="{O:\'2012003124\',OF:\'33/1\'}" id="2777218438116541654" />
                                      <odd name="0:2" value="101.00" g="{O:\'2012003125\',OF:\'100/1\'}" id="2777218438116551655" />
                                      <odd name="0:3" value="501.00" g="{O:\'2012003127\',OF:\'500/1\'}" id="2777218438116561656" />
                                      <odd name="1:2" value="51.00" g="{O:\'2012003126\',OF:\'50/1\'}" id="2777218438116601660" />
                                      <odd name="1:3" value="251.00" g="{O:\'2012003128\',OF:\'250/1\'}" id="2777218438116611661" />
                                      <odd name="2:3" value="201.00" g="{O:\'2012003129\',OF:\'200/1\'}" id="2777218438116651665" />
                                      <odd name="7:0" value="51.00" g="{O:\'2012003114\',OF:\'50/1\'}" id="2777218438117851785" />
                                      <odd name="7:1" value="101.00" g="{O:\'2012003115\',OF:\'100/1\'}" id="2777218438117861786" />
                                      <odd name="7:2" value="451.00" g="{O:\'2012003116\',OF:\'450/1\'}" id="2777218438117871787" />
                                      <odd name="8:0" value="101.00" g="{O:\'2012003117\',OF:\'100/1\'}" id="2777218438120342034" />
                                      <odd name="8:1" value="251.00" g="{O:\'2012003118\',OF:\'250/1\'}" id="2777218438120352035" />
                                      <odd name="9:0" value="301.00" g="{O:\'2012003119\',OF:\'300/1\'}" id="2777218438120952095" />
                                  </bookmaker>
                              </type>
                              <type value="Highest Scoring Half" stop="False" id="91">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw" value="3.75" g="{O:\'2012004203\',OF:\'11/4\'}" id="2777218439115701570" />
                                      <odd name="1st Half" value="3.00" g="{O:\'2012004201\',OF:\'2/1\'}" id="2777218439116941694" />
                                      <odd name="2nd Half" value="2.00" g="{O:\'2012004202\',OF:\'1/1\'}" id="2777218439116951695" />
                                  </bookmaker>
                              </type>
                              <type value="Correct Score 1st Half" stop="False" id="181">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="2.87" g="{O:\'2012003223\',OF:\'15/8\'}" id="27772184318116311631" />
                                      <odd name="2:0" value="4.50" g="{O:\'2012003224\',OF:\'7/2\'}" id="27772184318116321632" />
                                      <odd name="2:1" value="23.00" g="{O:\'2012003225\',OF:\'22/1\'}" id="27772184318116331633" />
                                      <odd name="3:0" value="11.00" g="{O:\'2012003226\',OF:\'10/1\'}" id="27772184318116341634" />
                                      <odd name="3:1" value="41.00" g="{O:\'2012003227\',OF:\'40/1\'}" id="27772184318116351635" />
                                      <odd name="3:2" value="301.00" g="{O:\'2012003228\',OF:\'300/1\'}" id="27772184318116361636" />
                                      <odd name="4:0" value="29.00" g="{O:\'2012003229\',OF:\'28/1\'}" id="27772184318116371637" />
                                      <odd name="4:1" value="101.00" g="{O:\'2012003230\',OF:\'100/1\'}" id="27772184318116381638" />
                                      <odd name="5:0" value="81.00" g="{O:\'2012003231\',OF:\'80/1\'}" id="27772184318116411641" />
                                      <odd name="5:1" value="351.00" g="{O:\'2012003232\',OF:\'350/1\'}" id="27772184318116421642" />
                                      <odd name="6:0" value="301.00" g="{O:\'2012003234\',OF:\'300/1\'}" id="27772184318116461646" />
                                      <odd name="0:0" value="3.50" g="{O:\'2012003235\',OF:\'5/2\'}" id="27772184318116491649" />
                                      <odd name="1:1" value="15.00" g="{O:\'2012003237\',OF:\'14/1\'}" id="27772184318116501650" />
                                      <odd name="2:2" value="126.00" g="{O:\'2012003239\',OF:\'125/1\'}" id="27772184318116511651" />
                                      <odd name="0:1" value="19.00" g="{O:\'2012003241\',OF:\'18/1\'}" id="27772184318116541654" />
                                      <odd name="0:2" value="101.00" g="{O:\'2012003243\',OF:\'100/1\'}" id="27772184318116551655" />
                                      <odd name="1:2" value="81.00" g="{O:\'2012003245\',OF:\'80/1\'}" id="27772184318116601660" />
                                  </bookmaker>
                              </type>
                              <type value="Double Chance" stop="False" id="222">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.01" g="{O:\'2012003096\',OF:\'1/66\'}" id="27772184322216261626" />
                                      <odd name="Home/Away" value="1.11" g="{O:\'2012003095\',OF:\'1/9\'}" id="27772184322216271627" />
                                      <odd name="Draw/Away" value="6.00" g="{O:\'2012003094\',OF:\'5/1\'}" id="27772184322216281628" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Winner" stop="False" id="2102">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.50" g="{O:\'2012003214\',OF:\'1/2\'}" id="277721843210215681568" />
                                      <odd name="Draw" value="2.87" g="{O:\'2012003215\',OF:\'15/8\'}" id="277721843210215701570" />
                                      <odd name="Away" value="17.00" g="{O:\'2012003217\',OF:\'16/1\'}" id="277721843210215711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score First" stop="False" id="2224">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.10" g="{O:\'2012003274\',OF:\'1/10\'}" id="277721843222415681568" />
                                      <odd name="Draw" value="12.00" g="{O:\'2012003275\',OF:\'11/1\'}" id="277721843222415701570" />
                                      <odd name="Away" value="8.00" g="{O:\'2012003276\',OF:\'7/1\'}" id="277721843222415711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score Last" stop="False" id="2225">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.10" g="{O:\'2012004420\',OF:\'1/10\'}" id="277721843222515681568" />
                                      <odd name="Away" value="8.00" g="{O:\'2012004422\',OF:\'7/1\'}" id="277721843222515711571" />
                                      <odd name="No goal" value="12.00" g="{O:\'2012004421\',OF:\'11/1\'}" id="277721843222516871687" />
                                  </bookmaker>
                              </type>
                              <type value="Win Both Halves" stop="False" id="2293">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.00" g="{O:\'2012004511\',OF:\'1/1\'}" id="277721843229315681568" />
                                      <odd name="Away" value="101.00" g="{O:\'2012004521\',OF:\'100/1\'}" id="277721843229315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Total - Home" stop="False" id="22124">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="3.25" g="{O:\'2012004273\',OF:\'9/4\'}" id="2777218432212415721572" />
                                          <odd name="Under" value="1.33" g="{O:\'2012004274\',OF:\'1/3\'}" id="2777218432212415741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="1.28" g="{O:\'2012004264\',OF:\'2/7\'}" id="2777218432212415751575" />
                                          <odd name="Under" value="3.50" g="{O:\'2012004266\',OF:\'5/2\'}" id="2777218432212415771577" />
                                      </total>
                                      <total name="4.5" stop="False">
                                          <odd name="Over" value="6.50" g="{O:\'2012004275\',OF:\'11/2\'}" id="2777218432212415781578" />
                                          <odd name="Under" value="1.11" g="{O:\'2012004276\',OF:\'1/9\'}" id="2777218432212415801580" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="1.83" g="{O:\'2012004271\',OF:\'5/6\'}" id="2777218432212415811581" />
                                          <odd name="Under" value="1.83" g="{O:\'2012004272\',OF:\'5/6\'}" id="2777218432212415831583" />
                                      </total>
                                      <total name="5.5" stop="False">
                                          <odd name="Over" value="13.00" g="{O:\'2012004279\',OF:\'12/1\'}" id="2777218432212415961596" />
                                          <odd name="Under" value="1.04" g="{O:\'2012004280\',OF:\'1/25\'}" id="2777218432212415981598" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Total - Away" stop="False" id="22125">
                                  <bookmaker name="bet365" stop="False" ts="1557739490" id="16">
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="13.00" g="{O:\'2012004288\',OF:\'12/1\'}" id="2777218432212515751575" />
                                          <odd name="Under" value="1.04" g="{O:\'2012004289\',OF:\'1/25\'}" id="2777218432212515771577" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result 1st Half" stop="False" id="22600">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="3.00" g="{O:\'2012004190\',OF:\'2/1\'}" id="2777218432260015441544" />
                                          <odd name="Away" value="2.62" g="{O:\'2012004192\',OF:\'13/8\'}" id="2777218432260015461546" />
                                          <odd name="Draw" value="2.62" g="{O:\'2012004191\',OF:\'13/8\'}" id="2777218432260017011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.02" g="{O:\'2012004196\',OF:\'1/50\'}" id="2777218432260015471547" />
                                          <odd name="Away" value="67.00" g="{O:\'2012004198\',OF:\'66/1\'}" id="2777218432260015491549" />
                                          <odd name="Draw" value="17.00" g="{O:\'2012004197\',OF:\'16/1\'}" id="2777218432260016961696" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="7.50" g="{O:\'2012004193\',OF:\'13/2\'}" id="2777218432260017021702" />
                                          <odd name="Draw" value="4.33" g="{O:\'2012004194\',OF:\'10/3\'}" id="2777218432260017041704" />
                                          <odd name="Away" value="1.33" g="{O:\'2012004195\',OF:\'1/3\'}" id="2777218432260017051705" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap First Half" stop="False" id="22601">
                                  <bookmaker name="bet365" stop="False" ts="1557706791" id="16">
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="1.27" g="{O:\'2018021441\',OF:\'11/40\'}" id="2777218432260115261526" />
                                          <odd name="Away" value="3.55" g="{O:\'2018021442\',OF:\'51/20\'}" id="2777218432260115281528" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="1.50" g="{O:\'2018021439\',OF:\'1/2\'}" id="2777218432260115321532" />
                                          <odd name="Away" value="2.50" g="{O:\'2018021440\',OF:\'6/4\'}" id="2777218432260115341534" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="1.67" g="{O:\'2018021437\',OF:\'27/40\'}" id="2777218432260115381538" />
                                          <odd name="Away" value="2.15" g="{O:\'2018021438\',OF:\'23/20\'}" id="2777218432260115401540" />
                                      </handicap>
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="2.07" g="{O:\'2011465527\',OF:\'43/40\'}" id="2777218432260115441544" />
                                          <odd name="Away" value="1.72" g="{O:\'2011465528\',OF:\'29/40\'}" id="2777218432260115461546" />
                                      </handicap>
                                      <handicap name="-1.5" stop="False">
                                          <odd name="Home" value="3.00" g="{O:\'2018021422\',OF:\'2/1\'}" id="2777218432260115501550" />
                                          <odd name="Away" value="1.37" g="{O:\'2018021423\',OF:\'3/8\'}" id="2777218432260115521552" />
                                      </handicap>
                                      <handicap name="-1.25" stop="False">
                                          <odd name="Home" value="2.50" g="{O:\'2018021435\',OF:\'6/4\'}" id="2777218432260115561556" />
                                          <odd name="Away" value="1.50" g="{O:\'2018021436\',OF:\'1/2\'}" id="2777218432260115581558" />
                                      </handicap>
                                      <handicap name="-1.75" stop="False">
                                          <odd name="Home" value="3.90" g="{O:\'2018021382\',OF:\'29/10\'}" id="2777218432260115591559" />
                                          <odd name="Away" value="1.24" g="{O:\'2018021384\',OF:\'6/25\'}" id="2777218432260115611561" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="6.40" g="{O:\'2018021374\',OF:\'27/5\'}" id="2777218432260117021702" />
                                          <odd name="Away" value="1.11" g="{O:\'2018021375\',OF:\'23/200\'}" id="2777218432260117051705" />
                                      </handicap>
                                      <handicap name="-2.25" stop="False">
                                          <odd name="Home" value="7.00" g="{O:\'2018021372\',OF:\'6/1\'}" id="2777218432260117701770" />
                                          <odd name="Away" value="1.10" g="{O:\'2018021373\',OF:\'1/10\'}" id="2777218432260117721772" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Double Chance - 1st Half" stop="False" id="22602">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.02" g="{O:\'2012003289\',OF:\'1/50\'}" id="2777218432260216261626" />
                                      <odd name="Home/Away" value="1.42" g="{O:\'2012003288\',OF:\'21/50\'}" id="2777218432260216271627" />
                                      <odd name="Draw/Away" value="2.62" g="{O:\'2012003287\',OF:\'13/8\'}" id="2777218432260216281628" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 1st Half" stop="False" id="22604">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="8.00" g="{O:\'2012004568\',OF:\'7/1\'}" id="2777218432260416291629" />
                                      <odd name="No" value="1.08" g="{O:\'2012004569\',OF:\'1/12\'}" id="2777218432260416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 2nd Half" stop="False" id="22605">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="6.00" g="{O:\'2012004596\',OF:\'5/1\'}" id="2777218432260516291629" />
                                      <odd name="No" value="1.12" g="{O:\'2012004597\',OF:\'1/8\'}" id="2777218432260516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Win To Nil" stop="False" id="22607">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.50" g="{O:\'2012004456\',OF:\'1/2\'}" id="2777218432260715681568" />
                                      <odd name="Away" value="29.00" g="{O:\'2012004477\',OF:\'28/1\'}" id="2777218432260715711571" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even" stop="False" id="22608">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="1.95" g="{O:\'2012003191\',OF:\'19/20\'}" id="2777218432260816881688" />
                                      <odd name="Even" value="1.90" g="{O:\'2012003187\',OF:\'9/10\'}" id="2777218432260816891689" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even 1st Half" stop="False" id="22609">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="2.00" g="{O:\'2012003271\',OF:\'1/1\'}" id="2777218432260916881688" />
                                      <odd name="Even" value="1.80" g="{O:\'2012003268\',OF:\'4/5\'}" id="2777218432260916891689" />
                                  </bookmaker>
                              </type>
                              <type value="Exact Goals Number" stop="False" id="22614">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="4.00" g="{O:\'2012003937\',OF:\'3/1\'}" id="2777218432261415881588" />
                                      <odd name="3" value="4.00" g="{O:\'2012003938\',OF:\'3/1\'}" id="2777218432261415911591" />
                                      <odd name="4" value="5.00" g="{O:\'2012003939\',OF:\'4/1\'}" id="2777218432261415941594" />
                                      <odd name="1" value="6.50" g="{O:\'2012003936\',OF:\'11/2\'}" id="2777218432261416821682" />
                                      <odd name="0" value="12.00" g="{O:\'2012003935\',OF:\'11/1\'}" id="2777218432261416901690" />
                                      <odd name="5" value="8.00" g="{O:\'2012003940\',OF:\'7/1\'}" id="2777218432261416911691" />
                                      <odd name="6" value="15.00" g="{O:\'2012003941\',OF:\'14/1\'}" id="2777218432261416921692" />
                                      <odd name="more 7" value="17.00" g="{O:\'2012003942\',OF:\'16/1\'}" id="2777218432261416931693" />
                                  </bookmaker>
                              </type>
                              <type value="To Win Either Half" stop="False" id="22615">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.08" g="{O:\'2012004502\',OF:\'1/12\'}" id="2777218432261515681568" />
                                      <odd name="Away" value="9.00" g="{O:\'2012004507\',OF:\'8/1\'}" id="2777218432261515711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home Team Exact Goals Number" stop="False" id="22616">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.60" g="{O:\'2012004556\',OF:\'13/5\'}" id="2777218432261615881588" />
                                      <odd name="1" value="4.75" g="{O:\'2012004555\',OF:\'15/4\'}" id="2777218432261616821682" />
                                      <odd name="0" value="11.00" g="{O:\'2012004554\',OF:\'10/1\'}" id="2777218432261616901690" />
                                      <odd name="more 3" value="1.83" g="{O:\'2012004557\',OF:\'5/6\'}" id="2777218432261617201720" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Exact Goals Number" stop="False" id="22617">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="15.00" g="{O:\'2012004560\',OF:\'14/1\'}" id="2777218432261715881588" />
                                      <odd name="1" value="3.25" g="{O:\'2012004559\',OF:\'9/4\'}" id="2777218432261716821682" />
                                      <odd name="0" value="1.40" g="{O:\'2012004558\',OF:\'2/5\'}" id="2777218432261716901690" />
                                      <odd name="more 3" value="51.00" g="{O:\'2012004561\',OF:\'50/1\'}" id="2777218432261717201720" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Exact Goals Number" stop="False" id="22619">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.40" g="{O:\'2012004243\',OF:\'12/5\'}" id="2777218432261915881588" />
                                      <odd name="3" value="6.00" g="{O:\'2012004244\',OF:\'5/1\'}" id="2777218432261915911591" />
                                      <odd name="4" value="13.00" g="{O:\'2012004245\',OF:\'12/1\'}" id="2777218432261915941594" />
                                      <odd name="1" value="3.00" g="{O:\'2012004242\',OF:\'2/1\'}" id="2777218432261916821682" />
                                      <odd name="0" value="4.50" g="{O:\'2012004240\',OF:\'7/2\'}" id="2777218432261916901690" />
                                      <odd name="more 5" value="21.00" g="{O:\'2012004246\',OF:\'20/1\'}" id="2777218432261917271727" />
                                  </bookmaker>
                              </type>
                              <type value="Results/Both Teams To Score" stop="False" id="22620">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Yes" value="4.00" g="{O:\'2012004534\',OF:\'3/1\'}" id="2777218432262017211721" />
                                      <odd name="Draw/Yes" value="11.00" g="{O:\'2012004536\',OF:\'10/1\'}" id="2777218432262017221722" />
                                      <odd name="Away/Yes" value="41.00" g="{O:\'2012004538\',OF:\'40/1\'}" id="2777218432262017231723" />
                                      <odd name="Home/No" value="1.50" g="{O:\'2012004535\',OF:\'1/2\'}" id="2777218432262017241724" />
                                      <odd name="Draw/No" value="12.00" g="{O:\'2012004537\',OF:\'11/1\'}" id="2777218432262017251725" />
                                      <odd name="Away/No" value="29.00" g="{O:\'2012004539\',OF:\'28/1\'}" id="2777218432262017261726" />
                                  </bookmaker>
                              </type>
                              <type value="Result/Total Goals" stop="False" id="22621">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="2.5" stop="False">
                                          <odd name="Home/Over" value="1.66" g="{O:\'2012004423\',OF:\'4/6\'}" id="2777218432262117141714" />
                                          <odd name="Draw/Over" value="41.00" g="{O:\'2012004425\',OF:\'40/1\'}" id="2777218432262117151715" />
                                          <odd name="Away/Over" value="41.00" g="{O:\'2012004427\',OF:\'40/1\'}" id="2777218432262117161716" />
                                          <odd name="Home/Under" value="3.00" g="{O:\'2012004424\',OF:\'2/1\'}" id="2777218432262117171717" />
                                          <odd name="Draw/Under" value="7.50" g="{O:\'2012004426\',OF:\'13/2\'}" id="2777218432262117181718" />
                                          <odd name="Away/Under" value="29.00" g="{O:\'2012004428\',OF:\'28/1\'}" id="2777218432262117191719" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Home Team Score a Goal" stop="False" id="22622">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.05" g="{O:\'2012004367\',OF:\'1/20\'}" id="2777218432262216291629" />
                                      <odd name="No" value="11.00" g="{O:\'2012004366\',OF:\'10/1\'}" id="2777218432262216301630" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Score a Goal" stop="False" id="22623">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="2.75" g="{O:\'2012004363\',OF:\'7/4\'}" id="2777218432262316291629" />
                                      <odd name="No" value="1.40" g="{O:\'2012004362\',OF:\'2/5\'}" id="2777218432262316301630" />
                                  </bookmaker>
                              </type>
                              <type value="First 10 min Winner" stop="False" id="22626">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="4.75" g="{O:\'2012069767\',OF:\'15/4\'}" id="2777218432262615681568" />
                                      <odd name="Draw" value="1.20" g="{O:\'2012069768\',OF:\'1/5\'}" id="2777218432262615701570" />
                                      <odd name="Away" value="34.00" g="{O:\'2012069769\',OF:\'33/1\'}" id="2777218432262615711571" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Exact Goals Number" stop="False" id="22655">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.75" g="{O:\'2012004182\',OF:\'11/4\'}" id="2777218432265515881588" />
                                      <odd name="3" value="8.00" g="{O:\'2012004183\',OF:\'7/1\'}" id="2777218432265515911591" />
                                      <odd name="4" value="21.00" g="{O:\'2012004184\',OF:\'20/1\'}" id="2777218432265515941594" />
                                      <odd name="1" value="2.62" g="{O:\'2012004181\',OF:\'13/8\'}" id="2777218432265516821682" />
                                      <odd name="0" value="3.50" g="{O:\'2012004180\',OF:\'5/2\'}" id="2777218432265516901690" />
                                      <odd name="more 5" value="41.00" g="{O:\'2012004185\',OF:\'40/1\'}" id="2777218432265517271727" />
                                  </bookmaker>
                              </type>
                          </odds>
                      </match>
                      <match status="19:00" date="Jun 15" formatted_date="15.06.2019" time="19:00" venue="Arena do Grêmio" static_id="2581643" fix_id="3077139" id="3141449">
                          <localteam name="Venezuela" goals="?" id="17504" />
                          <visitorteam name="Peru" goals="?" id="13898" />
                          <events />
                          <ht score="" />
                          <odds ts="1557739490">
                              <type value="Match Winner" stop="False" id="1">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="3.75" g="{O:\'2011465533\',OF:\'11/4\'}" id="277721943115681568" />
                                      <odd name="Draw" value="3.00" g="{O:\'2011465534\',OF:\'2/1\'}" id="277721943115701570" />
                                      <odd name="Away" value="2.15" g="{O:\'2011465535\',OF:\'23/20\'}" id="277721943115711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home/Away" stop="False" id="2">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.62" g="{O:\'2012011457\',OF:\'13/8\'}" id="277721943215681568" />
                                      <odd name="Away" value="1.44" g="{O:\'2012011458\',OF:\'4/9\'}" id="277721943215711571" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Winner" stop="False" id="3">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="3.75" g="{O:\'2012012405\',OF:\'11/4\'}" id="277721943315681568" />
                                      <odd name="Draw" value="2.20" g="{O:\'2012012406\',OF:\'6/5\'}" id="277721943315701570" />
                                      <odd name="Away" value="2.50" g="{O:\'2012012407\',OF:\'6/4\'}" id="277721943315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap" stop="False" id="4">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="+0" stop="False">
                                          <odd name="Home" value="2.60" g="{O:\'2018023001\',OF:\'8/5\'}" id="277721943415231523" />
                                          <odd name="Away" value="1.47" g="{O:\'2018023002\',OF:\'19/40\'}" id="277721943415251525" />
                                      </handicap>
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="3.10" g="{O:\'2018022999\',OF:\'21/10\'}" id="277721943415261526" />
                                          <odd name="Away" value="1.35" g="{O:\'2018023000\',OF:\'7/20\'}" id="277721943415281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="2.05" g="{O:\'2011465538\',OF:\'21/20\'}" id="277721943415291529" />
                                          <odd name="Away" value="1.85" g="{O:\'2011465539\',OF:\'17/20\'}" id="277721943415311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="3.55" g="{O:\'2018022997\',OF:\'51/20\'}" id="277721943415321532" />
                                          <odd name="Away" value="1.27" g="{O:\'2018022998\',OF:\'11/40\'}" id="277721943415341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="1.70" g="{O:\'2018023003\',OF:\'7/10\'}" id="277721943415351535" />
                                          <odd name="Away" value="2.10" g="{O:\'2018023004\',OF:\'11/10\'}" id="277721943415371537" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="4.80" g="{O:\'2018022995\',OF:\'19/5\'}" id="277721943415381538" />
                                          <odd name="Away" value="1.17" g="{O:\'2018022996\',OF:\'7/40\'}" id="277721943415401540" />
                                      </handicap>
                                      <handicap name="+0.75" stop="False">
                                          <odd name="Home" value="1.50" g="{O:\'2018023005\',OF:\'1/2\'}" id="277721943415411541" />
                                          <odd name="Away" value="2.50" g="{O:\'2018023006\',OF:\'6/4\'}" id="277721943415431543" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.30" g="{O:\'2018023007\',OF:\'3/10\'}" id="277721943415471547" />
                                          <odd name="Away" value="3.45" g="{O:\'2018023008\',OF:\'49/20\'}" id="277721943415491549" />
                                      </handicap>
                                      <handicap name="+1.5" stop="False">
                                          <odd name="Home" value="1.21" g="{O:\'2018023013\',OF:\'21/100\'}" id="277721943415531553" />
                                          <odd name="Away" value="4.25" g="{O:\'2018023014\',OF:\'13/4\'}" id="277721943415551555" />
                                      </handicap>
                                      <handicap name="+1.25" stop="False">
                                          <odd name="Home" value="1.25" g="{O:\'2018023009\',OF:\'1/4\'}" id="277721943415621562" />
                                          <odd name="Away" value="3.80" g="{O:\'2018023010\',OF:\'14/5\'}" id="277721943415641564" />
                                      </handicap>
                                      <handicap name="+1.75" stop="False">
                                          <odd name="Home" value="1.13" g="{O:\'2018023015\',OF:\'13/100\'}" id="277721943415651565" />
                                          <odd name="Away" value="5.90" g="{O:\'2018023016\',OF:\'49/10\'}" id="277721943415671567" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under" stop="False" id="5">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="5.00" g="{O:\'2012012130\',OF:\'4/1\'}" id="277721943515721572" />
                                          <odd name="Under" value="1.16" g="{O:\'2012012131\',OF:\'1/6\'}" id="277721943515741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="1.50" g="{O:\'2012012128\',OF:\'1/2\'}" id="277721943515751575" />
                                          <odd name="Under" value="2.62" g="{O:\'2012012129\',OF:\'13/8\'}" id="277721943515771577" />
                                      </total>
                                      <total name="4.5" stop="False">
                                          <odd name="Over" value="11.00" g="{O:\'2012012134\',OF:\'10/1\'}" id="277721943515781578" />
                                          <odd name="Under" value="1.05" g="{O:\'2012012135\',OF:\'1/20\'}" id="277721943515801580" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="2.50" g="{O:\'2011465536\',OF:\'6/4\'}" id="277721943515811581" />
                                          <odd name="Under" value="1.53" g="{O:\'2011465537\',OF:\'8/15\'}" id="277721943515831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.11" g="{O:\'2012012126\',OF:\'1/9\'}" id="277721943515841584" />
                                          <odd name="Under" value="6.50" g="{O:\'2012012127\',OF:\'11/2\'}" id="277721943515861586" />
                                      </total>
                                      <total name="5.5" stop="False">
                                          <odd name="Over" value="23.00" g="{O:\'2012012136\',OF:\'22/1\'}" id="277721943515961596" />
                                          <odd name="Under" value="1.01" g="{O:\'2012012137\',OF:\'1/80\'}" id="277721943515981598" />
                                      </total>
                                      <total name="2.25" stop="False">
                                          <odd name="Over" value="2.25" g="{O:\'2018023037\',OF:\'5/4\'}" id="277721943515991599" />
                                          <odd name="Under" value="1.62" g="{O:\'2018023038\',OF:\'5/8\'}" id="277721943516011601" />
                                      </total>
                                      <total name="3.25" stop="False">
                                          <odd name="Over" value="4.50" g="{O:\'2018023054\',OF:\'7/2\'}" id="277721943516021602" />
                                          <odd name="Under" value="1.19" g="{O:\'2018023055\',OF:\'19/100\'}" id="277721943516041604" />
                                      </total>
                                      <total name="2.75" stop="False">
                                          <odd name="Over" value="3.10" g="{O:\'2018023041\',OF:\'21/10\'}" id="277721943516051605" />
                                          <odd name="Under" value="1.35" g="{O:\'2018023042\',OF:\'7/20\'}" id="277721943516071607" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="1.32" g="{O:\'2018023031\',OF:\'13/40\'}" id="277721943516081608" />
                                          <odd name="Under" value="3.30" g="{O:\'2018023032\',OF:\'23/10\'}" id="277721943516101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="1.65" g="{O:\'2018023035\',OF:\'13/20\'}" id="277721943516141614" />
                                          <odd name="Under" value="2.20" g="{O:\'2018023036\',OF:\'6/5\'}" id="277721943516161616" />
                                      </total>
                                      <total name="3.75" stop="False">
                                          <odd name="Over" value="6.40" g="{O:\'2018023061\',OF:\'27/5\'}" id="277721943516171617" />
                                          <odd name="Under" value="1.11" g="{O:\'2018023062\',OF:\'23/200\'}" id="277721943516191619" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.13" g="{O:\'2018023027\',OF:\'13/100\'}" id="277721943516841684" />
                                          <odd name="Under" value="5.90" g="{O:\'2018023028\',OF:\'49/10\'}" id="277721943516861686" />
                                      </total>
                                      <total name="3.0" stop="False">
                                          <odd name="Over" value="4.10" g="{O:\'2018023045\',OF:\'31/10\'}" id="277721943515901590" />
                                          <odd name="Under" value="1.22" g="{O:\'2018023047\',OF:\'9/40\'}" id="2777219435210052210052" />
                                      </total>
                                      <total name="2.0" stop="False">
                                          <odd name="Over" value="1.95" g="{O:\'2011465540\',OF:\'19/20\'}" id="277721943515871587" />
                                          <odd name="Under" value="1.95" g="{O:\'2011465541\',OF:\'19/20\'}" id="2777219435210055210055" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="1.16" g="{O:\'2018023029\',OF:\'4/25\'}" id="277721943516811681" />
                                          <odd name="Under" value="5.25" g="{O:\'2018023030\',OF:\'17/4\'}" id="2777219435210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 1st Half" stop="False" id="6">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="3.75" g="{O:\'2012012305\',OF:\'11/4\'}" id="277721943615751575" />
                                          <odd name="Under" value="1.25" g="{O:\'2012012306\',OF:\'1/4\'}" id="277721943615771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="11.00" g="{O:\'2012012309\',OF:\'10/1\'}" id="277721943615811581" />
                                          <odd name="Under" value="1.05" g="{O:\'2012012310\',OF:\'1/20\'}" id="277721943615831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.57" g="{O:\'2012012303\',OF:\'4/7\'}" id="277721943615841584" />
                                          <odd name="Under" value="2.25" g="{O:\'2012012304\',OF:\'5/4\'}" id="277721943615861586" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="3.10" g="{O:\'2018023158\',OF:\'21/10\'}" id="277721943616081608" />
                                          <odd name="Under" value="1.35" g="{O:\'2018023159\',OF:\'7/20\'}" id="277721943616101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="5.25" g="{O:\'2018023162\',OF:\'17/4\'}" id="277721943616141614" />
                                          <odd name="Under" value="1.16" g="{O:\'2018023163\',OF:\'4/25\'}" id="277721943616161616" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.82" g="{O:\'2011465544\',OF:\'33/40\'}" id="277721943616841684" />
                                          <odd name="Under" value="1.97" g="{O:\'2011465545\',OF:\'39/40\'}" id="277721943616861686" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="2.42" g="{O:\'2018023156\',OF:\'57/40\'}" id="277721943616811681" />
                                          <odd name="Under" value="1.52" g="{O:\'2018023157\',OF:\'21/40\'}" id="2777219436210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 2nd Half" stop="False" id="7">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="19.00" g="{O:\'2012012421\',OF:\'18/1\'}" id="277721943715721572" />
                                          <odd name="Under" value="1.02" g="{O:\'2012012422\',OF:\'1/50\'}" id="277721943715741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.62" g="{O:\'2012012412\',OF:\'13/8\'}" id="277721943715751575" />
                                          <odd name="Under" value="1.44" g="{O:\'2012012413\',OF:\'4/9\'}" id="277721943715771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="6.50" g="{O:\'2012012417\',OF:\'11/2\'}" id="277721943715811581" />
                                          <odd name="Under" value="1.11" g="{O:\'2012012418\',OF:\'1/9\'}" id="277721943715831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.33" g="{O:\'2012012408\',OF:\'1/3\'}" id="277721943715841584" />
                                          <odd name="Under" value="3.25" g="{O:\'2012012409\',OF:\'9/4\'}" id="277721943715861586" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="HT/FT Double" stop="False" id="12">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Venezuela/Venezuela" value="6.00" g="{O:\'2012011446\',OF:\'5/1\'}" id="27772194312112426112426" />
                                      <odd name="Venezuela/Draw" value="15.00" g="{O:\'2012011447\',OF:\'14/1\'}" id="27772194312112427112427" />
                                      <odd name="Venezuela/Peru" value="29.00" g="{O:\'2012011448\',OF:\'28/1\'}" id="27772194312112428112428" />
                                      <odd name="Draw/Venezuela" value="7.50" g="{O:\'2012011449\',OF:\'13/2\'}" id="27772194312112429112429" />
                                      <odd name="Draw/Peru" value="4.75" g="{O:\'2012011452\',OF:\'15/4\'}" id="27772194312112430112430" />
                                      <odd name="Peru/Venezuela" value="41.00" g="{O:\'2012011454\',OF:\'40/1\'}" id="27772194312112431112431" />
                                      <odd name="Peru/Draw" value="15.00" g="{O:\'2012011455\',OF:\'14/1\'}" id="27772194312112432112432" />
                                      <odd name="Peru/Peru" value="3.60" g="{O:\'2012011456\',OF:\'13/5\'}" id="27772194312112433112433" />
                                      <odd name="Draw/Draw" value="4.33" g="{O:\'2012011450\',OF:\'10/3\'}" id="2777219431216761676" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Home" stop="False" id="13">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="3.40" g="{O:\'2012012589\',OF:\'12/5\'}" id="2777219431316291629" />
                                      <odd name="No" value="1.30" g="{O:\'2012012590\',OF:\'3/10\'}" id="2777219431316301630" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Away" stop="False" id="14">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="2.25" g="{O:\'2012012624\',OF:\'5/4\'}" id="2777219431416291629" />
                                      <odd name="No" value="1.57" g="{O:\'2012012626\',OF:\'4/7\'}" id="2777219431416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score" stop="False" id="15">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="2.10" g="{O:\'2012012636\',OF:\'11/10\'}" id="2777219431516291629" />
                                      <odd name="No" value="1.66" g="{O:\'2012012637\',OF:\'4/6\'}" id="2777219431516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result" stop="False" id="79">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="9.00" g="{O:\'2012012214\',OF:\'8/1\'}" id="2777219437915441544" />
                                          <odd name="Away" value="1.28" g="{O:\'2012012216\',OF:\'2/7\'}" id="2777219437915461546" />
                                          <odd name="Draw" value="5.00" g="{O:\'2012012215\',OF:\'4/1\'}" id="2777219437917011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.72" g="{O:\'2012012165\',OF:\'8/11\'}" id="2777219437915471547" />
                                          <odd name="Away" value="4.33" g="{O:\'2012012167\',OF:\'10/3\'}" id="2777219437915491549" />
                                          <odd name="Draw" value="3.60" g="{O:\'2012012166\',OF:\'13/5\'}" id="2777219437916961696" />
                                      </handicap>
                                      <handicap name="+2" stop="False">
                                          <odd name="Home" value="1.18" g="{O:\'2012012217\',OF:\'2/11\'}" id="2777219437916971697" />
                                          <odd name="Draw" value="6.00" g="{O:\'2012012218\',OF:\'5/1\'}" id="2777219437916991699" />
                                          <odd name="Away" value="10.00" g="{O:\'2012012219\',OF:\'9/1\'}" id="2777219437917001700" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="19.00" g="{O:\'2012012168\',OF:\'18/1\'}" id="2777219437917021702" />
                                          <odd name="Draw" value="10.00" g="{O:\'2012012169\',OF:\'9/1\'}" id="2777219437917041704" />
                                          <odd name="Away" value="1.05" g="{O:\'2012012170\',OF:\'1/18\'}" id="2777219437917051705" />
                                      </handicap>
                                      <handicap name="+3" stop="False">
                                          <odd name="Home" value="1.04" g="{O:\'2012012220\',OF:\'1/22\'}" id="2777219437917101710" />
                                          <odd name="Draw" value="11.00" g="{O:\'2012012221\',OF:\'10/1\'}" id="2777219437917121712" />
                                          <odd name="Away" value="19.00" g="{O:\'2012012222\',OF:\'18/1\'}" id="2777219437917131713" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Correct Score" stop="False" id="81">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="8.50" g="{O:\'2012011384\',OF:\'15/2\'}" id="2777219438116311631" />
                                      <odd name="2:0" value="17.00" g="{O:\'2012011385\',OF:\'16/1\'}" id="2777219438116321632" />
                                      <odd name="2:1" value="15.00" g="{O:\'2012011386\',OF:\'14/1\'}" id="2777219438116331633" />
                                      <odd name="3:0" value="41.00" g="{O:\'2012011387\',OF:\'40/1\'}" id="2777219438116341634" />
                                      <odd name="3:1" value="41.00" g="{O:\'2012011388\',OF:\'40/1\'}" id="2777219438116351635" />
                                      <odd name="3:2" value="51.00" g="{O:\'2012011389\',OF:\'50/1\'}" id="2777219438116361636" />
                                      <odd name="4:0" value="126.00" g="{O:\'2012011390\',OF:\'125/1\'}" id="2777219438116371637" />
                                      <odd name="4:1" value="101.00" g="{O:\'2012011391\',OF:\'100/1\'}" id="2777219438116381638" />
                                      <odd name="4:2" value="151.00" g="{O:\'2012011392\',OF:\'150/1\'}" id="2777219438116391639" />
                                      <odd name="4:3" value="301.00" g="{O:\'2012011393\',OF:\'300/1\'}" id="2777219438116401640" />
                                      <odd name="5:0" value="501.00" g="{O:\'2012011394\',OF:\'500/1\'}" id="2777219438116411641" />
                                      <odd name="5:1" value="451.00" g="{O:\'2012011395\',OF:\'450/1\'}" id="2777219438116421642" />
                                      <odd name="0:0" value="6.50" g="{O:\'2012011396\',OF:\'11/2\'}" id="2777219438116491649" />
                                      <odd name="1:1" value="6.00" g="{O:\'2012011397\',OF:\'5/1\'}" id="2777219438116501650" />
                                      <odd name="2:2" value="19.00" g="{O:\'2012011398\',OF:\'18/1\'}" id="2777219438116511651" />
                                      <odd name="3:3" value="81.00" g="{O:\'2012011399\',OF:\'80/1\'}" id="2777219438116521652" />
                                      <odd name="0:1" value="5.50" g="{O:\'2012011400\',OF:\'9/2\'}" id="2777219438116541654" />
                                      <odd name="0:2" value="9.00" g="{O:\'2012011401\',OF:\'8/1\'}" id="2777219438116551655" />
                                      <odd name="0:3" value="19.00" g="{O:\'2012011403\',OF:\'18/1\'}" id="2777219438116561656" />
                                      <odd name="0:4" value="41.00" g="{O:\'2012011408\',OF:\'40/1\'}" id="2777219438116571657" />
                                      <odd name="0:5" value="126.00" g="{O:\'2012011412\',OF:\'125/1\'}" id="2777219438116581658" />
                                      <odd name="0:6" value="451.00" g="{O:\'2012011415\',OF:\'450/1\'}" id="2777219438116591659" />
                                      <odd name="1:2" value="9.50" g="{O:\'2012011402\',OF:\'17/2\'}" id="2777219438116601660" />
                                      <odd name="1:3" value="21.00" g="{O:\'2012011404\',OF:\'20/1\'}" id="2777219438116611661" />
                                      <odd name="1:4" value="51.00" g="{O:\'2012011409\',OF:\'50/1\'}" id="2777219438116621662" />
                                      <odd name="1:5" value="126.00" g="{O:\'2012011413\',OF:\'125/1\'}" id="2777219438116631663" />
                                      <odd name="1:6" value="501.00" g="{O:\'2012011416\',OF:\'500/1\'}" id="2777219438116641664" />
                                      <odd name="2:3" value="41.00" g="{O:\'2012011405\',OF:\'40/1\'}" id="2777219438116651665" />
                                      <odd name="2:4" value="81.00" g="{O:\'2012011410\',OF:\'80/1\'}" id="2777219438116661666" />
                                      <odd name="2:5" value="251.00" g="{O:\'2012011414\',OF:\'250/1\'}" id="2777219438116671667" />
                                      <odd name="3:4" value="201.00" g="{O:\'2012011411\',OF:\'200/1\'}" id="2777219438116691669" />
                                  </bookmaker>
                              </type>
                              <type value="Highest Scoring Half" stop="False" id="91">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw" value="3.10" g="{O:\'2012012386\',OF:\'21/10\'}" id="2777219439115701570" />
                                      <odd name="1st Half" value="3.20" g="{O:\'2012012384\',OF:\'11/5\'}" id="2777219439116941694" />
                                      <odd name="2nd Half" value="2.20" g="{O:\'2012012385\',OF:\'6/5\'}" id="2777219439116951695" />
                                  </bookmaker>
                              </type>
                              <type value="Correct Score 1st Half" stop="False" id="181">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="5.50" g="{O:\'2012011464\',OF:\'9/2\'}" id="27772194318116311631" />
                                      <odd name="2:0" value="23.00" g="{O:\'2012011465\',OF:\'22/1\'}" id="27772194318116321632" />
                                      <odd name="2:1" value="34.00" g="{O:\'2012011466\',OF:\'33/1\'}" id="27772194318116331633" />
                                      <odd name="3:0" value="81.00" g="{O:\'2012011467\',OF:\'80/1\'}" id="27772194318116341634" />
                                      <odd name="3:1" value="151.00" g="{O:\'2012011468\',OF:\'150/1\'}" id="27772194318116351635" />
                                      <odd name="3:2" value="451.00" g="{O:\'2012011469\',OF:\'450/1\'}" id="27772194318116361636" />
                                      <odd name="0:0" value="2.25" g="{O:\'2012011470\',OF:\'5/4\'}" id="27772194318116491649" />
                                      <odd name="1:1" value="9.00" g="{O:\'2012011471\',OF:\'8/1\'}" id="27772194318116501650" />
                                      <odd name="2:2" value="81.00" g="{O:\'2012011472\',OF:\'80/1\'}" id="27772194318116511651" />
                                      <odd name="0:1" value="4.00" g="{O:\'2012011473\',OF:\'3/1\'}" id="27772194318116541654" />
                                      <odd name="0:2" value="13.00" g="{O:\'2012011474\',OF:\'12/1\'}" id="27772194318116551655" />
                                      <odd name="0:3" value="51.00" g="{O:\'2012011476\',OF:\'50/1\'}" id="27772194318116561656" />
                                      <odd name="0:4" value="201.00" g="{O:\'2012011479\',OF:\'200/1\'}" id="27772194318116571657" />
                                      <odd name="1:2" value="29.00" g="{O:\'2012011475\',OF:\'28/1\'}" id="27772194318116601660" />
                                      <odd name="1:3" value="81.00" g="{O:\'2012011477\',OF:\'80/1\'}" id="27772194318116611661" />
                                      <odd name="1:4" value="501.00" g="{O:\'2012011480\',OF:\'500/1\'}" id="27772194318116621662" />
                                      <odd name="2:3" value="351.00" g="{O:\'2012011478\',OF:\'350/1\'}" id="27772194318116651665" />
                                  </bookmaker>
                              </type>
                              <type value="Double Chance" stop="False" id="222">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.72" g="{O:\'2012011383\',OF:\'8/11\'}" id="27772194322216261626" />
                                      <odd name="Home/Away" value="1.40" g="{O:\'2012011382\',OF:\'2/5\'}" id="27772194322216271627" />
                                      <odd name="Draw/Away" value="1.28" g="{O:\'2012011381\',OF:\'2/7\'}" id="27772194322216281628" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Winner" stop="False" id="2102">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="4.33" g="{O:\'2012011461\',OF:\'10/3\'}" id="277721943210215681568" />
                                      <odd name="Draw" value="1.95" g="{O:\'2012011462\',OF:\'20/21\'}" id="277721943210215701570" />
                                      <odd name="Away" value="3.00" g="{O:\'2012011463\',OF:\'2/1\'}" id="277721943210215711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score First" stop="False" id="2224">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.62" g="{O:\'2012011486\',OF:\'13/8\'}" id="277721943222415681568" />
                                      <odd name="Draw" value="6.50" g="{O:\'2012011487\',OF:\'11/2\'}" id="277721943222415701570" />
                                      <odd name="Away" value="1.72" g="{O:\'2012011488\',OF:\'8/11\'}" id="277721943222415711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score Last" stop="False" id="2225">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.62" g="{O:\'2012012668\',OF:\'13/8\'}" id="277721943222515681568" />
                                      <odd name="Away" value="1.72" g="{O:\'2012012670\',OF:\'8/11\'}" id="277721943222515711571" />
                                      <odd name="No goal" value="6.50" g="{O:\'2012012669\',OF:\'11/2\'}" id="277721943222516871687" />
                                  </bookmaker>
                              </type>
                              <type value="Win Both Halves" stop="False" id="2293">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="15.00" g="{O:\'2012012807\',OF:\'14/1\'}" id="277721943229315681568" />
                                      <odd name="Away" value="8.00" g="{O:\'2012012817\',OF:\'7/1\'}" id="277721943229315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Total - Home" stop="False" id="22124">
                                  <bookmaker name="bet365" stop="False" ts="1557739490" id="16">
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="4.00" g="{O:\'2012012488\',OF:\'3/1\'}" id="2777219432212415751575" />
                                          <odd name="Under" value="1.22" g="{O:\'2012012489\',OF:\'2/9\'}" id="2777219432212415771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="13.00" g="{O:\'2012012490\',OF:\'12/1\'}" id="2777219432212415811581" />
                                          <odd name="Under" value="1.04" g="{O:\'2012012491\',OF:\'1/25\'}" id="2777219432212415831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Total - Away" stop="False" id="22125">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="19.00" g="{O:\'2012012547\',OF:\'18/1\'}" id="2777219432212515721572" />
                                          <odd name="Under" value="1.02" g="{O:\'2012012548\',OF:\'1/50\'}" id="2777219432212515741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.50" g="{O:\'2012012498\',OF:\'6/4\'}" id="2777219432212515751575" />
                                          <odd name="Under" value="1.50" g="{O:\'2012012499\',OF:\'1/2\'}" id="2777219432212515771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="6.50" g="{O:\'2012012500\',OF:\'11/2\'}" id="2777219432212515811581" />
                                          <odd name="Under" value="1.11" g="{O:\'2012012501\',OF:\'1/9\'}" id="2777219432212515831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result 1st Half" stop="False" id="22600">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="17.00" g="{O:\'2012012374\',OF:\'16/1\'}" id="2777219432260015441544" />
                                          <odd name="Away" value="1.20" g="{O:\'2012012377\',OF:\'1/5\'}" id="2777219432260015461546" />
                                          <odd name="Draw" value="4.75" g="{O:\'2012012376\',OF:\'15/4\'}" id="2777219432260017011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.36" g="{O:\'2012012371\',OF:\'4/11\'}" id="2777219432260015471547" />
                                          <odd name="Away" value="10.00" g="{O:\'2012012373\',OF:\'9/1\'}" id="2777219432260015491549" />
                                          <odd name="Draw" value="3.60" g="{O:\'2012012372\',OF:\'13/5\'}" id="2777219432260016961696" />
                                      </handicap>
                                      <handicap name="+2" stop="False">
                                          <odd name="Home" value="1.05" g="{O:\'2012012381\',OF:\'1/20\'}" id="2777219432260016971697" />
                                          <odd name="Draw" value="11.00" g="{O:\'2012012382\',OF:\'10/1\'}" id="2777219432260016991699" />
                                          <odd name="Away" value="23.00" g="{O:\'2012012383\',OF:\'22/1\'}" id="2777219432260017001700" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap First Half" stop="False" id="22601">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="+0" stop="False">
                                          <odd name="Home" value="2.37" g="{O:\'2018023081\',OF:\'11/8\'}" id="2777219432260115231523" />
                                          <odd name="Away" value="1.55" g="{O:\'2018023082\',OF:\'11/20\'}" id="2777219432260115251525" />
                                      </handicap>
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="3.45" g="{O:\'2018023079\',OF:\'49/20\'}" id="2777219432260115261526" />
                                          <odd name="Away" value="1.30" g="{O:\'2018023080\',OF:\'3/10\'}" id="2777219432260115281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="1.62" g="{O:\'2011465542\',OF:\'5/8\'}" id="2777219432260115291529" />
                                          <odd name="Away" value="2.25" g="{O:\'2011465543\',OF:\'5/4\'}" id="2777219432260115311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="4.40" g="{O:\'2018023077\',OF:\'17/5\'}" id="2777219432260115321532" />
                                          <odd name="Away" value="1.20" g="{O:\'2018023078\',OF:\'1/5\'}" id="2777219432260115341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="1.40" g="{O:\'2018023083\',OF:\'2/5\'}" id="2777219432260115351535" />
                                          <odd name="Away" value="2.85" g="{O:\'2018023084\',OF:\'37/20\'}" id="2777219432260115371537" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="6.60" g="{O:\'2018023075\',OF:\'28/5\'}" id="2777219432260115381538" />
                                          <odd name="Away" value="1.11" g="{O:\'2018023076\',OF:\'11/100\'}" id="2777219432260115401540" />
                                      </handicap>
                                      <handicap name="+0.75" stop="False">
                                          <odd name="Home" value="1.24" g="{O:\'2018023085\',OF:\'6/25\'}" id="2777219432260115411541" />
                                          <odd name="Away" value="3.90" g="{O:\'2018023086\',OF:\'29/10\'}" id="2777219432260115431543" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Double Chance - 1st Half" stop="False" id="22602">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.36" g="{O:\'2012011492\',OF:\'4/11\'}" id="2777219432260216261626" />
                                      <odd name="Home/Away" value="1.80" g="{O:\'2012011491\',OF:\'4/5\'}" id="2777219432260216271627" />
                                      <odd name="Draw/Away" value="1.20" g="{O:\'2012011490\',OF:\'1/5\'}" id="2777219432260216281628" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 1st Half" stop="False" id="22604">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="6.00" g="{O:\'2012013647\',OF:\'5/1\'}" id="2777219432260416291629" />
                                      <odd name="No" value="1.12" g="{O:\'2012013650\',OF:\'1/8\'}" id="2777219432260416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 2nd Half" stop="False" id="22605">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="4.33" g="{O:\'2012013722\',OF:\'10/3\'}" id="2777219432260516291629" />
                                      <odd name="No" value="1.20" g="{O:\'2012013723\',OF:\'1/5\'}" id="2777219432260516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Win To Nil" stop="False" id="22607">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="5.50" g="{O:\'2012012734\',OF:\'9/2\'}" id="2777219432260715681568" />
                                      <odd name="Away" value="3.20" g="{O:\'2012012749\',OF:\'11/5\'}" id="2777219432260715711571" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even" stop="False" id="22608">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="1.95" g="{O:\'2012011460\',OF:\'19/20\'}" id="2777219432260816881688" />
                                      <odd name="Even" value="1.90" g="{O:\'2012011459\',OF:\'9/10\'}" id="2777219432260816891689" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even 1st Half" stop="False" id="22609">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="2.20" g="{O:\'2012011485\',OF:\'6/5\'}" id="2777219432260916881688" />
                                      <odd name="Even" value="1.66" g="{O:\'2012011484\',OF:\'4/6\'}" id="2777219432260916891689" />
                                  </bookmaker>
                              </type>
                              <type value="Exact Goals Number" stop="False" id="22614">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.25" g="{O:\'2012012159\',OF:\'9/4\'}" id="2777219432261415881588" />
                                      <odd name="3" value="4.75" g="{O:\'2012012160\',OF:\'15/4\'}" id="2777219432261415911591" />
                                      <odd name="4" value="8.00" g="{O:\'2012012161\',OF:\'7/1\'}" id="2777219432261415941594" />
                                      <odd name="1" value="3.75" g="{O:\'2012012158\',OF:\'11/4\'}" id="2777219432261416821682" />
                                      <odd name="0" value="6.50" g="{O:\'2012012157\',OF:\'11/2\'}" id="2777219432261416901690" />
                                      <odd name="5" value="19.00" g="{O:\'2012012162\',OF:\'18/1\'}" id="2777219432261416911691" />
                                      <odd name="6" value="41.00" g="{O:\'2012012163\',OF:\'40/1\'}" id="2777219432261416921692" />
                                      <odd name="more 7" value="51.00" g="{O:\'2012012164\',OF:\'50/1\'}" id="2777219432261416931693" />
                                  </bookmaker>
                              </type>
                              <type value="To Win Either Half" stop="False" id="22615">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.37" g="{O:\'2012012771\',OF:\'11/8\'}" id="2777219432261515681568" />
                                      <odd name="Away" value="1.66" g="{O:\'2012012796\',OF:\'4/6\'}" id="2777219432261515711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home Team Exact Goals Number" stop="False" id="22616">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="5.50" g="{O:\'2012013554\',OF:\'9/2\'}" id="2777219432261615881588" />
                                      <odd name="1" value="2.40" g="{O:\'2012013551\',OF:\'7/5\'}" id="2777219432261616821682" />
                                      <odd name="0" value="2.25" g="{O:\'2012013550\',OF:\'5/4\'}" id="2777219432261616901690" />
                                      <odd name="more 3" value="13.00" g="{O:\'2012013557\',OF:\'12/1\'}" id="2777219432261617201720" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Exact Goals Number" stop="False" id="22617">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.75" g="{O:\'2012013577\',OF:\'11/4\'}" id="2777219432261715881588" />
                                      <odd name="1" value="2.50" g="{O:\'2012013574\',OF:\'6/4\'}" id="2777219432261716821682" />
                                      <odd name="0" value="3.40" g="{O:\'2012013571\',OF:\'12/5\'}" id="2777219432261716901690" />
                                      <odd name="more 3" value="6.50" g="{O:\'2012013580\',OF:\'11/2\'}" id="2777219432261717201720" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Exact Goals Number" stop="False" id="22619">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="4.00" g="{O:\'2012012475\',OF:\'3/1\'}" id="2777219432261915881588" />
                                      <odd name="3" value="9.00" g="{O:\'2012012477\',OF:\'8/1\'}" id="2777219432261915911591" />
                                      <odd name="4" value="26.00" g="{O:\'2012012478\',OF:\'25/1\'}" id="2777219432261915941594" />
                                      <odd name="1" value="2.60" g="{O:\'2012012472\',OF:\'8/5\'}" id="2777219432261916821682" />
                                      <odd name="0" value="3.25" g="{O:\'2012012470\',OF:\'9/4\'}" id="2777219432261916901690" />
                                      <odd name="more 5" value="51.00" g="{O:\'2012012482\',OF:\'50/1\'}" id="2777219432261917271727" />
                                  </bookmaker>
                              </type>
                              <type value="Results/Both Teams To Score" stop="False" id="22620">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Yes" value="9.50" g="{O:\'2012012907\',OF:\'17/2\'}" id="2777219432262017211721" />
                                      <odd name="Draw/Yes" value="4.75" g="{O:\'2012012912\',OF:\'15/4\'}" id="2777219432262017221722" />
                                      <odd name="Away/Yes" value="5.50" g="{O:\'2012012914\',OF:\'9/2\'}" id="2777219432262017231723" />
                                      <odd name="Home/No" value="5.50" g="{O:\'2012012909\',OF:\'9/2\'}" id="2777219432262017241724" />
                                      <odd name="Draw/No" value="6.50" g="{O:\'2012012913\',OF:\'11/2\'}" id="2777219432262017251725" />
                                      <odd name="Away/No" value="3.20" g="{O:\'2012012916\',OF:\'11/5\'}" id="2777219432262017261726" />
                                  </bookmaker>
                              </type>
                              <type value="Result/Total Goals" stop="False" id="22621">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="2.5" stop="False">
                                          <odd name="Home/Over" value="8.00" g="{O:\'2012012686\',OF:\'7/1\'}" id="2777219432262117141714" />
                                          <odd name="Draw/Over" value="17.00" g="{O:\'2012012689\',OF:\'16/1\'}" id="2777219432262117151715" />
                                          <odd name="Away/Over" value="4.33" g="{O:\'2012012693\',OF:\'10/3\'}" id="2777219432262117161716" />
                                          <odd name="Home/Under" value="6.50" g="{O:\'2012012688\',OF:\'11/2\'}" id="2777219432262117171717" />
                                          <odd name="Draw/Under" value="3.40" g="{O:\'2012012691\',OF:\'12/5\'}" id="2777219432262117181718" />
                                          <odd name="Away/Under" value="3.75" g="{O:\'2012012694\',OF:\'11/4\'}" id="2777219432262117191719" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Home Team Score a Goal" stop="False" id="22622">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.57" g="{O:\'2012012626\',OF:\'4/7\'}" id="2777219432262216291629" />
                                      <odd name="No" value="2.25" g="{O:\'2012012624\',OF:\'5/4\'}" id="2777219432262216301630" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Score a Goal" stop="False" id="22623">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.30" g="{O:\'2012012590\',OF:\'3/10\'}" id="2777219432262316291629" />
                                      <odd name="No" value="3.40" g="{O:\'2012012589\',OF:\'12/5\'}" id="2777219432262316301630" />
                                  </bookmaker>
                              </type>
                              <type value="First 10 min Winner" stop="False" id="22626">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="15.00" g="{O:\'2012071507\',OF:\'14/1\'}" id="2777219432262615681568" />
                                      <odd name="Draw" value="1.12" g="{O:\'2012071508\',OF:\'1/8\'}" id="2777219432262615701570" />
                                      <odd name="Away" value="10.00" g="{O:\'2012071509\',OF:\'9/1\'}" id="2777219432262615711571" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Exact Goals Number" stop="False" id="22655">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="5.00" g="{O:\'2012012367\',OF:\'4/1\'}" id="2777219432265515881588" />
                                      <odd name="3" value="15.00" g="{O:\'2012012368\',OF:\'14/1\'}" id="2777219432265515911591" />
                                      <odd name="4" value="41.00" g="{O:\'2012012369\',OF:\'40/1\'}" id="2777219432265515941594" />
                                      <odd name="1" value="2.50" g="{O:\'2012012366\',OF:\'6/4\'}" id="2777219432265516821682" />
                                      <odd name="0" value="2.25" g="{O:\'2012012365\',OF:\'5/4\'}" id="2777219432265516901690" />
                                      <odd name="more 5" value="126.00" g="{O:\'2012012370\',OF:\'125/1\'}" id="2777219432265517271727" />
                                  </bookmaker>
                              </type>
                          </odds>
                      </match>
                      <match status="22:00" date="Jun 15" formatted_date="15.06.2019" time="22:00" venue="Arena Fonte Nova" static_id="2581644" fix_id="3077140" id="3141450">
                          <localteam name="Argentina" goals="?" id="5886" />
                          <visitorteam name="Colombia" goals="?" id="8117" />
                          <events />
                          <ht score="" />
                          <odds ts="1557739490">
                              <type value="Match Winner" stop="False" id="1">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.15" g="{O:\'2011465564\',OF:\'23/20\'}" id="277721643115681568" />
                                      <odd name="Draw" value="3.20" g="{O:\'2011465565\',OF:\'11/5\'}" id="277721643115701570" />
                                      <odd name="Away" value="3.50" g="{O:\'2011465566\',OF:\'5/2\'}" id="277721643115711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home/Away" stop="False" id="2">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.53" g="{O:\'2012000649\',OF:\'8/15\'}" id="277721643215681568" />
                                      <odd name="Away" value="2.37" g="{O:\'2012000650\',OF:\'11/8\'}" id="277721643215711571" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Winner" stop="False" id="3">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.50" g="{O:\'2012001953\',OF:\'6/4\'}" id="277721643315681568" />
                                      <odd name="Draw" value="2.30" g="{O:\'2012001954\',OF:\'13/10\'}" id="277721643315701570" />
                                      <odd name="Away" value="3.50" g="{O:\'2012001955\',OF:\'5/2\'}" id="277721643315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap" stop="False" id="4">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="+0" stop="False">
                                          <odd name="Home" value="1.52" g="{O:\'2018020515\',OF:\'21/40\'}" id="277721643415231523" />
                                          <odd name="Away" value="2.42" g="{O:\'2018020516\',OF:\'57/40\'}" id="277721643415251525" />
                                      </handicap>
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="1.87" g="{O:\'2011465569\',OF:\'87/100\'}" id="277721643415261526" />
                                          <odd name="Away" value="2.03" g="{O:\'2011465570\',OF:\'103/100\'}" id="277721643415281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="1.37" g="{O:\'2018020517\',OF:\'3/8\'}" id="277721643415291529" />
                                          <odd name="Away" value="3.00" g="{O:\'2018020518\',OF:\'2/1\'}" id="277721643415311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="2.10" g="{O:\'2018020513\',OF:\'11/10\'}" id="277721643415321532" />
                                          <odd name="Away" value="1.70" g="{O:\'2018020514\',OF:\'7/10\'}" id="277721643415341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="1.30" g="{O:\'2018020519\',OF:\'3/10\'}" id="277721643415351535" />
                                          <odd name="Away" value="3.45" g="{O:\'2018020520\',OF:\'49/20\'}" id="277721643415371537" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="2.50" g="{O:\'2018020511\',OF:\'6/4\'}" id="277721643415381538" />
                                          <odd name="Away" value="1.50" g="{O:\'2018020512\',OF:\'1/2\'}" id="277721643415401540" />
                                      </handicap>
                                      <handicap name="+0.75" stop="False">
                                          <odd name="Home" value="1.20" g="{O:\'2018020521\',OF:\'1/5\'}" id="277721643415411541" />
                                          <odd name="Away" value="4.40" g="{O:\'2018020522\',OF:\'17/5\'}" id="277721643415431543" />
                                      </handicap>
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="3.30" g="{O:\'2018020509\',OF:\'23/10\'}" id="277721643415441544" />
                                          <odd name="Away" value="1.32" g="{O:\'2018020510\',OF:\'13/40\'}" id="277721643415461546" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.10" g="{O:\'2018020523\',OF:\'1/10\'}" id="277721643415471547" />
                                          <odd name="Away" value="7.00" g="{O:\'2018020524\',OF:\'6/1\'}" id="277721643415491549" />
                                      </handicap>
                                      <handicap name="-1.5" stop="False">
                                          <odd name="Home" value="4.15" g="{O:\'2018020505\',OF:\'63/20\'}" id="277721643415501550" />
                                          <odd name="Away" value="1.22" g="{O:\'2018020506\',OF:\'11/50\'}" id="277721643415521552" />
                                      </handicap>
                                      <handicap name="-1.25" stop="False">
                                          <odd name="Home" value="3.70" g="{O:\'2018020507\',OF:\'27/10\'}" id="277721643415561556" />
                                          <odd name="Away" value="1.26" g="{O:\'2018020508\',OF:\'13/50\'}" id="277721643415581558" />
                                      </handicap>
                                      <handicap name="-1.75" stop="False">
                                          <odd name="Home" value="5.75" g="{O:\'2018020503\',OF:\'19/4\'}" id="277721643415591559" />
                                          <odd name="Away" value="1.14" g="{O:\'2018020504\',OF:\'7/50\'}" id="277721643415611561" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under" stop="False" id="5">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="4.33" g="{O:\'2012001524\',OF:\'10/3\'}" id="277721643515721572" />
                                          <odd name="Under" value="1.22" g="{O:\'2012001527\',OF:\'2/9\'}" id="277721643515741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="1.40" g="{O:\'2012001491\',OF:\'2/5\'}" id="277721643515751575" />
                                          <odd name="Under" value="3.00" g="{O:\'2012001493\',OF:\'2/1\'}" id="277721643515771577" />
                                      </total>
                                      <total name="4.5" stop="False">
                                          <odd name="Over" value="9.00" g="{O:\'2012001570\',OF:\'8/1\'}" id="277721643515781578" />
                                          <odd name="Under" value="1.07" g="{O:\'2012001573\',OF:\'1/14\'}" id="277721643515801580" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="2.30" g="{O:\'2011465567\',OF:\'13/10\'}" id="277721643515811581" />
                                          <odd name="Under" value="1.61" g="{O:\'2011465568\',OF:\'8/13\'}" id="277721643515831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.08" g="{O:\'2012001437\',OF:\'1/12\'}" id="277721643515841584" />
                                          <odd name="Under" value="8.00" g="{O:\'2012001439\',OF:\'7/1\'}" id="277721643515861586" />
                                      </total>
                                      <total name="5.5" stop="False">
                                          <odd name="Over" value="19.00" g="{O:\'2012001586\',OF:\'18/1\'}" id="277721643515961596" />
                                          <odd name="Under" value="1.02" g="{O:\'2012001587\',OF:\'1/50\'}" id="277721643515981598" />
                                      </total>
                                      <total name="2.25" stop="False">
                                          <odd name="Over" value="2.05" g="{O:\'2011465571\',OF:\'21/20\'}" id="277721643515991599" />
                                          <odd name="Under" value="1.85" g="{O:\'2011465572\',OF:\'17/20\'}" id="277721643516011601" />
                                      </total>
                                      <total name="3.25" stop="False">
                                          <odd name="Over" value="3.80" g="{O:\'2018020563\',OF:\'14/5\'}" id="277721643516021602" />
                                          <odd name="Under" value="1.25" g="{O:\'2018020565\',OF:\'1/4\'}" id="277721643516041604" />
                                      </total>
                                      <total name="2.75" stop="False">
                                          <odd name="Over" value="2.67" g="{O:\'2018020559\',OF:\'67/40\'}" id="277721643516051605" />
                                          <odd name="Under" value="1.45" g="{O:\'2018020560\',OF:\'9/20\'}" id="277721643516071607" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="1.26" g="{O:\'2018020549\',OF:\'13/50\'}" id="277721643516081608" />
                                          <odd name="Under" value="3.70" g="{O:\'2018020550\',OF:\'27/10\'}" id="277721643516101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="1.52" g="{O:\'2018020553\',OF:\'21/40\'}" id="277721643516141614" />
                                          <odd name="Under" value="2.42" g="{O:\'2018020554\',OF:\'57/40\'}" id="277721643516161616" />
                                      </total>
                                      <total name="3.75" stop="False">
                                          <odd name="Over" value="5.50" g="{O:\'2018020570\',OF:\'9/2\'}" id="277721643516171617" />
                                          <odd name="Under" value="1.15" g="{O:\'2018020571\',OF:\'3/20\'}" id="277721643516191619" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.10" g="{O:\'2018020545\',OF:\'1/10\'}" id="277721643516841684" />
                                          <odd name="Under" value="7.00" g="{O:\'2018020546\',OF:\'6/1\'}" id="277721643516861686" />
                                      </total>
                                      <total name="3.0" stop="False">
                                          <odd name="Over" value="3.45" g="{O:\'2018020561\',OF:\'49/20\'}" id="277721643515901590" />
                                          <odd name="Under" value="1.30" g="{O:\'2018020562\',OF:\'3/10\'}" id="2777216435210052210052" />
                                      </total>
                                      <total name="2.0" stop="False">
                                          <odd name="Over" value="1.70" g="{O:\'2018020555\',OF:\'7/10\'}" id="277721643515871587" />
                                          <odd name="Under" value="2.10" g="{O:\'2018020556\',OF:\'11/10\'}" id="2777216435210055210055" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="1.12" g="{O:\'2018020547\',OF:\'3/25\'}" id="277721643516811681" />
                                          <odd name="Under" value="6.25" g="{O:\'2018020548\',OF:\'21/4\'}" id="2777216435210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 1st Half" stop="False" id="6">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="26.00" g="{O:\'2012001874\',OF:\'25/1\'}" id="277721643615721572" />
                                          <odd name="Under" value="1.01" g="{O:\'2012001875\',OF:\'1/100\'}" id="277721643615741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="3.40" g="{O:\'2012001862\',OF:\'12/5\'}" id="277721643615751575" />
                                          <odd name="Under" value="1.30" g="{O:\'2012001865\',OF:\'3/10\'}" id="277721643615771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="10.00" g="{O:\'2012001872\',OF:\'9/1\'}" id="277721643615811581" />
                                          <odd name="Under" value="1.06" g="{O:\'2012001873\',OF:\'1/16\'}" id="277721643615831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.50" g="{O:\'2012001850\',OF:\'1/2\'}" id="277721643615841584" />
                                          <odd name="Under" value="2.50" g="{O:\'2012001851\',OF:\'6/4\'}" id="277721643615861586" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="2.75" g="{O:\'2018020906\',OF:\'7/4\'}" id="277721643616081608" />
                                          <odd name="Under" value="1.42" g="{O:\'2018020909\',OF:\'17/40\'}" id="277721643616101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="4.40" g="{O:\'2018020931\',OF:\'17/5\'}" id="277721643616141614" />
                                          <odd name="Under" value="1.20" g="{O:\'2018020933\',OF:\'1/5\'}" id="277721643616161616" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.70" g="{O:\'2011465575\',OF:\'7/10\'}" id="277721643616841684" />
                                          <odd name="Under" value="2.10" g="{O:\'2011465576\',OF:\'11/10\'}" id="277721643616861686" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="2.15" g="{O:\'2018020893\',OF:\'23/20\'}" id="277721643616811681" />
                                          <odd name="Under" value="1.67" g="{O:\'2018020895\',OF:\'27/40\'}" id="2777216436210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 2nd Half" stop="False" id="7">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="15.00" g="{O:\'2012002008\',OF:\'14/1\'}" id="277721643715721572" />
                                          <odd name="Under" value="1.03" g="{O:\'2012002010\',OF:\'1/33\'}" id="277721643715741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.37" g="{O:\'2012001992\',OF:\'11/8\'}" id="277721643715751575" />
                                          <odd name="Under" value="1.53" g="{O:\'2012001993\',OF:\'8/15\'}" id="277721643715771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="5.50" g="{O:\'2012001999\',OF:\'9/2\'}" id="277721643715811581" />
                                          <odd name="Under" value="1.14" g="{O:\'2012002000\',OF:\'1/7\'}" id="277721643715831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.28" g="{O:\'2012001976\',OF:\'2/7\'}" id="277721643715841584" />
                                          <odd name="Under" value="3.50" g="{O:\'2012001980\',OF:\'5/2\'}" id="277721643715861586" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="HT/FT Double" stop="False" id="12">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw/Argentina" value="5.00" g="{O:\'2012000620\',OF:\'4/1\'}" id="277721643121657916579" />
                                      <odd name="Argentina/Draw" value="15.00" g="{O:\'2012000618\',OF:\'14/1\'}" id="277721643121658116581" />
                                      <odd name="Argentina/Argentina" value="3.60" g="{O:\'2012000617\',OF:\'13/5\'}" id="277721643121658216582" />
                                      <odd name="Draw/Draw" value="4.50" g="{O:\'2012000626\',OF:\'7/2\'}" id="2777216431216761676" />
                                      <odd name="Colombia/Argentina" value="29.00" g="{O:\'2012000634\',OF:\'28/1\'}" id="27772164312408503408503" />
                                      <odd name="Argentina/Colombia" value="34.00" g="{O:\'2012000619\',OF:\'33/1\'}" id="27772164312408504408504" />
                                      <odd name="Draw/Colombia" value="7.00" g="{O:\'2012000627\',OF:\'6/1\'}" id="277721643127327073270" />
                                      <odd name="Colombia/Draw" value="15.00" g="{O:\'2012000635\',OF:\'14/1\'}" id="277721643127327273272" />
                                      <odd name="Colombia/Colombia" value="5.50" g="{O:\'2012000638\',OF:\'9/2\'}" id="277721643127327373273" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Home" stop="False" id="13">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="2.62" g="{O:\'2012002080\',OF:\'13/8\'}" id="2777216431316291629" />
                                      <odd name="No" value="1.44" g="{O:\'2012002081\',OF:\'4/9\'}" id="2777216431316301630" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Away" stop="False" id="14">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="3.50" g="{O:\'2012002100\',OF:\'5/2\'}" id="2777216431416291629" />
                                      <odd name="No" value="1.28" g="{O:\'2012002101\',OF:\'2/7\'}" id="2777216431416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score" stop="False" id="15">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.95" g="{O:\'2012002104\',OF:\'19/20\'}" id="2777216431516291629" />
                                      <odd name="No" value="1.80" g="{O:\'2012002105\',OF:\'4/5\'}" id="2777216431516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result" stop="False" id="79">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="4.33" g="{O:\'2012001706\',OF:\'10/3\'}" id="2777216437915441544" />
                                          <odd name="Away" value="1.72" g="{O:\'2012001711\',OF:\'8/11\'}" id="2777216437915461546" />
                                          <odd name="Draw" value="3.75" g="{O:\'2012001708\',OF:\'11/4\'}" id="2777216437917011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.30" g="{O:\'2012001808\',OF:\'3/10\'}" id="2777216437915471547" />
                                          <odd name="Away" value="7.50" g="{O:\'2012001817\',OF:\'13/2\'}" id="2777216437915491549" />
                                          <odd name="Draw" value="4.75" g="{O:\'2012001810\',OF:\'15/4\'}" id="2777216437916961696" />
                                      </handicap>
                                      <handicap name="+2" stop="False">
                                          <odd name="Home" value="1.07" g="{O:\'2012001833\',OF:\'1/14\'}" id="2777216437916971697" />
                                          <odd name="Draw" value="9.00" g="{O:\'2012001834\',OF:\'8/1\'}" id="2777216437916991699" />
                                          <odd name="Away" value="17.00" g="{O:\'2012001835\',OF:\'16/1\'}" id="2777216437917001700" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="10.00" g="{O:\'2012001792\',OF:\'9/1\'}" id="2777216437917021702" />
                                          <odd name="Draw" value="6.00" g="{O:\'2012001794\',OF:\'5/1\'}" id="2777216437917041704" />
                                          <odd name="Away" value="1.18" g="{O:\'2012001796\',OF:\'2/11\'}" id="2777216437917051705" />
                                      </handicap>
                                      <handicap name="-3" stop="False">
                                          <odd name="Home" value="17.00" g="{O:\'2012001775\',OF:\'16/1\'}" id="2777216437917061706" />
                                          <odd name="Draw" value="11.00" g="{O:\'2012001777\',OF:\'10/1\'}" id="2777216437917081708" />
                                          <odd name="Away" value="1.04" g="{O:\'2012001779\',OF:\'1/22\'}" id="2777216437917091709" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Correct Score" stop="False" id="81">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="6.50" g="{O:\'2012000560\',OF:\'11/2\'}" id="2777216438116311631" />
                                      <odd name="2:0" value="9.50" g="{O:\'2012000562\',OF:\'17/2\'}" id="2777216438116321632" />
                                      <odd name="2:1" value="9.00" g="{O:\'2012000563\',OF:\'8/1\'}" id="2777216438116331633" />
                                      <odd name="3:0" value="21.00" g="{O:\'2012000565\',OF:\'20/1\'}" id="2777216438116341634" />
                                      <odd name="3:1" value="19.00" g="{O:\'2012000566\',OF:\'18/1\'}" id="2777216438116351635" />
                                      <odd name="3:2" value="34.00" g="{O:\'2012000567\',OF:\'33/1\'}" id="2777216438116361636" />
                                      <odd name="4:0" value="41.00" g="{O:\'2012000568\',OF:\'40/1\'}" id="2777216438116371637" />
                                      <odd name="4:1" value="41.00" g="{O:\'2012000569\',OF:\'40/1\'}" id="2777216438116381638" />
                                      <odd name="4:2" value="67.00" g="{O:\'2012000571\',OF:\'66/1\'}" id="2777216438116391639" />
                                      <odd name="4:3" value="151.00" g="{O:\'2012000572\',OF:\'150/1\'}" id="2777216438116401640" />
                                      <odd name="5:0" value="101.00" g="{O:\'2012000576\',OF:\'100/1\'}" id="2777216438116411641" />
                                      <odd name="5:1" value="101.00" g="{O:\'2012000577\',OF:\'100/1\'}" id="2777216438116421642" />
                                      <odd name="5:2" value="201.00" g="{O:\'2012000579\',OF:\'200/1\'}" id="2777216438116431643" />
                                      <odd name="5:3" value="501.00" g="{O:\'2012000581\',OF:\'500/1\'}" id="2777216438116441644" />
                                      <odd name="6:0" value="451.00" g="{O:\'2012000582\',OF:\'450/1\'}" id="2777216438116461646" />
                                      <odd name="6:1" value="401.00" g="{O:\'2012000583\',OF:\'400/1\'}" id="2777216438116471647" />
                                      <odd name="0:0" value="8.00" g="{O:\'2012000585\',OF:\'7/1\'}" id="2777216438116491649" />
                                      <odd name="1:1" value="6.00" g="{O:\'2012000586\',OF:\'5/1\'}" id="2777216438116501650" />
                                      <odd name="2:2" value="17.00" g="{O:\'2012000587\',OF:\'16/1\'}" id="2777216438116511651" />
                                      <odd name="3:3" value="67.00" g="{O:\'2012000588\',OF:\'66/1\'}" id="2777216438116521652" />
                                      <odd name="4:4" value="501.00" g="{O:\'2012000590\',OF:\'500/1\'}" id="2777216438116531653" />
                                      <odd name="0:1" value="8.50" g="{O:\'2012000591\',OF:\'15/2\'}" id="2777216438116541654" />
                                      <odd name="0:2" value="15.00" g="{O:\'2012000592\',OF:\'14/1\'}" id="2777216438116551655" />
                                      <odd name="0:3" value="41.00" g="{O:\'2012000594\',OF:\'40/1\'}" id="2777216438116561656" />
                                      <odd name="0:4" value="81.00" g="{O:\'2012000597\',OF:\'80/1\'}" id="2777216438116571657" />
                                      <odd name="0:5" value="351.00" g="{O:\'2012000602\',OF:\'350/1\'}" id="2777216438116581658" />
                                      <odd name="1:2" value="12.00" g="{O:\'2012000593\',OF:\'11/1\'}" id="2777216438116601660" />
                                      <odd name="1:3" value="29.00" g="{O:\'2012000595\',OF:\'28/1\'}" id="2777216438116611661" />
                                      <odd name="1:4" value="67.00" g="{O:\'2012000598\',OF:\'66/1\'}" id="2777216438116621662" />
                                      <odd name="1:5" value="251.00" g="{O:\'2012000603\',OF:\'250/1\'}" id="2777216438116631663" />
                                      <odd name="2:3" value="41.00" g="{O:\'2012000596\',OF:\'40/1\'}" id="2777216438116651665" />
                                      <odd name="2:4" value="101.00" g="{O:\'2012000599\',OF:\'100/1\'}" id="2777216438116661666" />
                                      <odd name="2:5" value="401.00" g="{O:\'2012000604\',OF:\'400/1\'}" id="2777216438116671667" />
                                      <odd name="3:4" value="201.00" g="{O:\'2012000601\',OF:\'200/1\'}" id="2777216438116691669" />
                                  </bookmaker>
                              </type>
                              <type value="Highest Scoring Half" stop="False" id="91">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw" value="3.25" g="{O:\'2012001941\',OF:\'9/4\'}" id="2777216439115701570" />
                                      <odd name="1st Half" value="3.20" g="{O:\'2012001938\',OF:\'11/5\'}" id="2777216439116941694" />
                                      <odd name="2nd Half" value="2.10" g="{O:\'2012001939\',OF:\'11/10\'}" id="2777216439116951695" />
                                  </bookmaker>
                              </type>
                              <type value="Correct Score 1st Half" stop="False" id="181">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="4.00" g="{O:\'2012000762\',OF:\'3/1\'}" id="27772164318116311631" />
                                      <odd name="2:0" value="13.00" g="{O:\'2012000764\',OF:\'12/1\'}" id="27772164318116321632" />
                                      <odd name="2:1" value="26.00" g="{O:\'2012000765\',OF:\'25/1\'}" id="27772164318116331633" />
                                      <odd name="3:0" value="41.00" g="{O:\'2012000766\',OF:\'40/1\'}" id="27772164318116341634" />
                                      <odd name="3:1" value="81.00" g="{O:\'2012000767\',OF:\'80/1\'}" id="27772164318116351635" />
                                      <odd name="3:2" value="251.00" g="{O:\'2012000768\',OF:\'250/1\'}" id="27772164318116361636" />
                                      <odd name="4:0" value="201.00" g="{O:\'2012000769\',OF:\'200/1\'}" id="27772164318116371637" />
                                      <odd name="4:1" value="401.00" g="{O:\'2012000770\',OF:\'400/1\'}" id="27772164318116381638" />
                                      <odd name="0:0" value="2.50" g="{O:\'2012000772\',OF:\'6/4\'}" id="27772164318116491649" />
                                      <odd name="1:1" value="8.50" g="{O:\'2012000773\',OF:\'15/2\'}" id="27772164318116501650" />
                                      <odd name="2:2" value="67.00" g="{O:\'2012000774\',OF:\'66/1\'}" id="27772164318116511651" />
                                      <odd name="0:1" value="5.00" g="{O:\'2012000775\',OF:\'4/1\'}" id="27772164318116541654" />
                                      <odd name="0:2" value="19.00" g="{O:\'2012000776\',OF:\'18/1\'}" id="27772164318116551655" />
                                      <odd name="0:3" value="67.00" g="{O:\'2012000778\',OF:\'66/1\'}" id="27772164318116561656" />
                                      <odd name="0:4" value="451.00" g="{O:\'2012000781\',OF:\'450/1\'}" id="27772164318116571657" />
                                      <odd name="1:2" value="29.00" g="{O:\'2012000777\',OF:\'28/1\'}" id="27772164318116601660" />
                                      <odd name="1:3" value="101.00" g="{O:\'2012000779\',OF:\'100/1\'}" id="27772164318116611661" />
                                      <odd name="2:3" value="301.00" g="{O:\'2012000780\',OF:\'300/1\'}" id="27772164318116651665" />
                                  </bookmaker>
                              </type>
                              <type value="Double Chance" stop="False" id="222">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.30" g="{O:\'2012000557\',OF:\'3/10\'}" id="27772164322216261626" />
                                      <odd name="Home/Away" value="1.36" g="{O:\'2012000556\',OF:\'4/11\'}" id="27772164322216271627" />
                                      <odd name="Draw/Away" value="1.72" g="{O:\'2012000555\',OF:\'8/11\'}" id="27772164322216281628" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Winner" stop="False" id="2102">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="3.00" g="{O:\'2012000749\',OF:\'2/1\'}" id="277721643210215681568" />
                                      <odd name="Draw" value="2.00" g="{O:\'2012000751\',OF:\'1/1\'}" id="277721643210215701570" />
                                      <odd name="Away" value="4.00" g="{O:\'2012000753\',OF:\'3/1\'}" id="277721643210215711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score First" stop="False" id="2224">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.72" g="{O:\'2012000805\',OF:\'8/11\'}" id="277721643222415681568" />
                                      <odd name="Draw" value="8.00" g="{O:\'2012000806\',OF:\'7/1\'}" id="277721643222415701570" />
                                      <odd name="Away" value="2.40" g="{O:\'2012000807\',OF:\'7/5\'}" id="277721643222415711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score Last" stop="False" id="2225">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.72" g="{O:\'2012002110\',OF:\'8/11\'}" id="277721643222515681568" />
                                      <odd name="Away" value="2.40" g="{O:\'2012002112\',OF:\'7/5\'}" id="277721643222515711571" />
                                      <odd name="No goal" value="8.00" g="{O:\'2012002111\',OF:\'7/1\'}" id="277721643222516871687" />
                                  </bookmaker>
                              </type>
                              <type value="Win Both Halves" stop="False" id="2293">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="8.00" g="{O:\'2012002204\',OF:\'7/1\'}" id="277721643229315681568" />
                                      <odd name="Away" value="13.00" g="{O:\'2012002207\',OF:\'12/1\'}" id="277721643229315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Total - Home" stop="False" id="22124">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="17.00" g="{O:\'2012002056\',OF:\'16/1\'}" id="2777216432212415721572" />
                                          <odd name="Under" value="1.02" g="{O:\'2012002057\',OF:\'1/40\'}" id="2777216432212415741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.37" g="{O:\'2012002052\',OF:\'11/8\'}" id="2777216432212415751575" />
                                          <odd name="Under" value="1.53" g="{O:\'2012002053\',OF:\'8/15\'}" id="2777216432212415771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="6.00" g="{O:\'2012002054\',OF:\'5/1\'}" id="2777216432212415811581" />
                                          <odd name="Under" value="1.12" g="{O:\'2012002055\',OF:\'1/8\'}" id="2777216432212415831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Total - Away" stop="False" id="22125">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="26.00" g="{O:\'2012002068\',OF:\'25/1\'}" id="2777216432212515721572" />
                                          <odd name="Under" value="1.01" g="{O:\'2012002069\',OF:\'1/100\'}" id="2777216432212515741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="3.40" g="{O:\'2012002062\',OF:\'12/5\'}" id="2777216432212515751575" />
                                          <odd name="Under" value="1.30" g="{O:\'2012002063\',OF:\'3/10\'}" id="2777216432212515771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="10.00" g="{O:\'2012002066\',OF:\'9/1\'}" id="2777216432212515811581" />
                                          <odd name="Under" value="1.06" g="{O:\'2012002067\',OF:\'1/16\'}" id="2777216432212515831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result 1st Half" stop="False" id="22600">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="10.00" g="{O:\'2012001910\',OF:\'9/1\'}" id="2777216432260015441544" />
                                          <odd name="Away" value="1.36" g="{O:\'2012001912\',OF:\'4/11\'}" id="2777216432260015461546" />
                                          <odd name="Draw" value="3.60" g="{O:\'2012001911\',OF:\'13/5\'}" id="2777216432260017011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.22" g="{O:\'2012001923\',OF:\'2/9\'}" id="2777216432260015471547" />
                                          <odd name="Away" value="15.00" g="{O:\'2012001926\',OF:\'14/1\'}" id="2777216432260015491549" />
                                          <odd name="Draw" value="4.50" g="{O:\'2012001924\',OF:\'7/2\'}" id="2777216432260016961696" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="23.00" g="{O:\'2012001913\',OF:\'22/1\'}" id="2777216432260017021702" />
                                          <odd name="Draw" value="11.00" g="{O:\'2012001914\',OF:\'10/1\'}" id="2777216432260017041704" />
                                          <odd name="Away" value="1.05" g="{O:\'2012001915\',OF:\'1/20\'}" id="2777216432260017051705" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap First Half" stop="False" id="22601">
                                  <bookmaker name="bet365" stop="False" ts="1557739490" id="16">
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="2.25" g="{O:\'2011465573\',OF:\'5/4\'}" id="2777216432260115261526" />
                                          <odd name="Away" value="1.62" g="{O:\'2011465574\',OF:\'5/8\'}" id="2777216432260115281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="1.35" g="{O:\'2018020750\',OF:\'7/20\'}" id="2777216432260115291529" />
                                          <odd name="Away" value="3.10" g="{O:\'2018020751\',OF:\'21/10\'}" id="2777216432260115311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="2.85" g="{O:\'2018020742\',OF:\'37/20\'}" id="2777216432260115321532" />
                                          <odd name="Away" value="1.40" g="{O:\'2018020744\',OF:\'2/5\'}" id="2777216432260115341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="1.23" g="{O:\'2018020752\',OF:\'23/100\'}" id="2777216432260115351535" />
                                          <odd name="Away" value="4.00" g="{O:\'2018020753\',OF:\'3/1\'}" id="2777216432260115371537" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="3.90" g="{O:\'2018020723\',OF:\'29/10\'}" id="2777216432260115381538" />
                                          <odd name="Away" value="1.24" g="{O:\'2018020724\',OF:\'6/25\'}" id="2777216432260115401540" />
                                      </handicap>
                                      <handicap name="+0.75" stop="False">
                                          <odd name="Home" value="1.13" g="{O:\'2018020754\',OF:\'13/100\'}" id="2777216432260115411541" />
                                          <odd name="Away" value="5.90" g="{O:\'2018020755\',OF:\'49/10\'}" id="2777216432260115431543" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Double Chance - 1st Half" stop="False" id="22602">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.22" g="{O:\'2012000810\',OF:\'2/9\'}" id="2777216432260216261626" />
                                      <odd name="Home/Away" value="1.72" g="{O:\'2012000809\',OF:\'8/11\'}" id="2777216432260216271627" />
                                      <odd name="Draw/Away" value="1.36" g="{O:\'2012000808\',OF:\'4/11\'}" id="2777216432260216281628" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 1st Half" stop="False" id="22604">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="5.50" g="{O:\'2012002264\',OF:\'9/2\'}" id="2777216432260416291629" />
                                      <odd name="No" value="1.14" g="{O:\'2012002266\',OF:\'1/7\'}" id="2777216432260416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 2nd Half" stop="False" id="22605">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="3.75" g="{O:\'2012002331\',OF:\'11/4\'}" id="2777216432260516291629" />
                                      <odd name="No" value="1.25" g="{O:\'2012002332\',OF:\'1/4\'}" id="2777216432260516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Win To Nil" stop="False" id="22607">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="3.50" g="{O:\'2012002190\',OF:\'5/2\'}" id="2777216432260715681568" />
                                      <odd name="Away" value="5.50" g="{O:\'2012002199\',OF:\'9/2\'}" id="2777216432260715711571" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even" stop="False" id="22608">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="1.95" g="{O:\'2012000700\',OF:\'19/20\'}" id="2777216432260816881688" />
                                      <odd name="Even" value="1.90" g="{O:\'2012000699\',OF:\'9/10\'}" id="2777216432260816891689" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even 1st Half" stop="False" id="22609">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="2.20" g="{O:\'2012000799\',OF:\'6/5\'}" id="2777216432260916881688" />
                                      <odd name="Even" value="1.66" g="{O:\'2012000798\',OF:\'4/6\'}" id="2777216432260916891689" />
                                  </bookmaker>
                              </type>
                              <type value="Exact Goals Number" stop="False" id="22614">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.40" g="{O:\'2012001683\',OF:\'12/5\'}" id="2777216432261415881588" />
                                      <odd name="3" value="4.33" g="{O:\'2012001685\',OF:\'10/3\'}" id="2777216432261415911591" />
                                      <odd name="4" value="7.00" g="{O:\'2012001687\',OF:\'6/1\'}" id="2777216432261415941594" />
                                      <odd name="1" value="4.00" g="{O:\'2012001681\',OF:\'3/1\'}" id="2777216432261416821682" />
                                      <odd name="0" value="8.00" g="{O:\'2012001679\',OF:\'7/1\'}" id="2777216432261416901690" />
                                      <odd name="5" value="15.00" g="{O:\'2012001689\',OF:\'14/1\'}" id="2777216432261416911691" />
                                      <odd name="6" value="34.00" g="{O:\'2012001690\',OF:\'33/1\'}" id="2777216432261416921692" />
                                      <odd name="more 7" value="41.00" g="{O:\'2012001693\',OF:\'40/1\'}" id="2777216432261416931693" />
                                  </bookmaker>
                              </type>
                              <type value="To Win Either Half" stop="False" id="22615">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.66" g="{O:\'2012002202\',OF:\'4/6\'}" id="2777216432261515681568" />
                                      <odd name="Away" value="2.20" g="{O:\'2012002203\',OF:\'6/5\'}" id="2777216432261515711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home Team Exact Goals Number" stop="False" id="22616">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.75" g="{O:\'2012002244\',OF:\'11/4\'}" id="2777216432261615881588" />
                                      <odd name="1" value="2.60" g="{O:\'2012002243\',OF:\'8/5\'}" id="2777216432261616821682" />
                                      <odd name="0" value="3.50" g="{O:\'2012002242\',OF:\'5/2\'}" id="2777216432261616901690" />
                                      <odd name="more 3" value="6.00" g="{O:\'2012002245\',OF:\'5/1\'}" id="2777216432261617201720" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Exact Goals Number" stop="False" id="22617">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="4.50" g="{O:\'2012002256\',OF:\'7/2\'}" id="2777216432261715881588" />
                                      <odd name="1" value="2.40" g="{O:\'2012002255\',OF:\'7/5\'}" id="2777216432261716821682" />
                                      <odd name="0" value="2.62" g="{O:\'2012002254\',OF:\'13/8\'}" id="2777216432261716901690" />
                                      <odd name="more 3" value="10.00" g="{O:\'2012002257\',OF:\'9/1\'}" id="2777216432261717201720" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Exact Goals Number" stop="False" id="22619">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.75" g="{O:\'2012002046\',OF:\'11/4\'}" id="2777216432261915881588" />
                                      <odd name="3" value="8.00" g="{O:\'2012002047\',OF:\'7/1\'}" id="2777216432261915911591" />
                                      <odd name="4" value="21.00" g="{O:\'2012002048\',OF:\'20/1\'}" id="2777216432261915941594" />
                                      <odd name="1" value="2.60" g="{O:\'2012002045\',OF:\'8/5\'}" id="2777216432261916821682" />
                                      <odd name="0" value="3.50" g="{O:\'2012002044\',OF:\'5/2\'}" id="2777216432261916901690" />
                                      <odd name="more 5" value="41.00" g="{O:\'2012002049\',OF:\'40/1\'}" id="2777216432261917271727" />
                                  </bookmaker>
                              </type>
                              <type value="Results/Both Teams To Score" stop="False" id="22620">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Yes" value="5.00" g="{O:\'2012002222\',OF:\'4/1\'}" id="2777216432262017211721" />
                                      <odd name="Draw/Yes" value="4.50" g="{O:\'2012002224\',OF:\'7/2\'}" id="2777216432262017221722" />
                                      <odd name="Away/Yes" value="7.50" g="{O:\'2012002226\',OF:\'13/2\'}" id="2777216432262017231723" />
                                      <odd name="Home/No" value="3.50" g="{O:\'2012002223\',OF:\'5/2\'}" id="2777216432262017241724" />
                                      <odd name="Draw/No" value="8.00" g="{O:\'2012002225\',OF:\'7/1\'}" id="2777216432262017251725" />
                                      <odd name="Away/No" value="5.50" g="{O:\'2012002227\',OF:\'9/2\'}" id="2777216432262017261726" />
                                  </bookmaker>
                              </type>
                              <type value="Result/Total Goals" stop="False" id="22621">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="2.5" stop="False">
                                          <odd name="Home/Over" value="4.00" g="{O:\'2012002113\',OF:\'3/1\'}" id="2777216432262117141714" />
                                          <odd name="Draw/Over" value="15.00" g="{O:\'2012002115\',OF:\'14/1\'}" id="2777216432262117151715" />
                                          <odd name="Away/Over" value="6.50" g="{O:\'2012002117\',OF:\'11/2\'}" id="2777216432262117161716" />
                                          <odd name="Home/Under" value="4.33" g="{O:\'2012002114\',OF:\'10/3\'}" id="2777216432262117171717" />
                                          <odd name="Draw/Under" value="3.75" g="{O:\'2012002116\',OF:\'11/4\'}" id="2777216432262117181718" />
                                          <odd name="Away/Under" value="6.00" g="{O:\'2012002118\',OF:\'5/1\'}" id="2777216432262117191719" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Home Team Score a Goal" stop="False" id="22622">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.28" g="{O:\'2012002101\',OF:\'2/7\'}" id="2777216432262216291629" />
                                      <odd name="No" value="3.50" g="{O:\'2012002100\',OF:\'5/2\'}" id="2777216432262216301630" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Score a Goal" stop="False" id="22623">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.44" g="{O:\'2012002081\',OF:\'4/9\'}" id="2777216432262316291629" />
                                      <odd name="No" value="2.62" g="{O:\'2012002080\',OF:\'13/8\'}" id="2777216432262316301630" />
                                  </bookmaker>
                              </type>
                              <type value="First 10 min Winner" stop="False" id="22626">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="9.50" g="{O:\'2012069187\',OF:\'17/2\'}" id="2777216432262615681568" />
                                      <odd name="Draw" value="1.14" g="{O:\'2012069188\',OF:\'1/7\'}" id="2777216432262615701570" />
                                      <odd name="Away" value="12.00" g="{O:\'2012069189\',OF:\'11/1\'}" id="2777216432262615711571" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Exact Goals Number" stop="False" id="22655">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="4.50" g="{O:\'2012001904\',OF:\'7/2\'}" id="2777216432265515881588" />
                                      <odd name="3" value="13.00" g="{O:\'2012001905\',OF:\'12/1\'}" id="2777216432265515911591" />
                                      <odd name="4" value="41.00" g="{O:\'2012001906\',OF:\'40/1\'}" id="2777216432265515941594" />
                                      <odd name="1" value="2.50" g="{O:\'2012001903\',OF:\'6/4\'}" id="2777216432265516821682" />
                                      <odd name="0" value="2.50" g="{O:\'2012001902\',OF:\'6/4\'}" id="2777216432265516901690" />
                                      <odd name="more 5" value="101.00" g="{O:\'2012001907\',OF:\'100/1\'}" id="2777216432265517271727" />
                                  </bookmaker>
                              </type>
                          </odds>
                      </match>
                      <match status="19:00" date="Jun 16" formatted_date="16.06.2019" time="19:00" venue="Estadio Jornalista Mário Filho" static_id="2581645" fix_id="3077141" id="3141451">
                          <localteam name="Paraguay" goals="?" id="13867" />
                          <visitorteam name="Qatar" goals="?" id="14492" />
                          <events />
                          <ht score="" />
                          <odds ts="1557739490">
                              <type value="Match Winner" stop="False" id="1">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.66" g="{O:\'2011465579\',OF:\'4/6\'}" id="277721543115681568" />
                                      <odd name="Draw" value="3.50" g="{O:\'2011465580\',OF:\'5/2\'}" id="277721543115701570" />
                                      <odd name="Away" value="5.50" g="{O:\'2011465581\',OF:\'9/2\'}" id="277721543115711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home/Away" stop="False" id="2">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.25" g="{O:\'2012007888\',OF:\'1/4\'}" id="277721543215681568" />
                                      <odd name="Away" value="3.75" g="{O:\'2012007889\',OF:\'11/4\'}" id="277721543215711571" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Winner" stop="False" id="3">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.05" g="{O:\'2012008587\',OF:\'21/20\'}" id="277721543315681568" />
                                      <odd name="Draw" value="2.30" g="{O:\'2012008588\',OF:\'13/10\'}" id="277721543315701570" />
                                      <odd name="Away" value="5.50" g="{O:\'2012008589\',OF:\'9/2\'}" id="277721543315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap" stop="False" id="4">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="+0" stop="False">
                                          <odd name="Home" value="1.24" g="{O:\'2018022380\',OF:\'6/25\'}" id="277721543415231523" />
                                          <odd name="Away" value="3.90" g="{O:\'2018022381\',OF:\'29/10\'}" id="277721543415251525" />
                                      </handicap>
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="1.45" g="{O:\'2018022378\',OF:\'9/20\'}" id="277721543415261526" />
                                          <odd name="Away" value="2.67" g="{O:\'2018022379\',OF:\'67/40\'}" id="277721543415281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="1.19" g="{O:\'2018022382\',OF:\'19/100\'}" id="277721543415291529" />
                                          <odd name="Away" value="4.50" g="{O:\'2018022383\',OF:\'7/2\'}" id="277721543415311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="1.65" g="{O:\'2018022376\',OF:\'13/20\'}" id="277721543415321532" />
                                          <odd name="Away" value="2.20" g="{O:\'2018022377\',OF:\'6/5\'}" id="277721543415341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="1.16" g="{O:\'2018022384\',OF:\'4/25\'}" id="277721543415351535" />
                                          <odd name="Away" value="5.25" g="{O:\'2018022385\',OF:\'17/4\'}" id="277721543415371537" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="1.92" g="{O:\'2011465584\',OF:\'23/25\'}" id="277721543415381538" />
                                          <odd name="Away" value="1.98" g="{O:\'2011465585\',OF:\'49/50\'}" id="277721543415401540" />
                                      </handicap>
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="2.25" g="{O:\'2018022374\',OF:\'5/4\'}" id="277721543415441544" />
                                          <odd name="Away" value="1.62" g="{O:\'2018022375\',OF:\'5/8\'}" id="277721543415461546" />
                                      </handicap>
                                      <handicap name="-1.5" stop="False">
                                          <odd name="Home" value="3.00" g="{O:\'2018022370\',OF:\'2/1\'}" id="277721543415501550" />
                                          <odd name="Away" value="1.37" g="{O:\'2018022371\',OF:\'3/8\'}" id="277721543415521552" />
                                      </handicap>
                                      <handicap name="-1.25" stop="False">
                                          <odd name="Home" value="2.60" g="{O:\'2018022372\',OF:\'8/5\'}" id="277721543415561556" />
                                          <odd name="Away" value="1.47" g="{O:\'2018022373\',OF:\'19/40\'}" id="277721543415581558" />
                                      </handicap>
                                      <handicap name="-1.75" stop="False">
                                          <odd name="Home" value="3.70" g="{O:\'2018022368\',OF:\'27/10\'}" id="277721543415591559" />
                                          <odd name="Away" value="1.26" g="{O:\'2018022369\',OF:\'13/50\'}" id="277721543415611561" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="5.75" g="{O:\'2018022366\',OF:\'19/4\'}" id="277721543417021702" />
                                          <odd name="Away" value="1.14" g="{O:\'2018022367\',OF:\'7/50\'}" id="277721543417051705" />
                                      </handicap>
                                      <handicap name="-2.5" stop="False">
                                          <odd name="Home" value="6.60" g="{O:\'2018022362\',OF:\'28/5\'}" id="277721543417671767" />
                                          <odd name="Away" value="1.11" g="{O:\'2018022363\',OF:\'11/100\'}" id="277721543417691769" />
                                      </handicap>
                                      <handicap name="-2.25" stop="False">
                                          <odd name="Home" value="6.00" g="{O:\'2018022364\',OF:\'5/1\'}" id="277721543417701770" />
                                          <odd name="Away" value="1.12" g="{O:\'2018022365\',OF:\'1/8\'}" id="277721543417721772" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under" stop="False" id="5">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="4.50" g="{O:\'2012008356\',OF:\'7/2\'}" id="277721543515721572" />
                                          <odd name="Under" value="1.20" g="{O:\'2012008357\',OF:\'1/5\'}" id="277721543515741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="1.44" g="{O:\'2012008354\',OF:\'4/9\'}" id="277721543515751575" />
                                          <odd name="Under" value="2.75" g="{O:\'2012008355\',OF:\'7/4\'}" id="277721543515771577" />
                                      </total>
                                      <total name="4.5" stop="False">
                                          <odd name="Over" value="10.00" g="{O:\'2012008368\',OF:\'9/1\'}" id="277721543515781578" />
                                          <odd name="Under" value="1.06" g="{O:\'2012008369\',OF:\'1/16\'}" id="277721543515801580" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="2.50" g="{O:\'2011465582\',OF:\'6/4\'}" id="277721543515811581" />
                                          <odd name="Under" value="1.53" g="{O:\'2011465583\',OF:\'8/15\'}" id="277721543515831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.10" g="{O:\'2012008350\',OF:\'1/10\'}" id="277721543515841584" />
                                          <odd name="Under" value="7.00" g="{O:\'2012008351\',OF:\'6/1\'}" id="277721543515861586" />
                                      </total>
                                      <total name="5.5" stop="False">
                                          <odd name="Over" value="21.00" g="{O:\'2012008370\',OF:\'20/1\'}" id="277721543515961596" />
                                          <odd name="Under" value="1.01" g="{O:\'2012008371\',OF:\'1/66\'}" id="277721543515981598" />
                                      </total>
                                      <total name="2.25" stop="False">
                                          <odd name="Over" value="2.10" g="{O:\'2018022525\',OF:\'11/10\'}" id="277721543515991599" />
                                          <odd name="Under" value="1.70" g="{O:\'2018022527\',OF:\'7/10\'}" id="277721543516011601" />
                                      </total>
                                      <total name="3.25" stop="False">
                                          <odd name="Over" value="4.15" g="{O:\'2018022570\',OF:\'63/20\'}" id="277721543516021602" />
                                          <odd name="Under" value="1.22" g="{O:\'2018022572\',OF:\'11/50\'}" id="277721543516041604" />
                                      </total>
                                      <total name="2.75" stop="False">
                                          <odd name="Over" value="2.85" g="{O:\'2018022547\',OF:\'37/20\'}" id="277721543516051605" />
                                          <odd name="Under" value="1.40" g="{O:\'2018022549\',OF:\'2/5\'}" id="277721543516071607" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="1.30" g="{O:\'2018022487\',OF:\'3/10\'}" id="277721543516081608" />
                                          <odd name="Under" value="3.45" g="{O:\'2018022489\',OF:\'49/20\'}" id="277721543516101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="1.60" g="{O:\'2018022514\',OF:\'3/5\'}" id="277721543516141614" />
                                          <odd name="Under" value="2.30" g="{O:\'2018022516\',OF:\'13/10\'}" id="277721543516161616" />
                                      </total>
                                      <total name="3.75" stop="False">
                                          <odd name="Over" value="6.00" g="{O:\'2018022591\',OF:\'5/1\'}" id="277721543516171617" />
                                          <odd name="Under" value="1.12" g="{O:\'2018022593\',OF:\'1/8\'}" id="277721543516191619" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.11" g="{O:\'2018022459\',OF:\'23/200\'}" id="277721543516841684" />
                                          <odd name="Under" value="6.40" g="{O:\'2018022461\',OF:\'27/5\'}" id="277721543516861686" />
                                      </total>
                                      <total name="3.0" stop="False">
                                          <odd name="Over" value="3.80" g="{O:\'2018022559\',OF:\'14/5\'}" id="277721543515901590" />
                                          <odd name="Under" value="1.25" g="{O:\'2018022561\',OF:\'1/4\'}" id="2777215435210052210052" />
                                      </total>
                                      <total name="2.0" stop="False">
                                          <odd name="Over" value="1.85" g="{O:\'2011465586\',OF:\'17/20\'}" id="277721543515871587" />
                                          <odd name="Under" value="2.05" g="{O:\'2011465587\',OF:\'21/20\'}" id="2777215435210055210055" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="1.14" g="{O:\'2018022476\',OF:\'7/50\'}" id="277721543516811681" />
                                          <odd name="Under" value="5.75" g="{O:\'2018022478\',OF:\'19/4\'}" id="2777215435210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 1st Half" stop="False" id="6">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="3.50" g="{O:\'2012008465\',OF:\'5/2\'}" id="277721543615751575" />
                                          <odd name="Under" value="1.28" g="{O:\'2012008466\',OF:\'2/7\'}" id="277721543615771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="11.00" g="{O:\'2012008467\',OF:\'10/1\'}" id="277721543615811581" />
                                          <odd name="Under" value="1.05" g="{O:\'2012008468\',OF:\'1/20\'}" id="277721543615831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.50" g="{O:\'2012008461\',OF:\'1/2\'}" id="277721543615841584" />
                                          <odd name="Under" value="2.50" g="{O:\'2012008462\',OF:\'6/4\'}" id="277721543615861586" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="2.85" g="{O:\'2018022651\',OF:\'37/20\'}" id="277721543616081608" />
                                          <odd name="Under" value="1.40" g="{O:\'2018022652\',OF:\'2/5\'}" id="277721543616101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="4.65" g="{O:\'2018022655\',OF:\'73/20\'}" id="277721543616141614" />
                                          <odd name="Under" value="1.18" g="{O:\'2018022656\',OF:\'9/50\'}" id="277721543616161616" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.75" g="{O:\'2011465590\',OF:\'3/4\'}" id="277721543616841684" />
                                          <odd name="Under" value="2.05" g="{O:\'2011465591\',OF:\'21/20\'}" id="277721543616861686" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="2.30" g="{O:\'2018022649\',OF:\'13/10\'}" id="277721543616811681" />
                                          <odd name="Under" value="1.60" g="{O:\'2018022650\',OF:\'3/5\'}" id="2777215436210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 2nd Half" stop="False" id="7">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="19.00" g="{O:\'2012008600\',OF:\'18/1\'}" id="277721543715721572" />
                                          <odd name="Under" value="1.02" g="{O:\'2012008601\',OF:\'1/50\'}" id="277721543715741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.50" g="{O:\'2012008594\',OF:\'6/4\'}" id="277721543715751575" />
                                          <odd name="Under" value="1.50" g="{O:\'2012008595\',OF:\'1/2\'}" id="277721543715771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="6.50" g="{O:\'2012008596\',OF:\'11/2\'}" id="277721543715811581" />
                                          <odd name="Under" value="1.11" g="{O:\'2012008597\',OF:\'1/9\'}" id="277721543715831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.33" g="{O:\'2012008592\',OF:\'1/3\'}" id="277721543715841584" />
                                          <odd name="Under" value="3.25" g="{O:\'2012008593\',OF:\'9/4\'}" id="277721543715861586" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="HT/FT Double" stop="False" id="12">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Paraguay/Paraguay" value="2.62" g="{O:\'2012007879\',OF:\'13/8\'}" id="27772154312112436112436" />
                                      <odd name="Paraguay/Draw" value="17.00" g="{O:\'2012007880\',OF:\'16/1\'}" id="27772154312112437112437" />
                                      <odd name="Draw/Paraguay" value="4.00" g="{O:\'2012007882\',OF:\'3/1\'}" id="27772154312112439112439" />
                                      <odd name="Draw/Draw" value="4.75" g="{O:\'2012007883\',OF:\'15/4\'}" id="2777215431216761676" />
                                      <odd name="Paraguay/Qatar" value="51.00" g="{O:\'2012007881\',OF:\'50/1\'}" id="27772154312434305434305" />
                                      <odd name="Qatar/Paraguay" value="26.00" g="{O:\'2012007885\',OF:\'25/1\'}" id="27772154312434306434306" />
                                      <odd name="Draw/Qatar" value="12.00" g="{O:\'2012007884\',OF:\'11/1\'}" id="277721543125675056750" />
                                      <odd name="Qatar/Draw" value="17.00" g="{O:\'2012007886\',OF:\'16/1\'}" id="277721543125675256752" />
                                      <odd name="Qatar/Qatar" value="9.50" g="{O:\'2012007887\',OF:\'17/2\'}" id="277721543125675356753" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Home" stop="False" id="13">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.83" g="{O:\'2012008767\',OF:\'5/6\'}" id="2777215431316291629" />
                                      <odd name="No" value="1.83" g="{O:\'2012008769\',OF:\'5/6\'}" id="2777215431316301630" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Away" stop="False" id="14">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="4.00" g="{O:\'2012008785\',OF:\'3/1\'}" id="2777215431416291629" />
                                      <odd name="No" value="1.22" g="{O:\'2012008787\',OF:\'2/9\'}" id="2777215431416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score" stop="False" id="15">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="2.25" g="{O:\'2012008801\',OF:\'5/4\'}" id="2777215431516291629" />
                                      <odd name="No" value="1.57" g="{O:\'2012008802\',OF:\'4/7\'}" id="2777215431516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result" stop="False" id="79">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="3.00" g="{O:\'2012008404\',OF:\'2/1\'}" id="2777215437915441544" />
                                          <odd name="Away" value="2.25" g="{O:\'2012008407\',OF:\'5/4\'}" id="2777215437915461546" />
                                          <odd name="Draw" value="3.25" g="{O:\'2012008406\',OF:\'9/4\'}" id="2777215437917011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.16" g="{O:\'2012008441\',OF:\'1/6\'}" id="2777215437915471547" />
                                          <odd name="Away" value="13.00" g="{O:\'2012008443\',OF:\'12/1\'}" id="2777215437915491549" />
                                          <odd name="Draw" value="6.50" g="{O:\'2012008442\',OF:\'11/2\'}" id="2777215437916961696" />
                                      </handicap>
                                      <handicap name="+2" stop="False">
                                          <odd name="Home" value="1.03" g="{O:\'2012008446\',OF:\'1/33\'}" id="2777215437916971697" />
                                          <odd name="Draw" value="15.00" g="{O:\'2012008448\',OF:\'14/1\'}" id="2777215437916991699" />
                                          <odd name="Away" value="21.00" g="{O:\'2012008450\',OF:\'20/1\'}" id="2777215437917001700" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="6.50" g="{O:\'2012008432\',OF:\'11/2\'}" id="2777215437917021702" />
                                          <odd name="Draw" value="4.75" g="{O:\'2012008433\',OF:\'15/4\'}" id="2777215437917041704" />
                                          <odd name="Away" value="1.33" g="{O:\'2012008434\',OF:\'1/3\'}" id="2777215437917051705" />
                                      </handicap>
                                      <handicap name="-3" stop="False">
                                          <odd name="Home" value="13.00" g="{O:\'2012008425\',OF:\'12/1\'}" id="2777215437917061706" />
                                          <odd name="Draw" value="8.50" g="{O:\'2012008427\',OF:\'15/2\'}" id="2777215437917081708" />
                                          <odd name="Away" value="1.08" g="{O:\'2012008428\',OF:\'1/12\'}" id="2777215437917091709" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Correct Score" stop="False" id="81">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="5.00" g="{O:\'2012007844\',OF:\'4/1\'}" id="2777215438116311631" />
                                      <odd name="2:0" value="6.50" g="{O:\'2012007845\',OF:\'11/2\'}" id="2777215438116321632" />
                                      <odd name="2:1" value="9.00" g="{O:\'2012007846\',OF:\'8/1\'}" id="2777215438116331633" />
                                      <odd name="3:0" value="12.00" g="{O:\'2012007847\',OF:\'11/1\'}" id="2777215438116341634" />
                                      <odd name="3:1" value="17.00" g="{O:\'2012007848\',OF:\'16/1\'}" id="2777215438116351635" />
                                      <odd name="3:2" value="41.00" g="{O:\'2012007849\',OF:\'40/1\'}" id="2777215438116361636" />
                                      <odd name="4:0" value="29.00" g="{O:\'2012007850\',OF:\'28/1\'}" id="2777215438116371637" />
                                      <odd name="4:1" value="34.00" g="{O:\'2012007851\',OF:\'33/1\'}" id="2777215438116381638" />
                                      <odd name="4:2" value="67.00" g="{O:\'2012007852\',OF:\'66/1\'}" id="2777215438116391639" />
                                      <odd name="4:3" value="201.00" g="{O:\'2012007853\',OF:\'200/1\'}" id="2777215438116401640" />
                                      <odd name="5:0" value="51.00" g="{O:\'2012007854\',OF:\'50/1\'}" id="2777215438116411641" />
                                      <odd name="5:1" value="81.00" g="{O:\'2012007855\',OF:\'80/1\'}" id="2777215438116421642" />
                                      <odd name="5:2" value="151.00" g="{O:\'2012007856\',OF:\'150/1\'}" id="2777215438116431643" />
                                      <odd name="6:0" value="151.00" g="{O:\'2012007857\',OF:\'150/1\'}" id="2777215438116461646" />
                                      <odd name="6:1" value="251.00" g="{O:\'2012007858\',OF:\'250/1\'}" id="2777215438116471647" />
                                      <odd name="0:0" value="7.00" g="{O:\'2012007860\',OF:\'6/1\'}" id="2777215438116491649" />
                                      <odd name="1:1" value="7.00" g="{O:\'2012007861\',OF:\'6/1\'}" id="2777215438116501650" />
                                      <odd name="2:2" value="21.00" g="{O:\'2012007862\',OF:\'20/1\'}" id="2777215438116511651" />
                                      <odd name="3:3" value="101.00" g="{O:\'2012007863\',OF:\'100/1\'}" id="2777215438116521652" />
                                      <odd name="0:1" value="11.00" g="{O:\'2012007864\',OF:\'10/1\'}" id="2777215438116541654" />
                                      <odd name="0:2" value="26.00" g="{O:\'2012007865\',OF:\'25/1\'}" id="2777215438116551655" />
                                      <odd name="0:3" value="67.00" g="{O:\'2012007867\',OF:\'66/1\'}" id="2777215438116561656" />
                                      <odd name="0:4" value="251.00" g="{O:\'2012007870\',OF:\'250/1\'}" id="2777215438116571657" />
                                      <odd name="1:2" value="19.00" g="{O:\'2012007866\',OF:\'18/1\'}" id="2777215438116601660" />
                                      <odd name="1:3" value="51.00" g="{O:\'2012007868\',OF:\'50/1\'}" id="2777215438116611661" />
                                      <odd name="1:4" value="201.00" g="{O:\'2012007871\',OF:\'200/1\'}" id="2777215438116621662" />
                                      <odd name="2:3" value="51.00" g="{O:\'2012007869\',OF:\'50/1\'}" id="2777215438116651665" />
                                      <odd name="2:4" value="251.00" g="{O:\'2012007872\',OF:\'250/1\'}" id="2777215438116661666" />
                                      <odd name="3:4" value="451.00" g="{O:\'2012007873\',OF:\'450/1\'}" id="2777215438116691669" />
                                  </bookmaker>
                              </type>
                              <type value="Highest Scoring Half" stop="False" id="91">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw" value="3.20" g="{O:\'2012008586\',OF:\'11/5\'}" id="2777215439115701570" />
                                      <odd name="1st Half" value="3.10" g="{O:\'2012008584\',OF:\'21/10\'}" id="2777215439116941694" />
                                      <odd name="2nd Half" value="2.20" g="{O:\'2012008585\',OF:\'6/5\'}" id="2777215439116951695" />
                                  </bookmaker>
                              </type>
                              <type value="Correct Score 1st Half" stop="False" id="181">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="3.40" g="{O:\'2012007920\',OF:\'12/5\'}" id="27772154318116311631" />
                                      <odd name="2:0" value="9.00" g="{O:\'2012007921\',OF:\'8/1\'}" id="27772154318116321632" />
                                      <odd name="2:1" value="26.00" g="{O:\'2012007922\',OF:\'25/1\'}" id="27772154318116331633" />
                                      <odd name="3:0" value="34.00" g="{O:\'2012007923\',OF:\'33/1\'}" id="27772154318116341634" />
                                      <odd name="3:1" value="67.00" g="{O:\'2012007924\',OF:\'66/1\'}" id="27772154318116351635" />
                                      <odd name="3:2" value="301.00" g="{O:\'2012007925\',OF:\'300/1\'}" id="27772154318116361636" />
                                      <odd name="4:0" value="101.00" g="{O:\'2012007926\',OF:\'100/1\'}" id="27772154318116371637" />
                                      <odd name="4:1" value="301.00" g="{O:\'2012007927\',OF:\'300/1\'}" id="27772154318116381638" />
                                      <odd name="0:0" value="2.50" g="{O:\'2012007928\',OF:\'6/4\'}" id="27772154318116491649" />
                                      <odd name="1:1" value="9.50" g="{O:\'2012007929\',OF:\'17/2\'}" id="27772154318116501650" />
                                      <odd name="2:2" value="81.00" g="{O:\'2012007930\',OF:\'80/1\'}" id="27772154318116511651" />
                                      <odd name="0:1" value="6.50" g="{O:\'2012007931\',OF:\'11/2\'}" id="27772154318116541654" />
                                      <odd name="0:2" value="34.00" g="{O:\'2012007932\',OF:\'33/1\'}" id="27772154318116551655" />
                                      <odd name="0:3" value="151.00" g="{O:\'2012007934\',OF:\'150/1\'}" id="27772154318116561656" />
                                      <odd name="1:2" value="41.00" g="{O:\'2012007933\',OF:\'40/1\'}" id="27772154318116601660" />
                                      <odd name="1:3" value="201.00" g="{O:\'2012007935\',OF:\'200/1\'}" id="27772154318116611661" />
                                  </bookmaker>
                              </type>
                              <type value="Double Chance" stop="False" id="222">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.16" g="{O:\'2012007738\',OF:\'1/6\'}" id="27772154322216261626" />
                                      <odd name="Home/Away" value="1.30" g="{O:\'2012007737\',OF:\'3/10\'}" id="27772154322216271627" />
                                      <odd name="Draw/Away" value="2.25" g="{O:\'2012007736\',OF:\'5/4\'}" id="27772154322216281628" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Winner" stop="False" id="2102">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.37" g="{O:\'2012007892\',OF:\'11/8\'}" id="277721543210215681568" />
                                      <odd name="Draw" value="2.05" g="{O:\'2012007893\',OF:\'21/20\'}" id="277721543210215701570" />
                                      <odd name="Away" value="6.00" g="{O:\'2012007894\',OF:\'5/1\'}" id="277721543210215711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score First" stop="False" id="2224">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.44" g="{O:\'2012007944\',OF:\'4/9\'}" id="277721543222415681568" />
                                      <odd name="Draw" value="7.00" g="{O:\'2012007945\',OF:\'6/1\'}" id="277721543222415701570" />
                                      <odd name="Away" value="3.40" g="{O:\'2012007946\',OF:\'12/5\'}" id="277721543222415711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score Last" stop="False" id="2225">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.44" g="{O:\'2012008832\',OF:\'4/9\'}" id="277721543222515681568" />
                                      <odd name="Away" value="3.40" g="{O:\'2012008835\',OF:\'12/5\'}" id="277721543222515711571" />
                                      <odd name="No goal" value="7.00" g="{O:\'2012008834\',OF:\'6/1\'}" id="277721543222516871687" />
                                  </bookmaker>
                              </type>
                              <type value="Win Both Halves" stop="False" id="2293">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="5.00" g="{O:\'2012008907\',OF:\'4/1\'}" id="277721543229315681568" />
                                      <odd name="Away" value="26.00" g="{O:\'2012008918\',OF:\'25/1\'}" id="277721543229315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Total - Home" stop="False" id="22124">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="11.00" g="{O:\'2012008661\',OF:\'10/1\'}" id="2777215432212415721572" />
                                          <odd name="Under" value="1.05" g="{O:\'2012008663\',OF:\'1/20\'}" id="2777215432212415741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.00" g="{O:\'2012008636\',OF:\'1/1\'}" id="2777215432212415751575" />
                                          <odd name="Under" value="1.72" g="{O:\'2012008638\',OF:\'8/11\'}" id="2777215432212415771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="4.33" g="{O:\'2012008649\',OF:\'10/3\'}" id="2777215432212415811581" />
                                          <odd name="Under" value="1.20" g="{O:\'2012008651\',OF:\'1/5\'}" id="2777215432212415831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Total - Away" stop="False" id="22125">
                                  <bookmaker name="bet365" stop="False" ts="1557739490" id="16">
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="5.50" g="{O:\'2012008696\',OF:\'9/2\'}" id="2777215432212515751575" />
                                          <odd name="Under" value="1.14" g="{O:\'2012008698\',OF:\'1/7\'}" id="2777215432212515771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="19.00" g="{O:\'2012008709\',OF:\'18/1\'}" id="2777215432212515811581" />
                                          <odd name="Under" value="1.02" g="{O:\'2012008710\',OF:\'1/50\'}" id="2777215432212515831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result 1st Half" stop="False" id="22600">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="7.50" g="{O:\'2012008573\',OF:\'13/2\'}" id="2777215432260015441544" />
                                          <odd name="Away" value="1.53" g="{O:\'2012008575\',OF:\'8/15\'}" id="2777215432260015461546" />
                                          <odd name="Draw" value="3.10" g="{O:\'2012008574\',OF:\'21/10\'}" id="2777215432260017011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.12" g="{O:\'2012008581\',OF:\'1/8\'}" id="2777215432260015471547" />
                                          <odd name="Away" value="23.00" g="{O:\'2012008583\',OF:\'22/1\'}" id="2777215432260015491549" />
                                          <odd name="Draw" value="6.00" g="{O:\'2012008582\',OF:\'5/1\'}" id="2777215432260016961696" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="21.00" g="{O:\'2012008576\',OF:\'20/1\'}" id="2777215432260017021702" />
                                          <odd name="Draw" value="8.00" g="{O:\'2012008577\',OF:\'7/1\'}" id="2777215432260017041704" />
                                          <odd name="Away" value="1.08" g="{O:\'2012008578\',OF:\'1/12\'}" id="2777215432260017051705" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap First Half" stop="False" id="22601">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="+0" stop="False">
                                          <odd name="Home" value="1.32" g="{O:\'2018022627\',OF:\'13/40\'}" id="2777215432260115231523" />
                                          <odd name="Away" value="3.30" g="{O:\'2018022628\',OF:\'23/10\'}" id="2777215432260115251525" />
                                      </handicap>
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="1.85" g="{O:\'2011465588\',OF:\'17/20\'}" id="2777215432260115261526" />
                                          <odd name="Away" value="1.95" g="{O:\'2011465589\',OF:\'19/20\'}" id="2777215432260115281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="1.20" g="{O:\'2018022631\',OF:\'1/5\'}" id="2777215432260115291529" />
                                          <odd name="Away" value="4.40" g="{O:\'2018022632\',OF:\'17/5\'}" id="2777215432260115311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="2.35" g="{O:\'2018022625\',OF:\'27/20\'}" id="2777215432260115321532" />
                                          <odd name="Away" value="1.57" g="{O:\'2018022626\',OF:\'23/40\'}" id="2777215432260115341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="1.14" g="{O:\'2018022633\',OF:\'7/50\'}" id="2777215432260115351535" />
                                          <odd name="Away" value="5.75" g="{O:\'2018022634\',OF:\'19/4\'}" id="2777215432260115371537" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="3.10" g="{O:\'2018022623\',OF:\'21/10\'}" id="2777215432260115381538" />
                                          <odd name="Away" value="1.35" g="{O:\'2018022624\',OF:\'7/20\'}" id="2777215432260115401540" />
                                      </handicap>
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="5.50" g="{O:\'2018022621\',OF:\'9/2\'}" id="2777215432260115441544" />
                                          <odd name="Away" value="1.15" g="{O:\'2018022622\',OF:\'3/20\'}" id="2777215432260115461546" />
                                      </handicap>
                                      <handicap name="-1.25" stop="False">
                                          <odd name="Home" value="6.40" g="{O:\'2018022618\',OF:\'27/5\'}" id="2777215432260115561556" />
                                          <odd name="Away" value="1.11" g="{O:\'2018022620\',OF:\'23/200\'}" id="2777215432260115581558" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Double Chance - 1st Half" stop="False" id="22602">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.12" g="{O:\'2012007949\',OF:\'1/8\'}" id="2777215432260216261626" />
                                      <odd name="Home/Away" value="1.72" g="{O:\'2012007948\',OF:\'8/11\'}" id="2777215432260216271627" />
                                      <odd name="Draw/Away" value="1.53" g="{O:\'2012007947\',OF:\'8/15\'}" id="2777215432260216281628" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 1st Half" stop="False" id="22604">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="6.50" g="{O:\'2012008973\',OF:\'11/2\'}" id="2777215432260416291629" />
                                      <odd name="No" value="1.11" g="{O:\'2012008974\',OF:\'1/9\'}" id="2777215432260416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 2nd Half" stop="False" id="22605">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="4.50" g="{O:\'2012009005\',OF:\'7/2\'}" id="2777215432260516291629" />
                                      <odd name="No" value="1.18" g="{O:\'2012009006\',OF:\'2/11\'}" id="2777215432260516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Win To Nil" stop="False" id="22607">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.40" g="{O:\'2012008892\',OF:\'7/5\'}" id="2777215432260715681568" />
                                      <odd name="Away" value="8.00" g="{O:\'2012008895\',OF:\'7/1\'}" id="2777215432260715711571" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even" stop="False" id="22608">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="1.95" g="{O:\'2012007891\',OF:\'19/20\'}" id="2777215432260816881688" />
                                      <odd name="Even" value="1.90" g="{O:\'2012007890\',OF:\'9/10\'}" id="2777215432260816891689" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even 1st Half" stop="False" id="22609">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="2.20" g="{O:\'2012007941\',OF:\'6/5\'}" id="2777215432260916881688" />
                                      <odd name="Even" value="1.66" g="{O:\'2012007940\',OF:\'4/6\'}" id="2777215432260916891689" />
                                  </bookmaker>
                              </type>
                              <type value="Exact Goals Number" stop="False" id="22614">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.40" g="{O:\'2012008397\',OF:\'12/5\'}" id="2777215432261415881588" />
                                      <odd name="3" value="4.50" g="{O:\'2012008398\',OF:\'7/2\'}" id="2777215432261415911591" />
                                      <odd name="4" value="7.50" g="{O:\'2012008399\',OF:\'13/2\'}" id="2777215432261415941594" />
                                      <odd name="1" value="3.75" g="{O:\'2012008396\',OF:\'11/4\'}" id="2777215432261416821682" />
                                      <odd name="0" value="7.00" g="{O:\'2012008395\',OF:\'6/1\'}" id="2777215432261416901690" />
                                      <odd name="5" value="17.00" g="{O:\'2012008400\',OF:\'16/1\'}" id="2777215432261416911691" />
                                      <odd name="6" value="41.00" g="{O:\'2012008401\',OF:\'40/1\'}" id="2777215432261416921692" />
                                      <odd name="more 7" value="51.00" g="{O:\'2012008402\',OF:\'50/1\'}" id="2777215432261416931693" />
                                  </bookmaker>
                              </type>
                              <type value="To Win Either Half" stop="False" id="22615">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.44" g="{O:\'2012008896\',OF:\'4/9\'}" id="2777215432261515681568" />
                                      <odd name="Away" value="3.25" g="{O:\'2012008906\',OF:\'9/4\'}" id="2777215432261515711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home Team Exact Goals Number" stop="False" id="22616">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.50" g="{O:\'2012008959\',OF:\'5/2\'}" id="2777215432261615881588" />
                                      <odd name="1" value="2.75" g="{O:\'2012008958\',OF:\'7/4\'}" id="2777215432261616821682" />
                                      <odd name="0" value="4.00" g="{O:\'2012008957\',OF:\'3/1\'}" id="2777215432261616901690" />
                                      <odd name="more 3" value="4.33" g="{O:\'2012008960\',OF:\'10/3\'}" id="2777215432261617201720" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Exact Goals Number" stop="False" id="22617">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="6.50" g="{O:\'2012008964\',OF:\'11/2\'}" id="2777215432261715881588" />
                                      <odd name="1" value="2.50" g="{O:\'2012008963\',OF:\'6/4\'}" id="2777215432261716821682" />
                                      <odd name="0" value="1.83" g="{O:\'2012008961\',OF:\'5/6\'}" id="2777215432261716901690" />
                                      <odd name="more 3" value="19.00" g="{O:\'2012008965\',OF:\'18/1\'}" id="2777215432261717201720" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Exact Goals Number" stop="False" id="22619">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="4.00" g="{O:\'2012008622\',OF:\'3/1\'}" id="2777215432261915881588" />
                                      <odd name="3" value="9.00" g="{O:\'2012008623\',OF:\'8/1\'}" id="2777215432261915911591" />
                                      <odd name="4" value="26.00" g="{O:\'2012008624\',OF:\'25/1\'}" id="2777215432261915941594" />
                                      <odd name="1" value="2.60" g="{O:\'2012008621\',OF:\'8/5\'}" id="2777215432261916821682" />
                                      <odd name="0" value="3.25" g="{O:\'2012008620\',OF:\'9/4\'}" id="2777215432261916901690" />
                                      <odd name="more 5" value="51.00" g="{O:\'2012008625\',OF:\'50/1\'}" id="2777215432261917271727" />
                                  </bookmaker>
                              </type>
                              <type value="Results/Both Teams To Score" stop="False" id="22620">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Yes" value="4.75" g="{O:\'2012008939\',OF:\'15/4\'}" id="2777215432262017211721" />
                                      <odd name="Draw/Yes" value="5.50" g="{O:\'2012008941\',OF:\'9/2\'}" id="2777215432262017221722" />
                                      <odd name="Away/Yes" value="13.00" g="{O:\'2012008943\',OF:\'12/1\'}" id="2777215432262017231723" />
                                      <odd name="Home/No" value="2.40" g="{O:\'2012008940\',OF:\'7/5\'}" id="2777215432262017241724" />
                                      <odd name="Draw/No" value="7.00" g="{O:\'2012008942\',OF:\'6/1\'}" id="2777215432262017251725" />
                                      <odd name="Away/No" value="8.00" g="{O:\'2012008944\',OF:\'7/1\'}" id="2777215432262017261726" />
                                  </bookmaker>
                              </type>
                              <type value="Result/Total Goals" stop="False" id="22621">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="2.5" stop="False">
                                          <odd name="Home/Over" value="3.20" g="{O:\'2012008839\',OF:\'11/5\'}" id="2777215432262117141714" />
                                          <odd name="Draw/Over" value="21.00" g="{O:\'2012008841\',OF:\'20/1\'}" id="2777215432262117151715" />
                                          <odd name="Away/Over" value="12.00" g="{O:\'2012008843\',OF:\'11/1\'}" id="2777215432262117161716" />
                                          <odd name="Home/Under" value="3.10" g="{O:\'2012008840\',OF:\'21/10\'}" id="2777215432262117171717" />
                                          <odd name="Draw/Under" value="4.00" g="{O:\'2012008842\',OF:\'3/1\'}" id="2777215432262117181718" />
                                          <odd name="Away/Under" value="8.50" g="{O:\'2012008844\',OF:\'15/2\'}" id="2777215432262117191719" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Home Team Score a Goal" stop="False" id="22622">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.22" g="{O:\'2012008787\',OF:\'2/9\'}" id="2777215432262216291629" />
                                      <odd name="No" value="4.00" g="{O:\'2012008785\',OF:\'3/1\'}" id="2777215432262216301630" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Score a Goal" stop="False" id="22623">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.83" g="{O:\'2012008769\',OF:\'5/6\'}" id="2777215432262316291629" />
                                      <odd name="No" value="1.83" g="{O:\'2012008767\',OF:\'5/6\'}" id="2777215432262316301630" />
                                  </bookmaker>
                              </type>
                              <type value="First 10 min Winner" stop="False" id="22626">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="8.50" g="{O:\'2012070631\',OF:\'15/2\'}" id="2777215432262615681568" />
                                      <odd name="Draw" value="1.12" g="{O:\'2012070635\',OF:\'1/8\'}" id="2777215432262615701570" />
                                      <odd name="Away" value="17.00" g="{O:\'2012070639\',OF:\'16/1\'}" id="2777215432262615711571" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Exact Goals Number" stop="False" id="22655">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="4.75" g="{O:\'2012008567\',OF:\'15/4\'}" id="2777215432265515881588" />
                                      <odd name="3" value="13.00" g="{O:\'2012008568\',OF:\'12/1\'}" id="2777215432265515911591" />
                                      <odd name="4" value="41.00" g="{O:\'2012008569\',OF:\'40/1\'}" id="2777215432265515941594" />
                                      <odd name="1" value="2.50" g="{O:\'2012008566\',OF:\'6/4\'}" id="2777215432265516821682" />
                                      <odd name="0" value="2.50" g="{O:\'2012008565\',OF:\'6/4\'}" id="2777215432265516901690" />
                                      <odd name="more 5" value="101.00" g="{O:\'2012008571\',OF:\'100/1\'}" id="2777215432265517271727" />
                                  </bookmaker>
                              </type>
                          </odds>
                      </match>
                      <match status="22:00" date="Jun 16" formatted_date="16.06.2019" time="22:00" venue="Estádio Governador Magalhães Pinto" static_id="2581646" fix_id="3077142" id="3141452">
                          <localteam name="Uruguay" goals="?" id="17412" />
                          <visitorteam name="Ecuador" goals="?" id="8848" />
                          <events />
                          <ht score="" />
                          <odds ts="1557739490">
                              <type value="Match Winner" stop="False" id="1">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.60" g="{O:\'2011465595\',OF:\'3/5\'}" id="277721743115681568" />
                                      <odd name="Draw" value="3.50" g="{O:\'2011465596\',OF:\'5/2\'}" id="277721743115701570" />
                                      <odd name="Away" value="6.50" g="{O:\'2011465597\',OF:\'11/2\'}" id="277721743115711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home/Away" stop="False" id="2">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.22" g="{O:\'2012009624\',OF:\'2/9\'}" id="277721743215681568" />
                                      <odd name="Away" value="4.00" g="{O:\'2012009626\',OF:\'3/1\'}" id="277721743215711571" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Winner" stop="False" id="3">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.00" g="{O:\'2012010292\',OF:\'1/1\'}" id="277721743315681568" />
                                      <odd name="Draw" value="2.37" g="{O:\'2012010294\',OF:\'11/8\'}" id="277721743315701570" />
                                      <odd name="Away" value="5.50" g="{O:\'2012010298\',OF:\'9/2\'}" id="277721743315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap" stop="False" id="4">
                                  <bookmaker name="bet365" stop="False" ts="1557704718" id="16">
                                      <handicap name="+0" stop="False">
                                          <odd name="Home" value="1.24" g="{O:\'2018022725\',OF:\'6/25\'}" id="277721743415231523" />
                                          <odd name="Away" value="3.90" g="{O:\'2018022726\',OF:\'29/10\'}" id="277721743415251525" />
                                      </handicap>
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="1.45" g="{O:\'2018022723\',OF:\'9/20\'}" id="277721743415261526" />
                                          <odd name="Away" value="2.67" g="{O:\'2018022724\',OF:\'67/40\'}" id="277721743415281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="1.19" g="{O:\'2018022728\',OF:\'19/100\'}" id="277721743415291529" />
                                          <odd name="Away" value="4.50" g="{O:\'2018022730\',OF:\'7/2\'}" id="277721743415311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="1.65" g="{O:\'2018022707\',OF:\'13/20\'}" id="277721743415321532" />
                                          <odd name="Away" value="2.20" g="{O:\'2018022708\',OF:\'6/5\'}" id="277721743415341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="1.16" g="{O:\'2018022731\',OF:\'4/25\'}" id="277721743415351535" />
                                          <odd name="Away" value="5.25" g="{O:\'2018022732\',OF:\'17/4\'}" id="277721743415371537" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="1.91" g="{O:\'2011465600\',OF:\'91/100\'}" id="277721743415381538" />
                                          <odd name="Away" value="1.99" g="{O:\'2011465601\',OF:\'99/100\'}" id="277721743415401540" />
                                      </handicap>
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="2.20" g="{O:\'2058406371\',OF:\'6/5\'}" id="277721743415441544" />
                                          <odd name="Away" value="1.65" g="{O:\'2058406373\',OF:\'13/20\'}" id="277721743415461546" />
                                      </handicap>
                                      <handicap name="-1.5" stop="False">
                                          <odd name="Home" value="3.00" g="{O:\'2018022701\',OF:\'2/1\'}" id="277721743415501550" />
                                          <odd name="Away" value="1.37" g="{O:\'2018022702\',OF:\'3/8\'}" id="277721743415521552" />
                                      </handicap>
                                      <handicap name="-1.25" stop="False">
                                          <odd name="Home" value="2.60" g="{O:\'2018022703\',OF:\'8/5\'}" id="277721743415561556" />
                                          <odd name="Away" value="1.47" g="{O:\'2018022704\',OF:\'19/40\'}" id="277721743415581558" />
                                      </handicap>
                                      <handicap name="-1.75" stop="False">
                                          <odd name="Home" value="3.55" g="{O:\'2018022699\',OF:\'51/20\'}" id="277721743415591559" />
                                          <odd name="Away" value="1.27" g="{O:\'2018022700\',OF:\'11/40\'}" id="277721743415611561" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="5.50" g="{O:\'2018022695\',OF:\'9/2\'}" id="277721743417021702" />
                                          <odd name="Away" value="1.15" g="{O:\'2018022696\',OF:\'3/20\'}" id="277721743417051705" />
                                      </handicap>
                                      <handicap name="-2.5" stop="False">
                                          <odd name="Home" value="6.25" g="{O:\'2018022677\',OF:\'21/4\'}" id="277721743417671767" />
                                          <odd name="Away" value="1.12" g="{O:\'2018022678\',OF:\'3/25\'}" id="277721743417691769" />
                                      </handicap>
                                      <handicap name="-2.25" stop="False">
                                          <odd name="Home" value="5.90" g="{O:\'2018022679\',OF:\'49/10\'}" id="277721743417701770" />
                                          <odd name="Away" value="1.13" g="{O:\'2018022680\',OF:\'13/100\'}" id="277721743417721772" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under" stop="False" id="5">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="4.33" g="{O:\'2012010042\',OF:\'10/3\'}" id="277721743515721572" />
                                          <odd name="Under" value="1.22" g="{O:\'2012010043\',OF:\'2/9\'}" id="277721743515741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="1.44" g="{O:\'2012010040\',OF:\'4/9\'}" id="277721743515751575" />
                                          <odd name="Under" value="2.75" g="{O:\'2012010041\',OF:\'7/4\'}" id="277721743515771577" />
                                      </total>
                                      <total name="4.5" stop="False">
                                          <odd name="Over" value="9.00" g="{O:\'2012010047\',OF:\'8/1\'}" id="277721743515781578" />
                                          <odd name="Under" value="1.07" g="{O:\'2012010048\',OF:\'1/14\'}" id="277721743515801580" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="2.30" g="{O:\'2011465598\',OF:\'13/10\'}" id="277721743515811581" />
                                          <odd name="Under" value="1.61" g="{O:\'2011465599\',OF:\'8/13\'}" id="277721743515831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.10" g="{O:\'2012010038\',OF:\'1/10\'}" id="277721743515841584" />
                                          <odd name="Under" value="7.50" g="{O:\'2012010039\',OF:\'13/2\'}" id="277721743515861586" />
                                      </total>
                                      <total name="5.5" stop="False">
                                          <odd name="Over" value="19.00" g="{O:\'2012010060\',OF:\'18/1\'}" id="277721743515961596" />
                                          <odd name="Under" value="1.02" g="{O:\'2012010061\',OF:\'1/50\'}" id="277721743515981598" />
                                      </total>
                                      <total name="2.25" stop="False">
                                          <odd name="Over" value="2.07" g="{O:\'2011465602\',OF:\'107/100\'}" id="277721743515991599" />
                                          <odd name="Under" value="1.83" g="{O:\'2011465603\',OF:\'83/100\'}" id="277721743516011601" />
                                      </total>
                                      <total name="3.25" stop="False">
                                          <odd name="Over" value="3.80" g="{O:\'2018022765\',OF:\'14/5\'}" id="277721743516021602" />
                                          <odd name="Under" value="1.25" g="{O:\'2018022766\',OF:\'1/4\'}" id="277721743516041604" />
                                      </total>
                                      <total name="2.75" stop="False">
                                          <odd name="Over" value="2.67" g="{O:\'2018022761\',OF:\'67/40\'}" id="277721743516051605" />
                                          <odd name="Under" value="1.45" g="{O:\'2018022762\',OF:\'9/20\'}" id="277721743516071607" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="1.27" g="{O:\'2018022749\',OF:\'11/40\'}" id="277721743516081608" />
                                          <odd name="Under" value="3.55" g="{O:\'2018022750\',OF:\'51/20\'}" id="277721743516101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="1.52" g="{O:\'2018022753\',OF:\'21/40\'}" id="277721743516141614" />
                                          <odd name="Under" value="2.42" g="{O:\'2018022754\',OF:\'57/40\'}" id="277721743516161616" />
                                      </total>
                                      <total name="3.75" stop="False">
                                          <odd name="Over" value="5.50" g="{O:\'2018022769\',OF:\'9/2\'}" id="277721743516171617" />
                                          <odd name="Under" value="1.15" g="{O:\'2018022770\',OF:\'3/20\'}" id="277721743516191619" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.10" g="{O:\'2018022739\',OF:\'21/200\'}" id="277721743516841684" />
                                          <odd name="Under" value="6.80" g="{O:\'2018022740\',OF:\'29/5\'}" id="277721743516861686" />
                                      </total>
                                      <total name="3.0" stop="False">
                                          <odd name="Over" value="3.45" g="{O:\'2018022763\',OF:\'49/20\'}" id="277721743515901590" />
                                          <odd name="Under" value="1.30" g="{O:\'2018022764\',OF:\'3/10\'}" id="2777217435210052210052" />
                                      </total>
                                      <total name="2.0" stop="False">
                                          <odd name="Over" value="1.70" g="{O:\'2018022757\',OF:\'7/10\'}" id="277721743515871587" />
                                          <odd name="Under" value="2.10" g="{O:\'2018022758\',OF:\'11/10\'}" id="2777217435210055210055" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="1.12" g="{O:\'2018022741\',OF:\'3/25\'}" id="277721743516811681" />
                                          <odd name="Under" value="6.25" g="{O:\'2018022742\',OF:\'21/4\'}" id="277721743516831683" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 1st Half" stop="False" id="6">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="3.40" g="{O:\'2012010214\',OF:\'12/5\'}" id="277721743615751575" />
                                          <odd name="Under" value="1.30" g="{O:\'2012010215\',OF:\'3/10\'}" id="277721743615771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="10.00" g="{O:\'2012010226\',OF:\'9/1\'}" id="277721743615811581" />
                                          <odd name="Under" value="1.06" g="{O:\'2012010227\',OF:\'1/16\'}" id="277721743615831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.50" g="{O:\'2012010169\',OF:\'1/2\'}" id="277721743615841584" />
                                          <odd name="Under" value="2.50" g="{O:\'2012010170\',OF:\'6/4\'}" id="277721743615861586" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="2.75" g="{O:\'2018022949\',OF:\'7/4\'}" id="277721743616081608" />
                                          <odd name="Under" value="1.42" g="{O:\'2018022950\',OF:\'17/40\'}" id="277721743616101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="4.40" g="{O:\'2018022955\',OF:\'17/5\'}" id="277721743616141614" />
                                          <odd name="Under" value="1.20" g="{O:\'2018022956\',OF:\'1/5\'}" id="277721743616161616" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.70" g="{O:\'2011465606\',OF:\'7/10\'}" id="277721743616841684" />
                                          <odd name="Under" value="2.10" g="{O:\'2011465607\',OF:\'11/10\'}" id="277721743616861686" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="2.15" g="{O:\'2018022947\',OF:\'23/20\'}" id="277721743616811681" />
                                          <odd name="Under" value="1.67" g="{O:\'2018022948\',OF:\'27/40\'}" id="2777217436210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 2nd Half" stop="False" id="7">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="17.00" g="{O:\'2012010316\',OF:\'16/1\'}" id="277721743715721572" />
                                          <odd name="Under" value="1.02" g="{O:\'2012010317\',OF:\'1/40\'}" id="277721743715741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.50" g="{O:\'2012010311\',OF:\'6/4\'}" id="277721743715751575" />
                                          <odd name="Under" value="1.50" g="{O:\'2012010312\',OF:\'1/2\'}" id="277721743715771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="6.00" g="{O:\'2012010314\',OF:\'5/1\'}" id="277721743715811581" />
                                          <odd name="Under" value="1.12" g="{O:\'2012010315\',OF:\'1/8\'}" id="277721743715831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.30" g="{O:\'2012010307\',OF:\'3/10\'}" id="277721743715841584" />
                                          <odd name="Under" value="3.40" g="{O:\'2012010308\',OF:\'12/5\'}" id="277721743715861586" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="HT/FT Double" stop="False" id="12">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw/Draw" value="4.75" g="{O:\'2012009605\',OF:\'15/4\'}" id="2777217431216761676" />
                                      <odd name="Draw/Uruguay" value="4.00" g="{O:\'2012009603\',OF:\'3/1\'}" id="277721743122308723087" />
                                      <odd name="Uruguay/Draw" value="17.00" g="{O:\'2012009599\',OF:\'16/1\'}" id="277721743122308923089" />
                                      <odd name="Uruguay/Uruguay" value="2.60" g="{O:\'2012009597\',OF:\'8/5\'}" id="277721743122309023090" />
                                      <odd name="Uruguay/Ecuador" value="51.00" g="{O:\'2012009601\',OF:\'50/1\'}" id="27772174312434307434307" />
                                      <odd name="Ecuador/Uruguay" value="26.00" g="{O:\'2012009609\',OF:\'25/1\'}" id="27772174312434308434308" />
                                      <odd name="Ecuador/Ecuador" value="10.00" g="{O:\'2012009613\',OF:\'9/1\'}" id="277721743129970999709" />
                                      <odd name="Ecuador/Draw" value="17.00" g="{O:\'2012009611\',OF:\'16/1\'}" id="277721743129971099710" />
                                      <odd name="Draw/Ecuador" value="12.00" g="{O:\'2012009607\',OF:\'11/1\'}" id="277721743129971299712" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Home" stop="False" id="13">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.83" g="{O:\'2012010380\',OF:\'5/6\'}" id="2777217431316291629" />
                                      <odd name="No" value="1.83" g="{O:\'2012010381\',OF:\'5/6\'}" id="2777217431316301630" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Away" stop="False" id="14">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="4.33" g="{O:\'2012010383\',OF:\'10/3\'}" id="2777217431416291629" />
                                      <odd name="No" value="1.20" g="{O:\'2012010384\',OF:\'1/5\'}" id="2777217431416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score" stop="False" id="15">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="2.20" g="{O:\'2012010389\',OF:\'6/5\'}" id="2777217431516291629" />
                                      <odd name="No" value="1.61" g="{O:\'2012010391\',OF:\'8/13\'}" id="2777217431516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result" stop="False" id="79">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="2.87" g="{O:\'2012010142\',OF:\'15/8\'}" id="2777217437915441544" />
                                          <odd name="Away" value="2.37" g="{O:\'2012010144\',OF:\'11/8\'}" id="2777217437915461546" />
                                          <odd name="Draw" value="3.25" g="{O:\'2012010143\',OF:\'9/4\'}" id="2777217437917011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.12" g="{O:\'2012010151\',OF:\'1/8\'}" id="2777217437915471547" />
                                          <odd name="Away" value="15.00" g="{O:\'2012010153\',OF:\'14/1\'}" id="2777217437915491549" />
                                          <odd name="Draw" value="7.00" g="{O:\'2012010152\',OF:\'6/1\'}" id="2777217437916961696" />
                                      </handicap>
                                      <handicap name="+2" stop="False">
                                          <odd name="Home" value="1.02" g="{O:\'2012010154\',OF:\'1/40\'}" id="2777217437916971697" />
                                          <odd name="Draw" value="17.00" g="{O:\'2012010155\',OF:\'16/1\'}" id="2777217437916991699" />
                                          <odd name="Away" value="23.00" g="{O:\'2012010156\',OF:\'22/1\'}" id="2777217437917001700" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="6.00" g="{O:\'2012010148\',OF:\'5/1\'}" id="2777217437917021702" />
                                          <odd name="Draw" value="4.50" g="{O:\'2012010149\',OF:\'7/2\'}" id="2777217437917041704" />
                                          <odd name="Away" value="1.36" g="{O:\'2012010150\',OF:\'4/11\'}" id="2777217437917051705" />
                                      </handicap>
                                      <handicap name="-3" stop="False">
                                          <odd name="Home" value="13.00" g="{O:\'2012010145\',OF:\'12/1\'}" id="2777217437917061706" />
                                          <odd name="Draw" value="8.50" g="{O:\'2012010146\',OF:\'15/2\'}" id="2777217437917081708" />
                                          <odd name="Away" value="1.09" g="{O:\'2012010147\',OF:\'1/11\'}" id="2777217437917091709" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Correct Score" stop="False" id="81">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="5.50" g="{O:\'2012009527\',OF:\'9/2\'}" id="2777217438116311631" />
                                      <odd name="2:0" value="6.50" g="{O:\'2012009528\',OF:\'11/2\'}" id="2777217438116321632" />
                                      <odd name="2:1" value="8.50" g="{O:\'2012009530\',OF:\'15/2\'}" id="2777217438116331633" />
                                      <odd name="3:0" value="12.00" g="{O:\'2012009531\',OF:\'11/1\'}" id="2777217438116341634" />
                                      <odd name="3:1" value="15.00" g="{O:\'2012009533\',OF:\'14/1\'}" id="2777217438116351635" />
                                      <odd name="3:2" value="34.00" g="{O:\'2012009535\',OF:\'33/1\'}" id="2777217438116361636" />
                                      <odd name="4:0" value="26.00" g="{O:\'2012009537\',OF:\'25/1\'}" id="2777217438116371637" />
                                      <odd name="4:1" value="34.00" g="{O:\'2012009538\',OF:\'33/1\'}" id="2777217438116381638" />
                                      <odd name="4:2" value="67.00" g="{O:\'2012009540\',OF:\'66/1\'}" id="2777217438116391639" />
                                      <odd name="4:3" value="201.00" g="{O:\'2012009541\',OF:\'200/1\'}" id="2777217438116401640" />
                                      <odd name="5:0" value="51.00" g="{O:\'2012009543\',OF:\'50/1\'}" id="2777217438116411641" />
                                      <odd name="5:1" value="67.00" g="{O:\'2012009544\',OF:\'66/1\'}" id="2777217438116421642" />
                                      <odd name="5:2" value="151.00" g="{O:\'2012009546\',OF:\'150/1\'}" id="2777217438116431643" />
                                      <odd name="5:3" value="501.00" g="{O:\'2012009547\',OF:\'500/1\'}" id="2777217438116441644" />
                                      <odd name="6:0" value="151.00" g="{O:\'2012009549\',OF:\'150/1\'}" id="2777217438116461646" />
                                      <odd name="6:1" value="201.00" g="{O:\'2012009550\',OF:\'200/1\'}" id="2777217438116471647" />
                                      <odd name="6:2" value="501.00" g="{O:\'2012009552\',OF:\'500/1\'}" id="2777217438116481648" />
                                      <odd name="0:0" value="7.50" g="{O:\'2012009555\',OF:\'13/2\'}" id="2777217438116491649" />
                                      <odd name="1:1" value="7.00" g="{O:\'2012009556\',OF:\'6/1\'}" id="2777217438116501650" />
                                      <odd name="2:2" value="21.00" g="{O:\'2012009558\',OF:\'20/1\'}" id="2777217438116511651" />
                                      <odd name="3:3" value="81.00" g="{O:\'2012009559\',OF:\'80/1\'}" id="2777217438116521652" />
                                      <odd name="0:1" value="12.00" g="{O:\'2012009560\',OF:\'11/1\'}" id="2777217438116541654" />
                                      <odd name="0:2" value="29.00" g="{O:\'2012009561\',OF:\'28/1\'}" id="2777217438116551655" />
                                      <odd name="0:3" value="67.00" g="{O:\'2012009564\',OF:\'66/1\'}" id="2777217438116561656" />
                                      <odd name="0:4" value="301.00" g="{O:\'2012009569\',OF:\'300/1\'}" id="2777217438116571657" />
                                      <odd name="1:2" value="19.00" g="{O:\'2012009562\',OF:\'18/1\'}" id="2777217438116601660" />
                                      <odd name="1:3" value="51.00" g="{O:\'2012009565\',OF:\'50/1\'}" id="2777217438116611661" />
                                      <odd name="1:4" value="201.00" g="{O:\'2012009572\',OF:\'200/1\'}" id="2777217438116621662" />
                                      <odd name="2:3" value="51.00" g="{O:\'2012009567\',OF:\'50/1\'}" id="2777217438116651665" />
                                      <odd name="2:4" value="251.00" g="{O:\'2012009573\',OF:\'250/1\'}" id="2777217438116661666" />
                                      <odd name="3:4" value="451.00" g="{O:\'2012009575\',OF:\'450/1\'}" id="2777217438116691669" />
                                  </bookmaker>
                              </type>
                              <type value="Highest Scoring Half" stop="False" id="91">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw" value="3.25" g="{O:\'2012010279\',OF:\'9/4\'}" id="2777217439115701570" />
                                      <odd name="1st Half" value="3.20" g="{O:\'2012010277\',OF:\'11/5\'}" id="2777217439116941694" />
                                      <odd name="2nd Half" value="2.10" g="{O:\'2012010278\',OF:\'11/10\'}" id="2777217439116951695" />
                                  </bookmaker>
                              </type>
                              <type value="Correct Score 1st Half" stop="False" id="181">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="3.40" g="{O:\'2012009665\',OF:\'12/5\'}" id="27772174318116311631" />
                                      <odd name="2:0" value="9.00" g="{O:\'2012009667\',OF:\'8/1\'}" id="27772174318116321632" />
                                      <odd name="2:1" value="23.00" g="{O:\'2012009668\',OF:\'22/1\'}" id="27772174318116331633" />
                                      <odd name="3:0" value="34.00" g="{O:\'2012009670\',OF:\'33/1\'}" id="27772174318116341634" />
                                      <odd name="3:1" value="67.00" g="{O:\'2012009671\',OF:\'66/1\'}" id="27772174318116351635" />
                                      <odd name="3:2" value="301.00" g="{O:\'2012009673\',OF:\'300/1\'}" id="27772174318116361636" />
                                      <odd name="4:0" value="101.00" g="{O:\'2012009674\',OF:\'100/1\'}" id="27772174318116371637" />
                                      <odd name="4:1" value="251.00" g="{O:\'2012009676\',OF:\'250/1\'}" id="27772174318116381638" />
                                      <odd name="5:0" value="501.00" g="{O:\'2012009677\',OF:\'500/1\'}" id="27772174318116411641" />
                                      <odd name="0:0" value="2.50" g="{O:\'2012009680\',OF:\'6/4\'}" id="27772174318116491649" />
                                      <odd name="1:1" value="9.50" g="{O:\'2012009682\',OF:\'17/2\'}" id="27772174318116501650" />
                                      <odd name="2:2" value="81.00" g="{O:\'2012009684\',OF:\'80/1\'}" id="27772174318116511651" />
                                      <odd name="0:1" value="7.00" g="{O:\'2012009685\',OF:\'6/1\'}" id="27772174318116541654" />
                                      <odd name="0:2" value="34.00" g="{O:\'2012009688\',OF:\'33/1\'}" id="27772174318116551655" />
                                      <odd name="0:3" value="151.00" g="{O:\'2012009691\',OF:\'150/1\'}" id="27772174318116561656" />
                                      <odd name="1:2" value="41.00" g="{O:\'2012009690\',OF:\'40/1\'}" id="27772174318116601660" />
                                      <odd name="1:3" value="251.00" g="{O:\'2012009692\',OF:\'250/1\'}" id="27772174318116611661" />
                                  </bookmaker>
                              </type>
                              <type value="Double Chance" stop="False" id="222">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.12" g="{O:\'2012009514\',OF:\'1/8\'}" id="27772174322216261626" />
                                      <odd name="Home/Away" value="1.30" g="{O:\'2012009513\',OF:\'3/10\'}" id="27772174322216271627" />
                                      <odd name="Draw/Away" value="2.37" g="{O:\'2012009511\',OF:\'11/8\'}" id="27772174322216281628" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Winner" stop="False" id="2102">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.30" g="{O:\'2012009652\',OF:\'13/10\'}" id="277721743210215681568" />
                                      <odd name="Draw" value="2.05" g="{O:\'2012009654\',OF:\'21/20\'}" id="277721743210215701570" />
                                      <odd name="Away" value="6.00" g="{O:\'2012009655\',OF:\'5/1\'}" id="277721743210215711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score First" stop="False" id="2224">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.44" g="{O:\'2012009733\',OF:\'4/9\'}" id="277721743222415681568" />
                                      <odd name="Draw" value="7.50" g="{O:\'2012009736\',OF:\'13/2\'}" id="277721743222415701570" />
                                      <odd name="Away" value="3.50" g="{O:\'2012009737\',OF:\'5/2\'}" id="277721743222415711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score Last" stop="False" id="2225">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.44" g="{O:\'2012010420\',OF:\'4/9\'}" id="277721743222515681568" />
                                      <odd name="Away" value="3.50" g="{O:\'2012010423\',OF:\'5/2\'}" id="277721743222515711571" />
                                      <odd name="No goal" value="7.50" g="{O:\'2012010421\',OF:\'13/2\'}" id="277721743222516871687" />
                                  </bookmaker>
                              </type>
                              <type value="Win Both Halves" stop="False" id="2293">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="4.50" g="{O:\'2012010557\',OF:\'7/2\'}" id="277721743229315681568" />
                                      <odd name="Away" value="26.00" g="{O:\'2012010572\',OF:\'25/1\'}" id="277721743229315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Total - Home" stop="False" id="22124">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="11.00" g="{O:\'2012010340\',OF:\'10/1\'}" id="2777217432212415721572" />
                                          <odd name="Under" value="1.05" g="{O:\'2012010341\',OF:\'1/20\'}" id="2777217432212415741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="1.90" g="{O:\'2012010334\',OF:\'10/11\'}" id="2777217432212415751575" />
                                          <odd name="Under" value="1.80" g="{O:\'2012010335\',OF:\'4/5\'}" id="2777217432212415771577" />
                                      </total>
                                      <total name="4.5" stop="False">
                                          <odd name="Over" value="26.00" g="{O:\'2012010342\',OF:\'25/1\'}" id="2777217432212415781578" />
                                          <odd name="Under" value="1.01" g="{O:\'2012010343\',OF:\'1/100\'}" id="2777217432212415801580" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="4.00" g="{O:\'2012010338\',OF:\'3/1\'}" id="2777217432212415811581" />
                                          <odd name="Under" value="1.22" g="{O:\'2012010339\',OF:\'2/9\'}" id="2777217432212415831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Total - Away" stop="False" id="22125">
                                  <bookmaker name="bet365" stop="False" ts="1557739490" id="16">
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="5.50" g="{O:\'2012010350\',OF:\'9/2\'}" id="2777217432212515751575" />
                                          <odd name="Under" value="1.14" g="{O:\'2012010351\',OF:\'1/7\'}" id="2777217432212515771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="19.00" g="{O:\'2012010354\',OF:\'18/1\'}" id="2777217432212515811581" />
                                          <odd name="Under" value="1.02" g="{O:\'2012010355\',OF:\'1/50\'}" id="2777217432212515831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result 1st Half" stop="False" id="22600">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="7.00" g="{O:\'2012010266\',OF:\'6/1\'}" id="2777217432260015441544" />
                                          <odd name="Away" value="1.57" g="{O:\'2012010268\',OF:\'4/7\'}" id="2777217432260015461546" />
                                          <odd name="Draw" value="3.10" g="{O:\'2012010267\',OF:\'21/10\'}" id="2777217432260017011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.12" g="{O:\'2012010274\',OF:\'1/8\'}" id="2777217432260015471547" />
                                          <odd name="Away" value="26.00" g="{O:\'2012010276\',OF:\'25/1\'}" id="2777217432260015491549" />
                                          <odd name="Draw" value="6.50" g="{O:\'2012010275\',OF:\'11/2\'}" id="2777217432260016961696" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="19.00" g="{O:\'2012010271\',OF:\'18/1\'}" id="2777217432260017021702" />
                                          <odd name="Draw" value="8.00" g="{O:\'2012010272\',OF:\'7/1\'}" id="2777217432260017041704" />
                                          <odd name="Away" value="1.08" g="{O:\'2012010273\',OF:\'1/12\'}" id="2777217432260017051705" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap First Half" stop="False" id="22601">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="+0" stop="False">
                                          <odd name="Home" value="1.32" g="{O:\'2018022821\',OF:\'13/40\'}" id="2777217432260115231523" />
                                          <odd name="Away" value="3.30" g="{O:\'2018022823\',OF:\'23/10\'}" id="2777217432260115251525" />
                                      </handicap>
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="1.82" g="{O:\'2011465604\',OF:\'33/40\'}" id="2777217432260115261526" />
                                          <odd name="Away" value="1.97" g="{O:\'2011465605\',OF:\'39/40\'}" id="2777217432260115281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="1.20" g="{O:\'2018022832\',OF:\'1/5\'}" id="2777217432260115291529" />
                                          <odd name="Away" value="4.40" g="{O:\'2018022834\',OF:\'17/5\'}" id="2777217432260115311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="2.30" g="{O:\'2018022810\',OF:\'13/10\'}" id="2777217432260115321532" />
                                          <odd name="Away" value="1.60" g="{O:\'2018022812\',OF:\'3/5\'}" id="2777217432260115341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="1.14" g="{O:\'2018022844\',OF:\'7/50\'}" id="2777217432260115351535" />
                                          <odd name="Away" value="5.75" g="{O:\'2018022846\',OF:\'19/4\'}" id="2777217432260115371537" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="3.00" g="{O:\'2018022798\',OF:\'2/1\'}" id="2777217432260115381538" />
                                          <odd name="Away" value="1.37" g="{O:\'2018022800\',OF:\'3/8\'}" id="2777217432260115401540" />
                                      </handicap>
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="5.25" g="{O:\'2018022785\',OF:\'17/4\'}" id="2777217432260115441544" />
                                          <odd name="Away" value="1.16" g="{O:\'2018022786\',OF:\'4/25\'}" id="2777217432260115461546" />
                                      </handicap>
                                      <handicap name="-1.5" stop="False">
                                          <odd name="Home" value="6.80" g="{O:\'2018022781\',OF:\'29/5\'}" id="2777217432260115501550" />
                                          <odd name="Away" value="1.10" g="{O:\'2018022782\',OF:\'21/200\'}" id="2777217432260115521552" />
                                      </handicap>
                                      <handicap name="-1.25" stop="False">
                                          <odd name="Home" value="6.00" g="{O:\'2018022783\',OF:\'5/1\'}" id="2777217432260115561556" />
                                          <odd name="Away" value="1.12" g="{O:\'2018022784\',OF:\'1/8\'}" id="2777217432260115581558" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Double Chance - 1st Half" stop="False" id="22602">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.12" g="{O:\'2012009755\',OF:\'1/8\'}" id="2777217432260216261626" />
                                      <odd name="Home/Away" value="1.72" g="{O:\'2012009753\',OF:\'8/11\'}" id="2777217432260216271627" />
                                      <odd name="Draw/Away" value="1.57" g="{O:\'2012009751\',OF:\'4/7\'}" id="2777217432260216281628" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 1st Half" stop="False" id="22604">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="6.50" g="{O:\'2012010670\',OF:\'11/2\'}" id="2777217432260416291629" />
                                      <odd name="No" value="1.11" g="{O:\'2012010671\',OF:\'1/9\'}" id="2777217432260416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 2nd Half" stop="False" id="22605">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="4.33" g="{O:\'2012010742\',OF:\'10/3\'}" id="2777217432260516291629" />
                                      <odd name="No" value="1.20" g="{O:\'2012010744\',OF:\'1/5\'}" id="2777217432260516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Win To Nil" stop="False" id="22607">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.37" g="{O:\'2012010492\',OF:\'11/8\'}" id="2777217432260715681568" />
                                      <odd name="Away" value="8.50" g="{O:\'2012010505\',OF:\'15/2\'}" id="2777217432260715711571" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even" stop="False" id="22608">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="1.95" g="{O:\'2012009640\',OF:\'19/20\'}" id="2777217432260816881688" />
                                      <odd name="Even" value="1.90" g="{O:\'2012009638\',OF:\'9/10\'}" id="2777217432260816891689" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even 1st Half" stop="False" id="22609">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="2.20" g="{O:\'2012009721\',OF:\'6/5\'}" id="2777217432260916881688" />
                                      <odd name="Even" value="1.66" g="{O:\'2012009719\',OF:\'4/6\'}" id="2777217432260916891689" />
                                  </bookmaker>
                              </type>
                              <type value="Exact Goals Number" stop="False" id="22614">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.40" g="{O:\'2012010130\',OF:\'12/5\'}" id="2777217432261415881588" />
                                      <odd name="3" value="4.33" g="{O:\'2012010131\',OF:\'10/3\'}" id="2777217432261415911591" />
                                      <odd name="4" value="7.00" g="{O:\'2012010133\',OF:\'6/1\'}" id="2777217432261415941594" />
                                      <odd name="1" value="4.00" g="{O:\'2012010128\',OF:\'3/1\'}" id="2777217432261416821682" />
                                      <odd name="0" value="7.50" g="{O:\'2012010126\',OF:\'13/2\'}" id="2777217432261416901690" />
                                      <odd name="5" value="15.00" g="{O:\'2012010134\',OF:\'14/1\'}" id="2777217432261416911691" />
                                      <odd name="6" value="34.00" g="{O:\'2012010136\',OF:\'33/1\'}" id="2777217432261416921692" />
                                      <odd name="more 7" value="41.00" g="{O:\'2012010137\',OF:\'40/1\'}" id="2777217432261416931693" />
                                  </bookmaker>
                              </type>
                              <type value="To Win Either Half" stop="False" id="22615">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="1.40" g="{O:\'2012010516\',OF:\'2/5\'}" id="2777217432261515681568" />
                                      <odd name="Away" value="3.25" g="{O:\'2012010528\',OF:\'9/4\'}" id="2777217432261515711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home Team Exact Goals Number" stop="False" id="22616">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.40" g="{O:\'2012010638\',OF:\'12/5\'}" id="2777217432261615881588" />
                                      <odd name="1" value="2.75" g="{O:\'2012010637\',OF:\'7/4\'}" id="2777217432261616821682" />
                                      <odd name="0" value="4.33" g="{O:\'2012010636\',OF:\'10/3\'}" id="2777217432261616901690" />
                                      <odd name="more 3" value="4.00" g="{O:\'2012010639\',OF:\'3/1\'}" id="2777217432261617201720" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Exact Goals Number" stop="False" id="22617">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="6.50" g="{O:\'2012010653\',OF:\'11/2\'}" id="2777217432261715881588" />
                                      <odd name="1" value="2.50" g="{O:\'2012010651\',OF:\'6/4\'}" id="2777217432261716821682" />
                                      <odd name="0" value="1.83" g="{O:\'2012010648\',OF:\'5/6\'}" id="2777217432261716901690" />
                                      <odd name="more 3" value="19.00" g="{O:\'2012010654\',OF:\'18/1\'}" id="2777217432261717201720" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Exact Goals Number" stop="False" id="22619">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.75" g="{O:\'2012010328\',OF:\'11/4\'}" id="2777217432261915881588" />
                                      <odd name="3" value="8.50" g="{O:\'2012010329\',OF:\'15/2\'}" id="2777217432261915911591" />
                                      <odd name="4" value="23.00" g="{O:\'2012010330\',OF:\'22/1\'}" id="2777217432261915941594" />
                                      <odd name="1" value="2.60" g="{O:\'2012010327\',OF:\'8/5\'}" id="2777217432261916821682" />
                                      <odd name="0" value="3.40" g="{O:\'2012010326\',OF:\'12/5\'}" id="2777217432261916901690" />
                                      <odd name="more 5" value="41.00" g="{O:\'2012010331\',OF:\'40/1\'}" id="2777217432261917271727" />
                                  </bookmaker>
                              </type>
                              <type value="Results/Both Teams To Score" stop="False" id="22620">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Yes" value="4.50" g="{O:\'2012010616\',OF:\'7/2\'}" id="2777217432262017211721" />
                                      <odd name="Draw/Yes" value="5.50" g="{O:\'2012010618\',OF:\'9/2\'}" id="2777217432262017221722" />
                                      <odd name="Away/Yes" value="13.00" g="{O:\'2012010620\',OF:\'12/1\'}" id="2777217432262017231723" />
                                      <odd name="Home/No" value="2.37" g="{O:\'2012010617\',OF:\'11/8\'}" id="2777217432262017241724" />
                                      <odd name="Draw/No" value="7.50" g="{O:\'2012010619\',OF:\'13/2\'}" id="2777217432262017251725" />
                                      <odd name="Away/No" value="8.50" g="{O:\'2012010621\',OF:\'15/2\'}" id="2777217432262017261726" />
                                  </bookmaker>
                              </type>
                              <type value="Result/Total Goals" stop="False" id="22621">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="2.5" stop="False">
                                          <odd name="Home/Over" value="3.00" g="{O:\'2012010435\',OF:\'2/1\'}" id="2777217432262117141714" />
                                          <odd name="Draw/Over" value="21.00" g="{O:\'2012010438\',OF:\'20/1\'}" id="2777217432262117151715" />
                                          <odd name="Away/Over" value="12.00" g="{O:\'2012010440\',OF:\'11/1\'}" id="2777217432262117161716" />
                                          <odd name="Home/Under" value="3.20" g="{O:\'2012010437\',OF:\'11/5\'}" id="2777217432262117171717" />
                                          <odd name="Draw/Under" value="4.00" g="{O:\'2012010439\',OF:\'3/1\'}" id="2777217432262117181718" />
                                          <odd name="Away/Under" value="9.50" g="{O:\'2012010442\',OF:\'17/2\'}" id="2777217432262117191719" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Home Team Score a Goal" stop="False" id="22622">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.20" g="{O:\'2012010384\',OF:\'1/5\'}" id="2777217432262216291629" />
                                      <odd name="No" value="4.33" g="{O:\'2012010383\',OF:\'10/3\'}" id="2777217432262216301630" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Score a Goal" stop="False" id="22623">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.83" g="{O:\'2012010381\',OF:\'5/6\'}" id="2777217432262316291629" />
                                      <odd name="No" value="1.83" g="{O:\'2012010380\',OF:\'5/6\'}" id="2777217432262316301630" />
                                  </bookmaker>
                              </type>
                              <type value="First 10 min Winner" stop="False" id="22626">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="8.50" g="{O:\'2012070880\',OF:\'15/2\'}" id="2777217432262615681568" />
                                      <odd name="Draw" value="1.12" g="{O:\'2012070881\',OF:\'1/8\'}" id="2777217432262615701570" />
                                      <odd name="Away" value="19.00" g="{O:\'2012070882\',OF:\'18/1\'}" id="2777217432262615711571" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Exact Goals Number" stop="False" id="22655">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="4.50" g="{O:\'2012010262\',OF:\'7/2\'}" id="2777217432265515881588" />
                                      <odd name="3" value="13.00" g="{O:\'2012010263\',OF:\'12/1\'}" id="2777217432265515911591" />
                                      <odd name="4" value="41.00" g="{O:\'2012010264\',OF:\'40/1\'}" id="2777217432265515941594" />
                                      <odd name="1" value="2.50" g="{O:\'2012010261\',OF:\'6/4\'}" id="2777217432265516821682" />
                                      <odd name="0" value="2.50" g="{O:\'2012010260\',OF:\'6/4\'}" id="2777217432265516901690" />
                                      <odd name="more 5" value="101.00" g="{O:\'2012010265\',OF:\'100/1\'}" id="2777217432265517271727" />
                                  </bookmaker>
                              </type>
                          </odds>
                      </match>
                      <match status="23:00" date="Jun 17" formatted_date="17.06.2019" time="23:00" venue="Estádio Cícero Pompeu de Toledo" static_id="2581647" fix_id="3077143" id="3141453">
                          <localteam name="Japan" goals="?" id="12124" />
                          <visitorteam name="Chile" goals="?" id="7959" />
                          <events />
                          <ht score="" />
                          <odds ts="1557739490">
                              <type value="Match Winner" stop="False" id="1">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="4.75" g="{O:\'2011465612\',OF:\'15/4\'}" id="277721443115681568" />
                                      <odd name="Draw" value="3.30" g="{O:\'2011465613\',OF:\'23/10\'}" id="277721443115701570" />
                                      <odd name="Away" value="1.80" g="{O:\'2011465614\',OF:\'4/5\'}" id="277721443115711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home/Away" stop="False" id="2">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="3.40" g="{O:\'2012005472\',OF:\'12/5\'}" id="277721443215681568" />
                                      <odd name="Away" value="1.30" g="{O:\'2012005473\',OF:\'3/10\'}" id="277721443215711571" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Winner" stop="False" id="3">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="4.50" g="{O:\'2012006096\',OF:\'7/2\'}" id="277721443315681568" />
                                      <odd name="Draw" value="2.30" g="{O:\'2012006098\',OF:\'13/10\'}" id="277721443315701570" />
                                      <odd name="Away" value="2.20" g="{O:\'2012006100\',OF:\'6/5\'}" id="277721443315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap" stop="False" id="4">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="+0" stop="False">
                                          <odd name="Home" value="3.30" g="{O:\'2018021952\',OF:\'23/10\'}" id="277721443415231523" />
                                          <odd name="Away" value="1.32" g="{O:\'2018021953\',OF:\'13/40\'}" id="277721443415251525" />
                                      </handicap>
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="3.70" g="{O:\'2018021944\',OF:\'27/10\'}" id="277721443415261526" />
                                          <odd name="Away" value="1.26" g="{O:\'2018021945\',OF:\'13/50\'}" id="277721443415281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="2.35" g="{O:\'2018021958\',OF:\'27/20\'}" id="277721443415291529" />
                                          <odd name="Away" value="1.57" g="{O:\'2018021959\',OF:\'23/40\'}" id="277721443415311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="4.25" g="{O:\'2018021934\',OF:\'13/4\'}" id="277721443415321532" />
                                          <odd name="Away" value="1.21" g="{O:\'2018021935\',OF:\'21/100\'}" id="277721443415341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="2.03" g="{O:\'2011465617\',OF:\'103/100\'}" id="277721443415351535" />
                                          <odd name="Away" value="1.87" g="{O:\'2011465618\',OF:\'87/100\'}" id="277721443415371537" />
                                      </handicap>
                                      <handicap name="-0.75" stop="False">
                                          <odd name="Home" value="5.90" g="{O:\'2018021907\',OF:\'49/10\'}" id="277721443415381538" />
                                          <odd name="Away" value="1.13" g="{O:\'2018021911\',OF:\'13/100\'}" id="277721443415401540" />
                                      </handicap>
                                      <handicap name="+0.75" stop="False">
                                          <odd name="Home" value="1.72" g="{O:\'2018021961\',OF:\'29/40\'}" id="277721443415411541" />
                                          <odd name="Away" value="2.07" g="{O:\'2018021962\',OF:\'43/40\'}" id="277721443415431543" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.47" g="{O:\'2018021970\',OF:\'19/40\'}" id="277721443415471547" />
                                          <odd name="Away" value="2.60" g="{O:\'2018021972\',OF:\'8/5\'}" id="277721443415491549" />
                                      </handicap>
                                      <handicap name="+1.5" stop="False">
                                          <odd name="Home" value="1.30" g="{O:\'2018022016\',OF:\'3/10\'}" id="277721443415531553" />
                                          <odd name="Away" value="3.45" g="{O:\'2018022018\',OF:\'49/20\'}" id="277721443415551555" />
                                      </handicap>
                                      <handicap name="+1.25" stop="False">
                                          <odd name="Home" value="1.37" g="{O:\'2018022003\',OF:\'3/8\'}" id="277721443415621562" />
                                          <odd name="Away" value="3.00" g="{O:\'2018022006\',OF:\'2/1\'}" id="277721443415641564" />
                                      </handicap>
                                      <handicap name="+1.75" stop="False">
                                          <odd name="Home" value="1.20" g="{O:\'2018022028\',OF:\'1/5\'}" id="277721443415651565" />
                                          <odd name="Away" value="4.40" g="{O:\'2018022030\',OF:\'17/5\'}" id="277721443415671567" />
                                      </handicap>
                                      <handicap name="+2" stop="False">
                                          <odd name="Home" value="1.11" g="{O:\'2018022040\',OF:\'11/100\'}" id="277721443416971697" />
                                          <odd name="Away" value="6.60" g="{O:\'2018022042\',OF:\'28/5\'}" id="277721443417001700" />
                                      </handicap>
                                      <handicap name="+2.25" stop="True">
                                          <odd name="Home" value="1.10" g="{O:\'2018022053\',OF:\'1/10\'}" id="277721443417421742" />
                                          <odd name="Away" value="7.00" g="{O:\'2018022055\',OF:\'6/1\'}" id="277721443417441744" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under" stop="False" id="5">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="4.50" g="{O:\'2012005840\',OF:\'7/2\'}" id="277721443515721572" />
                                          <odd name="Under" value="1.20" g="{O:\'2012005841\',OF:\'1/5\'}" id="277721443515741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="1.44" g="{O:\'2012005838\',OF:\'4/9\'}" id="277721443515751575" />
                                          <odd name="Under" value="2.75" g="{O:\'2012005839\',OF:\'7/4\'}" id="277721443515771577" />
                                      </total>
                                      <total name="4.5" stop="False">
                                          <odd name="Over" value="10.00" g="{O:\'2012005846\',OF:\'9/1\'}" id="277721443515781578" />
                                          <odd name="Under" value="1.06" g="{O:\'2012005847\',OF:\'1/16\'}" id="277721443515801580" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="2.37" g="{O:\'2011465615\',OF:\'11/8\'}" id="277721443515811581" />
                                          <odd name="Under" value="1.57" g="{O:\'2011465616\',OF:\'4/7\'}" id="277721443515831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.10" g="{O:\'2012005834\',OF:\'1/10\'}" id="277721443515841584" />
                                          <odd name="Under" value="7.50" g="{O:\'2012005835\',OF:\'13/2\'}" id="277721443515861586" />
                                      </total>
                                      <total name="5.5" stop="False">
                                          <odd name="Over" value="21.00" g="{O:\'2012005850\',OF:\'20/1\'}" id="277721443515961596" />
                                          <odd name="Under" value="1.01" g="{O:\'2012005851\',OF:\'1/66\'}" id="277721443515981598" />
                                      </total>
                                      <total name="2.25" stop="False">
                                          <odd name="Over" value="2.05" g="{O:\'2018022158\',OF:\'21/20\'}" id="277721443515991599" />
                                          <odd name="Under" value="1.75" g="{O:\'2018022159\',OF:\'3/4\'}" id="277721443516011601" />
                                      </total>
                                      <total name="3.25" stop="False">
                                          <odd name="Over" value="4.00" g="{O:\'2018022201\',OF:\'3/1\'}" id="277721443516021602" />
                                          <odd name="Under" value="1.23" g="{O:\'2018022203\',OF:\'23/100\'}" id="277721443516041604" />
                                      </total>
                                      <total name="2.75" stop="False">
                                          <odd name="Over" value="2.75" g="{O:\'2018022174\',OF:\'7/4\'}" id="277721443516051605" />
                                          <odd name="Under" value="1.42" g="{O:\'2018022177\',OF:\'17/40\'}" id="277721443516071607" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="1.27" g="{O:\'2018022133\',OF:\'11/40\'}" id="277721443516081608" />
                                          <odd name="Under" value="3.55" g="{O:\'2018022135\',OF:\'51/20\'}" id="277721443516101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="1.55" g="{O:\'2018022155\',OF:\'11/20\'}" id="277721443516141614" />
                                          <odd name="Under" value="2.37" g="{O:\'2018022157\',OF:\'11/8\'}" id="277721443516161616" />
                                      </total>
                                      <total name="3.75" stop="False">
                                          <odd name="Over" value="5.75" g="{O:\'2018022215\',OF:\'19/4\'}" id="277721443516171617" />
                                          <odd name="Under" value="1.14" g="{O:\'2018022216\',OF:\'7/50\'}" id="277721443516191619" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.11" g="{O:\'2018022109\',OF:\'11/100\'}" id="277721443516841684" />
                                          <odd name="Under" value="6.60" g="{O:\'2018022111\',OF:\'28/5\'}" id="277721443516861686" />
                                      </total>
                                      <total name="3.0" stop="False">
                                          <odd name="Over" value="3.55" g="{O:\'2018022188\',OF:\'51/20\'}" id="277721443515901590" />
                                          <odd name="Under" value="1.27" g="{O:\'2018022189\',OF:\'11/40\'}" id="2777214435210052210052" />
                                      </total>
                                      <total name="2.0" stop="False">
                                          <odd name="Over" value="1.79" g="{O:\'2011465619\',OF:\'79/100\'}" id="277721443515871587" />
                                          <odd name="Under" value="2.11" g="{O:\'2011465620\',OF:\'111/100\'}" id="2777214435210055210055" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="1.13" g="{O:\'2018022121\',OF:\'13/100\'}" id="277721443516811681" />
                                          <odd name="Under" value="5.90" g="{O:\'2018022123\',OF:\'49/10\'}" id="2777214435210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 1st Half" stop="False" id="6">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="3.50" g="{O:\'2012005940\',OF:\'5/2\'}" id="277721443615751575" />
                                          <odd name="Under" value="1.28" g="{O:\'2012005941\',OF:\'2/7\'}" id="277721443615771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="11.00" g="{O:\'2012005964\',OF:\'10/1\'}" id="277721443615811581" />
                                          <odd name="Under" value="1.05" g="{O:\'2012005966\',OF:\'1/20\'}" id="277721443615831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.50" g="{O:\'2012005938\',OF:\'1/2\'}" id="277721443615841584" />
                                          <odd name="Under" value="2.50" g="{O:\'2012005939\',OF:\'6/4\'}" id="277721443615861586" />
                                      </total>
                                      <total name="1.25" stop="False">
                                          <odd name="Over" value="2.75" g="{O:\'2018022305\',OF:\'7/4\'}" id="277721443616081608" />
                                          <odd name="Under" value="1.42" g="{O:\'2018022306\',OF:\'17/40\'}" id="277721443616101610" />
                                      </total>
                                      <total name="1.75" stop="False">
                                          <odd name="Over" value="4.50" g="{O:\'2018022309\',OF:\'7/2\'}" id="277721443616141614" />
                                          <odd name="Under" value="1.19" g="{O:\'2018022310\',OF:\'19/100\'}" id="277721443616161616" />
                                      </total>
                                      <total name="0.75" stop="False">
                                          <odd name="Over" value="1.72" g="{O:\'2011465623\',OF:\'29/40\'}" id="277721443616841684" />
                                          <odd name="Under" value="2.07" g="{O:\'2011465624\',OF:\'43/40\'}" id="277721443616861686" />
                                      </total>
                                      <total name="1.0" stop="False">
                                          <odd name="Over" value="2.20" g="{O:\'2018022303\',OF:\'6/5\'}" id="277721443616811681" />
                                          <odd name="Under" value="1.65" g="{O:\'2018022304\',OF:\'13/20\'}" id="2777214436210061210061" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Goals Over/Under 2nd Half" stop="False" id="7">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="17.00" g="{O:\'2012006310\',OF:\'16/1\'}" id="277721443715721572" />
                                          <odd name="Under" value="1.02" g="{O:\'2012006312\',OF:\'1/40\'}" id="277721443715741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.50" g="{O:\'2012006262\',OF:\'6/4\'}" id="277721443715751575" />
                                          <odd name="Under" value="1.50" g="{O:\'2012006264\',OF:\'1/2\'}" id="277721443715771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="6.00" g="{O:\'2012006279\',OF:\'5/1\'}" id="277721443715811581" />
                                          <odd name="Under" value="1.12" g="{O:\'2012006281\',OF:\'1/8\'}" id="277721443715831583" />
                                      </total>
                                      <total name="0.5" stop="False">
                                          <odd name="Over" value="1.30" g="{O:\'2012006111\',OF:\'3/10\'}" id="277721443715841584" />
                                          <odd name="Under" value="3.40" g="{O:\'2012006113\',OF:\'12/5\'}" id="277721443715861586" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="HT/FT Double" stop="False" id="12">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw/Draw" value="4.50" g="{O:\'2012005466\',OF:\'7/2\'}" id="2777214431216761676" />
                                      <odd name="Draw/Japan" value="9.50" g="{O:\'2012005465\',OF:\'17/2\'}" id="277721443122280622806" />
                                      <odd name="Japan/Draw" value="17.00" g="{O:\'2012005463\',OF:\'16/1\'}" id="277721443122280822808" />
                                      <odd name="Japan/Japan" value="8.00" g="{O:\'2012005462\',OF:\'7/1\'}" id="277721443122280922809" />
                                      <odd name="Draw/Chile" value="4.33" g="{O:\'2012005467\',OF:\'10/3\'}" id="277721443126001060010" />
                                      <odd name="Chile/Draw" value="15.00" g="{O:\'2012005469\',OF:\'14/1\'}" id="277721443126001260012" />
                                      <odd name="Chile/Chile" value="2.87" g="{O:\'2012005470\',OF:\'15/8\'}" id="277721443126001360013" />
                                      <odd name="Japan/Chile" value="26.00" g="{O:\'2012005464\',OF:\'25/1\'}" id="277721443127238572385" />
                                      <odd name="Chile/Japan" value="41.00" g="{O:\'2012005468\',OF:\'40/1\'}" id="277721443127238672386" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Home" stop="False" id="13">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="4.00" g="{O:\'2012006485\',OF:\'3/1\'}" id="2777214431316291629" />
                                      <odd name="No" value="1.22" g="{O:\'2012006486\',OF:\'2/9\'}" id="2777214431316301630" />
                                  </bookmaker>
                              </type>
                              <type value="Clean Sheet - Away" stop="False" id="14">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="2.10" g="{O:\'2012006489\',OF:\'11/10\'}" id="2777214431416291629" />
                                      <odd name="No" value="1.66" g="{O:\'2012006490\',OF:\'4/6\'}" id="2777214431416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score" stop="False" id="15">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="2.10" g="{O:\'2012006491\',OF:\'11/10\'}" id="2777214431516291629" />
                                      <odd name="No" value="1.66" g="{O:\'2012006492\',OF:\'4/6\'}" id="2777214431516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result" stop="False" id="79">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="11.00" g="{O:\'2012005909\',OF:\'10/1\'}" id="2777214437915441544" />
                                          <odd name="Away" value="1.20" g="{O:\'2012005911\',OF:\'1/5\'}" id="2777214437915461546" />
                                          <odd name="Draw" value="6.00" g="{O:\'2012005910\',OF:\'5/1\'}" id="2777214437917011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="2.05" g="{O:\'2012005903\',OF:\'21/20\'}" id="2777214437915471547" />
                                          <odd name="Away" value="3.25" g="{O:\'2012005905\',OF:\'9/4\'}" id="2777214437915491549" />
                                          <odd name="Draw" value="3.40" g="{O:\'2012005904\',OF:\'12/5\'}" id="2777214437916961696" />
                                      </handicap>
                                      <handicap name="+2" stop="False">
                                          <odd name="Home" value="1.28" g="{O:\'2012005913\',OF:\'2/7\'}" id="2777214437916971697" />
                                          <odd name="Draw" value="5.00" g="{O:\'2012005914\',OF:\'4/1\'}" id="2777214437916991699" />
                                          <odd name="Away" value="7.00" g="{O:\'2012005916\',OF:\'6/1\'}" id="2777214437917001700" />
                                      </handicap>
                                      <handicap name="-2" stop="False">
                                          <odd name="Home" value="21.00" g="{O:\'2012005906\',OF:\'20/1\'}" id="2777214437917021702" />
                                          <odd name="Draw" value="13.00" g="{O:\'2012005907\',OF:\'12/1\'}" id="2777214437917041704" />
                                          <odd name="Away" value="1.04" g="{O:\'2012005908\',OF:\'1/25\'}" id="2777214437917051705" />
                                      </handicap>
                                      <handicap name="+3" stop="False">
                                          <odd name="Home" value="1.07" g="{O:\'2012005917\',OF:\'1/14\'}" id="2777214437917101710" />
                                          <odd name="Draw" value="9.00" g="{O:\'2012005918\',OF:\'8/1\'}" id="2777214437917121712" />
                                          <odd name="Away" value="15.00" g="{O:\'2012005919\',OF:\'14/1\'}" id="2777214437917131713" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Correct Score" stop="False" id="81">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="10.00" g="{O:\'2012005418\',OF:\'9/1\'}" id="2777214438116311631" />
                                      <odd name="2:0" value="23.00" g="{O:\'2012005420\',OF:\'22/1\'}" id="2777214438116321632" />
                                      <odd name="2:1" value="17.00" g="{O:\'2012005421\',OF:\'16/1\'}" id="2777214438116331633" />
                                      <odd name="3:0" value="51.00" g="{O:\'2012005422\',OF:\'50/1\'}" id="2777214438116341634" />
                                      <odd name="3:1" value="41.00" g="{O:\'2012005423\',OF:\'40/1\'}" id="2777214438116351635" />
                                      <odd name="3:2" value="51.00" g="{O:\'2012005424\',OF:\'50/1\'}" id="2777214438116361636" />
                                      <odd name="4:0" value="151.00" g="{O:\'2012005425\',OF:\'150/1\'}" id="2777214438116371637" />
                                      <odd name="4:1" value="126.00" g="{O:\'2012005426\',OF:\'125/1\'}" id="2777214438116381638" />
                                      <odd name="4:2" value="151.00" g="{O:\'2012005428\',OF:\'150/1\'}" id="2777214438116391639" />
                                      <odd name="4:3" value="301.00" g="{O:\'2012005429\',OF:\'300/1\'}" id="2777214438116401640" />
                                      <odd name="5:1" value="501.00" g="{O:\'2012005430\',OF:\'500/1\'}" id="2777214438116421642" />
                                      <odd name="0:0" value="7.50" g="{O:\'2012005431\',OF:\'13/2\'}" id="2777214438116491649" />
                                      <odd name="1:1" value="6.50" g="{O:\'2012005432\',OF:\'11/2\'}" id="2777214438116501650" />
                                      <odd name="2:2" value="19.00" g="{O:\'2012005433\',OF:\'18/1\'}" id="2777214438116511651" />
                                      <odd name="3:3" value="81.00" g="{O:\'2012005434\',OF:\'80/1\'}" id="2777214438116521652" />
                                      <odd name="0:1" value="5.50" g="{O:\'2012005435\',OF:\'9/2\'}" id="2777214438116541654" />
                                      <odd name="0:2" value="7.50" g="{O:\'2012005436\',OF:\'13/2\'}" id="2777214438116551655" />
                                      <odd name="0:3" value="15.00" g="{O:\'2012005438\',OF:\'14/1\'}" id="2777214438116561656" />
                                      <odd name="0:4" value="34.00" g="{O:\'2012005441\',OF:\'33/1\'}" id="2777214438116571657" />
                                      <odd name="0:5" value="67.00" g="{O:\'2012005445\',OF:\'66/1\'}" id="2777214438116581658" />
                                      <odd name="0:6" value="201.00" g="{O:\'2012005449\',OF:\'200/1\'}" id="2777214438116591659" />
                                      <odd name="1:2" value="9.00" g="{O:\'2012005437\',OF:\'8/1\'}" id="2777214438116601660" />
                                      <odd name="1:3" value="17.00" g="{O:\'2012005439\',OF:\'16/1\'}" id="2777214438116611661" />
                                      <odd name="1:4" value="41.00" g="{O:\'2012005442\',OF:\'40/1\'}" id="2777214438116621662" />
                                      <odd name="1:5" value="81.00" g="{O:\'2012005446\',OF:\'80/1\'}" id="2777214438116631663" />
                                      <odd name="1:6" value="251.00" g="{O:\'2012005450\',OF:\'250/1\'}" id="2777214438116641664" />
                                      <odd name="2:3" value="34.00" g="{O:\'2012005440\',OF:\'33/1\'}" id="2777214438116651665" />
                                      <odd name="2:4" value="67.00" g="{O:\'2012005443\',OF:\'66/1\'}" id="2777214438116661666" />
                                      <odd name="2:5" value="151.00" g="{O:\'2012005447\',OF:\'150/1\'}" id="2777214438116671667" />
                                      <odd name="3:4" value="151.00" g="{O:\'2012005444\',OF:\'150/1\'}" id="2777214438116691669" />
                                      <odd name="3:5" value="501.00" g="{O:\'2012005448\',OF:\'500/1\'}" id="2777214438116701670" />
                                  </bookmaker>
                              </type>
                              <type value="Highest Scoring Half" stop="False" id="91">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Draw" value="3.25" g="{O:\'2012006081\',OF:\'9/4\'}" id="2777214439115701570" />
                                      <odd name="1st Half" value="3.20" g="{O:\'2012006077\',OF:\'11/5\'}" id="2777214439116941694" />
                                      <odd name="2nd Half" value="2.10" g="{O:\'2012006079\',OF:\'11/10\'}" id="2777214439116951695" />
                                  </bookmaker>
                              </type>
                              <type value="Correct Score 1st Half" stop="False" id="181">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="1:0" value="6.00" g="{O:\'2012005488\',OF:\'5/1\'}" id="27772144318116311631" />
                                      <odd name="2:0" value="29.00" g="{O:\'2012005490\',OF:\'28/1\'}" id="27772144318116321632" />
                                      <odd name="2:1" value="41.00" g="{O:\'2012005491\',OF:\'40/1\'}" id="27772144318116331633" />
                                      <odd name="3:0" value="126.00" g="{O:\'2012005492\',OF:\'125/1\'}" id="27772144318116341634" />
                                      <odd name="3:1" value="151.00" g="{O:\'2012005493\',OF:\'150/1\'}" id="27772144318116351635" />
                                      <odd name="3:2" value="501.00" g="{O:\'2012005495\',OF:\'500/1\'}" id="27772144318116361636" />
                                      <odd name="0:0" value="2.50" g="{O:\'2012005497\',OF:\'6/4\'}" id="27772144318116491649" />
                                      <odd name="1:1" value="9.00" g="{O:\'2012005498\',OF:\'8/1\'}" id="27772144318116501650" />
                                      <odd name="2:2" value="81.00" g="{O:\'2012005499\',OF:\'80/1\'}" id="27772144318116511651" />
                                      <odd name="0:1" value="3.60" g="{O:\'2012005500\',OF:\'13/5\'}" id="27772144318116541654" />
                                      <odd name="0:2" value="10.00" g="{O:\'2012005501\',OF:\'9/1\'}" id="27772144318116551655" />
                                      <odd name="0:3" value="41.00" g="{O:\'2012005503\',OF:\'40/1\'}" id="27772144318116561656" />
                                      <odd name="0:4" value="126.00" g="{O:\'2012005506\',OF:\'125/1\'}" id="27772144318116571657" />
                                      <odd name="1:2" value="26.00" g="{O:\'2012005502\',OF:\'25/1\'}" id="27772144318116601660" />
                                      <odd name="1:3" value="67.00" g="{O:\'2012005504\',OF:\'66/1\'}" id="27772144318116611661" />
                                      <odd name="1:4" value="301.00" g="{O:\'2012005507\',OF:\'300/1\'}" id="27772144318116621662" />
                                      <odd name="2:3" value="301.00" g="{O:\'2012005505\',OF:\'300/1\'}" id="27772144318116651665" />
                                  </bookmaker>
                              </type>
                              <type value="Double Chance" stop="False" id="222">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="2.05" g="{O:\'2012005415\',OF:\'21/20\'}" id="27772144322216261626" />
                                      <odd name="Home/Away" value="1.34" g="{O:\'2012005414\',OF:\'17/50\'}" id="27772144322216271627" />
                                      <odd name="Draw/Away" value="1.20" g="{O:\'2012005408\',OF:\'1/5\'}" id="27772144322216281628" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Winner" stop="False" id="2102">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="5.50" g="{O:\'2012005478\',OF:\'9/2\'}" id="277721443210215681568" />
                                      <odd name="Draw" value="2.00" g="{O:\'2012005479\',OF:\'1/1\'}" id="277721443210215701570" />
                                      <odd name="Away" value="2.50" g="{O:\'2012005480\',OF:\'6/4\'}" id="277721443210215711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score First" stop="False" id="2224">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="3.00" g="{O:\'2012005514\',OF:\'2/1\'}" id="277721443222415681568" />
                                      <odd name="Draw" value="7.50" g="{O:\'2012005516\',OF:\'13/2\'}" id="277721443222415701570" />
                                      <odd name="Away" value="1.53" g="{O:\'2012005517\',OF:\'8/15\'}" id="277721443222415711571" />
                                  </bookmaker>
                              </type>
                              <type value="Team To Score Last" stop="False" id="2225">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="3.00" g="{O:\'2012006503\',OF:\'2/1\'}" id="277721443222515681568" />
                                      <odd name="Away" value="1.53" g="{O:\'2012006505\',OF:\'8/15\'}" id="277721443222515711571" />
                                      <odd name="No goal" value="7.50" g="{O:\'2012006504\',OF:\'13/2\'}" id="277721443222516871687" />
                                  </bookmaker>
                              </type>
                              <type value="Win Both Halves" stop="False" id="2293">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="21.00" g="{O:\'2012006650\',OF:\'20/1\'}" id="277721443229315681568" />
                                      <odd name="Away" value="5.50" g="{O:\'2012006651\',OF:\'9/2\'}" id="277721443229315711571" />
                                  </bookmaker>
                              </type>
                              <type value="Total - Home" stop="False" id="22124">
                                  <bookmaker name="bet365" stop="False" ts="1557739490" id="16">
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="4.50" g="{O:\'2012006356\',OF:\'7/2\'}" id="2777214432212415751575" />
                                          <odd name="Under" value="1.18" g="{O:\'2012006357\',OF:\'2/11\'}" id="2777214432212415771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="15.00" g="{O:\'2012006367\',OF:\'14/1\'}" id="2777214432212415811581" />
                                          <odd name="Under" value="1.03" g="{O:\'2012006369\',OF:\'1/33\'}" id="2777214432212415831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Total - Away" stop="False" id="22125">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="3.5" stop="False">
                                          <odd name="Over" value="13.00" g="{O:\'2012006474\',OF:\'12/1\'}" id="2777214432212515721572" />
                                          <odd name="Under" value="1.04" g="{O:\'2012006475\',OF:\'1/25\'}" id="2777214432212515741574" />
                                      </total>
                                      <total name="1.5" stop="False">
                                          <odd name="Over" value="2.10" g="{O:\'2012006418\',OF:\'11/10\'}" id="2777214432212515751575" />
                                          <odd name="Under" value="1.66" g="{O:\'2012006419\',OF:\'4/6\'}" id="2777214432212515771577" />
                                      </total>
                                      <total name="2.5" stop="False">
                                          <odd name="Over" value="4.50" g="{O:\'2012006469\',OF:\'7/2\'}" id="2777214432212515811581" />
                                          <odd name="Under" value="1.18" g="{O:\'2012006472\',OF:\'2/11\'}" id="2777214432212515831583" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Handicap Result 1st Half" stop="False" id="22600">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="-1" stop="False">
                                          <odd name="Home" value="21.00" g="{O:\'2012006046\',OF:\'20/1\'}" id="2777214432260015441544" />
                                          <odd name="Away" value="1.14" g="{O:\'2012006050\',OF:\'1/7\'}" id="2777214432260015461546" />
                                          <odd name="Draw" value="5.50" g="{O:\'2012006048\',OF:\'9/2\'}" id="2777214432260017011701" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.50" g="{O:\'2012006032\',OF:\'1/2\'}" id="2777214432260015471547" />
                                          <odd name="Away" value="8.00" g="{O:\'2012006035\',OF:\'7/1\'}" id="2777214432260015491549" />
                                          <odd name="Draw" value="3.20" g="{O:\'2012006034\',OF:\'11/5\'}" id="2777214432260016961696" />
                                      </handicap>
                                      <handicap name="+2" stop="False">
                                          <odd name="Home" value="1.07" g="{O:\'2012006064\',OF:\'1/14\'}" id="2777214432260016971697" />
                                          <odd name="Draw" value="9.00" g="{O:\'2012006066\',OF:\'8/1\'}" id="2777214432260016991699" />
                                          <odd name="Away" value="21.00" g="{O:\'2012006067\',OF:\'20/1\'}" id="2777214432260017001700" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Asian Handicap First Half" stop="False" id="22601">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <handicap name="+0" stop="False">
                                          <odd name="Home" value="2.75" g="{O:\'2018022238\',OF:\'7/4\'}" id="2777214432260115231523" />
                                          <odd name="Away" value="1.42" g="{O:\'2018022239\',OF:\'17/40\'}" id="2777214432260115251525" />
                                      </handicap>
                                      <handicap name="-0.25" stop="False">
                                          <odd name="Home" value="3.80" g="{O:\'2018022236\',OF:\'14/5\'}" id="2777214432260115261526" />
                                          <odd name="Away" value="1.25" g="{O:\'2018022237\',OF:\'1/4\'}" id="2777214432260115281528" />
                                      </handicap>
                                      <handicap name="+0.25" stop="False">
                                          <odd name="Home" value="1.80" g="{O:\'2011465621\',OF:\'4/5\'}" id="2777214432260115291529" />
                                          <odd name="Away" value="2.00" g="{O:\'2011465622\',OF:\'1/1\'}" id="2777214432260115311531" />
                                      </handicap>
                                      <handicap name="-0.5" stop="False">
                                          <odd name="Home" value="5.00" g="{O:\'2018022232\',OF:\'4/1\'}" id="2777214432260115321532" />
                                          <odd name="Away" value="1.17" g="{O:\'2018022233\',OF:\'17/100\'}" id="2777214432260115341534" />
                                      </handicap>
                                      <handicap name="+0.5" stop="False">
                                          <odd name="Home" value="1.50" g="{O:\'2018022242\',OF:\'1/2\'}" id="2777214432260115351535" />
                                          <odd name="Away" value="2.50" g="{O:\'2018022243\',OF:\'6/4\'}" id="2777214432260115371537" />
                                      </handicap>
                                      <handicap name="+0.75" stop="False">
                                          <odd name="Home" value="1.30" g="{O:\'2018022244\',OF:\'3/10\'}" id="2777214432260115411541" />
                                          <odd name="Away" value="3.45" g="{O:\'2018022245\',OF:\'49/20\'}" id="2777214432260115431543" />
                                      </handicap>
                                      <handicap name="+1" stop="False">
                                          <odd name="Home" value="1.12" g="{O:\'2018022246\',OF:\'1/8\'}" id="2777214432260115471547" />
                                          <odd name="Away" value="6.00" g="{O:\'2018022247\',OF:\'5/1\'}" id="2777214432260115491549" />
                                      </handicap>
                                      <handicap name="+1.25" stop="False">
                                          <odd name="Home" value="1.10" g="{O:\'2018022248\',OF:\'1/10\'}" id="2777214432260115621562" />
                                          <odd name="Away" value="7.00" g="{O:\'2018022249\',OF:\'6/1\'}" id="2777214432260115641564" />
                                      </handicap>
                                  </bookmaker>
                              </type>
                              <type value="Double Chance - 1st Half" stop="False" id="22602">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Draw" value="1.50" g="{O:\'2012005520\',OF:\'1/2\'}" id="2777214432260216261626" />
                                      <odd name="Home/Away" value="1.72" g="{O:\'2012005519\',OF:\'8/11\'}" id="2777214432260216271627" />
                                      <odd name="Draw/Away" value="1.14" g="{O:\'2012005518\',OF:\'1/7\'}" id="2777214432260216281628" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 1st Half" stop="False" id="22604">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="6.00" g="{O:\'2012006739\',OF:\'5/1\'}" id="2777214432260416291629" />
                                      <odd name="No" value="1.12" g="{O:\'2012006740\',OF:\'1/8\'}" id="2777214432260416301630" />
                                  </bookmaker>
                              </type>
                              <type value="Both Teams To Score - 2nd Half" stop="False" id="22605">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="4.00" g="{O:\'2012006781\',OF:\'3/1\'}" id="2777214432260516291629" />
                                      <odd name="No" value="1.22" g="{O:\'2012006784\',OF:\'2/9\'}" id="2777214432260516301630" />
                                  </bookmaker>
                              </type>
                              <type value="Win To Nil" stop="False" id="22607">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="7.00" g="{O:\'2012006520\',OF:\'6/1\'}" id="2777214432260715681568" />
                                      <odd name="Away" value="2.75" g="{O:\'2012006530\',OF:\'7/4\'}" id="2777214432260715711571" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even" stop="False" id="22608">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="1.95" g="{O:\'2012005477\',OF:\'19/20\'}" id="2777214432260816881688" />
                                      <odd name="Even" value="1.90" g="{O:\'2012005476\',OF:\'9/10\'}" id="2777214432260816891689" />
                                  </bookmaker>
                              </type>
                              <type value="Odd/Even 1st Half" stop="False" id="22609">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Odd" value="2.20" g="{O:\'2012005512\',OF:\'6/5\'}" id="2777214432260916881688" />
                                      <odd name="Even" value="1.66" g="{O:\'2012005511\',OF:\'4/6\'}" id="2777214432260916891689" />
                                  </bookmaker>
                              </type>
                              <type value="Exact Goals Number" stop="False" id="22614">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.40" g="{O:\'2012005897\',OF:\'12/5\'}" id="2777214432261415881588" />
                                      <odd name="3" value="4.50" g="{O:\'2012005898\',OF:\'7/2\'}" id="2777214432261415911591" />
                                      <odd name="4" value="7.50" g="{O:\'2012005899\',OF:\'13/2\'}" id="2777214432261415941594" />
                                      <odd name="1" value="4.00" g="{O:\'2012005896\',OF:\'3/1\'}" id="2777214432261416821682" />
                                      <odd name="0" value="7.50" g="{O:\'2012005895\',OF:\'13/2\'}" id="2777214432261416901690" />
                                      <odd name="5" value="15.00" g="{O:\'2012005900\',OF:\'14/1\'}" id="2777214432261416911691" />
                                      <odd name="6" value="34.00" g="{O:\'2012005901\',OF:\'33/1\'}" id="2777214432261416921692" />
                                      <odd name="more 7" value="41.00" g="{O:\'2012005902\',OF:\'40/1\'}" id="2777214432261416931693" />
                                  </bookmaker>
                              </type>
                              <type value="To Win Either Half" stop="False" id="22615">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="2.75" g="{O:\'2012006542\',OF:\'7/4\'}" id="2777214432261515681568" />
                                      <odd name="Away" value="1.50" g="{O:\'2012006606\',OF:\'1/2\'}" id="2777214432261515711571" />
                                  </bookmaker>
                              </type>
                              <type value="Home Team Exact Goals Number" stop="False" id="22616">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="6.00" g="{O:\'2012006727\',OF:\'5/1\'}" id="2777214432261615881588" />
                                      <odd name="1" value="2.50" g="{O:\'2012006726\',OF:\'6/4\'}" id="2777214432261616821682" />
                                      <odd name="0" value="2.10" g="{O:\'2012006725\',OF:\'11/10\'}" id="2777214432261616901690" />
                                      <odd name="more 3" value="15.00" g="{O:\'2012006728\',OF:\'14/1\'}" id="2777214432261617201720" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Exact Goals Number" stop="False" id="22617">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.50" g="{O:\'2012006731\',OF:\'5/2\'}" id="2777214432261715881588" />
                                      <odd name="1" value="2.62" g="{O:\'2012006730\',OF:\'13/8\'}" id="2777214432261716821682" />
                                      <odd name="0" value="4.00" g="{O:\'2012006729\',OF:\'3/1\'}" id="2777214432261716901690" />
                                      <odd name="more 3" value="4.50" g="{O:\'2012006732\',OF:\'7/2\'}" id="2777214432261717201720" />
                                  </bookmaker>
                              </type>
                              <type value="2nd Half Exact Goals Number" stop="False" id="22619">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="3.75" g="{O:\'2012006338\',OF:\'11/4\'}" id="2777214432261915881588" />
                                      <odd name="3" value="8.50" g="{O:\'2012006339\',OF:\'15/2\'}" id="2777214432261915911591" />
                                      <odd name="4" value="23.00" g="{O:\'2012006341\',OF:\'22/1\'}" id="2777214432261915941594" />
                                      <odd name="1" value="2.60" g="{O:\'2012006337\',OF:\'8/5\'}" id="2777214432261916821682" />
                                      <odd name="0" value="3.40" g="{O:\'2012006336\',OF:\'12/5\'}" id="2777214432261916901690" />
                                      <odd name="more 5" value="41.00" g="{O:\'2012006343\',OF:\'40/1\'}" id="2777214432261917271727" />
                                  </bookmaker>
                              </type>
                              <type value="Results/Both Teams To Score" stop="False" id="22620">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home/Yes" value="11.00" g="{O:\'2012006660\',OF:\'10/1\'}" id="2777214432262017211721" />
                                      <odd name="Draw/Yes" value="5.00" g="{O:\'2012006662\',OF:\'4/1\'}" id="2777214432262017221722" />
                                      <odd name="Away/Yes" value="4.75" g="{O:\'2012006664\',OF:\'15/4\'}" id="2777214432262017231723" />
                                      <odd name="Home/No" value="7.00" g="{O:\'2012006661\',OF:\'6/1\'}" id="2777214432262017241724" />
                                      <odd name="Draw/No" value="7.50" g="{O:\'2012006663\',OF:\'13/2\'}" id="2777214432262017251725" />
                                      <odd name="Away/No" value="2.75" g="{O:\'2012006665\',OF:\'7/4\'}" id="2777214432262017261726" />
                                  </bookmaker>
                              </type>
                              <type value="Result/Total Goals" stop="False" id="22621">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <total name="2.5" stop="False">
                                          <odd name="Home/Over" value="9.50" g="{O:\'2012006508\',OF:\'17/2\'}" id="2777214432262117141714" />
                                          <odd name="Draw/Over" value="19.00" g="{O:\'2012006510\',OF:\'18/1\'}" id="2777214432262117151715" />
                                          <odd name="Away/Over" value="3.40" g="{O:\'2012006512\',OF:\'12/5\'}" id="2777214432262117161716" />
                                          <odd name="Home/Under" value="7.50" g="{O:\'2012006509\',OF:\'13/2\'}" id="2777214432262117171717" />
                                          <odd name="Draw/Under" value="3.75" g="{O:\'2012006511\',OF:\'11/4\'}" id="2777214432262117181718" />
                                          <odd name="Away/Under" value="3.50" g="{O:\'2012006513\',OF:\'5/2\'}" id="2777214432262117191719" />
                                      </total>
                                  </bookmaker>
                              </type>
                              <type value="Home Team Score a Goal" stop="False" id="22622">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.66" g="{O:\'2012006490\',OF:\'4/6\'}" id="2777214432262216291629" />
                                      <odd name="No" value="2.10" g="{O:\'2012006489\',OF:\'11/10\'}" id="2777214432262216301630" />
                                  </bookmaker>
                              </type>
                              <type value="Away Team Score a Goal" stop="False" id="22623">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Yes" value="1.22" g="{O:\'2012006486\',OF:\'2/9\'}" id="2777214432262316291629" />
                                      <odd name="No" value="4.00" g="{O:\'2012006485\',OF:\'3/1\'}" id="2777214432262316301630" />
                                  </bookmaker>
                              </type>
                              <type value="First 10 min Winner" stop="False" id="22626">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="Home" value="17.00" g="{O:\'2012069968\',OF:\'16/1\'}" id="2777214432262615681568" />
                                      <odd name="Draw" value="1.12" g="{O:\'2012069969\',OF:\'1/8\'}" id="2777214432262615701570" />
                                      <odd name="Away" value="9.00" g="{O:\'2012069970\',OF:\'8/1\'}" id="2777214432262615711571" />
                                  </bookmaker>
                              </type>
                              <type value="1st Half Exact Goals Number" stop="False" id="22655">
                                  <bookmaker name="bet365" stop="False" ts="1557700196" id="16">
                                      <odd name="2" value="4.75" g="{O:\'2012006016\',OF:\'15/4\'}" id="2777214432265515881588" />
                                      <odd name="3" value="13.00" g="{O:\'2012006019\',OF:\'12/1\'}" id="2777214432265515911591" />
                                      <odd name="4" value="41.00" g="{O:\'2012006020\',OF:\'40/1\'}" id="2777214432265515941594" />
                                      <odd name="1" value="2.50" g="{O:\'2012006015\',OF:\'6/4\'}" id="2777214432265516821682" />
                                      <odd name="0" value="2.50" g="{O:\'2012006012\',OF:\'6/4\'}" id="2777214432265516901690" />
                                      <odd name="more 5" value="101.00" g="{O:\'2012006022\',OF:\'100/1\'}" id="2777214432265517271727" />
                                  </bookmaker>
                              </type>
                          </odds>
                      </match>
                  </matches>
              </category>
          </scores>'
      end
    end
  end
end
