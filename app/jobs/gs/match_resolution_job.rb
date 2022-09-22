module GS
  class MatchResolutionJob < ApplicationJob
    queue_as :result_process

    def perform(match_data, match_id)
 #      {:success=>1,
 # :results=>
 #  {:"0"=>
 #    {:id=>"1668780",
 #     :sport_id=>"1",
 #     :time=>"1561575617",
 #     :time_status=>"3",
 #     :league=>{:id=>"450", :name=>"Brazil U20 League", :cc=>"br"},
 #     :home=>{:id=>"65476", :name=>"Vitoria BA U20", :image_id=>"41825", :cc=>"br"},
 #     :o_home=>{:id=>"55537", :name=>"Vitoria U20", :image_id=>"41825", :cc=>"br"},
 #     :away=>{:id=>"9093", :name=>"Santos U20", :image_id=>"188143", :cc=>"br"},
 #     :ss=>"2-2",
 #     :scores=>{:"1"=>{:home=>"1", :away=>"0"}, :"2"=>{:home=>"2", :away=>"2"}},
 #     :stats=>
 #      {:attacks=>{:"0"=>"56", :"1"=>"51"},
 #       :corners=>{:"0"=>"6", :"1"=>"4"},
 #       :corner_f=>{:"0"=>"6", :"1"=>"4"},
 #       :corner_h=>{:"0"=>"3", :"1"=>"2"},
 #       :dangerous_attacks=>{:"0"=>"32", :"1"=>"29"},
 #       :goals=>{:"0"=>"2", :"1"=>"2"},
 #       :off_target=>{:"0"=>"5", :"1"=>"4"},
 #       :on_target=>{:"0"=>"8", :"1"=>"7"},
 #       :penalties=>{:"0"=>"1", :"1"=>"0"},
 #       :possession_rt=>{:"0"=>"50", :"1"=>"50"},
 #       :redcards=>{:"0"=>"0", :"1"=>"1"},
 #       :substitutions=>{:"0"=>"0", :"1"=>"0"},
 #       :yellowcards=>{:"0"=>"2", :"1"=>"3"}},
 #     :extra=>{:length=>"90", :home_pos=>"2", :away_pos=>"2", :round=>"1"},
 #     :has_lineup=>0,
 #     :events=>
 #      {:"0"=>{:id=>"54592266", :text=>"19' - 1st Yellow Card -  (Santos U20)"},
 #       :"1"=>{:id=>"54592309", :text=>"22' - 1st Corner - Vitoria U20"},
 #       :"2"=>{:id=>"54592342", :text=>"25' - 2nd Corner - Vitoria U20"},
 #       :"3"=>{:id=>"54592377", :text=>"27' - 3rd Corner - Santos U20"},
 #       :"4"=>{:id=>"54592483", :text=>"33' - 4th Corner - Vitoria U20"},
 #       :"5"=>{:id=>"54592484", :text=>"33' - Race to 3 Corners - Vitoria U20"},
 #       :"6"=>{:id=>"54592513", :text=>"35' - 5th Corner - Santos U20"},
 #       :"7"=>{:id=>"54592617", :text=>"42' - 1st Goal -   (Vitoria U20) -"},
 #       :"8"=>{:id=>"54592696", :text=>"Score After First Half - 1-0"},
 #       :"9"=>{:id=>"54592975", :text=>"55' - 2nd Yellow Card -  (Santos U20)"},
 #       :"10"=>{:id=>"54592993", :text=>"57' - 3rd Yellow Card -  (Vitoria U20)"},
 #       :"11"=>{:id=>"54593008", :text=>"59' - 6th Corner - Santos U20"},
 #       :"12"=>{:id=>"54593017", :text=>"59' - 7th Corner - Santos U20"},
 #       :"13"=>{:id=>"54593028", :text=>"61' - 1st Red Card -  (Santos U20)"},
 #       :"14"=>{:id=>"54593029", :text=>"62' - 4th Yellow Card -  (Santos U20)"},
 #       :"15"=>{:id=>"54593033", :text=>"62' - 5th Yellow Card -  (Vitoria U20)"},
 #       :"16"=>{:id=>"54593057", :text=>"65' - 2nd Goal -   (Santos U20) -"},
 #       :"17"=>{:id=>"54593100", :text=>"70' - 8th Corner - Vitoria U20"},
 #       :"18"=>{:id=>"54593124", :text=>"72' - 9th Corner - Vitoria U20"},
 #       :"19"=>{:id=>"54593125", :text=>"72' - Race to 5 Corners - Vitoria U20"},
 #       :"20"=>{:id=>"54593163", :text=>"76' - 10th Corner - Vitoria U20"},
 #       :"21"=>{:id=>"54593273", :text=>"90+2' - 3rd Goal -   (Santos U20) -"},
 #       :"22"=>{:id=>"54593300", :text=>"90+6' - 4th Goal -   (Vitoria U20) -"},
 #       :"23"=>{:id=>"54593305", :text=>"Score After Full Time - 2-2"}},
 #     :inplay_created_at=>"1561575110",
 #     :inplay_updated_at=>"1561582415",
 #     :confirmed_at=>"1561577653"}}}
        # begin
          match = Match.find_by_id match_id
          #loop mraket through pending bets
          match.markets.uniq.each do |market|
            if Constants::SPECIFIRE_MARKETS.include?(market.uid)
              market.outcomes.each do |outcome|
                bets = match.bets.where(market_id: market.id, status: Bet::statuses['pending'], outcome_id: outcome.id)
                bets_data = bets.group_by(&:specifier_text)
                bets_data.each do |specifier_text, bets|
                  result = GS::ResolveMarket.new(match: match, market: market).resolve(match_data, specifier_text)
                  void_factor = result == 'void' ? 1 : 0 # result: 0, void_factor: 1
                  Betting::DirectBetResult.run(
                    data: { match: match, market: market, specifiers: specifier_text, bets: bets,
                            result: market.outcome_result(result, outcome.name), void_factor: void_factor }
                  ) if result.present?
                end if bets.present?
              end
            else
              result = GS::ResolveMarket.new(match: match, market: market).resolve(match_data)
              next if result.blank?
              void_factor = result == 'void' ? 1 : 0
              market.outcomes.each do |outcome|
                bets = match.bets.where(market_id: market.id, status: Bet::statuses['pending'], outcome_id: outcome.id)
                Betting::DirectBetResult.run(
                  data: { match_uid: match.uid, market: market, result: market.outcome_result(result, outcome.name),
                          void_factor: void_factor, bets: bets }
                ) if bets.present?
              end if result.present?
            end
          end
          match.update_columns(status: "resolved", actual_status: "resolved")
        # rescue ::StandardError => exception
        #   Honeybadger.notify(
        #     "[Process MatchResolutionJob] : [#{exception.class}] : [#{exception.cause}]",
        #     class_name: exception.class
        #   )
        #   NotificationMailer.feed_result_job("#{exception.class} :: #{exception.message}", match_id,  exception.backtrace.split(",")).deliver_later  
        # end
      end
    end
end