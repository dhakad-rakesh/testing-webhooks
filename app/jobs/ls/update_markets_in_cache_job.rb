module LS
  class UpdateMarketsInCacheJob
    include Sidekiq::Worker

    attr_accessor :data, :old_data, :match

    def perform(match_uid, data)
      @match = Match.find_by(uid: match_uid)
      return if @match.blank?
      @data = data.with_indifferent_access
      @old_data = odds_store.odds_data
      store_data_in_cache
    end

    private

    # TODO: check if further optimized solution available for writing to cache
    def store_data_in_cache
      new_data = { markets: {} }
      existing_markets = old_data[:markets].keys & data[:markets].keys
      process_data(existing_markets) if filter_old_updates?
      new_data[:markets] = old_data[:markets].deep_merge(data[:markets])
      odds_store.odds_data = new_data
      write_to_persistent_layer(new_data)
    end

    def process_data(existing_market_ids)
      existing_market_ids.each do |market_id|
        old_outcomes = old_data[:markets][market_id]['49'][:outcomes].keys
        new_outcomes = data[:markets][market_id]['49'][:outcomes].keys
        existing_outcomes = old_outcomes & new_outcomes
        process_outcomes(existing_outcomes, market_id)
      end
    end

    def process_outcomes(existing_outcome_ids, market_id)
      existing_outcome_ids.each do |id|
        last_update = old_data[:markets][market_id]['49'][:outcomes][id][:last_update]
        current_update = data[:markets][market_id]['49'][:outcomes][id][:last_update]
        next if current_update.blank? || last_update.blank?
        # Do not update if old update is received
        if last_update.to_time > current_update.to_time
          update_rejection_count
          data[:markets][market_id]['49'][:outcomes].delete(id)
        end
      end
    end

    def update_rejection_count
      count = Rails.cache.fetch(:rejection_count) || 0
      Rails.cache.write(:rejection_count, count + 1)
    end

    def filter_old_updates?
      ENV.fetch('FILTER_OLD_UPDATES', "false") == "true"
    end

    def write_to_persistent_layer(data)
      return unless FeatureTogglers::WriteOddsToPersistentLayer::Toggler.activated?
      rational_time = Time.zone.now.to_r
      time_params = { numerator: rational_time.numerator, denominator: rational_time.denominator }
      Odds::WriteToPersistentLayerJob.perform_later(@match.id, data, time_params)
    end

    def odds_store
      @odds_store ||= OddStore.new(@match.id)
    end
  end
end
