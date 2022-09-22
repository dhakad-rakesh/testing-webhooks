module Soccer
  module Feed
    module GS
      class MarketJob < ApplicationJob
        queue_as :market_list_job

        def perform(market)
          _market = ::Soccer::Create::GS::Market.run!(market_params(market))
          return if _market.blank?
          outcomes = Array.wrap(market[:bookmaker][:odd])

          outcomes.each do |outcome|
            OutcomeJob.perform_later(outcome, _market)
          end
        end

        private

        def market_params(market)
          { name: market[:value], uid: market[:id] }
        end
      end
    end
  end
end
