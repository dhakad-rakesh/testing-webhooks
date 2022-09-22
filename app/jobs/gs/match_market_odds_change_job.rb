module GS
  class MatchMarketOddsChangeJob < BR::AMQP::MatchMarketOddsChangeJob

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
      data[:markets].present? ? @match.enable : @match.disable
      store_data_in_cache(data)
    end
  end
end
