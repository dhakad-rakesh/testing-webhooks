module BR
  module AMQP
    class MatchMarketOddsChangeJob < ApplicationJob
      queue_as :odds_change
      include Betradar::MarketOddsUtil
      include Utility::JobUtility::BetStopUtility
      include Utility::JobUtility::PublishDataUtility
      include Utility::JobUtility::OutcomeGenerationUtility

      def perform(xml_data, routing_key)
        @json_data = xml_data.xml_to_hash[:odds_change]
        @match = routing_key.include?('match') &&
                 Match.find_by(uid: @json_data[:event_id])
        return if invalid_match_for_odds_change?(@match)
        @routing_key = routing_key
        remove_pre_log
        # Update match score has update of score and match status update
        @score = update_match_and_score
        update_match_status unless match_ended?
        if @match.betting_stopped?
          settle_bets_for_match
          close_concerned_markets
        else
          process_and_update_cache
        end
      end

      private

      def update_match_status
        betting_status = @json_data.dig(:sport_event_status, :status)
        match_status = Constants::MATCH_ENDED_STATUSES.include?(betting_status) ? :ended : @match.status
        @match.update(betting_status: betting_status, status: match_status)
        remove_bets_on_hold if Constants::MATCH_ENDED_STATUSES.include?(betting_status)
      end

      def match_ended?
        Constants::MATCH_ENDED_STATUSES.include?(@match.betting_status)
      end

      def settle_bets_for_match
        AmqpAuditLog.where(routing_type: :bet_settlement, event_id: @match.uid).each do |log|
          ::BR::AMQP::FeedResultJob.set(wait_until: Time.zone.now + 15.minutes).perform_later(log.xml_data)
        end
      end

      def process_and_update_cache
        filter_market_according_to_variants
        process_non_variant_markets
        process_variant_markets
      end

      def process_non_variant_markets
        update_cache(@non_variant_markets, false)
      end

      def process_variant_markets
        BR::AMQP::MatchVariantMarketOddsChangeJob.perform_later(
          @variant_markets,
          true,
          @match.id
        )
      end

      def update_cache(markets, variant)
        data = fetch_and_process_data(markets, variant)
        store_data_in_cache(data)
      end

      # filter markets according to their specifiers
      def filter_market_according_to_variants
        @variant_markets = []
        @non_variant_markets = []
        Array.wrap(@json_data.dig(:odds, :market)).compact.map do |data|
          if data[:specifiers]&.include?('variant')
            @variant_markets << data
          else
            @non_variant_markets << data
          end
        end
      end

      def close_concerned_markets
        if first_half_ended?
          publish_data(update_markets_status_half(@match, @match.actual_status), @match)
        else
          publish_data(update_markets_status(@match), @match)
        end
      end

      def first_half_ended?
        @match.actual_status == '31'
      end

      def remove_bets_on_hold
        @match&.bets&.hold&.destroy_all
      end

      def filter_markets(markets, variant)
        @markets_data, @all_markets = ::FilterMarkets.call(markets, match: @match, variant: variant)
      end

      # It will create a new score object according to sport and will update
      # match status with the new status
      def update_match_and_score
        return if (event_status = (@json_data[:sport_event_status] || {}).with_indifferent_access).blank?
        ActiveRecord::Base.transaction do
          match_status = event_status[:match_status]
          @match.update(
            actual_status: match_status,
            status: @match.load_status(match_status.to_i)
          )
          # return unless event_status[:status] != '0'
          # match_score = Score::MatchScore.run!(sport_event_status: event_status, match: @match)
          # { score: { home_score: match_score&.home_score, away_score: match_score&.away_score } }
        end
        # TODO: If match has started then call close_betting_pools method
      end

      def store_data_in_cache(data)
        old_data = OddStore.new(@match.uid).odds_data
        new_data = { markets: {} }
        # new_data[:markets] = data[:markets]#old_data[:markets].deep_merge(data[:markets])
        # Deep merge markets
        new_data[:markets] = old_data[:markets].deep_merge(data[:markets])
        if new_data[:markets].present?
          OddStore.new(@match.uid).odds_data = new_data
          publish_odd_updates(@match.uid, data) if prematch_updates_enabled?
        else
          OddStore.new(@match.uid).remove_odds_data
        end
      end

      def close_betting_pools
        pools = @match.betting_pools.where(last_match_id: @match.id)
        pools.update_all(status: :closed) # rubocop:disable Rails/SkipsModelValidations
      end

      def prematch_updates_enabled?
        FeatureTogglers::PrematchRealtimeUpdates::Toggler.activated?
      end
    end
  end
end
