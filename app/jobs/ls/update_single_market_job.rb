module LS
  class UpdateSingleMarketJob
    include Sidekiq::Worker
    include RedisMutex::Macro
    
    # Retries job after failure
    auto_mutex :perform, on: [:unique_id], block: 10, after_failure: lambda { Rails.cache.write('failure_count', Rails.cache.read('failure_count') + 1 ) }
    sidekiq_options queue: 'update_single_market'

    attr_accessor :data, :old_data, :match_uid

    def perform(match_uid, market_uid, data, unique_id)
      Rails.logger.info "Started updating match: #{match_uid} market: #{market_uid}"
      # @match = Match.find_by(uid: match_uid)
      # return if @match.blank?
      @match_uid = match_uid
      @data = data.with_indifferent_access
      @old_data = odd_store.get_market(market_uid) || {}
      store_data_in_cache(market_uid)
      Rails.logger.info "Finished updating match: #{match_uid} market: #{market_uid}"
    end

    private

    def store_data_in_cache(market_uid)
      @new_data = @data
      process_data(market_uid) if @old_data.present?
      odd_store.set_market(market_uid, @new_data)
    end

    def process_data(market_uid)
      old_outcomes = @old_data['49'][:outcomes].keys
      new_outcomes = @data['49'][:outcomes].keys
      existing_outcomes = old_outcomes & new_outcomes
      process_outcomes(existing_outcomes, market_uid)
      # @data['49'][:outcomes].merge!(@old_data['49'][:outcomes])
      @new_data = @old_data.deep_merge(@data)
    end

    def process_outcomes(existing_outcome_ids, market_id)
      existing_outcome_ids.each do |id|
        last_update = @old_data['49'][:outcomes][id][:last_update]
        current_update = @data['49'][:outcomes][id][:last_update]
        next if current_update.blank? || last_update.blank?
        # Do not update if old update is received
        if last_update.to_time > current_update.to_time
          @data['49'][:outcomes][id] = @old_data['49'][:outcomes][id]
        end
      end
    end

    def odd_store
      @odd_store ||= OddStore.new(match_uid)
    end
  end
end