module GoalServe
  module Feed
    class SoccerLiveScore
      def call
        response
      end

      private

      def response
        '<?xml version="1.0" encoding="UTF-8"?>
          <scores sport="soccer">
           <category name="Europe: Champions League - Play Offs" gid="3858" id="1005" file_group="eurocups" iscup="False">
              <matches date="Feb 11" formatted_date="11.02.2019">
                 <match status="FT" timer="" date="Feb 12" formatted_date="12.02.2019" time="20:00" commentary_available="1005" venue="Stadio Olimpico" v="60" static_id="2565610" fix_id="3061092" id="3131457">
                    <localteam name="AS Roma" goals="2" id="11998" />
                    <visitorteam name="FC Porto" goals="1" id="14408" />
                    <events>
                       <event type="subst" minute="68" extra_min="" team="visitorteam" player="Adrian" result="" playerId="5272" assist="Y. Brahimi" assistid="39221" eventid="31314571" />
                       <event type="goal" minute="70" extra_min="" team="localteam" player="N. Zaniolo" result="[1 - 0]" playerId="471102" assist="E. Dzeko" assistid="20588" eventid="31314572" />
                       <event type="yellowcard" minute="74" extra_min="" team="visitorteam" player="H. Herrera" result="" playerId="85145" assist="Tripping" assistid="" eventid="31314573" />
                       <event type="subst" minute="76" extra_min="" team="visitorteam" player="Andre Pereira" result="" playerId="356459" assist="Fernando" assistid="234697" eventid="31314574" />
                       <event type="goal" minute="76" extra_min="" team="localteam" player="N. Zaniolo" result="[2 - 0]" playeroccer-Id="471102" assist="E. Dzeko" assistid="20588" eventid="31314575" />
                       <event type="goal" minute="79" extra_min="" team="visitorteam" player="Adrian" result="[2 - 1]" playerId="5272" assist="T. Soares" assistid="119308" eventid="31314576" />
                       <event type="subst" minute="83" extra_min="" team="localteam" player="S. N\'Zonzi" result="" playerId="47041" assist="L. Pellegrini" assistid="339273" eventid="31314577" />
                       <event type="subst" minute="84" extra_min="" team="visitorteam" player="Hernani" result="" playerId="166311" assist="Otavio" assistid="251491" eventid="31314578" />
                       <event type="subst" minute="87" extra_min="" team="localteam" player="D. Santon" result="" playerId="61131" assist="N. Zaniolo" assistid="471102" eventid="31314579" />
                       <event type="yellowcard" minute="88" extra_min="" team="localteam" player="S. El Shaarawy" result="" playerId="69323" assist="Tripping" assistid="" eventid="313145710" />
                       <event type="subst" minute="90" extra_min="" team="localteam" player="J. Kluivert" result="" playerId="426578" assist="S. El Shaarawy" assistid="69323" eventid="313145711" />
                    </events>
                    <ht score="[0-0]" />
                    <ft score="[2-1]" />
                 </match>
                 <match status="FT" timer="" date="Feb 12" formatted_date="12.02.2019" time="20:00" commentary_available="1005" venue="Old Trafford" v="60" static_id="2565604" fix_id="3061086" id="3131461">
                    <localteam name="Manchester Utd" goals="0" id="9260" />
                    <visitorteam name="Paris SG" goals="2" id="10061" />
                    <events>
                       <event type="yellowcard" minute="11" extra_min="" team="visitorteam" player="P. Kimpembe" result="" playerId="265372" assist="Roughing" assistid="" eventid="31314611" />
                       <event type="yellowcard" minute="19" extra_min="" team="visitorteam" player="J. Draxler" result="" playerId="170341" assist="Tripping" assistid="" eventid="31314612" />
                       <event type="yellowcard" minute="26" extra_min="" team="localteam" player="P. Pogba" result="" playerId="177208" assist="Tripping" assistid="" eventid="31314613" />
                       <event type="yellowcard" minute="30" extra_min="" team="localteam" player="A. Young" result="" playerId="2553" assist="Holding" assistid="" eventid="31314614" />
                       <event type="yellowcard" minute="34" extra_min="" team="visitorteam" player="J. Bernat" result="" playerId="204842" assist="Roughing" assistid="" eventid="31314615" />
                       <event type="subst" minute="45" extra_min="4" team="localteam" player="A. Sanchez" result="" playerId="4117" assist="J. Lingard" assistid="220119" eventid="31314616" />
                       <event type="subst" minute="46" extra_min="" team="localteam" player="J. Mata" result="" playerId="19106" assist="A. Martial" assistid="215647" eventid="31314617" />
                       <event type="yellowcard" minute="50" extra_min="" team="localteam" player="V. Lindelof" result="" playerId="127315" assist="Holding" assistid="" eventid="31314618" />
                       <event type="goal" minute="53" extra_min="" team="visitorteam" player="P. Kimpembe" result="[0 - 1]" playerId="265372" assist="A. Di Maria" assistid="16579" eventid="31314619" />
                       <event type="goal" minute="60" extra_min="" team="visitorteam" player="K. Mbappe" result="[0 - 2]" playerId="377149" assist="A. Di Maria" assistid="16579" eventid="313146110" />
                       <event type="yellowcard" minute="62" extra_min="" team="visitorteam" player="D. Alves" result="" playerId="3123" assist="Tripping" assistid="" eventid="313146111" />
                       <event type="subst" minute="75" extra_min="" team="visitorteam" player="L. Paredes" result="" playerId="163887" assist="M. Verratti" assistid="93388" eventid="313146112" />
                       <event type="subst" minute="81" extra_min="" team="visitorteam" player="C. Dagba" result="" playerId="419046" assist="A. Di Maria" assistid="16579" eventid="313146113" />
                       <event type="subst" minute="84" extra_min="" team="localteam" player="R. Lukaku" result="" playerId="79495" assist="M. Rashford" assistid="420221" eventid="313146114" />
                       <event type="yellowcard" minute="87" extra_min="" team="localteam" player="A. Herrera" result="" playerId="72451" assist="Tripping" assistid="" eventid="313146115" />
                       <event type="yellowred" minute="89" extra_min="" team="localteam" player="P. Pogba" result="" playerId="177208" assist="Roughing" assistid="" eventid="313146116" />
                       <event type="yellowcard" minute="90" extra_min="2" team="localteam" player="L. Shaw" result="" playerId="209805" assist="Roughing" assistid="" eventid="313146117" />
                    </events>
                    <ht score="[0-0]" />
                    <ft score="[0-2]" />
                 </match>
              </matches>
           </category>
        </scores>'
      end
    end
  end
end
