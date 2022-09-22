module GS
  class LiveMatchMarketOddsChangeJob < BR::AMQP::MatchMarketOddsChangeJob
    queue_as :amqp_processes

    def perform(data)
      @json_data = data
      @match = Match.find_by(uid: @json_data[:event_id])
      return if @match.blank? || @match.betting_stopped? || @match.resolved?
      #return if invalid_gs_match_for_odds_change?(@match)
      #@routing_key = routing_key
      # Update match score has update of score and match status update
      update_match_and_score
      #update_match_status unless match_ended?
      #if @match.betting_stopped?
        # resolve goal serve bets from here
        #settle_bets_for_match
        #close_concerned_markets
      #else
      process_and_update_cache
      #end
    end

    private

    # def update_match_status
    #   actual_status = @json_data.dig(:sport_event_status, :status)
    #   status = @match.load_gs_status(actual_status)
    #   betting_status = Utility::GS::MatchStatusUtility.load_status(status)
    #   match_status = Constants::MATCH_ENDED_STATUSES.include?(betting_status) ? :ended : @match.status
    #   @match.update(betting_status: betting_status, status: match_status)
    #   remove_bets_on_hold if Constants::MATCH_ENDED_STATUSES.include?(betting_status)
    # end

    # It will create a new score object according to sport and will update
    # match status with the new status
    def update_match_and_score
      event_status = @json_data[:sport_event_status]
      ActiveRecord::Base.transaction do
        if event_status[:match_status] == "ended"
          betting_status = '4'
          enabled = false
        else
          betting_status = '0'
          enabled = true
        end
        match_status = event_status[:match_status]
        updated_fields = { actual_status: match_status,
                           status: match_status,
                           enabled: enabled,
                           betting_status: betting_status,
                           score: @json_data[:score],
                           running_time: @json_data[:running_time] }

        updated_fields.each do |key, value|
          updated_fields.delete(key) if @match.send(key.to_s) == value
        end

        @match.update(updated_fields) if updated_fields.present?
      end
    end

    def process_and_update_cache
      update_cache(@json_data[:odds])
    end

    def update_cache(data)
      #data[:markets].present? ? @match.enable : @match.disable
      store_data_in_cache(data)
    end
  end
end
