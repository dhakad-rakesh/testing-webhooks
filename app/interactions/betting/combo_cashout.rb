module Betting
  class ComboCashout < ::Betting::Cashout
    def execute
      ActiveRecord::Base.transaction do
        bet.status = 'cashed_out'
        bet.save
      end
      bet
    end
  end
end
