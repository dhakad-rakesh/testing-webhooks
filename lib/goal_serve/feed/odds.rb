module GoalServe
  module Feed
    class Odds
      def call
        response
      end

      def allowed_bookmaker_ids
        %w[16].freeze
      end

      private

      def response
        '<scores sport="soccer" ts="1551199121388">
          <category name="England: Premier League" gid="1204" id="1204" file_group="england" iscup="False">
              <matches date="Feb 26" formatted_date="26.02.2019">
                  <match status="19:45" date="Feb 26" formatted_date="26.02.2019" time="19:45" venue="Cardiff City Stadium" static_id="2378622" fix_id="2231171" id="3146031">
                      <localteam name="Cardiff" goals="?" id="9083"/>
                      <visitorteam name="Everton" goals="?" id="9158"/>
                      <events/>
                      <ht score=""/>
                      <odds ts="1551197939949" rotation_home="2553" rotation_away="2552">
                          <type value="3Way Result" id="1">
                              <bookmaker name="10Bet" extra="eventID=34154111" id="14">
                                  <odd name="1" value="3.75" dp3="3.750" us="27" id="4603806110711523"/>
                                  <odd name="2" value="2.00" dp3="2.000" us="100" id="4603806110731524"/>
                                  <odd name="X" value="3.20" dp3="3.200" us="22" id="4603806110721525"/>
                              </bookmaker>
                              <bookmaker name="188Bet" extra="" id="56">
                                  <odd name="1" value="3.90" dp3="3.900" us="29" id="4603806116111523"/>
                                  <odd name="2" value="2.08" dp3="2.080" us="10" id="4603806116131524"/>
                                  <odd name="X" value="3.30" dp3="3.300" us="23" id="4603806116121525"/>
                              </bookmaker>
                              <bookmaker name="5 Dimes" extra="" id="20">
                                  <odd name="1" value="4.02" dp3="4.020" us="30" id="460380619511523"/>
                                  <odd name="2" value="2.08" dp3="2.080" us="10" id="460380619531524"/>
                                  <odd name="X" value="3.44" dp3="3.440" us="24" id="460380619521525"/>
                              </bookmaker>
                              <bookmaker name="BetCRIS" extra="" id="230">
                                  <odd name="1" value="3.68" dp3="3.680" us="26" id="460380617311523"/>
                                  <odd name="2" value="2.06" dp3="2.060" us="10" id="460380617331524"/>
                                  <odd name="X" value="3.41" dp3="3.410" us="24" id="460380617321525"/>
                              </bookmaker>
                              <bookmaker name="Betfair" extra="eventID=29124246" id="21">
                                  <odd name="1" value="4.10" dp3="4.100" us="31" id="460380612111523"/>
                                  <odd name="2" value="2.10" dp3="2.100" us="11" id="460380612131524"/>
                                  <odd name="X" value="3.50" dp3="3.500" us="25" id="460380612121525"/>
                              </bookmaker>
                              <bookmaker name="BetOnline" extra="" id="206">
                                  <odd name="1" value="4.00" dp3="4.000" us="30" id="4603806120611523"/>
                                  <odd name="2" value="2.00" dp3="2.000" us="100" id="4603806120631524"/>
                                  <odd name="X" value="3.15" dp3="3.150" us="21" id="4603806120621525"/>
                              </bookmaker>
                              <bookmaker name="Betsafe" extra="eventID=2579122" id="24">
                                  <odd name="1" value="3.80" dp3="3.800" us="28" id="4603806112511523"/>
                                  <odd name="2" value="2.13" dp3="2.130" us="11" id="4603806112531524"/>
                                  <odd name="X" value="3.45" dp3="3.450" us="24" id="4603806112521525"/>
                              </bookmaker>
                              <bookmaker name="Betsson" extra="eventID=2579122" id="43">
                                  <odd name="1" value="4.00" dp3="4.000" us="30" id="4603806112911523"/>
                                  <odd name="2" value="2.08" dp3="2.080" us="10" id="4603806112931524"/>
                                  <odd name="X" value="3.45" dp3="3.450" us="24" id="4603806112921525"/>
                              </bookmaker>
                              <bookmaker name="BWin" extra="eventID=8243087" id="2">
                                  <odd name="1" value="3.90" dp3="3.900" us="29" id="460380612511523"/>
                                  <odd name="2" value="2.05" dp3="2.050" us="10" id="460380612531524"/>
                                  <odd name="X" value="3.40" dp3="3.400" us="24" id="460380612521525"/>
                              </bookmaker>
                              <bookmaker name="Coral" extra="eventID=12236402" id="5">
                                  <odd name="1" value="4.00" dp3="4.000" us="30" id="46038061511523"/>
                                  <odd name="2" value="2.05" dp3="2.050" us="10" id="46038061531524"/>
                                  <odd name="X" value="3.30" dp3="3.300" us="23" id="46038061521525"/>
                              </bookmaker>
                              <bookmaker name="Dafabet" extra="eventID=904571" id="232">
                                  <odd name="1" value="4.05" dp3="4.050" us="30" id="4603806121611523"/>
                                  <odd name="2" value="2.04" dp3="2.040" us="10" id="4603806121631524"/>
                                  <odd name="X" value="3.20" dp3="3.200" us="22" id="4603806121621525"/>
                              </bookmaker>
                              <bookmaker name="Intertops" extra="" id="190">
                                  <odd name="1" value="3.75" dp3="3.750" us="27" id="460380617011523"/>
                                  <odd name="2" value="2.00" dp3="2.000" us="100" id="460380617031524"/>
                                  <odd name="X" value="3.20" dp3="3.200" us="22" id="460380617021525"/>
                              </bookmaker>
                              <bookmaker name="Marathonbet" extra="eventid=7516113" id="226">
                                  <odd name="1" value="4.05" dp3="4.050" us="30" id="4603806122611523"/>
                                  <odd name="2" value="2.05" dp3="2.050" us="10" id="4603806122631524"/>
                                  <odd name="X" value="3.48" dp3="3.480" us="24" id="4603806122621525"/>
                              </bookmaker>
                              <bookmaker name="Matchbook" extra="https://www.matchbook.com/events/soccer/premier-le" id="235">
                                  <odd name="1" value="4.15" dp3="4.150" us="31" id="4603806123511523"/>
                                  <odd name="2" value="2.11" dp3="2.110" us="11" id="4603806123531524"/>
                                  <odd name="X" value="3.48" dp3="3.480" us="24" id="4603806123521525"/>
                              </bookmaker>
                              <bookmaker name="MyBet" extra="" id="41">
                                  <odd name="1" value="3.90" dp3="3.900" us="29" id="4603806119211523"/>
                                  <odd name="2" value="2.05" dp3="2.050" us="10" id="4603806119231524"/>
                                  <odd name="X" value="3.40" dp3="3.400" us="24" id="4603806119221525"/>
                              </bookmaker>
                              <bookmaker name="Pinnacle" extra="rotNum=2552" id="18">
                                  <odd name="1" value="4.06" dp3="4.060" us="30" id="460380615311523"/>
                                  <odd name="2" value="2.04" dp3="2.040" us="10" id="460380615331524"/>
                                  <odd name="X" value="3.48" dp3="3.480" us="24" id="460380615321525"/>
                              </bookmaker>
                              <bookmaker name="Sportsbet" extra="eventId=4508622" id="229">
                                  <odd name="1" value="3.75" dp3="3.750" us="27" id="460380611911523"/>
                                  <odd name="2" value="2.00" dp3="2.000" us="100" id="460380611931524"/>
                                  <odd name="X" value="3.40" dp3="3.400" us="24" id="460380611921525"/>
                              </bookmaker>
                              <bookmaker name="Tipico" extra="" id="70">
                                  <odd name="1" value="3.70" dp3="3.700" us="27" id="4603806119011523"/>
                                  <odd name="2" value="2.10" dp3="2.100" us="11" id="4603806119031524"/>
                                  <odd name="X" value="3.30" dp3="3.300" us="23" id="4603806119021525"/>
                              </bookmaker>
                              <bookmaker name="Unibet" extra="eventID=1005044512" id="82">
                                  <odd name="1" value="3.95" dp3="3.950" us="29" id="460380618211523"/>
                                  <odd name="2" value="2.08" dp3="2.080" us="10" id="460380618231524"/>
                                  <odd name="X" value="3.45" dp3="3.450" us="24" id="460380618221525"/>
                              </bookmaker>
                          </type>
                          <type value="Home/Away" id="2">
                              <bookmaker name="Betfair" id="21">
                                  <odd name="1" value="2.92" dp3="2.920" us="19" id="460380622111523"/>
                                  <odd name="2" value="1.50" dp3="1.500" us="-200" id="460380622121524"/>
                              </bookmaker>
                              <bookmaker name="Betsafe" id="24">
                                  <odd name="1" value="2.65" dp3="2.650" us="16" id="4603806212511523"/>
                                  <odd name="2" value="1.48" dp3="1.480" us="-208" id="4603806212521524"/>
                              </bookmaker>
                              <bookmaker name="Betsson" id="43">
                                  <odd name="1" value="2.75" dp3="2.750" us="17" id="4603806212911523"/>
                                  <odd name="2" value="1.45" dp3="1.450" us="-222" id="4603806212921524"/>
                              </bookmaker>
                              <bookmaker name="BWin" id="2">
                                  <odd name="1" value="2.60" dp3="2.600" us="16" id="460380622511523"/>
                                  <odd name="2" value="1.44" dp3="1.440" us="-227" id="460380622521524"/>
                              </bookmaker>
                              <bookmaker name="Coral" id="5">
                                  <odd name="1" value="2.50" dp3="2.500" us="15" id="46038062511523"/>
                                  <odd name="2" value="1.50" dp3="1.500" us="-200" id="46038062521524"/>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <odd name="1" value="2.93" dp3="2.930" us="19" id="4603806222611523"/>
                                  <odd name="2" value="1.48" dp3="1.480" us="-208" id="4603806222621524"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="1" value="2.80" dp3="2.800" us="18" id="460380628211523"/>
                                  <odd name="2" value="1.46" dp3="1.460" us="-217" id="460380628221524"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="2.75" dp3="2.750" us="17" id="460380625011523"/>
                                  <odd name="2" value="1.40" dp3="1.400" us="-250" id="460380625021524"/>
                              </bookmaker>
                          </type>
                          <type value="Over/Under" id="3">
                              <bookmaker name="10Bet" id="14">
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.22" dp3="2.220" us="12" id="4603806310711568"/>
                                      <odd name="Over" value="1.61" dp3="1.606" us="-165" id="4603806310721569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.86" dp3="1.855" us="-117" id="4603806310711570"/>
                                      <odd name="Over" value="1.89" dp3="1.885" us="-113" id="4603806310721571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.66" dp3="1.662" us="-151" id="4603806310711572"/>
                                      <odd name="Over" value="2.12" dp3="2.120" us="11" id="4603806310721573"/>
                                  </total>
                                  <total name="2.75" main="0">
                                      <odd name="Under" value="1.48" dp3="1.476" us="-210" id="4603806310711574"/>
                                      <odd name="Over" value="2.54" dp3="2.540" us="15" id="4603806310721575"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="188Bet" id="56">
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.35" dp3="2.350" us="13" id="4603806316111568"/>
                                      <odd name="Over" value="1.64" dp3="1.640" us="-156" id="4603806316121569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.90" dp3="1.900" us="-111" id="4603806316111570"/>
                                      <odd name="Over" value="2.00" dp3="2.000" us="100" id="4603806316121571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.73" dp3="1.730" us="-137" id="4603806316111572"/>
                                      <odd name="Over" value="2.20" dp3="2.200" us="12" id="4603806316121573"/>
                                  </total>
                                  <total name="2.75" main="0">
                                      <odd name="Under" value="1.55" dp3="1.550" us="-182" id="4603806316111574"/>
                                      <odd name="Over" value="2.53" dp3="2.530" us="15" id="4603806316121575"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="5 Dimes" id="20">
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.09" dp3="3.090" us="20" id="460380639511564"/>
                                      <odd name="Over" value="1.40" dp3="1.402" us="-249" id="460380639521565"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.33" dp3="2.330" us="13" id="460380639511568"/>
                                      <odd name="Over" value="1.68" dp3="1.676" us="-148" id="460380639521569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.89" dp3="1.885" us="-113" id="460380639511570"/>
                                      <odd name="Over" value="1.94" dp3="1.935" us="-107" id="460380639521571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.71" dp3="1.709" us="-141" id="460380639511572"/>
                                      <odd name="Over" value="2.26" dp3="2.260" us="12" id="460380639521573"/>
                                  </total>
                                  <total name="2.75" main="0">
                                      <odd name="Under" value="1.55" dp3="1.549" us="-182" id="460380639511574"/>
                                      <odd name="Over" value="2.59" dp3="2.590" us="15" id="460380639521575"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="BetCRIS" id="230">
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.93" dp3="1.926" us="-108" id="460380637311570"/>
                                      <odd name="Over" value="1.89" dp3="1.893" us="-112" id="460380637321571"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Betfair" id="21">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="10.00" dp3="10.000" us="90" id="460380632111560"/>
                                      <odd name="Over" value="1.10" dp3="1.100" us="-100" id="460380632121561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.20" dp3="3.200" us="22" id="460380632111564"/>
                                      <odd name="Over" value="1.43" dp3="1.430" us="-233" id="460380632121565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.75" dp3="1.750" us="-133" id="460380632111572"/>
                                      <odd name="Over" value="2.32" dp3="2.320" us="13" id="460380632121573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.29" dp3="1.290" us="-345" id="460380632111580"/>
                                      <odd name="Over" value="4.40" dp3="4.400" us="34" id="460380632121581"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.11" dp3="1.110" us="-909" id="460380632111588"/>
                                      <odd name="Over" value="9.60" dp3="9.600" us="86" id="460380632121589"/>
                                  </total>
                                  <total name="5.5" main="0">
                                      <odd name="Under" value="1.04" dp3="1.040" us="-250" id="460380632111594"/>
                                      <odd name="Over" value="25.00" dp3="25.000" us="24" id="460380632121595"/>
                                  </total>
                                  <total name="6.5" main="0">
                                      <odd name="Under" value="1.01" dp3="1.010" us="-100" id="460380632111596"/>
                                      <odd name="Over" value="75.00" dp3="75.000" us="74" id="460380632121597"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="BetOnline" id="206">
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.89" dp3="1.885" us="-113" id="4603806320611570"/>
                                      <odd name="Over" value="1.94" dp3="1.935" us="-107" id="4603806320621571"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Betsafe" id="24">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="1.04" dp3="1.040" us="-250" id="4603806312511560"/>
                                      <odd name="Over" value="9.50" dp3="9.500" us="85" id="4603806312521561"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Betsson" id="43">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="1.04" dp3="1.040" us="-250" id="4603806312911560"/>
                                      <odd name="Over" value="9.50" dp3="9.500" us="85" id="4603806312921561"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="BWin" id="2">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="7.25" dp3="7.250" us="62" id="460380632511560"/>
                                      <odd name="Over" value="1.06" dp3="1.060" us="-166" id="460380632521561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.00" dp3="3.000" us="20" id="460380632511564"/>
                                      <odd name="Over" value="1.34" dp3="1.340" us="-294" id="460380632521565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.72" dp3="1.720" us="-139" id="460380632511572"/>
                                      <odd name="Over" value="2.05" dp3="2.050" us="10" id="460380632521573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.26" dp3="1.260" us="-385" id="460380632511580"/>
                                      <odd name="Over" value="3.50" dp3="3.500" us="25" id="460380632521581"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.08" dp3="1.080" us="-125" id="460380632511588"/>
                                      <odd name="Over" value="6.50" dp3="6.500" us="55" id="460380632521589"/>
                                  </total>
                                  <total name="5.5" main="0">
                                      <odd name="Under" value="1.01" dp3="1.010" us="-100" id="460380632511594"/>
                                      <odd name="Over" value="11.00" dp3="11.000" us="10" id="460380632521595"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Coral" id="5">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="8.00" dp3="8.000" us="70" id="46038063511560"/>
                                      <odd name="Over" value="1.08" dp3="1.080" us="-125" id="46038063521561"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.67" dp3="1.670" us="-149" id="46038063511572"/>
                                      <odd name="Over" value="2.20" dp3="2.200" us="12" id="46038063521573"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="2.88" dp3="2.880" us="18" id="46038063511564"/>
                                      <odd name="Over" value="1.40" dp3="1.400" us="-250" id="46038063521565"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.25" dp3="1.250" us="-400" id="46038063511580"/>
                                      <odd name="Over" value="4.00" dp3="4.000" us="30" id="46038063521581"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.08" dp3="1.080" us="-125" id="46038063511588"/>
                                      <odd name="Over" value="8.50" dp3="8.500" us="75" id="46038063521589"/>
                                  </total>
                                  <total name="5.5" main="0">
                                      <odd name="Under" value="1.02" dp3="1.020" us="-500" id="46038063511594"/>
                                      <odd name="Over" value="21.00" dp3="21.000" us="20" id="46038063521595"/>
                                  </total>
                                  <total name="6.5" main="0">
                                      <odd name="Under" value="1.01" dp3="1.010" us="-100" id="46038063511596"/>
                                      <odd name="Over" value="51.00" dp3="51.000" us="50" id="46038063521597"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Dafabet" id="232">
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.94" dp3="1.940" us="-106" id="4603806321611570"/>
                                      <odd name="Over" value="1.98" dp3="1.980" us="-102" id="4603806321621571"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.35" dp3="2.350" us="13" id="4603806321611568"/>
                                      <odd name="Over" value="1.66" dp3="1.660" us="-152" id="4603806321621569"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.73" dp3="1.730" us="-137" id="4603806321611572"/>
                                      <odd name="Over" value="2.23" dp3="2.230" us="12" id="4603806321621573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Intertops" id="190">
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.75" dp3="1.750" us="-133" id="460380637011572"/>
                                      <odd name="Over" value="2.05" dp3="2.050" us="10" id="460380637021573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="9.10" dp3="9.100" us="81" id="4603806322611560"/>
                                      <odd name="Over" value="1.03" dp3="1.030" us="-333" id="4603806322621561"/>
                                  </total>
                                  <total name="0.75" main="0">
                                      <odd name="Under" value="8.10" dp3="8.100" us="71" id="4603806322611623"/>
                                      <odd name="Over" value="1.05" dp3="1.051" us="-196" id="4603806322621624"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="7.10" dp3="7.100" us="61" id="4603806322611562"/>
                                      <odd name="Over" value="1.08" dp3="1.077" us="-129" id="4603806322621563"/>
                                  </total>
                                  <total name="1.25" main="0">
                                      <odd name="Under" value="4.10" dp3="4.100" us="31" id="4603806322611600"/>
                                      <odd name="Over" value="1.22" dp3="1.220" us="-455" id="4603806322621601"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.08" dp3="3.080" us="20" id="4603806322611564"/>
                                      <odd name="Over" value="1.36" dp3="1.363" us="-275" id="4603806322621565"/>
                                  </total>
                                  <total name="1.75" main="0">
                                      <odd name="Under" value="2.70" dp3="2.700" us="17" id="4603806322611566"/>
                                      <odd name="Over" value="1.47" dp3="1.470" us="-213" id="4603806322621567"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.31" dp3="2.310" us="13" id="4603806322611568"/>
                                      <odd name="Over" value="1.63" dp3="1.630" us="-159" id="4603806322621569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.89" dp3="1.890" us="-112" id="4603806322611570"/>
                                      <odd name="Over" value="1.95" dp3="1.952" us="-105" id="4603806322621571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.71" dp3="1.710" us="-141" id="4603806322611572"/>
                                      <odd name="Over" value="2.28" dp3="2.280" us="12" id="4603806322621573"/>
                                  </total>
                                  <total name="2.75" main="0">
                                      <odd name="Under" value="1.52" dp3="1.520" us="-192" id="4603806322611574"/>
                                      <odd name="Over" value="2.61" dp3="2.610" us="16" id="4603806322621575"/>
                                  </total>
                                  <total name="3.0" main="0">
                                      <odd name="Under" value="1.33" dp3="1.330" us="-303" id="4603806322611576"/>
                                      <odd name="Over" value="3.38" dp3="3.380" us="23" id="4603806322621577"/>
                                  </total>
                                  <total name="3.25" main="0">
                                      <odd name="Under" value="1.27" dp3="1.270" us="-370" id="4603806322611578"/>
                                      <odd name="Over" value="3.76" dp3="3.760" us="27" id="4603806322621579"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.22" dp3="1.222" us="-450" id="4603806322611580"/>
                                      <odd name="Over" value="4.15" dp3="4.150" us="31" id="4603806322621581"/>
                                  </total>
                                  <total name="3.75" main="0">
                                      <odd name="Under" value="1.15" dp3="1.148" us="-676" id="4603806322611582"/>
                                      <odd name="Over" value="5.20" dp3="5.200" us="42" id="4603806322621583"/>
                                  </total>
                                  <total name="4.0" main="0">
                                      <odd name="Under" value="1.07" dp3="1.074" us="-135" id="4603806322611584"/>
                                      <odd name="Over" value="7.20" dp3="7.200" us="62" id="4603806322621585"/>
                                  </total>
                                  <total name="4.25" main="0">
                                      <odd name="Under" value="1.06" dp3="1.060" us="-166" id="4603806322611586"/>
                                      <odd name="Over" value="7.60" dp3="7.600" us="66" id="4603806322621587"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.05" dp3="1.046" us="-217" id="4603806322611588"/>
                                      <odd name="Over" value="8.00" dp3="8.000" us="70" id="4603806322621589"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Matchbook" id="235">
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.77" dp3="1.769" us="-130" id="4603806323511572"/>
                                      <odd name="Over" value="2.29" dp3="2.290" us="12" id="4603806323521573"/>
                                  </total>
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="9.00" dp3="9.000" us="80" id="4603806323511560"/>
                                      <odd name="Over" value="1.09" dp3="1.091" us="-109" id="4603806323521561"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.36" dp3="2.360" us="13" id="4603806323511568"/>
                                      <odd name="Over" value="1.71" dp3="1.709" us="-141" id="4603806323521569"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.10" dp3="1.102" us="-980" id="4603806323511588"/>
                                      <odd name="Over" value="8.80" dp3="8.800" us="78" id="4603806323521589"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.18" dp3="3.180" us="21" id="4603806323511564"/>
                                      <odd name="Over" value="1.42" dp3="1.420" us="-238" id="4603806323521565"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.29" dp3="1.286" us="-350" id="4603806323511580"/>
                                      <odd name="Over" value="4.20" dp3="4.200" us="32" id="4603806323521581"/>
                                  </total>
                                  <total name="5.5" main="0">
                                      <odd name="Under" value="1.02" dp3="1.020" us="-500" id="4603806323511594"/>
                                      <odd name="Over" value="21.00" dp3="21.000" us="20" id="4603806323521595"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="MyBet" id="41">
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="2.95" dp3="2.950" us="19" id="4603806319211564"/>
                                      <odd name="Over" value="1.35" dp3="1.350" us="-286" id="4603806319221565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.75" dp3="1.750" us="-133" id="4603806319211572"/>
                                      <odd name="Over" value="2.10" dp3="2.100" us="11" id="4603806319221573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.25" dp3="1.250" us="-400" id="4603806319211580"/>
                                      <odd name="Over" value="3.55" dp3="3.550" us="25" id="4603806319221581"/>
                                  </total>
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="7.00" dp3="7.000" us="60" id="4603806319211560"/>
                                      <odd name="Over" value="1.05" dp3="1.050" us="-200" id="4603806319221561"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.10" dp3="1.100" us="-100" id="4603806319211588"/>
                                      <odd name="Over" value="5.75" dp3="5.750" us="47" id="4603806319221589"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Pinnacle" id="18">
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.32" dp3="2.320" us="13" id="460380635311568"/>
                                      <odd name="Over" value="1.68" dp3="1.675" us="-148" id="460380635321569"/>
                                  </total>
                                  <total name="1.75" main="0">
                                      <odd name="Under" value="2.74" dp3="2.740" us="17" id="460380635311566"/>
                                      <odd name="Over" value="1.50" dp3="1.495" us="-202" id="460380635321567"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.93" dp3="1.934" us="-107" id="460380635311570"/>
                                      <odd name="Over" value="1.98" dp3="1.980" us="-102" id="460380635321571"/>
                                  </total>
                                  <total name="2.75" main="0">
                                      <odd name="Under" value="1.52" dp3="1.518" us="-193" id="460380635311574"/>
                                      <odd name="Over" value="2.67" dp3="2.670" us="16" id="460380635321575"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.70" dp3="1.704" us="-142" id="460380635311572"/>
                                      <odd name="Over" value="2.27" dp3="2.270" us="12" id="460380635321573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="8.50" dp3="8.500" us="75" id="460380638211562"/>
                                      <odd name="Over" value="1.10" dp3="1.100" us="-100" id="460380638221563"/>
                                  </total>
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="10.00" dp3="10.000" us="90" id="460380638211560"/>
                                      <odd name="Over" value="1.07" dp3="1.070" us="-142" id="460380638221561"/>
                                  </total>
                                  <total name="2.75" main="0">
                                      <odd name="Under" value="1.56" dp3="1.560" us="-179" id="460380638211574"/>
                                      <odd name="Over" value="2.48" dp3="2.480" us="14" id="460380638221575"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.26" dp3="1.260" us="-385" id="460380638211580"/>
                                      <odd name="Over" value="3.95" dp3="3.950" us="29" id="460380638221581"/>
                                  </total>
                                  <total name="5.0" main="0">
                                      <odd name="Under" value="1.03" dp3="1.030" us="-333" id="460380638211592"/>
                                      <odd name="Over" value="20.00" dp3="20.000" us="19" id="460380638221593"/>
                                  </total>
                                  <total name="5.5" main="0">
                                      <odd name="Under" value="1.02" dp3="1.020" us="-500" id="460380638211594"/>
                                      <odd name="Over" value="21.00" dp3="21.000" us="20" id="460380638221595"/>
                                  </total>
                                  <total name="0.75" main="0">
                                      <odd name="Under" value="9.00" dp3="9.000" us="80" id="460380638211623"/>
                                      <odd name="Over" value="1.08" dp3="1.080" us="-125" id="460380638221624"/>
                                  </total>
                                  <total name="1.25" main="0">
                                      <odd name="Under" value="4.50" dp3="4.500" us="35" id="460380638211600"/>
                                      <odd name="Over" value="1.22" dp3="1.220" us="-455" id="460380638221601"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.30" dp3="3.300" us="23" id="460380638211564"/>
                                      <odd name="Over" value="1.35" dp3="1.350" us="-286" id="460380638221565"/>
                                  </total>
                                  <total name="1.75" main="0">
                                      <odd name="Under" value="2.90" dp3="2.900" us="19" id="460380638211566"/>
                                      <odd name="Over" value="1.43" dp3="1.430" us="-233" id="460380638221567"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.48" dp3="2.480" us="14" id="460380638211568"/>
                                      <odd name="Over" value="1.57" dp3="1.570" us="-175" id="460380638221569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="2.00" dp3="2.000" us="100" id="460380638211570"/>
                                      <odd name="Over" value="1.85" dp3="1.850" us="-118" id="460380638221571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.75" dp3="1.750" us="-133" id="460380638211572"/>
                                      <odd name="Over" value="2.12" dp3="2.120" us="11" id="460380638221573"/>
                                  </total>
                                  <total name="3.0" main="0">
                                      <odd name="Under" value="1.38" dp3="1.380" us="-263" id="460380638211576"/>
                                      <odd name="Over" value="3.15" dp3="3.150" us="21" id="460380638221577"/>
                                  </total>
                                  <total name="3.25" main="0">
                                      <odd name="Under" value="1.30" dp3="1.300" us="-333" id="460380638211578"/>
                                      <odd name="Over" value="3.55" dp3="3.550" us="25" id="460380638221579"/>
                                  </total>
                                  <total name="3.75" main="0">
                                      <odd name="Under" value="1.19" dp3="1.190" us="-526" id="460380638211582"/>
                                      <odd name="Over" value="5.10" dp3="5.100" us="41" id="460380638221583"/>
                                  </total>
                                  <total name="4.0" main="0">
                                      <odd name="Under" value="1.11" dp3="1.110" us="-909" id="460380638211584"/>
                                      <odd name="Over" value="7.50" dp3="7.500" us="65" id="460380638221585"/>
                                  </total>
                                  <total name="4.25" main="0">
                                      <odd name="Under" value="1.10" dp3="1.100" us="-100" id="460380638211586"/>
                                      <odd name="Over" value="8.00" dp3="8.000" us="70" id="460380638221587"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.09" dp3="1.090" us="-111" id="460380638211588"/>
                                      <odd name="Over" value="8.50" dp3="8.500" us="75" id="460380638221589"/>
                                  </total>
                                  <total name="4.75" main="0">
                                      <odd name="Under" value="1.06" dp3="1.060" us="-166" id="460380638211590"/>
                                      <odd name="Over" value="11.50" dp3="11.500" us="10" id="460380638221591"/>
                                  </total>
                                  <total name="5.25" main="0">
                                      <odd name="Under" value="1.02" dp3="1.020" us="-500" id="460380638211618"/>
                                      <odd name="Over" value="20.00" dp3="20.000" us="19" id="460380638221619"/>
                                  </total>
                              </bookmaker>
                          </type>
                          <type value="Handicap" id="4">
                              <bookmaker name="10Bet" id="14">
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="2.70" dp3="2.700" us="17" id="4603806410711540"/>
                                      <odd name="2" handicap="0" value="1.43" dp3="1.430" us="-233" id="4603806410721541"/>
                                  </handicap>
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="2.06" dp3="2.060" us="10" id="4603806410711542"/>
                                      <odd name="2" handicap="-0.25" value="1.71" dp3="1.710" us="-141" id="4603806410721543"/>
                                  </handicap>
                                  <handicap name="+0.75" main="0">
                                      <odd name="1" handicap="+0.75" value="1.58" dp3="1.580" us="-172" id="4603806410711546"/>
                                      <odd name="2" handicap="-0.75" value="2.28" dp3="2.280" us="12" id="4603806410721547"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.78" dp3="1.780" us="-128" id="4603806410711544"/>
                                      <odd name="2" handicap="-0.5" value="1.95" dp3="1.950" us="-105" id="4603806410721545"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="188Bet" id="56">
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="2.17" dp3="2.170" us="11" id="4603806416111542"/>
                                      <odd name="2" handicap="-0.25" value="1.78" dp3="1.780" us="-128" id="4603806416121543"/>
                                  </handicap>
                                  <handicap name="+0.75" main="0">
                                      <odd name="1" handicap="+0.75" value="1.61" dp3="1.610" us="-164" id="4603806416111546"/>
                                      <odd name="2" handicap="-0.75" value="2.47" dp3="2.470" us="14" id="4603806416121547"/>
                                  </handicap>
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="2.78" dp3="2.780" us="17" id="4603806416111540"/>
                                      <odd name="2" handicap="0" value="1.49" dp3="1.490" us="-204" id="4603806416121541"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.85" dp3="1.850" us="-118" id="4603806416111544"/>
                                      <odd name="2" handicap="-0.5" value="2.08" dp3="2.080" us="10" id="4603806416121545"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="5 Dimes" id="20">
                                  <handicap name="-0.5" main="0">
                                      <odd name="1" handicap="-0.5" value="3.86" dp3="3.860" us="28" id="460380649511536"/>
                                      <odd name="2" handicap="+0.5" value="1.29" dp3="1.290" us="-345" id="460380649521537"/>
                                  </handicap>
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="2.80" dp3="2.800" us="18" id="460380649511540"/>
                                      <odd name="2" handicap="0" value="1.48" dp3="1.480" us="-208" id="460380649521541"/>
                                  </handicap>
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="2.16" dp3="2.160" us="11" id="460380649511542"/>
                                      <odd name="2" handicap="-0.25" value="1.76" dp3="1.760" us="-132" id="460380649521543"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.84" dp3="1.840" us="-119" id="460380649511544"/>
                                      <odd name="2" handicap="-0.5" value="2.04" dp3="2.040" us="10" id="460380649521545"/>
                                  </handicap>
                                  <handicap name="-0.25" main="0">
                                      <odd name="1" handicap="-0.25" value="3.25" dp3="3.250" us="22" id="460380649511538"/>
                                      <odd name="2" handicap="+0.25" value="1.39" dp3="1.390" us="-256" id="460380649521539"/>
                                  </handicap>
                                  <handicap name="+0.75" main="0">
                                      <odd name="1" handicap="+0.75" value="1.63" dp3="1.630" us="-159" id="460380649511546"/>
                                      <odd name="2" handicap="-0.75" value="2.43" dp3="2.430" us="14" id="460380649521547"/>
                                  </handicap>
                                  <handicap name="+1.0" main="0">
                                      <odd name="1" handicap="+1.0" value="1.37" dp3="1.370" us="-270" id="460380649511548"/>
                                      <odd name="2" handicap="-1.0" value="3.41" dp3="3.410" us="24" id="460380649521549"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="BetCRIS" id="230">
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="2.02" dp3="2.020" us="10" id="460380647311542"/>
                                      <odd name="2" handicap="-0.25" value="1.80" dp3="1.800" us="-125" id="460380647321543"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.79" dp3="1.790" us="-127" id="460380647311544"/>
                                      <odd name="2" handicap="-0.5" value="2.04" dp3="2.040" us="10" id="460380647321545"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Betfair" id="21">
                                  <handicap name="-1.75" main="0">
                                      <odd name="1" handicap="-1.75" value="15.88" dp3="15.880" us="14" id="460380642111526"/>
                                      <odd name="2" handicap="+1.75" value="1.04" dp3="1.040" us="-250" id="460380642121527"/>
                                  </handicap>
                                  <handicap name="-2.5" main="0">
                                      <odd name="1" handicap="-2.5" value="34.33" dp3="34.330" us="33" id="460380642111602"/>
                                      <odd name="2" handicap="+2.5" value="1.01" dp3="1.010" us="-100" id="460380642121603"/>
                                  </handicap>
                                  <handicap name="-2.25" main="0">
                                      <odd name="1" handicap="-2.25" value="33.19" dp3="33.190" us="32" id="460380642111604"/>
                                      <odd name="2" handicap="+2.25" value="1.01" dp3="1.010" us="-100" id="460380642121605"/>
                                  </handicap>
                                  <handicap name="-2.75" main="0">
                                      <odd name="1" handicap="-2.75" value="34.00" dp3="34.000" us="33" id="460380642111610"/>
                                      <odd name="2" handicap="+2.75" value="1.01" dp3="1.010" us="-100" id="460380642121611"/>
                                  </handicap>
                                  <handicap name="-0.5" main="0">
                                      <odd name="1" handicap="-0.5" value="4.10" dp3="4.100" us="31" id="460380642111536"/>
                                      <odd name="2" handicap="+0.5" value="1.31" dp3="1.310" us="-323" id="460380642121537"/>
                                  </handicap>
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="2.93" dp3="2.930" us="19" id="460380642111540"/>
                                      <odd name="2" handicap="0" value="1.50" dp3="1.500" us="-200" id="460380642121541"/>
                                  </handicap>
                                  <handicap name="-2.0" main="0">
                                      <odd name="1" handicap="-2.0" value="32.06" dp3="32.060" us="31" id="460380642111606"/>
                                      <odd name="2" handicap="+2.0" value="1.01" dp3="1.010" us="-100" id="460380642121607"/>
                                  </handicap>
                                  <handicap name="-1.5" main="0">
                                      <odd name="1" handicap="-1.5" value="10.50" dp3="10.500" us="95" id="460380642111528"/>
                                      <odd name="2" handicap="+1.5" value="1.07" dp3="1.070" us="-142" id="460380642121529"/>
                                  </handicap>
                                  <handicap name="-0.75" main="0">
                                      <odd name="1" handicap="-0.75" value="5.45" dp3="5.450" us="44" id="460380642111534"/>
                                      <odd name="2" handicap="+0.75" value="1.20" dp3="1.200" us="-500" id="460380642121535"/>
                                  </handicap>
                                  <handicap name="-0.25" main="0">
                                      <odd name="1" handicap="-0.25" value="3.52" dp3="3.520" us="25" id="460380642111538"/>
                                      <odd name="2" handicap="+0.25" value="1.38" dp3="1.380" us="-263" id="460380642121539"/>
                                  </handicap>
                                  <handicap name="+0.75" main="0">
                                      <odd name="1" handicap="+0.75" value="1.65" dp3="1.650" us="-154" id="460380642111546"/>
                                      <odd name="2" handicap="-0.75" value="2.46" dp3="2.460" us="14" id="460380642121547"/>
                                  </handicap>
                                  <handicap name="-1.25" main="0">
                                      <odd name="1" handicap="-1.25" value="9.71" dp3="9.710" us="87" id="460380642111530"/>
                                      <odd name="2" handicap="+1.25" value="1.08" dp3="1.080" us="-125" id="460380642121531"/>
                                  </handicap>
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="2.22" dp3="2.220" us="12" id="460380642111542"/>
                                      <odd name="2" handicap="-0.25" value="1.80" dp3="1.800" us="-125" id="460380642121543"/>
                                  </handicap>
                                  <handicap name="-1.0" main="0">
                                      <odd name="1" handicap="-1.0" value="8.93" dp3="8.930" us="79" id="460380642111532"/>
                                      <odd name="2" handicap="+1.0" value="1.09" dp3="1.090" us="-111" id="460380642121533"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.89" dp3="1.890" us="-112" id="460380642111544"/>
                                      <odd name="2" handicap="-0.5" value="2.10" dp3="2.100" us="11" id="460380642121545"/>
                                  </handicap>
                                  <handicap name="+1.0" main="0">
                                      <odd name="1" handicap="+1.0" value="1.41" dp3="1.410" us="-244" id="460380642111548"/>
                                      <odd name="2" handicap="-1.0" value="3.16" dp3="3.160" us="21" id="460380642121549"/>
                                  </handicap>
                                  <handicap name="+2.25" main="0">
                                      <odd name="1" handicap="+2.25" value="1.08" dp3="1.080" us="-125" id="460380642111612"/>
                                      <odd name="2" handicap="-2.25" value="9.75" dp3="9.750" us="87" id="460380642121613"/>
                                  </handicap>
                                  <handicap name="+2.5" main="0">
                                      <odd name="1" handicap="+2.5" value="1.08" dp3="1.080" us="-125" id="460380642111614"/>
                                      <odd name="2" handicap="-2.5" value="10.50" dp3="10.500" us="95" id="460380642121615"/>
                                  </handicap>
                                  <handicap name="+1.25" main="0">
                                      <odd name="1" handicap="+1.25" value="1.33" dp3="1.330" us="-303" id="460380642111550"/>
                                      <odd name="2" handicap="-1.25" value="3.65" dp3="3.650" us="26" id="460380642121551"/>
                                  </handicap>
                                  <handicap name="+2.75" main="0">
                                      <odd name="1" handicap="+2.75" value="1.05" dp3="1.050" us="-200" id="460380642111616"/>
                                      <odd name="2" handicap="-2.75" value="15.30" dp3="15.300" us="14" id="460380642121617"/>
                                  </handicap>
                                  <handicap name="+1.5" main="0">
                                      <odd name="1" handicap="+1.5" value="1.28" dp3="1.280" us="-357" id="460380642111552"/>
                                      <odd name="2" handicap="-1.5" value="4.14" dp3="4.140" us="31" id="460380642121553"/>
                                  </handicap>
                                  <handicap name="+3.0" main="0">
                                      <odd name="1" handicap="+3.0" value="1.02" dp3="1.020" us="-500" id="460380642111558"/>
                                      <odd name="2" handicap="-3.0" value="21.00" dp3="21.000" us="20" id="460380642121559"/>
                                  </handicap>
                                  <handicap name="+1.75" main="0">
                                      <odd name="1" handicap="+1.75" value="1.19" dp3="1.190" us="-526" id="460380642111554"/>
                                      <odd name="2" handicap="-1.75" value="5.50" dp3="5.500" us="45" id="460380642121555"/>
                                  </handicap>
                                  <handicap name="+3.25" main="0">
                                      <odd name="1" handicap="+3.25" value="1.02" dp3="1.020" us="-500" id="460380642111625"/>
                                      <odd name="2" handicap="-3.25" value="21.55" dp3="21.550" us="20" id="460380642121626"/>
                                  </handicap>
                                  <handicap name="+2.0" main="0">
                                      <odd name="1" handicap="+2.0" value="1.09" dp3="1.090" us="-111" id="460380642111556"/>
                                      <odd name="2" handicap="-2.0" value="8.96" dp3="8.960" us="79" id="460380642121557"/>
                                  </handicap>
                                  <handicap name="+3.5" main="0">
                                      <odd name="1" handicap="+3.5" value="1.02" dp3="1.020" us="-500" id="460380642111627"/>
                                      <odd name="2" handicap="-3.5" value="22.10" dp3="22.100" us="21" id="460380642121628"/>
                                  </handicap>
                                  <handicap name="+3.75" main="0">
                                      <odd name="1" handicap="+3.75" value="1.01" dp3="1.010" us="-100" id="460380642112291"/>
                                      <odd name="2" handicap="-3.75" value="22.10" dp3="22.100" us="21" id="460380642122292"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="BetOnline" id="206">
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.83" dp3="1.830" us="-120" id="4603806420611544"/>
                                      <odd name="2" handicap="-0.5" value="2.00" dp3="2.000" us="100" id="4603806420621545"/>
                                  </handicap>
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="2.13" dp3="2.130" us="11" id="4603806420611542"/>
                                      <odd name="2" handicap="-0.25" value="1.75" dp3="1.750" us="-133" id="4603806420621543"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Dafabet" id="232">
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="2.69" dp3="2.690" us="16" id="4603806421611540"/>
                                      <odd name="2" handicap="0" value="1.53" dp3="1.530" us="-189" id="4603806421621541"/>
                                  </handicap>
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="2.19" dp3="2.190" us="11" id="4603806421611542"/>
                                      <odd name="2" handicap="-0.25" value="1.79" dp3="1.790" us="-127" id="4603806421621543"/>
                                  </handicap>
                                  <handicap name="+0.75" main="0">
                                      <odd name="1" handicap="+0.75" value="1.65" dp3="1.650" us="-154" id="4603806421611546"/>
                                      <odd name="2" handicap="-0.75" value="2.42" dp3="2.420" us="14" id="4603806421621547"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.89" dp3="1.890" us="-112" id="4603806421611544"/>
                                      <odd name="2" handicap="-0.5" value="2.06" dp3="2.060" us="10" id="4603806421621545"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Intertops" id="190">
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="2.05" dp3="2.050" us="10" id="460380647011542"/>
                                      <odd name="2" handicap="-0.25" value="1.75" dp3="1.750" us="-133" id="460380647021543"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <handicap name="-2.0" main="0">
                                      <odd name="1" handicap="-2.0" value="12.00" dp3="12.000" us="11" id="4603806422611606"/>
                                      <odd name="2" handicap="+2.0" value="1.01" dp3="1.010" us="-100" id="4603806422621607"/>
                                  </handicap>
                                  <handicap name="-1.5" main="0">
                                      <odd name="1" handicap="-1.5" value="9.10" dp3="9.100" us="81" id="4603806422611528"/>
                                      <odd name="2" handicap="+1.5" value="1.05" dp3="1.050" us="-200" id="4603806422621529"/>
                                  </handicap>
                                  <handicap name="-1.25" main="0">
                                      <odd name="1" handicap="-1.25" value="8.60" dp3="8.600" us="76" id="4603806422611530"/>
                                      <odd name="2" handicap="+1.25" value="1.07" dp3="1.070" us="-142" id="4603806422621531"/>
                                  </handicap>
                                  <handicap name="-1.0" main="0">
                                      <odd name="1" handicap="-1.0" value="8.00" dp3="8.000" us="70" id="4603806422611532"/>
                                      <odd name="2" handicap="+1.0" value="1.09" dp3="1.090" us="-111" id="4603806422621533"/>
                                  </handicap>
                                  <handicap name="-0.75" main="0">
                                      <odd name="1" handicap="-0.75" value="4.95" dp3="4.950" us="39" id="4603806422611534"/>
                                      <odd name="2" handicap="+0.75" value="1.19" dp3="1.190" us="-526" id="4603806422621535"/>
                                  </handicap>
                                  <handicap name="-0.25" main="0">
                                      <odd name="1" handicap="-0.25" value="3.45" dp3="3.450" us="24" id="4603806422611538"/>
                                      <odd name="2" handicap="+0.25" value="1.34" dp3="1.340" us="-294" id="4603806422621539"/>
                                      <odd name="1" handicap="+0.25" value="2.09" dp3="2.090" us="10" id="4603806422611542"/>
                                      <odd name="2" handicap="-0.25" value="1.79" dp3="1.790" us="-127" id="4603806422621543"/>
                                  </handicap>
                                  <handicap name="+0.75" main="0">
                                      <odd name="1" handicap="+0.75" value="1.62" dp3="1.620" us="-161" id="4603806422611546"/>
                                      <odd name="2" handicap="-0.75" value="2.38" dp3="2.380" us="13" id="4603806422621547"/>
                                  </handicap>
                                  <handicap name="+1.0" main="0">
                                      <odd name="1" handicap="+1.0" value="1.38" dp3="1.380" us="-263" id="4603806422611548"/>
                                      <odd name="2" handicap="-1.0" value="3.10" dp3="3.100" us="21" id="4603806422621549"/>
                                  </handicap>
                                  <handicap name="+1.25" main="0">
                                      <odd name="1" handicap="+1.25" value="1.30" dp3="1.300" us="-333" id="4603806422611550"/>
                                      <odd name="2" handicap="-1.25" value="3.54" dp3="3.540" us="25" id="4603806422621551"/>
                                  </handicap>
                                  <handicap name="+1.5" main="0">
                                      <odd name="1" handicap="+1.5" value="1.24" dp3="1.240" us="-417" id="4603806422611552"/>
                                      <odd name="2" handicap="-1.5" value="3.98" dp3="3.980" us="29" id="4603806422621553"/>
                                  </handicap>
                                  <handicap name="+1.75" main="0">
                                      <odd name="1" handicap="+1.75" value="1.16" dp3="1.160" us="-625" id="4603806422611554"/>
                                      <odd name="2" handicap="-1.75" value="5.05" dp3="5.050" us="40" id="4603806422621555"/>
                                  </handicap>
                                  <handicap name="+2.0" main="0">
                                      <odd name="1" handicap="+2.0" value="1.07" dp3="1.070" us="-142" id="4603806422611556"/>
                                      <odd name="2" handicap="-2.0" value="7.30" dp3="7.300" us="63" id="4603806422621557"/>
                                  </handicap>
                                  <handicap name="+2.25" main="0">
                                      <odd name="1" handicap="+2.25" value="1.06" dp3="1.060" us="-166" id="4603806422611612"/>
                                      <odd name="2" handicap="-2.25" value="7.80" dp3="7.800" us="68" id="4603806422621613"/>
                                  </handicap>
                                  <handicap name="+2.5" main="0">
                                      <odd name="1" handicap="+2.5" value="1.04" dp3="1.040" us="-250" id="4603806422611614"/>
                                      <odd name="2" handicap="-2.5" value="8.20" dp3="8.200" us="72" id="4603806422621615"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Matchbook" id="235">
                                  <handicap name="-0.5" main="0">
                                      <odd name="1" handicap="-0.5" value="3.74" dp3="3.740" us="27" id="4603806423511536"/>
                                      <odd name="2" handicap="+0.5" value="1.31" dp3="1.310" us="-323" id="4603806423521537"/>
                                  </handicap>
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="2.84" dp3="2.840" us="18" id="4603806423511540"/>
                                      <odd name="2" handicap="0" value="1.47" dp3="1.470" us="-213" id="4603806423521541"/>
                                  </handicap>
                                  <handicap name="-0.25" main="0">
                                      <odd name="1" handicap="-0.25" value="3.26" dp3="3.260" us="22" id="4603806423511538"/>
                                      <odd name="2" handicap="+0.25" value="1.32" dp3="1.320" us="-312" id="4603806423521539"/>
                                      <odd name="1" handicap="+0.25" value="2.21" dp3="2.210" us="12" id="4603806423511542"/>
                                      <odd name="2" handicap="-0.25" value="1.79" dp3="1.790" us="-127" id="4603806423521543"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.89" dp3="1.890" us="-112" id="4603806423511544"/>
                                      <odd name="2" handicap="-0.5" value="2.10" dp3="2.100" us="11" id="4603806423521545"/>
                                  </handicap>
                                  <handicap name="+0.75" main="0">
                                      <odd name="1" handicap="+0.75" value="1.66" dp3="1.660" us="-152" id="4603806423511546"/>
                                      <odd name="2" handicap="-0.75" value="2.44" dp3="2.440" us="14" id="4603806423521547"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Pinnacle" id="18">
                                  <handicap name="-0.25" main="0">
                                      <odd name="1" handicap="-0.25" value="3.27" dp3="3.270" us="22" id="460380645311538"/>
                                      <odd name="2" handicap="+0.25" value="1.37" dp3="1.370" us="-270" id="460380645321539"/>
                                  </handicap>
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="2.92" dp3="2.920" us="19" id="460380645311540"/>
                                      <odd name="2" handicap="0" value="1.45" dp3="1.450" us="-222" id="460380645321541"/>
                                  </handicap>
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="2.22" dp3="2.220" us="12" id="460380645311542"/>
                                      <odd name="2" handicap="-0.25" value="1.75" dp3="1.750" us="-133" id="460380645321543"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.89" dp3="1.890" us="-112" id="460380645311544"/>
                                      <odd name="2" handicap="-0.5" value="2.04" dp3="2.040" us="10" id="460380645321545"/>
                                  </handicap>
                                  <handicap name="+0.75" main="0">
                                      <odd name="1" handicap="+0.75" value="1.65" dp3="1.650" us="-154" id="460380645311546"/>
                                      <odd name="2" handicap="-0.75" value="2.39" dp3="2.390" us="13" id="460380645321547"/>
                                  </handicap>
                                  <handicap name="+1.0" main="0">
                                      <odd name="1" handicap="+1.0" value="1.40" dp3="1.400" us="-250" id="460380645311548"/>
                                      <odd name="2" handicap="-1.0" value="3.13" dp3="3.130" us="21" id="460380645321549"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.73" dp3="1.730" us="-137" id="460380645011544"/>
                                      <odd name="2" handicap="-0.5" value="2.00" dp3="2.000" us="100" id="460380645021545"/>
                                  </handicap>
                              </bookmaker>
                          </type>
                          <type value="3Way Result 1st Half" id="5">
                              <bookmaker name="188Bet" id="56">
                                  <odd name="1" value="4.25" dp3="4.250" us="32" id="4603806516111523"/>
                                  <odd name="2" value="2.81" dp3="2.810" us="18" id="4603806516131524"/>
                                  <odd name="X" value="2.05" dp3="2.050" us="10" id="4603806516121525"/>
                              </bookmaker>
                              <bookmaker name="5 Dimes" id="20">
                                  <odd name="1" value="4.55" dp3="4.550" us="35" id="460380659511523"/>
                                  <odd name="2" value="2.95" dp3="2.950" us="19" id="460380659531524"/>
                                  <odd name="X" value="2.10" dp3="2.100" us="11" id="460380659521525"/>
                              </bookmaker>
                              <bookmaker name="Betfair" id="21">
                                  <odd name="1" value="4.80" dp3="4.800" us="38" id="460380652111523"/>
                                  <odd name="2" value="2.88" dp3="2.880" us="18" id="460380652131524"/>
                                  <odd name="X" value="2.20" dp3="2.200" us="12" id="460380652121525"/>
                              </bookmaker>
                              <bookmaker name="BetOnline" id="206">
                                  <odd name="1" value="4.30" dp3="4.300" us="33" id="4603806520611523"/>
                                  <odd name="2" value="2.77" dp3="2.770" us="17" id="4603806520631524"/>
                                  <odd name="X" value="1.97" dp3="1.971" us="-103" id="4603806520621525"/>
                              </bookmaker>
                              <bookmaker name="BWin" id="2">
                                  <odd name="1" value="4.25" dp3="4.250" us="32" id="460380652511523"/>
                                  <odd name="2" value="2.65" dp3="2.650" us="16" id="460380652531524"/>
                                  <odd name="X" value="2.00" dp3="2.000" us="100" id="460380652521525"/>
                              </bookmaker>
                              <bookmaker name="Intertops" id="190">
                                  <odd name="1" value="4.60" dp3="4.600" us="36" id="460380657011523"/>
                                  <odd name="2" value="2.75" dp3="2.750" us="17" id="460380657031524"/>
                                  <odd name="X" value="2.10" dp3="2.100" us="11" id="460380657021525"/>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <odd name="1" value="4.70" dp3="4.700" us="37" id="4603806522611523"/>
                                  <odd name="2" value="2.67" dp3="2.670" us="16" id="4603806522631524"/>
                                  <odd name="X" value="2.05" dp3="2.050" us="10" id="4603806522621525"/>
                              </bookmaker>
                              <bookmaker name="Pinnacle" id="18">
                                  <odd name="1" value="4.83" dp3="4.830" us="38" id="460380655311523"/>
                                  <odd name="2" value="2.89" dp3="2.890" us="18" id="460380655331524"/>
                                  <odd name="X" value="2.11" dp3="2.110" us="11" id="460380655321525"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="1" value="4.25" dp3="4.250" us="32" id="460380658211523"/>
                                  <odd name="2" value="2.65" dp3="2.650" us="16" id="460380658231524"/>
                                  <odd name="X" value="2.08" dp3="2.080" us="10" id="460380658221525"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="4.00" dp3="4.000" us="30" id="460380655011523"/>
                                  <odd name="2" value="2.88" dp3="2.880" us="18" id="460380655031524"/>
                                  <odd name="X" value="1.91" dp3="1.910" us="-110" id="460380655021525"/>
                              </bookmaker>
                          </type>
                          <type value="Over/Under 1st Half" id="7">
                              <bookmaker name="188Bet" id="56">
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.83" dp3="1.830" us="-120" id="4603806716111562"/>
                                      <odd name="Over" value="2.07" dp3="2.070" us="10" id="4603806716121563"/>
                                  </total>
                                  <total name="0.75" main="0">
                                      <odd name="Under" value="2.28" dp3="2.280" us="12" id="4603806716111623"/>
                                      <odd name="Over" value="1.68" dp3="1.680" us="-147" id="4603806716121624"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="5 Dimes" id="20">
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.78" dp3="1.781" us="-128" id="460380679511562"/>
                                      <odd name="Over" value="2.08" dp3="2.080" us="10" id="460380679521563"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Betfair" id="21">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.84" dp3="2.840" us="18" id="460380672111560"/>
                                      <odd name="Over" value="1.52" dp3="1.520" us="-192" id="460380672121561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.39" dp3="1.390" us="-256" id="460380672111564"/>
                                      <odd name="Over" value="3.45" dp3="3.450" us="24" id="460380672121565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.09" dp3="1.090" us="-111" id="460380672111572"/>
                                      <odd name="Over" value="9.40" dp3="9.400" us="84" id="460380672121573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="BetOnline" id="206">
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.76" dp3="1.758" us="-132" id="4603806720611562"/>
                                      <odd name="Over" value="2.12" dp3="2.120" us="11" id="4603806720621563"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="BWin" id="2">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.60" dp3="2.600" us="16" id="460380672511560"/>
                                      <odd name="Over" value="1.44" dp3="1.440" us="-227" id="460380672521561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.36" dp3="1.360" us="-278" id="460380672511564"/>
                                      <odd name="Over" value="2.90" dp3="2.900" us="19" id="460380672521565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.07" dp3="1.070" us="-142" id="460380672511572"/>
                                      <odd name="Over" value="7.00" dp3="7.000" us="60" id="460380672521573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.01" dp3="1.010" us="-100" id="460380672511580"/>
                                      <odd name="Over" value="17.00" dp3="17.000" us="16" id="460380672521581"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.72" dp3="2.720" us="17" id="4603806722611560"/>
                                      <odd name="Over" value="1.46" dp3="1.460" us="-217" id="4603806722621561"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.74" dp3="1.740" us="-135" id="4603806722611562"/>
                                      <odd name="Over" value="2.09" dp3="2.090" us="10" id="4603806722621563"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.34" dp3="1.340" us="-294" id="4603806722611564"/>
                                      <odd name="Over" value="3.26" dp3="3.260" us="22" id="4603806722621565"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="1.09" dp3="1.087" us="-114" id="4603806722611568"/>
                                      <odd name="Over" value="7.50" dp3="7.500" us="65" id="4603806722621569"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.06" dp3="1.063" us="-158" id="4603806722611572"/>
                                      <odd name="Over" value="8.90" dp3="8.900" us="79" id="4603806722621573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Pinnacle" id="18">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.70" dp3="2.700" us="17" id="460380675311560"/>
                                      <odd name="Over" value="1.51" dp3="1.507" us="-197" id="460380675321561"/>
                                  </total>
                                  <total name="1.25" main="0">
                                      <odd name="Under" value="1.48" dp3="1.476" us="-210" id="460380675311600"/>
                                      <odd name="Over" value="2.80" dp3="2.800" us="18" id="460380675321601"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.75" dp3="1.751" us="-133" id="460380675311562"/>
                                      <odd name="Over" value="2.20" dp3="2.200" us="12" id="460380675321563"/>
                                  </total>
                                  <total name="0.75" main="0">
                                      <odd name="Under" value="2.24" dp3="2.240" us="12" id="460380675311623"/>
                                      <odd name="Over" value="1.73" dp3="1.729" us="-137" id="460380675321624"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.34" dp3="1.341" us="-293" id="460380675311564"/>
                                      <odd name="Over" value="3.37" dp3="3.370" us="23" id="460380675321565"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.80" dp3="2.800" us="18" id="460380678211560"/>
                                      <odd name="Over" value="1.40" dp3="1.400" us="-250" id="460380678221561"/>
                                  </total>
                                  <total name="0.75" main="0">
                                      <odd name="Under" value="2.30" dp3="2.300" us="13" id="460380678211623"/>
                                      <odd name="Over" value="1.58" dp3="1.580" us="-172" id="460380678221624"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.78" dp3="1.780" us="-128" id="460380678211562"/>
                                      <odd name="Over" value="1.98" dp3="1.980" us="-102" id="460380678221563"/>
                                  </total>
                                  <total name="1.25" main="0">
                                      <odd name="Under" value="1.48" dp3="1.480" us="-208" id="460380678211600"/>
                                      <odd name="Over" value="2.55" dp3="2.550" us="15" id="460380678221601"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.33" dp3="1.330" us="-303" id="460380678211564"/>
                                      <odd name="Over" value="3.10" dp3="3.100" us="21" id="460380678221565"/>
                                  </total>
                                  <total name="1.75" main="0">
                                      <odd name="Under" value="1.21" dp3="1.210" us="-476" id="460380678211566"/>
                                      <odd name="Over" value="4.20" dp3="4.200" us="32" id="460380678221567"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="1.09" dp3="1.090" us="-111" id="460380678211568"/>
                                      <odd name="Over" value="7.50" dp3="7.500" us="65" id="460380678221569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.08" dp3="1.080" us="-125" id="460380678211570"/>
                                      <odd name="Over" value="8.00" dp3="8.000" us="70" id="460380678221571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.06" dp3="1.060" us="-166" id="460380678211572"/>
                                      <odd name="Over" value="8.50" dp3="8.500" us="75" id="460380678221573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.62" dp3="2.620" us="16" id="460380675011560"/>
                                      <odd name="Over" value="1.44" dp3="1.440" us="-227" id="460380675021561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.33" dp3="1.330" us="-303" id="460380675011564"/>
                                      <odd name="Over" value="3.25" dp3="3.250" us="22" id="460380675021565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.06" dp3="1.060" us="-166" id="460380675011572"/>
                                      <odd name="Over" value="8.00" dp3="8.000" us="70" id="460380675021573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.01" dp3="1.010" us="-100" id="460380675011580"/>
                                      <odd name="Over" value="17.00" dp3="17.000" us="16" id="460380675021581"/>
                                  </total>
                              </bookmaker>
                          </type>
                          <type value="Over/Under 2nd Half" id="8">
                              <bookmaker name="BWin" id="2">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="3.50" dp3="3.500" us="25" id="460380682511560"/>
                                      <odd name="Over" value="1.26" dp3="1.260" us="-385" id="460380682521561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.60" dp3="1.600" us="-167" id="460380682511564"/>
                                      <odd name="Over" value="2.20" dp3="2.200" us="12" id="460380682521565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.15" dp3="1.150" us="-667" id="460380682511572"/>
                                      <odd name="Over" value="4.75" dp3="4.750" us="37" id="460380682521573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.02" dp3="1.020" us="-500" id="460380682511580"/>
                                      <odd name="Over" value="9.75" dp3="9.750" us="87" id="460380682521581"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="3.60" dp3="3.600" us="26" id="4603806822611560"/>
                                      <odd name="Over" value="1.29" dp3="1.290" us="-345" id="4603806822621561"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="2.40" dp3="2.400" us="14" id="4603806822611562"/>
                                      <odd name="Over" value="1.57" dp3="1.571" us="-175" id="4603806822621563"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.57" dp3="1.570" us="-175" id="4603806822611564"/>
                                      <odd name="Over" value="2.41" dp3="2.410" us="14" id="4603806822621565"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="1.20" dp3="1.200" us="-500" id="4603806822611568"/>
                                      <odd name="Over" value="4.55" dp3="4.550" us="35" id="4603806822621569"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.14" dp3="1.135" us="-741" id="4603806822611572"/>
                                      <odd name="Over" value="5.85" dp3="5.850" us="48" id="4603806822621573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="3.65" dp3="3.650" us="26" id="460380688211560"/>
                                      <odd name="Over" value="1.25" dp3="1.250" us="-400" id="460380688221561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.57" dp3="1.570" us="-175" id="460380688211564"/>
                                      <odd name="Over" value="2.28" dp3="2.280" us="12" id="460380688221565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.14" dp3="1.140" us="-714" id="460380688211572"/>
                                      <odd name="Over" value="5.30" dp3="5.300" us="43" id="460380688221573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.02" dp3="1.020" us="-500" id="460380688211580"/>
                                      <odd name="Over" value="14.00" dp3="14.000" us="13" id="460380688221581"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="3.40" dp3="3.400" us="24" id="460380685011560"/>
                                      <odd name="Over" value="1.30" dp3="1.300" us="-333" id="460380685021561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.62" dp3="1.620" us="-161" id="460380685011564"/>
                                      <odd name="Over" value="2.20" dp3="2.200" us="12" id="460380685021565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.17" dp3="1.170" us="-588" id="460380685011572"/>
                                      <odd name="Over" value="4.50" dp3="4.500" us="35" id="460380685021573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.03" dp3="1.030" us="-333" id="460380685011580"/>
                                      <odd name="Over" value="11.00" dp3="11.000" us="10" id="460380685021581"/>
                                  </total>
                              </bookmaker>
                          </type>
                          <type value="HT/FT Double" id="14">
                              <bookmaker name="Betfair" id="21">
                                  <odd name="Draw/Draw" value="5.50" dp3="5.500" us="45" id="4603806142112422"/>
                                  <odd name="Draw/Everton" value="5.70" dp3="5.700" us="47" id="46038061421112897"/>
                                  <odd name="Everton/Draw" value="18.00" dp3="18.000" us="17" id="46038061421112899"/>
                                  <odd name="Everton/Everton" value="3.60" dp3="3.600" us="26" id="46038061421112900"/>
                                  <odd name="Cardiff/Cardiff" value="7.80" dp3="7.800" us="68" id="46038061421113251"/>
                                  <odd name="Cardiff/Draw" value="19.00" dp3="19.000" us="18" id="46038061421113252"/>
                                  <odd name="Draw/Cardiff" value="9.80" dp3="9.800" us="88" id="46038061421113254"/>
                                  <odd name="Cardiff/Everton" value="34.00" dp3="34.000" us="33" id="4603806142112123354"/>
                                  <odd name="Everton/Cardiff" value="55.00" dp3="55.000" us="54" id="4603806142112123355"/>
                              </bookmaker>
                              <bookmaker name="Tipico" id="70">
                                  <odd name="Draw/Draw" value="4.70" dp3="4.700" us="37" id="46038061419012422"/>
                                  <odd name="Draw/Everton" value="5.00" dp3="5.000" us="40" id="460380614190112897"/>
                                  <odd name="Everton/Draw" value="14.00" dp3="14.000" us="13" id="460380614190112899"/>
                                  <odd name="Everton/Everton" value="3.20" dp3="3.200" us="22" id="460380614190112900"/>
                                  <odd name="Cardiff/Cardiff" value="6.00" dp3="6.000" us="50" id="460380614190113251"/>
                                  <odd name="Cardiff/Draw" value="15.00" dp3="15.000" us="14" id="460380614190113252"/>
                                  <odd name="Draw/Cardiff" value="8.00" dp3="8.000" us="70" id="460380614190113254"/>
                                  <odd name="Cardiff/Everton" value="30.00" dp3="30.000" us="29" id="46038061419012123354"/>
                                  <odd name="Everton/Cardiff" value="45.00" dp3="45.000" us="44" id="46038061419012123355"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="Draw/Draw" value="4.90" dp3="4.900" us="39" id="4603806148212422"/>
                                  <odd name="Draw/Everton" value="5.10" dp3="5.100" us="41" id="46038061482112897"/>
                                  <odd name="Everton/Draw" value="14.00" dp3="14.000" us="13" id="46038061482112899"/>
                                  <odd name="Everton/Everton" value="3.20" dp3="3.200" us="22" id="46038061482112900"/>
                                  <odd name="Cardiff/Cardiff" value="6.25" dp3="6.250" us="52" id="46038061482113251"/>
                                  <odd name="Cardiff/Draw" value="14.00" dp3="14.000" us="13" id="46038061482113252"/>
                                  <odd name="Draw/Cardiff" value="8.00" dp3="8.000" us="70" id="46038061482113254"/>
                                  <odd name="Cardiff/Everton" value="25.00" dp3="25.000" us="24" id="4603806148212123354"/>
                                  <odd name="Everton/Cardiff" value="36.00" dp3="36.000" us="35" id="4603806148212123355"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="Draw/Draw" value="4.50" dp3="4.500" us="35" id="4603806145012422"/>
                                  <odd name="Draw/Everton" value="4.80" dp3="4.800" us="38" id="46038061450112897"/>
                                  <odd name="Everton/Draw" value="17.00" dp3="17.000" us="16" id="46038061450112899"/>
                                  <odd name="Everton/Everton" value="3.25" dp3="3.250" us="22" id="46038061450112900"/>
                                  <odd name="Cardiff/Cardiff" value="6.00" dp3="6.000" us="50" id="46038061450113251"/>
                                  <odd name="Cardiff/Draw" value="15.00" dp3="15.000" us="14" id="46038061450113252"/>
                                  <odd name="Draw/Cardiff" value="8.00" dp3="8.000" us="70" id="46038061450113254"/>
                                  <odd name="Cardiff/Everton" value="26.00" dp3="26.000" us="25" id="4603806145012123354"/>
                                  <odd name="Everton/Cardiff" value="34.00" dp3="34.000" us="33" id="4603806145012123355"/>
                              </bookmaker>
                          </type>
                          <type value="Both Teams to Score" id="25">
                              <bookmaker name="188Bet" id="56">
                                  <odd name="No" value="1.90" dp3="1.900" us="-111" id="46038062516112427"/>
                                  <odd name="Yes" value="1.91" dp3="1.910" us="-110" id="46038062516112428"/>
                              </bookmaker>
                              <bookmaker name="Betfair" id="21">
                                  <odd name="No" value="1.96" dp3="1.960" us="-104" id="4603806252112427"/>
                                  <odd name="Yes" value="2.00" dp3="2.000" us="100" id="4603806252112428"/>
                              </bookmaker>
                              <bookmaker name="Betsson" id="43">
                                  <odd name="No" value="1.96" dp3="1.960" us="-104" id="46038062512912427"/>
                                  <odd name="Yes" value="1.85" dp3="1.850" us="-118" id="46038062512912428"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="No" value="1.91" dp3="1.910" us="-110" id="4603806258212427"/>
                                  <odd name="Yes" value="1.86" dp3="1.860" us="-116" id="4603806258212428"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="No" value="1.73" dp3="1.730" us="-137" id="4603806255012427"/>
                                  <odd name="Yes" value="2.00" dp3="2.000" us="100" id="4603806255012428"/>
                              </bookmaker>
                          </type>
                          <type value="Double Chance" id="30">
                              <bookmaker name="BWin" id="2">
                                  <odd name="1X" value="1.67" dp3="1.670" us="-149" id="4603806302511620"/>
                                  <odd name="X2" value="1.30" dp3="1.300" us="-333" id="4603806302521621"/>
                                  <odd name="12" value="1.26" dp3="1.260" us="-385" id="4603806302531622"/>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <odd name="1X" value="1.80" dp3="1.800" us="-125" id="46038063022611620"/>
                                  <odd name="X2" value="1.32" dp3="1.320" us="-312" id="46038063022621621"/>
                                  <odd name="12" value="1.38" dp3="1.380" us="-263" id="46038063022631622"/>
                              </bookmaker>
                              <bookmaker name="MyBet" id="41">
                                  <odd name="1X" value="1.70" dp3="1.700" us="-143" id="46038063019211620"/>
                                  <odd name="X2" value="1.33" dp3="1.330" us="-303" id="46038063019221621"/>
                                  <odd name="12" value="1.30" dp3="1.300" us="-333" id="46038063019231622"/>
                              </bookmaker>
                              <bookmaker name="Tipico" id="70">
                                  <odd name="1X" value="1.01" dp3="1.010" us="-214" id="46038063019011620"/>
                                  <odd name="X2" value="1.27" dp3="1.270" us="-370" id="46038063019021621"/>
                                  <odd name="12" value="1.01" dp3="1.010" us="-214" id="46038063019031622"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="1X" value="1.75" dp3="1.750" us="-133" id="4603806308211620"/>
                                  <odd name="X2" value="1.30" dp3="1.300" us="-333" id="4603806308221621"/>
                                  <odd name="12" value="1.35" dp3="1.350" us="-286" id="4603806308231622"/>
                              </bookmaker>
                          </type>
                          <type value="Team To Score First" id="33">
                              <bookmaker name="Betfair" id="21">
                                  <odd name="1" value="2.60" dp3="2.600" us="16" id="4603806332111523"/>
                                  <odd name="2" value="1.78" dp3="1.780" us="-128" id="4603806332131524"/>
                                  <odd name="X" value="9.40" dp3="9.400" us="84" id="4603806332121525"/>
                              </bookmaker>
                              <bookmaker name="BWin" id="2">
                                  <odd name="1" value="2.40" dp3="2.400" us="14" id="4603806332511523"/>
                                  <odd name="2" value="1.70" dp3="1.700" us="-143" id="4603806332531524"/>
                                  <odd name="X" value="7.25" dp3="7.250" us="62" id="4603806332521525"/>
                              </bookmaker>
                              <bookmaker name="Coral" id="5">
                                  <odd name="1" value="2.60" dp3="2.600" us="16" id="460380633511523"/>
                                  <odd name="2" value="1.75" dp3="1.750" us="-133" id="460380633531524"/>
                                  <odd name="X" value="8.00" dp3="8.000" us="70" id="460380633521525"/>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <odd name="1" value="2.59" dp3="2.590" us="15" id="46038063322611523"/>
                                  <odd name="2" value="1.72" dp3="1.720" us="-139" id="46038063322631524"/>
                                  <odd name="X" value="9.30" dp3="9.300" us="83" id="46038063322621525"/>
                              </bookmaker>
                              <bookmaker name="MyBet" id="41">
                                  <odd name="1" value="2.35" dp3="2.350" us="13" id="46038063319211523"/>
                                  <odd name="2" value="1.75" dp3="1.750" us="-133" id="46038063319231524"/>
                                  <odd name="X" value="7.00" dp3="7.000" us="60" id="46038063319221525"/>
                              </bookmaker>
                              <bookmaker name="Tipico" id="70">
                                  <odd name="1" value="2.40" dp3="2.400" us="14" id="46038063319011523"/>
                                  <odd name="2" value="1.70" dp3="1.700" us="-143" id="46038063319031524"/>
                                  <odd name="X" value="9.50" dp3="9.500" us="85" id="46038063319021525"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="2.45" dp3="2.450" us="14" id="4603806335011523"/>
                                  <odd name="2" value="1.67" dp3="1.670" us="-149" id="4603806335031524"/>
                                  <odd name="X" value="8.50" dp3="8.500" us="75" id="4603806335021525"/>
                              </bookmaker>
                          </type>
                          <type value="Team To Score Last" id="34">
                              <bookmaker name="10Bet" id="14">
                                  <odd name="1" value="2.50" dp3="2.500" us="15" id="46038063410711523"/>
                                  <odd name="2" value="1.74" dp3="1.741" us="-135" id="46038063410731524"/>
                                  <odd name="X" value="8.50" dp3="8.500" us="75" id="46038063410721525"/>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <odd name="1" value="2.59" dp3="2.590" us="15" id="46038063422611523"/>
                                  <odd name="2" value="1.72" dp3="1.720" us="-139" id="46038063422631524"/>
                                  <odd name="X" value="9.30" dp3="9.300" us="83" id="46038063422621525"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="2.30" dp3="2.300" us="13" id="4603806345011523"/>
                                  <odd name="2" value="1.75" dp3="1.750" us="-133" id="4603806345031524"/>
                                  <odd name="X" value="8.50" dp3="8.500" us="75" id="4603806345021525"/>
                              </bookmaker>
                          </type>
                          <type value="3Way Result 2nd Half" id="55">
                              <bookmaker name="Marathonbet" id="226">
                                  <odd name="1" value="4.00" dp3="4.000" us="30" id="46038065522611523"/>
                                  <odd name="2" value="2.51" dp3="2.510" us="15" id="46038065522631524"/>
                                  <odd name="X" value="2.34" dp3="2.340" us="13" id="46038065522621525"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="1" value="3.80" dp3="3.800" us="28" id="4603806558211523"/>
                                  <odd name="2" value="2.45" dp3="2.450" us="14" id="4603806558231524"/>
                                  <odd name="X" value="2.38" dp3="2.380" us="13" id="4603806558221525"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="3.40" dp3="3.400" us="24" id="4603806555011523"/>
                                  <odd name="2" value="2.60" dp3="2.600" us="16" id="4603806555031524"/>
                                  <odd name="X" value="2.25" dp3="2.250" us="12" id="4603806555021525"/>
                              </bookmaker>
                          </type>
                          <type value="3Way Handicap" id="79">
                              <bookmaker name="Betfair" id="21">
                                  <odd name="1 : -1.0" value="10.50" dp3="10.500" us="95" id="4603806792111532"/>
                                  <odd name="2 : +1.0" value="1.31" dp3="1.310" us="-323" id="4603806792121533"/>
                                  <odd name="1 : +1.0" value="1.89" dp3="1.890" us="-112" id="4603806792111548"/>
                                  <odd name="2 : -1.0" value="4.10" dp3="4.100" us="31" id="4603806792121549"/>
                                  <odd name="1 : +2.0" value="1.28" dp3="1.280" us="-357" id="4603806792111556"/>
                                  <odd name="2 : -2.0" value="10.50" dp3="10.500" us="95" id="4603806792121557"/>
                                  <odd name="1 : +3.0" value="1.08" dp3="1.080" us="-125" id="4603806792111558"/>
                                  <odd name="2 : -3.0" value="22.00" dp3="22.000" us="21" id="4603806792121559"/>
                                  <odd name="1 : -2.0" value="34.00" dp3="34.000" us="33" id="4603806792111606"/>
                                  <odd name="2 : +2.0" value="1.07" dp3="1.070" us="-142" id="4603806792121607"/>
                                  <odd name="1 : -3.0" value="38.00" dp3="38.000" us="37" id="4603806792111608"/>
                                  <odd name="2 : +3.0" value="1.01" dp3="1.010" us="-100" id="4603806792121609"/>
                                  <odd name="X : -3.0" value="40.00" dp3="40.000" us="39" id="46038067921342364"/>
                                  <odd name="X : -2.0" value="14.50" dp3="14.500" us="13" id="46038067921342365"/>
                                  <odd name="X : -1.0" value="5.70" dp3="5.700" us="47" id="46038067921342366"/>
                                  <odd name="X : +1.0" value="3.95" dp3="3.950" us="29" id="46038067921342367"/>
                                  <odd name="X : +2.0" value="5.90" dp3="5.900" us="49" id="46038067921342368"/>
                                  <odd name="X : +3.0" value="15.00" dp3="15.000" us="14" id="46038067921342369"/>
                              </bookmaker>
                              <bookmaker name="BWin" id="2">
                                  <odd name="1 : -1.0" value="8.50" dp3="8.500" us="75" id="4603806792511532"/>
                                  <odd name="2 : +1.0" value="1.25" dp3="1.250" us="-400" id="4603806792521533"/>
                                  <odd name="1 : +1.0" value="1.75" dp3="1.750" us="-133" id="4603806792511548"/>
                                  <odd name="2 : -1.0" value="3.75" dp3="3.750" us="27" id="4603806792521549"/>
                                  <odd name="1 : +2.0" value="1.25" dp3="1.250" us="-400" id="4603806792511556"/>
                                  <odd name="2 : -2.0" value="8.00" dp3="8.000" us="70" id="4603806792521557"/>
                                  <odd name="1 : -2.0" value="17.50" dp3="17.500" us="16" id="4603806792511606"/>
                                  <odd name="2 : +2.0" value="1.05" dp3="1.050" us="-200" id="4603806792521607"/>
                                  <odd name="X : -2.0" value="9.75" dp3="9.750" us="87" id="46038067925342365"/>
                                  <odd name="X : -1.0" value="5.25" dp3="5.250" us="42" id="46038067925342366"/>
                                  <odd name="X : +1.0" value="3.70" dp3="3.700" us="27" id="46038067925342367"/>
                                  <odd name="X : +2.0" value="5.50" dp3="5.500" us="45" id="46038067925342368"/>
                              </bookmaker>
                              <bookmaker name="Coral" id="5">
                                  <odd name="1 : -1.0" value="10.00" dp3="10.000" us="90" id="460380679511532"/>
                                  <odd name="2 : +1.0" value="1.25" dp3="1.250" us="-400" id="460380679521533"/>
                                  <odd name="1 : +1.0" value="1.75" dp3="1.750" us="-133" id="460380679511548"/>
                                  <odd name="2 : -1.0" value="4.20" dp3="4.200" us="32" id="460380679521549"/>
                                  <odd name="1 : +2.0" value="1.25" dp3="1.250" us="-400" id="460380679511556"/>
                                  <odd name="2 : -2.0" value="10.00" dp3="10.000" us="90" id="460380679521557"/>
                                  <odd name="1 : +3.0" value="1.07" dp3="1.070" us="-142" id="460380679511558"/>
                                  <odd name="2 : -3.0" value="29.00" dp3="29.000" us="28" id="460380679521559"/>
                                  <odd name="1 : -2.0" value="29.00" dp3="29.000" us="28" id="460380679511606"/>
                                  <odd name="2 : +2.0" value="1.07" dp3="1.070" us="-142" id="460380679521607"/>
                                  <odd name="1 : -3.0" value="126.00" dp3="126.000" us="12" id="460380679511608"/>
                                  <odd name="2 : +3.0" value="1.01" dp3="1.010" us="-100" id="460380679521609"/>
                                  <odd name="2 : -5.0" value="201.00" dp3="201.000" us="20" id="460380679521743"/>
                                  <odd name="2 : -4.0" value="91.00" dp3="91.000" us="90" id="460380679521745"/>
                                  <odd name="1 : +4.0" value="1.02" dp3="1.020" us="-500" id="460380679511748"/>
                                  <odd name="1 : +5.0" value="1.01" dp3="1.010" us="-214" id="460380679511750"/>
                                  <odd name="X : -3.0" value="46.00" dp3="46.000" us="45" id="4603806795342364"/>
                                  <odd name="X : -2.0" value="12.00" dp3="12.000" us="11" id="4603806795342365"/>
                                  <odd name="X : -1.0" value="5.50" dp3="5.500" us="45" id="4603806795342366"/>
                                  <odd name="X : +1.0" value="3.70" dp3="3.700" us="27" id="4603806795342367"/>
                                  <odd name="X : +2.0" value="6.00" dp3="6.000" us="50" id="4603806795342368"/>
                                  <odd name="X : +3.0" value="13.00" dp3="13.000" us="12" id="4603806795342369"/>
                                  <odd name="X : +4.0" value="41.00" dp3="41.000" us="40" id="4603806795342372"/>
                                  <odd name="X : +5.0" value="126.00" dp3="126.000" us="12" id="4603806795342375"/>
                              </bookmaker>
                              <bookmaker name="MyBet" id="41">
                                  <odd name="1 : +1.0" value="1.75" dp3="1.750" us="-133" id="46038067919211548"/>
                                  <odd name="2 : -1.0" value="3.85" dp3="3.850" us="28" id="46038067919221549"/>
                                  <odd name="X : +1.0" value="3.80" dp3="3.800" us="28" id="460380679192342367"/>
                              </bookmaker>
                              <bookmaker name="Tipico" id="70">
                                  <odd name="1 : +1.0" value="1.01" dp3="1.010" us="-214" id="46038067919011548"/>
                                  <odd name="2 : -1.0" value="4.10" dp3="4.100" us="31" id="46038067919021549"/>
                                  <odd name="X : +1.0" value="1.01" dp3="1.010" us="-214" id="460380679190342367"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="1 : -1.0" value="9.00" dp3="9.000" us="80" id="4603806798211532"/>
                                  <odd name="2 : +1.0" value="1.21" dp3="1.210" us="-476" id="4603806798221533"/>
                                  <odd name="1 : +1.0" value="1.71" dp3="1.710" us="-141" id="4603806798211548"/>
                                  <odd name="2 : -1.0" value="3.85" dp3="3.850" us="28" id="4603806798221549"/>
                                  <odd name="1 : +2.0" value="1.19" dp3="1.190" us="-526" id="4603806798211556"/>
                                  <odd name="2 : -2.0" value="9.00" dp3="9.000" us="80" id="4603806798221557"/>
                                  <odd name="1 : +3.0" value="1.04" dp3="1.040" us="-250" id="4603806798211558"/>
                                  <odd name="2 : -3.0" value="23.00" dp3="23.000" us="22" id="4603806798221559"/>
                                  <odd name="1 : -2.0" value="26.00" dp3="26.000" us="25" id="4603806798211606"/>
                                  <odd name="2 : +2.0" value="1.04" dp3="1.040" us="-250" id="4603806798221607"/>
                                  <odd name="X : -2.0" value="11.50" dp3="11.500" us="10" id="46038067982342365"/>
                                  <odd name="X : -1.0" value="5.40" dp3="5.400" us="44" id="46038067982342366"/>
                                  <odd name="X : +1.0" value="3.65" dp3="3.650" us="26" id="46038067982342367"/>
                                  <odd name="X : +2.0" value="6.00" dp3="6.000" us="50" id="46038067982342368"/>
                                  <odd name="X : +3.0" value="12.00" dp3="12.000" us="11" id="46038067982342369"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1 : -1.0" value="9.00" dp3="9.000" us="80" id="4603806795011532"/>
                                  <odd name="2 : +1.0" value="1.20" dp3="1.200" us="-500" id="4603806795021533"/>
                                  <odd name="1 : +1.0" value="1.67" dp3="1.670" us="-149" id="4603806795011548"/>
                                  <odd name="2 : -1.0" value="3.90" dp3="3.900" us="29" id="4603806795021549"/>
                                  <odd name="1 : +2.0" value="1.18" dp3="1.180" us="-556" id="4603806795011556"/>
                                  <odd name="2 : -2.0" value="9.00" dp3="9.000" us="80" id="4603806795021557"/>
                                  <odd name="1 : +3.0" value="1.02" dp3="1.020" us="-500" id="4603806795011558"/>
                                  <odd name="2 : -3.0" value="19.00" dp3="19.000" us="18" id="4603806795021559"/>
                                  <odd name="1 : -2.0" value="19.00" dp3="19.000" us="18" id="4603806795011606"/>
                                  <odd name="2 : +2.0" value="1.02" dp3="1.020" us="-500" id="4603806795021607"/>
                                  <odd name="1 : -3.0" value="29.00" dp3="29.000" us="28" id="4603806795011608"/>
                                  <odd name="2 : +3.0" value="1.01" dp3="1.010" us="-100" id="4603806795021609"/>
                                  <odd name="2 : -4.0" value="29.00" dp3="29.000" us="28" id="4603806795021745"/>
                                  <odd name="1 : +4.0" value="1.01" dp3="1.010" us="-100" id="4603806795011748"/>
                                  <odd name="X : -3.0" value="21.00" dp3="21.000" us="20" id="46038067950342364"/>
                                  <odd name="X : -2.0" value="11.00" dp3="11.000" us="10" id="46038067950342365"/>
                                  <odd name="X : -1.0" value="5.50" dp3="5.500" us="45" id="46038067950342366"/>
                                  <odd name="X : +1.0" value="3.75" dp3="3.750" us="27" id="46038067950342367"/>
                                  <odd name="X : +2.0" value="6.00" dp3="6.000" us="50" id="46038067950342368"/>
                                  <odd name="X : +3.0" value="11.00" dp3="11.000" us="10" id="46038067950342369"/>
                                  <odd name="X : +4.0" value="21.00" dp3="21.000" us="20" id="46038067950342372"/>
                              </bookmaker>
                          </type>
                      </odds>
                  </match>
              </matches>
          </category>
          <category name="England: Fa Cup" gid="1198" id="1198" file_group="england" iscup="True">
              <matches date="Mar 16" formatted_date="16.03.2019">
                  <match status="12:15" date="Mar 16" formatted_date="16.03.2019" time="12:15" venue="" static_id="2589856" fix_id="3085365" id="3150825">
                      <localteam name="Watford" goals="?" id="9423"/>
                      <visitorteam name="Crystal Palace" goals="?" id="9127"/>
                      <events/>
                      <ht score=""/>
                      <odds ts="1551199121388" rotation_home="3952" rotation_away="3951">
                          <type value="3Way Result" id="1">
                              <bookmaker name="10Bet" extra="eventID=34440101" id="14">
                                  <odd name="1" value="2.50" dp3="2.500" us="15" id="4769904110711523"/>
                                  <odd name="2" value="2.55" dp3="2.550" us="15" id="4769904110731524"/>
                                  <odd name="X" value="3.05" dp3="3.050" us="20" id="4769904110721525"/>
                              </bookmaker>
                              <bookmaker name="188Bet" extra="" id="56">
                                  <odd name="1" value="2.68" dp3="2.680" us="16" id="4769904116111523"/>
                                  <odd name="2" value="2.64" dp3="2.640" us="16" id="4769904116131524"/>
                                  <odd name="X" value="3.35" dp3="3.350" us="23" id="4769904116121525"/>
                              </bookmaker>
                              <bookmaker name="888Sport" extra="eventID=1005313920" id="231">
                                  <odd name="1" value="2.70" dp3="2.700" us="17" id="4769904116911523"/>
                                  <odd name="2" value="2.70" dp3="2.700" us="17" id="4769904116931524"/>
                                  <odd name="X" value="3.20" dp3="3.200" us="22" id="4769904116921525"/>
                              </bookmaker>
                              <bookmaker name="Betfair" extra="eventID=29141446" id="21">
                                  <odd name="1" value="2.58" dp3="2.580" us="15" id="476990412111523"/>
                                  <odd name="2" value="2.56" dp3="2.560" us="15" id="476990412131524"/>
                                  <odd name="X" value="2.78" dp3="2.780" us="17" id="476990412121525"/>
                              </bookmaker>
                              <bookmaker name="BetOnline" extra="" id="206">
                                  <odd name="1" value="2.64" dp3="2.640" us="16" id="4769904120611523"/>
                                  <odd name="2" value="2.66" dp3="2.660" us="16" id="4769904120631524"/>
                                  <odd name="X" value="3.10" dp3="3.100" us="21" id="4769904120621525"/>
                              </bookmaker>
                              <bookmaker name="Coral" extra="eventID=12292159" id="5">
                                  <odd name="1" value="2.65" dp3="2.650" us="16" id="47699041511523"/>
                                  <odd name="2" value="2.65" dp3="2.650" us="16" id="47699041531524"/>
                                  <odd name="X" value="3.10" dp3="3.100" us="21" id="47699041521525"/>
                              </bookmaker>
                              <bookmaker name="Dafabet" extra="eventID=099900" id="232">
                                  <odd name="1" value="2.63" dp3="2.630" us="16" id="4769904121611523"/>
                                  <odd name="2" value="2.61" dp3="2.610" us="16" id="4769904121631524"/>
                                  <odd name="X" value="3.15" dp3="3.150" us="21" id="4769904121621525"/>
                              </bookmaker>
                              <bookmaker name="Intertops" extra="" id="190">
                                  <odd name="1" value="2.55" dp3="2.550" us="15" id="476990417011523"/>
                                  <odd name="2" value="2.60" dp3="2.600" us="16" id="476990417031524"/>
                                  <odd name="X" value="3.05" dp3="3.050" us="20" id="476990417021525"/>
                              </bookmaker>
                              <bookmaker name="Marathonbet" extra="eventid=7805092" id="226">
                                  <odd name="1" value="2.75" dp3="2.750" us="17" id="4769904122611523"/>
                                  <odd name="2" value="2.79" dp3="2.790" us="17" id="4769904122631524"/>
                                  <odd name="X" value="3.30" dp3="3.300" us="23" id="4769904122621525"/>
                              </bookmaker>
                              <bookmaker name="MyBet" extra="" id="41">
                                  <odd name="1" value="2.65" dp3="2.650" us="16" id="4769904119211523"/>
                                  <odd name="2" value="2.70" dp3="2.700" us="17" id="4769904119231524"/>
                                  <odd name="X" value="3.25" dp3="3.250" us="22" id="4769904119221525"/>
                              </bookmaker>
                              <bookmaker name="Pinnacle" extra="rotNum=3951" id="18">
                                  <odd name="1" value="2.78" dp3="2.780" us="17" id="476990415311523"/>
                                  <odd name="2" value="2.73" dp3="2.730" us="17" id="476990415331524"/>
                                  <odd name="X" value="3.27" dp3="3.270" us="22" id="476990415321525"/>
                              </bookmaker>
                              <bookmaker name="Tipico" extra="" id="70">
                                  <odd name="1" value="2.75" dp3="2.750" us="17" id="4769904119011523"/>
                                  <odd name="2" value="2.55" dp3="2.550" us="15" id="4769904119031524"/>
                                  <odd name="X" value="3.30" dp3="3.300" us="23" id="4769904119021525"/>
                              </bookmaker>
                              <bookmaker name="Unibet" extra="eventID=1005313920" id="82">
                                  <odd name="1" value="2.75" dp3="2.750" us="17" id="476990418211523"/>
                                  <odd name="2" value="2.70" dp3="2.700" us="17" id="476990418231524"/>
                                  <odd name="X" value="3.25" dp3="3.250" us="22" id="476990418221525"/>
                              </bookmaker>
                          </type>
                          <type value="Home/Away" id="2">
                              <bookmaker name="888Sport" id="231">
                                  <odd name="1" value="1.88" dp3="1.880" us="-114" id="4769904216911523"/>
                                  <odd name="2" value="1.84" dp3="1.840" us="-119" id="4769904216921524"/>
                              </bookmaker>
                              <bookmaker name="Coral" id="5">
                                  <odd name="1" value="1.95" dp3="1.950" us="-105" id="47699042511523"/>
                                  <odd name="2" value="1.80" dp3="1.800" us="-125" id="47699042521524"/>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <odd name="1" value="1.95" dp3="1.950" us="-105" id="4769904222611523"/>
                                  <odd name="2" value="1.97" dp3="1.970" us="-103" id="4769904222621524"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="1" value="1.88" dp3="1.880" us="-114" id="476990428211523"/>
                                  <odd name="2" value="1.84" dp3="1.840" us="-119" id="476990428221524"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="1.85" dp3="1.850" us="-118" id="476990425011523"/>
                                  <odd name="2" value="1.85" dp3="1.850" us="-118" id="476990425021524"/>
                              </bookmaker>
                          </type>
                          <type value="Over/Under" id="3">
                              <bookmaker name="10Bet" id="14">
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.24" dp3="2.240" us="12" id="4769904310711568"/>
                                      <odd name="Over" value="1.51" dp3="1.513" us="-195" id="4769904310721569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.86" dp3="1.855" us="-117" id="4769904310711570"/>
                                      <odd name="Over" value="1.77" dp3="1.769" us="-130" id="4769904310721571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.64" dp3="1.637" us="-157" id="4769904310711572"/>
                                      <odd name="Over" value="2.02" dp3="2.020" us="10" id="4769904310721573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="188Bet" id="56">
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.99" dp3="1.990" us="-101" id="4769904316111570"/>
                                      <odd name="Over" value="1.91" dp3="1.910" us="-110" id="4769904316121571"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="888Sport" id="2">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="9.00" dp3="9.000" us="80" id="4769904316911560"/>
                                      <odd name="Over" value="1.06" dp3="1.060" us="-166" id="4769904316921561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.20" dp3="3.200" us="22" id="4769904316911564"/>
                                      <odd name="Over" value="1.34" dp3="1.340" us="-294" id="4769904316921565"/>
                                  </total>
                                  <total name="1.75" main="0">
                                      <odd name="Under" value="2.80" dp3="2.800" us="18" id="4769904316911566"/>
                                      <odd name="Over" value="1.42" dp3="1.420" us="-238" id="4769904316921567"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.35" dp3="2.350" us="13" id="4769904316911568"/>
                                      <odd name="Over" value="1.57" dp3="1.570" us="-175" id="4769904316921569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.93" dp3="1.930" us="-107" id="4769904316911570"/>
                                      <odd name="Over" value="1.84" dp3="1.840" us="-119" id="4769904316921571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.68" dp3="1.680" us="-147" id="4769904316911572"/>
                                      <odd name="Over" value="2.10" dp3="2.100" us="11" id="4769904316921573"/>
                                  </total>
                                  <total name="2.75" main="0">
                                      <odd name="Under" value="1.52" dp3="1.520" us="-192" id="4769904316911574"/>
                                      <odd name="Over" value="2.48" dp3="2.480" us="14" id="4769904316921575"/>
                                  </total>
                                  <total name="3.0" main="0">
                                      <odd name="Under" value="1.34" dp3="1.340" us="-294" id="4769904316911576"/>
                                      <odd name="Over" value="3.15" dp3="3.150" us="21" id="4769904316921577"/>
                                  </total>
                                  <total name="3.25" main="0">
                                      <odd name="Under" value="1.28" dp3="1.280" us="-357" id="4769904316911578"/>
                                      <odd name="Over" value="3.55" dp3="3.550" us="25" id="4769904316921579"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.24" dp3="1.240" us="-417" id="4769904316911580"/>
                                      <odd name="Over" value="3.95" dp3="3.950" us="29" id="4769904316921581"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.07" dp3="1.070" us="-142" id="4769904316911588"/>
                                      <odd name="Over" value="8.50" dp3="8.500" us="75" id="4769904316921589"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Betfair" id="21">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="4.20" dp3="4.200" us="32" id="476990432111560"/>
                                      <odd name="Over" value="1.09" dp3="1.090" us="-111" id="476990432121561"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.70" dp3="1.700" us="-143" id="476990432111572"/>
                                      <odd name="Over" value="2.04" dp3="2.040" us="10" id="476990432121573"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.00" dp3="3.000" us="20" id="476990432111564"/>
                                      <odd name="Over" value="1.23" dp3="1.230" us="-435" id="476990432121565"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.07" dp3="1.070" us="-142" id="476990432111588"/>
                                      <odd name="Over" value="3.45" dp3="3.450" us="24" id="476990432121589"/>
                                  </total>
                                  <total name="5.5" main="0">
                                      <odd name="Under" value="1.01" dp3="1.010" us="-100" id="476990432111594"/>
                                      <odd name="Over" value="3.45" dp3="3.450" us="24" id="476990432121595"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="BetOnline" id="206">
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.94" dp3="1.943" us="-106" id="4769904320611570"/>
                                      <odd name="Over" value="1.88" dp3="1.877" us="-114" id="4769904320621571"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Coral" id="5">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="8.50" dp3="8.500" us="75" id="47699043511560"/>
                                      <odd name="Over" value="1.08" dp3="1.080" us="-125" id="47699043521561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.00" dp3="3.000" us="20" id="47699043511564"/>
                                      <odd name="Over" value="1.36" dp3="1.360" us="-278" id="47699043521565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.67" dp3="1.670" us="-149" id="47699043511572"/>
                                      <odd name="Over" value="2.15" dp3="2.150" us="11" id="47699043521573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.25" dp3="1.250" us="-400" id="47699043511580"/>
                                      <odd name="Over" value="3.90" dp3="3.900" us="29" id="47699043521581"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.08" dp3="1.080" us="-125" id="47699043511588"/>
                                      <odd name="Over" value="8.50" dp3="8.500" us="75" id="47699043521589"/>
                                  </total>
                                  <total name="5.5" main="0">
                                      <odd name="Under" value="1.02" dp3="1.020" us="-500" id="47699043511594"/>
                                      <odd name="Over" value="21.00" dp3="21.000" us="20" id="47699043521595"/>
                                  </total>
                                  <total name="6.5" main="0">
                                      <odd name="Under" value="1.01" dp3="1.010" us="-100" id="47699043511596"/>
                                      <odd name="Over" value="56.00" dp3="56.000" us="55" id="47699043521597"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Dafabet" id="232">
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.99" dp3="1.990" us="-101" id="4769904321611570"/>
                                      <odd name="Over" value="1.91" dp3="1.910" us="-110" id="4769904321621571"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Intertops" id="190">
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.65" dp3="1.650" us="-154" id="476990437011572"/>
                                      <odd name="Over" value="2.10" dp3="2.100" us="11" id="476990437021573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.75" dp3="1.750" us="-133" id="4769904322611572"/>
                                      <odd name="Over" value="2.20" dp3="2.200" us="12" id="4769904322621573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="MyBet" id="41">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="7.00" dp3="7.000" us="60" id="4769904319211560"/>
                                      <odd name="Over" value="1.05" dp3="1.050" us="-200" id="4769904319221561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="2.80" dp3="2.800" us="18" id="4769904319211564"/>
                                      <odd name="Over" value="1.38" dp3="1.380" us="-263" id="4769904319221565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.67" dp3="1.670" us="-149" id="4769904319211572"/>
                                      <odd name="Over" value="2.15" dp3="2.150" us="11" id="4769904319221573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.25" dp3="1.250" us="-400" id="4769904319211580"/>
                                      <odd name="Over" value="3.55" dp3="3.550" us="25" id="4769904319221581"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.08" dp3="1.080" us="-125" id="4769904319211588"/>
                                      <odd name="Over" value="6.50" dp3="6.500" us="55" id="4769904319221589"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Pinnacle" id="18">
                                  <total name="1.75" main="0">
                                      <odd name="Under" value="2.82" dp3="2.820" us="18" id="476990435311566"/>
                                      <odd name="Over" value="1.43" dp3="1.431" us="-232" id="476990435321567"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.41" dp3="2.410" us="14" id="476990435311568"/>
                                      <odd name="Over" value="1.59" dp3="1.588" us="-170" id="476990435321569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.99" dp3="1.990" us="-101" id="476990435311570"/>
                                      <odd name="Over" value="1.89" dp3="1.892" us="-112" id="476990435321571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.74" dp3="1.735" us="-136" id="476990435311572"/>
                                      <odd name="Over" value="2.17" dp3="2.170" us="11" id="476990435321573"/>
                                  </total>
                                  <total name="2.75" main="0">
                                      <odd name="Under" value="1.54" dp3="1.537" us="-186" id="476990435311574"/>
                                      <odd name="Over" value="2.52" dp3="2.520" us="15" id="476990435321575"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="9.00" dp3="9.000" us="80" id="476990438211560"/>
                                      <odd name="Over" value="1.06" dp3="1.060" us="-166" id="476990438221561"/>
                                  </total>
                                  <total name="0.75" main="0">
                                      <odd name="Under" value="8.50" dp3="8.500" us="75" id="476990438211623"/>
                                      <odd name="Over" value="1.08" dp3="1.080" us="-125" id="476990438221624"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="7.50" dp3="7.500" us="65" id="476990438211562"/>
                                      <odd name="Over" value="1.09" dp3="1.090" us="-111" id="476990438221563"/>
                                  </total>
                                  <total name="1.25" main="0">
                                      <odd name="Under" value="4.30" dp3="4.300" us="33" id="476990438211600"/>
                                      <odd name="Over" value="1.21" dp3="1.210" us="-476" id="476990438221601"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="3.20" dp3="3.200" us="22" id="476990438211564"/>
                                      <odd name="Over" value="1.34" dp3="1.340" us="-294" id="476990438221565"/>
                                  </total>
                                  <total name="1.75" main="0">
                                      <odd name="Under" value="2.80" dp3="2.800" us="18" id="476990438211566"/>
                                      <odd name="Over" value="1.42" dp3="1.420" us="-238" id="476990438221567"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="2.35" dp3="2.350" us="13" id="476990438211568"/>
                                      <odd name="Over" value="1.57" dp3="1.570" us="-175" id="476990438221569"/>
                                  </total>
                                  <total name="2.25" main="0">
                                      <odd name="Under" value="1.93" dp3="1.930" us="-107" id="476990438211570"/>
                                      <odd name="Over" value="1.84" dp3="1.840" us="-119" id="476990438221571"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.68" dp3="1.680" us="-147" id="476990438211572"/>
                                      <odd name="Over" value="2.10" dp3="2.100" us="11" id="476990438221573"/>
                                  </total>
                                  <total name="2.75" main="0">
                                      <odd name="Under" value="1.52" dp3="1.520" us="-192" id="476990438211574"/>
                                      <odd name="Over" value="2.48" dp3="2.480" us="14" id="476990438221575"/>
                                  </total>
                                  <total name="3.0" main="0">
                                      <odd name="Under" value="1.34" dp3="1.340" us="-294" id="476990438211576"/>
                                      <odd name="Over" value="3.15" dp3="3.150" us="21" id="476990438221577"/>
                                  </total>
                                  <total name="3.25" main="0">
                                      <odd name="Under" value="1.28" dp3="1.280" us="-357" id="476990438211578"/>
                                      <odd name="Over" value="3.55" dp3="3.550" us="25" id="476990438221579"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.24" dp3="1.240" us="-417" id="476990438211580"/>
                                      <odd name="Over" value="3.95" dp3="3.950" us="29" id="476990438221581"/>
                                  </total>
                                  <total name="3.75" main="0">
                                      <odd name="Under" value="1.16" dp3="1.160" us="-625" id="476990438211582"/>
                                      <odd name="Over" value="5.10" dp3="5.100" us="41" id="476990438221583"/>
                                  </total>
                                  <total name="4.0" main="0">
                                      <odd name="Under" value="1.09" dp3="1.090" us="-111" id="476990438211584"/>
                                      <odd name="Over" value="7.50" dp3="7.500" us="65" id="476990438221585"/>
                                  </total>
                                  <total name="4.5" main="0">
                                      <odd name="Under" value="1.07" dp3="1.070" us="-142" id="476990438211588"/>
                                      <odd name="Over" value="8.50" dp3="8.500" us="75" id="476990438221589"/>
                                  </total>
                              </bookmaker>
                          </type>
                          <type value="Handicap" id="4">
                              <bookmaker name="10Bet" id="14">
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="1.80" dp3="1.800" us="-125" id="4769904410711540"/>
                                      <odd name="2" handicap="0" value="1.83" dp3="1.830" us="-120" id="4769904410721541"/>
                                  </handicap>
                                  <handicap name="-0.25" main="0">
                                      <odd name="1" handicap="-0.25" value="2.18" dp3="2.180" us="11" id="4769904410711538"/>
                                      <odd name="2" handicap="+0.25" value="1.55" dp3="1.550" us="-182" id="4769904410721539"/>
                                      <odd name="1" handicap="+0.25" value="1.56" dp3="1.560" us="-179" id="4769904410711542"/>
                                      <odd name="2" handicap="-0.25" value="2.14" dp3="2.140" us="11" id="4769904410721543"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="188Bet" id="56">
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="1.94" dp3="1.940" us="-106" id="4769904416111540"/>
                                      <odd name="2" handicap="0" value="1.98" dp3="1.980" us="-102" id="4769904416121541"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Betfair" id="21">
                                  <handicap name="-1.75" main="0">
                                      <odd name="1" handicap="-1.75" value="3.25" dp3="3.250" us="22" id="476990442111526"/>
                                      <odd name="2" handicap="+1.75" value="1.01" dp3="1.010" us="-100" id="476990442121527"/>
                                  </handicap>
                                  <handicap name="-1.5" main="0">
                                      <odd name="1" handicap="-1.5" value="3.25" dp3="3.250" us="22" id="476990442111528"/>
                                      <odd name="2" handicap="+1.5" value="1.01" dp3="1.010" us="-100" id="476990442121529"/>
                                  </handicap>
                                  <handicap name="-0.75" main="0">
                                      <odd name="1" handicap="-0.75" value="3.22" dp3="3.220" us="22" id="476990442111534"/>
                                      <odd name="2" handicap="+0.75" value="1.33" dp3="1.330" us="-303" id="476990442121535"/>
                                  </handicap>
                                  <handicap name="-1.25" main="0">
                                      <odd name="1" handicap="-1.25" value="3.22" dp3="3.220" us="22" id="476990442111530"/>
                                      <odd name="2" handicap="+1.25" value="1.02" dp3="1.020" us="-500" id="476990442121531"/>
                                  </handicap>
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="1.86" dp3="1.860" us="-116" id="476990442111540"/>
                                      <odd name="2" handicap="0" value="1.85" dp3="1.850" us="-118" id="476990442121541"/>
                                  </handicap>
                                  <handicap name="-1.0" main="0">
                                      <odd name="1" handicap="-1.0" value="3.35" dp3="3.350" us="23" id="476990442111532"/>
                                      <odd name="2" handicap="+1.0" value="1.03" dp3="1.030" us="-333" id="476990442121533"/>
                                  </handicap>
                                  <handicap name="-0.5" main="0">
                                      <odd name="1" handicap="-0.5" value="2.58" dp3="2.580" us="15" id="476990442111536"/>
                                      <odd name="2" handicap="+0.5" value="1.47" dp3="1.470" us="-213" id="476990442121537"/>
                                  </handicap>
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="1.61" dp3="1.610" us="-164" id="476990442111542"/>
                                      <odd name="2" handicap="-0.25" value="2.20" dp3="2.200" us="12" id="476990442121543"/>
                                      <odd name="1" handicap="-0.25" value="2.22" dp3="2.220" us="12" id="476990442111538"/>
                                      <odd name="2" handicap="+0.25" value="1.61" dp3="1.610" us="-164" id="476990442121539"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.47" dp3="1.470" us="-213" id="476990442111544"/>
                                      <odd name="2" handicap="-0.5" value="2.56" dp3="2.560" us="15" id="476990442121545"/>
                                  </handicap>
                                  <handicap name="+0.75" main="0">
                                      <odd name="1" handicap="+0.75" value="1.33" dp3="1.330" us="-303" id="476990442111546"/>
                                      <odd name="2" handicap="-0.75" value="3.22" dp3="3.220" us="22" id="476990442121547"/>
                                  </handicap>
                                  <handicap name="+1.0" main="0">
                                      <odd name="1" handicap="+1.0" value="1.02" dp3="1.020" us="-500" id="476990442111548"/>
                                      <odd name="2" handicap="-1.0" value="3.32" dp3="3.320" us="23" id="476990442121549"/>
                                  </handicap>
                                  <handicap name="+1.25" main="0">
                                      <odd name="1" handicap="+1.25" value="1.01" dp3="1.010" us="-100" id="476990442111550"/>
                                      <odd name="2" handicap="-1.25" value="3.13" dp3="3.130" us="21" id="476990442121551"/>
                                  </handicap>
                                  <handicap name="+1.5" main="0">
                                      <odd name="1" handicap="+1.5" value="1.01" dp3="1.010" us="-100" id="476990442111552"/>
                                      <odd name="2" handicap="-1.5" value="3.13" dp3="3.130" us="21" id="476990442121553"/>
                                  </handicap>
                                  <handicap name="+1.75" main="0">
                                      <odd name="1" handicap="+1.75" value="1.01" dp3="1.010" us="-100" id="476990442111554"/>
                                      <odd name="2" handicap="-1.75" value="3.29" dp3="3.290" us="22" id="476990442121555"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="BetOnline" id="206">
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="1.91" dp3="1.910" us="-110" id="4769904420611540"/>
                                      <odd name="2" handicap="0" value="1.91" dp3="1.910" us="-110" id="4769904420621541"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Dafabet" id="232">
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="1.93" dp3="1.930" us="-107" id="4769904421611540"/>
                                      <odd name="2" handicap="0" value="1.99" dp3="1.990" us="-101" id="4769904421621541"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Intertops" id="190">
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="1.60" dp3="1.600" us="-167" id="476990447011542"/>
                                      <odd name="2" handicap="-0.25" value="2.20" dp3="2.200" us="12" id="476990447021543"/>
                                      <odd name="1" handicap="-0.25" value="2.20" dp3="2.200" us="12" id="476990447011538"/>
                                      <odd name="2" handicap="+0.25" value="1.60" dp3="1.600" us="-167" id="476990447021539"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="Pinnacle" id="18">
                                  <handicap name="-0.5" main="0">
                                      <odd name="1" handicap="-0.5" value="2.75" dp3="2.750" us="17" id="476990445311536"/>
                                      <odd name="2" handicap="+0.5" value="1.47" dp3="1.470" us="-213" id="476990445321537"/>
                                  </handicap>
                                  <handicap name="-0.25" main="0">
                                      <odd name="1" handicap="-0.25" value="2.36" dp3="2.360" us="13" id="476990445311538"/>
                                      <odd name="2" handicap="+0.25" value="1.64" dp3="1.640" us="-156" id="476990445321539"/>
                                  </handicap>
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="1.97" dp3="1.970" us="-103" id="476990445311540"/>
                                      <odd name="2" handicap="0" value="1.93" dp3="1.930" us="-107" id="476990445321541"/>
                                  </handicap>
                                  <handicap name="+0.25" main="0">
                                      <odd name="1" handicap="+0.25" value="1.66" dp3="1.660" us="-152" id="476990445311542"/>
                                      <odd name="2" handicap="-0.25" value="2.32" dp3="2.320" us="13" id="476990445321543"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.49" dp3="1.490" us="-204" id="476990445311544"/>
                                      <odd name="2" handicap="-0.5" value="2.70" dp3="2.700" us="17" id="476990445321545"/>
                                  </handicap>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <handicap name="-0.5" main="0">
                                      <odd name="1" handicap="-0.5" value="2.62" dp3="2.620" us="16" id="476990445011536"/>
                                      <odd name="2" handicap="+0.5" value="1.44" dp3="1.440" us="-227" id="476990445021537"/>
                                  </handicap>
                                  <handicap name="0" main="0">
                                      <odd name="1" handicap="0" value="1.91" dp3="1.910" us="-110" id="476990445011540"/>
                                      <odd name="2" handicap="0" value="1.92" dp3="1.920" us="-109" id="476990445021541"/>
                                  </handicap>
                                  <handicap name="+0.5" main="0">
                                      <odd name="1" handicap="+0.5" value="1.44" dp3="1.440" us="-227" id="476990445011544"/>
                                      <odd name="2" handicap="-0.5" value="2.62" dp3="2.620" us="16" id="476990445021545"/>
                                  </handicap>
                              </bookmaker>
                          </type>
                          <type value="3Way Result 1st Half" id="5">
                              <bookmaker name="188Bet" id="56">
                                  <odd name="1" value="3.35" dp3="3.350" us="23" id="4769904516111523"/>
                                  <odd name="2" value="3.30" dp3="3.300" us="23" id="4769904516131524"/>
                                  <odd name="X" value="2.00" dp3="2.000" us="100" id="4769904516121525"/>
                              </bookmaker>
                              <bookmaker name="888Sport" id="231">
                                  <odd name="1" value="3.30" dp3="3.300" us="23" id="4769904516911523"/>
                                  <odd name="2" value="3.25" dp3="3.250" us="22" id="4769904516931524"/>
                                  <odd name="X" value="2.00" dp3="2.000" us="100" id="4769904516921525"/>
                              </bookmaker>
                              <bookmaker name="BetOnline" id="206">
                                  <odd name="1" value="3.35" dp3="3.350" us="23" id="4769904520611523"/>
                                  <odd name="2" value="3.35" dp3="3.350" us="23" id="4769904520631524"/>
                                  <odd name="X" value="1.92" dp3="1.917" us="-109" id="4769904520621525"/>
                              </bookmaker>
                              <bookmaker name="Intertops" id="190">
                                  <odd name="1" value="3.40" dp3="3.400" us="24" id="476990457011523"/>
                                  <odd name="2" value="3.45" dp3="3.450" us="24" id="476990457031524"/>
                                  <odd name="X" value="2.05" dp3="2.050" us="10" id="476990457021525"/>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <odd name="1" value="3.36" dp3="3.360" us="23" id="4769904522611523"/>
                                  <odd name="2" value="3.44" dp3="3.440" us="24" id="4769904522631524"/>
                                  <odd name="X" value="2.05" dp3="2.050" us="10" id="4769904522621525"/>
                              </bookmaker>
                              <bookmaker name="Pinnacle" id="18">
                                  <odd name="1" value="3.48" dp3="3.480" us="24" id="476990455311523"/>
                                  <odd name="2" value="3.47" dp3="3.470" us="24" id="476990455331524"/>
                                  <odd name="X" value="2.16" dp3="2.160" us="11" id="476990455321525"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="1" value="3.30" dp3="3.300" us="23" id="476990458211523"/>
                                  <odd name="2" value="3.25" dp3="3.250" us="22" id="476990458231524"/>
                                  <odd name="X" value="2.00" dp3="2.000" us="100" id="476990458221525"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="3.30" dp3="3.300" us="23" id="476990455011523"/>
                                  <odd name="2" value="3.40" dp3="3.400" us="24" id="476990455031524"/>
                                  <odd name="X" value="1.85" dp3="1.850" us="-118" id="476990455021525"/>
                              </bookmaker>
                          </type>
                          <type value="Over/Under 1st Half" id="7">
                              <bookmaker name="188Bet" id="56">
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.77" dp3="1.770" us="-130" id="4769904716111562"/>
                                      <odd name="Over" value="2.12" dp3="2.120" us="11" id="4769904716121563"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="888Sport" id="231">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.70" dp3="2.700" us="17" id="4769904716911560"/>
                                      <odd name="Over" value="1.38" dp3="1.380" us="-263" id="4769904716921561"/>
                                  </total>
                                  <total name="0.75" main="0">
                                      <odd name="Under" value="2.23" dp3="2.230" us="12" id="4769904716911623"/>
                                      <odd name="Over" value="1.58" dp3="1.580" us="-172" id="4769904716921624"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.72" dp3="1.720" us="-139" id="4769904716911562"/>
                                      <odd name="Over" value="2.00" dp3="2.000" us="100" id="4769904716921563"/>
                                  </total>
                                  <total name="1.25" main="0">
                                      <odd name="Under" value="1.44" dp3="1.440" us="-227" id="4769904716911600"/>
                                      <odd name="Over" value="2.60" dp3="2.600" us="16" id="4769904716921601"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.30" dp3="1.300" us="-333" id="4769904716911564"/>
                                      <odd name="Over" value="3.15" dp3="3.150" us="21" id="4769904716921565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.05" dp3="1.050" us="-200" id="4769904716911572"/>
                                      <odd name="Over" value="9.00" dp3="9.000" us="80" id="4769904716921573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="BetOnline" id="206">
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.75" dp3="1.746" us="-134" id="4769904720611562"/>
                                      <odd name="Over" value="2.14" dp3="2.140" us="11" id="4769904720621563"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Marathonbet" id="226">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.83" dp3="2.830" us="18" id="4769904722611560"/>
                                      <odd name="Over" value="1.42" dp3="1.420" us="-238" id="4769904722621561"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.82" dp3="1.820" us="-122" id="4769904722611562"/>
                                      <odd name="Over" value="1.97" dp3="1.970" us="-103" id="4769904722621563"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.07" dp3="1.073" us="-137" id="4769904722611572"/>
                                      <odd name="Over" value="7.90" dp3="7.900" us="69" id="4769904722621573"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.37" dp3="1.370" us="-270" id="4769904722611564"/>
                                      <odd name="Over" value="3.05" dp3="3.050" us="20" id="4769904722621565"/>
                                  </total>
                                  <total name="2.0" main="0">
                                      <odd name="Under" value="1.10" dp3="1.102" us="-980" id="4769904722611568"/>
                                      <odd name="Over" value="6.65" dp3="6.650" us="56" id="4769904722621569"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Pinnacle" id="18">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.77" dp3="2.770" us="17" id="476990475311560"/>
                                      <odd name="Over" value="1.44" dp3="1.442" us="-226" id="476990475321561"/>
                                  </total>
                                  <total name="0.75" main="0">
                                      <odd name="Under" value="2.29" dp3="2.290" us="12" id="476990475311623"/>
                                      <odd name="Over" value="1.66" dp3="1.657" us="-152" id="476990475321624"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.78" dp3="1.781" us="-128" id="476990475311562"/>
                                      <odd name="Over" value="2.11" dp3="2.110" us="11" id="476990475321563"/>
                                  </total>
                                  <total name="1.25" main="0">
                                      <odd name="Under" value="1.47" dp3="1.471" us="-212" id="476990475311600"/>
                                      <odd name="Over" value="2.69" dp3="2.690" us="16" id="476990475321601"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.32" dp3="1.321" us="-312" id="476990475311564"/>
                                      <odd name="Over" value="3.26" dp3="3.260" us="22" id="476990475321565"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.70" dp3="2.700" us="17" id="476990478211560"/>
                                      <odd name="Over" value="1.38" dp3="1.380" us="-263" id="476990478221561"/>
                                  </total>
                                  <total name="0.75" main="0">
                                      <odd name="Under" value="2.23" dp3="2.230" us="12" id="476990478211623"/>
                                      <odd name="Over" value="1.58" dp3="1.580" us="-172" id="476990478221624"/>
                                  </total>
                                  <total name="1.0" main="0">
                                      <odd name="Under" value="1.72" dp3="1.720" us="-139" id="476990478211562"/>
                                      <odd name="Over" value="2.00" dp3="2.000" us="100" id="476990478221563"/>
                                  </total>
                                  <total name="1.25" main="0">
                                      <odd name="Under" value="1.44" dp3="1.440" us="-227" id="476990478211600"/>
                                      <odd name="Over" value="2.60" dp3="2.600" us="16" id="476990478221601"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.30" dp3="1.300" us="-333" id="476990478211564"/>
                                      <odd name="Over" value="3.15" dp3="3.150" us="21" id="476990478221565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.05" dp3="1.050" us="-200" id="476990478211572"/>
                                      <odd name="Over" value="9.00" dp3="9.000" us="80" id="476990478221573"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="2.50" dp3="2.500" us="15" id="476990475011560"/>
                                      <odd name="Over" value="1.50" dp3="1.500" us="-200" id="476990475021561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.30" dp3="1.300" us="-333" id="476990475011564"/>
                                      <odd name="Over" value="3.40" dp3="3.400" us="24" id="476990475021565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.06" dp3="1.060" us="-166" id="476990475011572"/>
                                      <odd name="Over" value="8.00" dp3="8.000" us="70" id="476990475021573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.01" dp3="1.010" us="-100" id="476990475011580"/>
                                      <odd name="Over" value="17.00" dp3="17.000" us="16" id="476990475021581"/>
                                  </total>
                              </bookmaker>
                          </type>
                          <type value="Over/Under 2nd Half" id="8">
                              <bookmaker name="888Sport" id="231">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="3.55" dp3="3.550" us="25" id="4769904816911560"/>
                                      <odd name="Over" value="1.24" dp3="1.240" us="-417" id="4769904816921561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.54" dp3="1.540" us="-185" id="4769904816911564"/>
                                      <odd name="Over" value="2.28" dp3="2.280" us="12" id="4769904816921565"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="3.55" dp3="3.550" us="25" id="476990488211560"/>
                                      <odd name="Over" value="1.24" dp3="1.240" us="-417" id="476990488221561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.54" dp3="1.540" us="-185" id="476990488211564"/>
                                      <odd name="Over" value="2.28" dp3="2.280" us="12" id="476990488221565"/>
                                  </total>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <total name="0.5" main="0">
                                      <odd name="Under" value="3.40" dp3="3.400" us="24" id="476990485011560"/>
                                      <odd name="Over" value="1.30" dp3="1.300" us="-333" id="476990485021561"/>
                                  </total>
                                  <total name="1.5" main="0">
                                      <odd name="Under" value="1.57" dp3="1.570" us="-175" id="476990485011564"/>
                                      <odd name="Over" value="2.30" dp3="2.300" us="13" id="476990485021565"/>
                                  </total>
                                  <total name="2.5" main="0">
                                      <odd name="Under" value="1.14" dp3="1.140" us="-714" id="476990485011572"/>
                                      <odd name="Over" value="5.00" dp3="5.000" us="40" id="476990485021573"/>
                                  </total>
                                  <total name="3.5" main="0">
                                      <odd name="Under" value="1.03" dp3="1.030" us="-333" id="476990485011580"/>
                                      <odd name="Over" value="11.00" dp3="11.000" us="10" id="476990485021581"/>
                                  </total>
                              </bookmaker>
                          </type>
                          <type value="HT/FT Double" id="14">
                              <bookmaker name="Tipico" id="70">
                                  <odd name="Draw/Draw" value="4.40" dp3="4.400" us="34" id="47699041419012422"/>
                                  <odd name="Crystal Palace/Crystal Palace" value="3.90" dp3="3.900" us="29" id="476990414190113472"/>
                                  <odd name="Crystal Palace/Draw" value="13.00" dp3="13.000" us="12" id="476990414190113473"/>
                                  <odd name="Draw/Crystal Palace" value="5.50" dp3="5.500" us="45" id="476990414190113474"/>
                                  <odd name="Draw/Watford" value="6.20" dp3="6.200" us="52" id="476990414190122257"/>
                                  <odd name="Watford/Draw" value="14.00" dp3="14.000" us="13" id="476990414190122259"/>
                                  <odd name="Watford/Watford" value="4.50" dp3="4.500" us="35" id="476990414190122260"/>
                                  <odd name="Crystal Palace/Watford" value="35.00" dp3="35.000" us="34" id="4769904141901259607"/>
                                  <odd name="Watford/Crystal Palace" value="30.00" dp3="30.000" us="29" id="4769904141901259609"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="Draw/Draw" value="4.70" dp3="4.700" us="37" id="4769904148212422"/>
                                  <odd name="Crystal Palace/Crystal Palace" value="4.35" dp3="4.350" us="33" id="47699041482113472"/>
                                  <odd name="Crystal Palace/Draw" value="13.00" dp3="13.000" us="12" id="47699041482113473"/>
                                  <odd name="Draw/Crystal Palace" value="6.25" dp3="6.250" us="52" id="47699041482113474"/>
                                  <odd name="Draw/Watford" value="6.40" dp3="6.400" us="54" id="47699041482122257"/>
                                  <odd name="Watford/Draw" value="13.00" dp3="13.000" us="12" id="47699041482122259"/>
                                  <odd name="Watford/Watford" value="4.40" dp3="4.400" us="34" id="47699041482122260"/>
                                  <odd name="Crystal Palace/Watford" value="29.00" dp3="29.000" us="28" id="476990414821259607"/>
                                  <odd name="Watford/Crystal Palace" value="29.00" dp3="29.000" us="28" id="476990414821259609"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="Draw/Draw" value="4.50" dp3="4.500" us="35" id="4769904145012422"/>
                                  <odd name="Crystal Palace/Crystal Palace" value="4.40" dp3="4.400" us="34" id="47699041450113472"/>
                                  <odd name="Crystal Palace/Draw" value="15.00" dp3="15.000" us="14" id="47699041450113473"/>
                                  <odd name="Draw/Crystal Palace" value="5.80" dp3="5.800" us="48" id="47699041450113474"/>
                                  <odd name="Draw/Watford" value="6.00" dp3="6.000" us="50" id="47699041450122257"/>
                                  <odd name="Watford/Draw" value="15.00" dp3="15.000" us="14" id="47699041450122259"/>
                                  <odd name="Watford/Watford" value="4.20" dp3="4.200" us="32" id="47699041450122260"/>
                                  <odd name="Crystal Palace/Watford" value="29.00" dp3="29.000" us="28" id="476990414501259607"/>
                                  <odd name="Watford/Crystal Palace" value="29.00" dp3="29.000" us="28" id="476990414501259609"/>
                              </bookmaker>
                          </type>
                          <type value="Both Teams to Score" id="25">
                              <bookmaker name="188Bet" id="56">
                                  <odd name="No" value="1.93" dp3="1.930" us="-107" id="47699042516112427"/>
                                  <odd name="Yes" value="1.84" dp3="1.840" us="-119" id="47699042516112428"/>
                              </bookmaker>
                              <bookmaker name="Betfair" id="21">
                                  <odd name="No" value="1.93" dp3="1.930" us="-107" id="4769904252112427"/>
                                  <odd name="Yes" value="1.80" dp3="1.800" us="-125" id="4769904252112428"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="No" value="1.92" dp3="1.920" us="-109" id="4769904258212427"/>
                                  <odd name="Yes" value="1.81" dp3="1.810" us="-123" id="4769904258212428"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="No" value="1.85" dp3="1.850" us="-118" id="4769904255012427"/>
                                  <odd name="Yes" value="1.85" dp3="1.850" us="-118" id="4769904255012428"/>
                              </bookmaker>
                          </type>
                          <type value="Double Chance" id="30">
                              <bookmaker name="MyBet" id="41">
                                  <odd name="1X" value="1.45" dp3="1.450" us="-222" id="47699043019211620"/>
                                  <odd name="X2" value="1.45" dp3="1.450" us="-222" id="47699043019221621"/>
                                  <odd name="12" value="1.25" dp3="1.250" us="-400" id="47699043019231622"/>
                              </bookmaker>
                              <bookmaker name="Tipico" id="70">
                                  <odd name="1X" value="1.01" dp3="1.010" us="-214" id="47699043019011620"/>
                                  <odd name="X2" value="1.45" dp3="1.450" us="-222" id="47699043019021621"/>
                                  <odd name="12" value="1.01" dp3="1.010" us="-214" id="47699043019031622"/>
                              </bookmaker>
                              <bookmaker name="WinLineBet" id="243">
                                  <odd name="1X" value="1.42" dp3="1.420" us="-238" id="47699043024311620"/>
                                  <odd name="X2" value="1.44" dp3="1.440" us="-227" id="47699043024321621"/>
                                  <odd name="12" value="1.32" dp3="1.320" us="-312" id="47699043024331622"/>
                              </bookmaker>
                          </type>
                          <type value="Team To Score First" id="33">
                              <bookmaker name="Coral" id="5">
                                  <odd name="1" value="2.05" dp3="2.050" us="10" id="476990433511523"/>
                                  <odd name="2" value="2.05" dp3="2.050" us="10" id="476990433531524"/>
                                  <odd name="X" value="8.50" dp3="8.500" us="75" id="476990433521525"/>
                              </bookmaker>
                              <bookmaker name="MyBet" id="41">
                                  <odd name="1" value="1.95" dp3="1.950" us="-105" id="47699043319211523"/>
                                  <odd name="2" value="1.95" dp3="1.950" us="-105" id="47699043319231524"/>
                                  <odd name="X" value="7.00" dp3="7.000" us="60" id="47699043319221525"/>
                              </bookmaker>
                              <bookmaker name="Tipico" id="70">
                                  <odd name="1" value="2.10" dp3="2.100" us="11" id="47699043319011523"/>
                                  <odd name="2" value="1.90" dp3="1.900" us="-111" id="47699043319031524"/>
                                  <odd name="X" value="8.00" dp3="8.000" us="70" id="47699043319021525"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="2.05" dp3="2.050" us="10" id="4769904335011523"/>
                                  <odd name="2" value="1.95" dp3="1.950" us="-105" id="4769904335031524"/>
                                  <odd name="X" value="8.00" dp3="8.000" us="70" id="4769904335021525"/>
                              </bookmaker>
                          </type>
                          <type value="Team To Score Last" id="34">
                              <bookmaker name="10Bet" id="14">
                                  <odd name="1" value="1.95" dp3="1.952" us="-105" id="47699043410711523"/>
                                  <odd name="2" value="1.95" dp3="1.952" us="-105" id="47699043410731524"/>
                                  <odd name="X" value="8.50" dp3="8.500" us="75" id="47699043410721525"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="2.05" dp3="2.050" us="10" id="4769904345011523"/>
                                  <odd name="2" value="1.95" dp3="1.950" us="-105" id="4769904345031524"/>
                                  <odd name="X" value="8.00" dp3="8.000" us="70" id="4769904345021525"/>
                              </bookmaker>
                          </type>
                          <type value="3Way Result 2nd Half" id="55">
                              <bookmaker name="Unibet" id="82">
                                  <odd name="1" value="3.00" dp3="3.000" us="20" id="4769904558211523"/>
                                  <odd name="2" value="2.95" dp3="2.950" us="19" id="4769904558231524"/>
                                  <odd name="X" value="2.32" dp3="2.320" us="13" id="4769904558221525"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1" value="3.00" dp3="3.000" us="20" id="4769904555011523"/>
                                  <odd name="2" value="3.00" dp3="3.000" us="20" id="4769904555031524"/>
                                  <odd name="X" value="2.20" dp3="2.200" us="12" id="4769904555021525"/>
                              </bookmaker>
                          </type>
                          <type value="3Way Handicap" id="79">
                              <bookmaker name="Coral" id="5">
                                  <odd name="1 : -1.0" value="6.00" dp3="6.000" us="50" id="476990479511532"/>
                                  <odd name="2 : +1.0" value="1.50" dp3="1.500" us="-200" id="476990479521533"/>
                                  <odd name="1 : +1.0" value="1.50" dp3="1.500" us="-200" id="476990479511548"/>
                                  <odd name="2 : -1.0" value="6.00" dp3="6.000" us="50" id="476990479521549"/>
                                  <odd name="1 : +2.0" value="1.13" dp3="1.130" us="-769" id="476990479511556"/>
                                  <odd name="2 : -2.0" value="17.00" dp3="17.000" us="16" id="476990479521557"/>
                                  <odd name="1 : +3.0" value="1.04" dp3="1.040" us="-250" id="476990479511558"/>
                                  <odd name="2 : -3.0" value="56.00" dp3="56.000" us="55" id="476990479521559"/>
                                  <odd name="1 : -2.0" value="17.00" dp3="17.000" us="16" id="476990479511606"/>
                                  <odd name="2 : +2.0" value="1.13" dp3="1.130" us="-769" id="476990479521607"/>
                                  <odd name="1 : -3.0" value="56.00" dp3="56.000" us="55" id="476990479511608"/>
                                  <odd name="2 : +3.0" value="1.04" dp3="1.040" us="-250" id="476990479521609"/>
                                  <odd name="1 : -4.0" value="151.00" dp3="151.000" us="15" id="476990479511633"/>
                                  <odd name="2 : +4.0" value="1.01" dp3="1.010" us="-214" id="476990479521634"/>
                                  <odd name="2 : -4.0" value="151.00" dp3="151.000" us="15" id="476990479521745"/>
                                  <odd name="1 : +4.0" value="1.01" dp3="1.010" us="-214" id="476990479511748"/>
                                  <odd name="X : -3.0" value="23.00" dp3="23.000" us="22" id="4769904795342364"/>
                                  <odd name="X : -2.0" value="8.50" dp3="8.500" us="75" id="4769904795342365"/>
                                  <odd name="X : -1.0" value="4.25" dp3="4.250" us="32" id="4769904795342366"/>
                                  <odd name="X : +1.0" value="4.25" dp3="4.250" us="32" id="4769904795342367"/>
                                  <odd name="X : +2.0" value="8.50" dp3="8.500" us="75" id="4769904795342368"/>
                                  <odd name="X : +3.0" value="23.00" dp3="23.000" us="22" id="4769904795342369"/>
                                  <odd name="X : -4.0" value="67.00" dp3="67.000" us="66" id="4769904795342370"/>
                                  <odd name="X : +4.0" value="67.00" dp3="67.000" us="66" id="4769904795342372"/>
                              </bookmaker>
                              <bookmaker name="MyBet" id="41">
                                  <odd name="1 : -1.0" value="5.35" dp3="5.350" us="43" id="47699047919211532"/>
                                  <odd name="2 : +1.0" value="1.45" dp3="1.450" us="-222" id="47699047919221533"/>
                                  <odd name="X : -1.0" value="4.10" dp3="4.100" us="31" id="476990479192342366"/>
                              </bookmaker>
                              <bookmaker name="Unibet" id="82">
                                  <odd name="1 : -1.0" value="5.60" dp3="5.600" us="46" id="4769904798211532"/>
                                  <odd name="2 : +1.0" value="1.38" dp3="1.380" us="-263" id="4769904798221533"/>
                                  <odd name="1 : +1.0" value="1.40" dp3="1.400" us="-250" id="4769904798211548"/>
                                  <odd name="2 : -1.0" value="5.75" dp3="5.750" us="47" id="4769904798221549"/>
                                  <odd name="1 : +2.0" value="1.09" dp3="1.090" us="-111" id="4769904798211556"/>
                                  <odd name="2 : -2.0" value="15.00" dp3="15.000" us="14" id="4769904798221557"/>
                                  <odd name="1 : -2.0" value="14.00" dp3="14.000" us="13" id="4769904798211606"/>
                                  <odd name="2 : +2.0" value="1.10" dp3="1.100" us="-100" id="4769904798221607"/>
                                  <odd name="X : -2.0" value="8.00" dp3="8.000" us="70" id="47699047982342365"/>
                                  <odd name="X : -1.0" value="4.35" dp3="4.350" us="33" id="47699047982342366"/>
                                  <odd name="X : +1.0" value="4.20" dp3="4.200" us="32" id="47699047982342367"/>
                                  <odd name="X : +2.0" value="8.00" dp3="8.000" us="70" id="47699047982342368"/>
                              </bookmaker>
                              <bookmaker name="William Hill" id="15">
                                  <odd name="1 : -1.0" value="5.50" dp3="5.500" us="45" id="4769904795011532"/>
                                  <odd name="2 : +1.0" value="1.40" dp3="1.400" us="-250" id="4769904795021533"/>
                                  <odd name="1 : +1.0" value="1.40" dp3="1.400" us="-250" id="4769904795011548"/>
                                  <odd name="2 : -1.0" value="5.50" dp3="5.500" us="45" id="4769904795021549"/>
                                  <odd name="1 : +2.0" value="1.08" dp3="1.080" us="-125" id="4769904795011556"/>
                                  <odd name="2 : -2.0" value="13.00" dp3="13.000" us="12" id="4769904795021557"/>
                                  <odd name="1 : +3.0" value="1.02" dp3="1.020" us="-500" id="4769904795011558"/>
                                  <odd name="2 : -3.0" value="26.00" dp3="26.000" us="25" id="4769904795021559"/>
                                  <odd name="1 : -2.0" value="13.00" dp3="13.000" us="12" id="4769904795011606"/>
                                  <odd name="2 : +2.0" value="1.08" dp3="1.080" us="-125" id="4769904795021607"/>
                                  <odd name="1 : -3.0" value="23.00" dp3="23.000" us="22" id="4769904795011608"/>
                                  <odd name="2 : +3.0" value="1.02" dp3="1.020" us="-500" id="4769904795021609"/>
                                  <odd name="X : -3.0" value="15.00" dp3="15.000" us="14" id="47699047950342364"/>
                                  <odd name="X : -2.0" value="8.00" dp3="8.000" us="70" id="47699047950342365"/>
                                  <odd name="X : -1.0" value="4.33" dp3="4.330" us="33" id="47699047950342366"/>
                                  <odd name="X : +1.0" value="4.33" dp3="4.330" us="33" id="47699047950342367"/>
                                  <odd name="X : +2.0" value="8.00" dp3="8.000" us="70" id="47699047950342368"/>
                                  <odd name="X : +3.0" value="15.00" dp3="15.000" us="14" id="47699047950342369"/>
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
