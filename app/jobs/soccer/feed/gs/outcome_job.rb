module Soccer
  module Feed
    module GS
      class OutcomeJob < ApplicationJob
        queue_as :market_list_job

        def perform(outcome, market)
          ::Soccer::Create::GS::Outcome.run!(outcome_params(outcome)
                                       .merge(market: market))
        end

        private

        def outcome_params(outcome)
          { name: outcome[:name], uid: outcome[:id] }
        end
      end
    end
  end
end
