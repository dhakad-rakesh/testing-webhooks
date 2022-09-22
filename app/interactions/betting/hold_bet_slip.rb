module Betting
  class HoldBetSlip < BetSlip
    symbol :status
    integer :betting_pool_id, default: nil

    set_callback :type_check, :before, :set_status_to_hold
    set_callback :type_check, :before, :validate_betting_pool_status
    set_callback :type_check, :before, :set_betting_pool_details

    # Skip validate_odds as when user will confirm bets then
    # the bet will be placed against the current odds.
    skip_callback(:type_check, :before, :validate_odds)

    def set_betting_pool_details
      self.betting_pool_id = betting_pool_id
    end

    def validate_betting_pool_status
      # TODO: Check if pool is opened for betting or closed
    end

    def set_status_to_hold
      self.status = :hold
    end
  end
end
