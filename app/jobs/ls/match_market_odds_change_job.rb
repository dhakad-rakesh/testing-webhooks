module LS
  class MatchMarketOddsChangeJob < BR::AMQP::MatchMarketOddsChangeJob

    def perform(data)
      @json_data = data
      @match = Match.find_by(uid: @json_data[:event_id])
      return if @match.blank?

      # update_match_and_score

      process_and_update_cache
    end

    private

    # It will create a new score object according to sport and will update
    # match status with the new status
    def update_match_and_score
      event_status = @json_data[:sport_event_status]
      ActiveRecord::Base.transaction do
        betting_status = event_status[:match_status] == "ended" ? '4' : '0'
        match_status = event_status[:match_status]
        @match.update(
          actual_status: match_status,
          status: match_status, #@match.load_gs_status(match_status)
          betting_status: betting_status
        )
      end
    end

    def process_and_update_cache
      update_cache(@json_data[:odds])
    end

    def update_cache(data)
      # data[:markets].present? ? @match.enable : @match.disable
      store_data_in_cache(data)
    end
  end
end
