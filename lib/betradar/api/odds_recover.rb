module Api
  module OddsRecover
    # Request recovery since after timestamp
    # Do recovery of odds and stateful messages over the feed. Subscribes client to feed messages.
    def recovery_after_timestamp(after, product = 'pre', request_id = -1)
      post("#{product}/recovery/initiate_request?after=#{after}&request_id=#{request_id}")
    end

    # Request full odds recovery
    # Do recovery of odds over the feed. Subscribes client to feed messages.
    def full_odds_recovery(product = 'pre', request_id = -1)
      post("#{product}/recovery/initiate_request?request_id=#{request_id}")
    end

    # Recover sport event
    # Request to resend all odds for all markets for a sport event.
    def event_odds(event_id, event_type = 'sr:match', product = 'pre', request_id = -1)
      post("#{product}/odds/events/#{event_type}:#{event_id}/initiate_request?request_id=#{request_id}")
    end

    # Recover stateful-messages for a sport event
    # Request to resend all stateful-messages (BetSettlement, RollbackBetSettlement, BetCancel, UndoBetCancel)
    # for a sport event.
    def stateful_messages(event_id, event_type = 'sr:match', product = 'pre', request_id = -1)
      post("#{product}/stateful_messages/events/#{event_type}:#{event_id}/initiate_request?request_id=#{request_id}")
    end
  end
end
