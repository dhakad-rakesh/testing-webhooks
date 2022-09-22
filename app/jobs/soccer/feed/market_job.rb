module Soccer
  module Feed
    class MarketJob < ApplicationJob
      queue_as :market_list_job

      def perform(market_data)
        ActiveRecord::Base.transaction do
          market = Utility::Cache.fetch_object_by_uid(::Market, market_data[:id]) || Market.new(uid: market_data[:id])
          assign_attributes(market, market_data).save! if market.new_record?
          if outcomes(market_data).present?
            outcomes(market_data).each do |outcome_data|
              outcome = process_outcome_data(outcome_data, market)
              market_outcomes = Utility::Cache.load_outcomes_for_market(market)
              market.outcomes << outcome unless market_outcomes.include?(outcome)
            end
          end
        end
      end

      private

      def process_outcome_data(outcome_data, market)
        outcome = Utility::Cache.fetch_object_by_uid(::Outcome, outcome_data[:id]) ||
                  Outcome.new(uid: outcome_data[:id])
        outcome.name = outcome_data[:name]
        begin
          if outcome.new_record?
            outcome.save!
            market.touch # rubocop:disable Rails/SkipsModelValidations
          end
        rescue ::StandardError => exception
          custom_error_logger(exception)
        end
        outcome
      end

      def custom_error_logger(exception)
        Honeybadger.notify(
          "[MarketJob] : [#{exception.class}] : [#{exception.cause}]",
          class_name: exception.class
        )
      end

      def outcomes(market_data)
        [market_data.dig(:outcomes, :outcome)].compact.flatten
      end

      def period_and_name(market_name)
        market_name.include?('-') ? market_name.split(' - ') : ['all', market_name]
      end

      def assign_attributes(market, market_data)
        market.name = market_data[:name]
        market.period, market.display_name = period_and_name(market.name)
        market.specifier_text = Utility::MarketUtility.fetch_specifier_text(market_data)
        market
      end
    end
  end
end
