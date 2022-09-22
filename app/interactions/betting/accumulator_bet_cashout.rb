module Betting
  class AccumulatorBetCashout < ::Betting::Base
    object :accumulator_bet
    float :cashout_odd

    set_callback :type_check, :before, :validate_cashout_eligibility
    set_callback :type_check, :before, :validate_odds

    def execute
      accumulator_bet.status = :cashed_out
      ActiveRecord::Base.transaction do
        wallet.credit(cashout_amount)
        accumulator_bet.cashed_out_amount = cashout_amount
        accumulator_bet.save!
        # Since we do not need validation and callbacks we are using update_all
        fail ActiveRecord::Rollback unless accumulator_bet.bets.update_all(status: :cashed_out) # rubocop:disable Rails/SkipsModelValidations
      end
      after_process_accumulator_bet(accumulator_bet)
      accumulator_bet
    end

    private

    def wallet
      @wallet ||= accumulator_bet.wallet
    end

    # Check if accumulator bet is pending i.e. eligible for cashout
    def validate_cashout_eligibility
      return true if accumulator_bet.eligible_for_cashout?
      errors.add(:bet, 'is not eligible for cashout.')
    end

    def cashout_amount
      @cashout_amount ||= CashoutService.cashout_value(accumulator_bet, cashout_odd).round(8)
    end

    def validate_odds
      return true unless cashout_odd < 1
      errors.add(:odds, 'not valid.')
    end

    def after_process_accumulator_bet(accumulator_bet)
      return unless accumulator_bet.is_a?(AccumulatorBet)
      Ledgers::GenerateBetLedgers.new(ledger_params(accumulator_bet)).call
    end

    def ledger_params(accumulator_bet)
      remark = "Credit of #{accumulator_bet.stake} for cashing out accumulator bet"
      { user: @user, wallet: accumulator_bet.wallet,
        betable: accumulator_bet, remark: remark, transaction_type: :credit }
    end
  end
end
