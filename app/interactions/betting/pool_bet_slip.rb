module Betting
  class PoolBetSlip < BetSlip
    integer :betting_pool_id

    set_callback :type_check, :before, :validate_betting_pool_status
    set_callback :type_check, :before, :set_betting_pool_details

    def set_betting_pool_details
      self.betting_pool_id = betting_pool_id
    end

    def validate_betting_pool_status
      # TODO: Check if pool is opened for betting or closed
    end
  end
end
