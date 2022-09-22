module LS
  class MatchResolutionJob < ApplicationJob
    queue_as :result_process

    def perform(fixture_id, markets)
      # null = ""
      # data = {"Header":{"Type":35,"MsgId":1,"MsgGuid":"957237cd-a350-4ea8-8df7-778893fcefd3","ServerTimestamp":1588159372},"Body":{"Events":[{"FixtureId":5365723,"Livescore":null,"Markets":[{"Id":5,"Name":"Odd/Even","Providers":[{"Id":8,"Name":"Bet365","LastUpdate":"2020-04-29T11:22:52.7429116Z","Bets":[{"Id":14314610315365723,"Name":"Even","Status":3,"StartPrice":"1.0","Price":"1.571","Settlement":2,"LastUpdate":"2020-04-29T11:22:52.7429116Z"},{"Id":17875963185365723,"Name":"Odd","Status":3,"StartPrice":"1.0","Price":"2.25","Settlement":1,"LastUpdate":"2020-04-29T11:22:52.7429116Z"}]}]}]}]}}
      match = Match.find_by uid: fixture_id

      resolve_bets(match, markets)

      # match.update_column(:status, 'resolved')
    end

    private

    def resolve_bets(match, markets)
      markets.each do |market|
        market[:Providers].each do |provider|
          next if provider[:Name] == 'BWin'

          provider[:Bets].each do |bet_outcome|
            bets = match.bets.where(outcome_id: bet_outcome[:Id])
            next if bets.blank? || market[:Id].to_s != bets.first.market.uid
            Betting::LS::DirectBetResult.run(
              data: { match: match, market: bets.first.market, specifiers: {}, bets: bets,
                      status: Bet.ls_settlement_status(bet_outcome[:Settlement]) }
            )
          end
        end
      end
    end
  end
end