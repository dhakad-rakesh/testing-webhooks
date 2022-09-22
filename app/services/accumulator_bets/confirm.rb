module AccumulatorBets
  class Confirm < ::ConfirmHoldBet
    def initialize(args = {})
      @user = args[:user]
      @bet_params = args[:bets_params]
      @bet_stakes = @bet_params.map { |bet| { bet[:id] => bet[:stake] } }.inject(:merge)
      @bet_ids = @bet_stakes.keys
      @status = true
      @failed_bets = []
    end

    def call
      @bets = @user.accumulator_bets.hold.where(id: @bet_ids).includes(:bets)
      return([false, I18n.t('accumulator_bets.invalid')]) if @bets.blank?
      # Removing pre check for balance as now we will use different wallets
      # return([false, I18n.t('wallet.not_enough_amount')]) if
      # @bet_params.sum { |bet_param| bet_param[:stake].to_i } > @user.point_wallet.available_amount
      @bets.each do |accumulator_bet|
        AccumulatorBet.transaction do
          bet = process_accumulator_bet(accumulator_bet, @bet_stakes[accumulator_bet.id].to_i)
          if bet.is_a?(AccumulatorBet)
            after_process_accumulator_bet(accumulator_bet)
          elsif bet.is_a?(Bet)
            after_process_bet(bet, {})
          end
        end
      end
      [@status, @failed_bets]
    end

    private

    def process_single_and_multiple_bets(bets, accumulator_bet, stake)
      if bets.size > 1
        accumulator_bet.update!(status: :pending, stake: stake)
      else
        bets&.first&.update!(accumulator_bet_id: nil, bet_type: :traditional, stake: stake)
        accumulator_bet.reload.destroy!
      end
      accumulator_bet.wallet.debit(stake)
      bets.size > 1 ? accumulator_bet : bets&.first
    end

    def process_accumulator_bet(accumulator_bet, stake)
      bets = accumulator_bet.bets
      if accumulator_not_eligible_for_confirmation?(bets, stake) || insufficient_balance?(accumulator_bet, stake)
        @status = false
        fail ActiveRecord::Rollback
      end
      bet_status = true
      bets.each do |bet|
        process_bet(bet, bet_parameters(bet))
        bet_status = false if bet.reload.hold?
      end
      unless bet_status
        @status = false
        fail ActiveRecord::Rollback
      end
      # If accumulator has only one bet then it is consider as traditional bets.
      return unless accumulator_bet.reload.bets.pluck(:status).uniq == ['pending']
      process_single_and_multiple_bets(bets, accumulator_bet, stake)
    end

    def insufficient_balance?(accumulator_bet, stake)
      accumulator_bet.wallet.available_amount < stake
    end

    def accumulator_not_eligible_for_confirmation?(accumulated_bets, stake)
      accumulated_bets.blank? || stake.blank? || stake <= 0
    end

    def after_process_accumulator_bet(accumulator_bet)
      Ledgers::GenerateBetLedgers.new(basic_params(accumulator_bet)).call
    end

    def basic_params(accumulator_bet)
      remark = "Debit of #{accumulator_bet.stake} for placing accumulator bet"
      { user: @user, wallet: accumulator_bet.wallet,
        betable: accumulator_bet, remark: remark }
    end
  end
end
