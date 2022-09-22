module LS
  class FormatOddsData < ApplicationInteraction
    object :match
    hash :data, strip: false, default: nil

    def execute
      format_markets(data['Markets'])
    end

  private

    def format_markets(markets)
      formatted_markets = {}
      markets.each do |market|
        next unless market['Providers'][0]['Name'] == 'Bet365'
        market_key = "market_#{market['Id']}"
        formatted_markets[market_key] = market.except('Providers').merge(
          outcomes: format_outcomes(market['Providers'][0]['Bets'])
        )
      end
      formatted_markets
    end

    def format_outcomes(outcomes)
      formatted_outcomes = {}
      outcomes.each do |outcome|
        outcome_key = "outcome_#{outcome['Id']}"
        formatted_outcomes[outcome_key] = outcome.except('Status').merge(
          'Status': map_status(outcome['Status'])
        )
      end
      formatted_outcomes
    end

    def map_status(status)
      Bet.ls_status(status)
    end
  end
end
