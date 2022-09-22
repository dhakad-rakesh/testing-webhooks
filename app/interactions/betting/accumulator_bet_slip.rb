module Betting
  class AccumulatorBetSlip < HoldBetSlip
    integer :accumulator_bet_id

    set_callback :type_check, :before, :validate_accumulator
    set_callback :type_check, :before, :validate_accumulator_bets_count
    set_callback :type_check, :before, :set_accumulator_bet_details

    skip_callback(:type_check, :before, :validate_stake)

    def set_accumulator_bet_details
      self.accumulator_bet_id = accumulator_bet_id
      self.stake = nil
    end

    def validate_accumulator
      @accumulator_bet = user.accumulator_bets.find_by(id: accumulator_bet_id)
      errors.add(:accumulator, 'invalid') if @accumulator_bet.blank? || !@accumulator_bet.hold?
    end

    def validate_accumulator_bets_count
      errors.add(:accumulator, 'is already full') if @accumulator && @accumulator_bet.bets.count > 2
    end
  end
end
