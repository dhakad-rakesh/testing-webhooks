module AccumulatorBets
  # TODO: Refactor this to make code common with cashout for single bets
  class Cashout
    def initialize(args = {})
      @user = args[:user]
      @accumulator_bets = args[:accumulator_bets]
      @status = true
      @failed_bets = []
    end

    def call
      ActiveRecord::Base.transaction do
        @accumulator_bets.each do |accumulator_bet_param|
          accumulator_bet = cashout_accumulator_bet(accumulator_bet_param)
          if accumulator_bet.nil? || accumulator_bet.errors.present?
            @failed_bets << generate_failed_bet_data(accumulator_bet_param, accumulator_bet)
          end
        end
      end
      [@status, @failed_bets]
    end

    private

    def cashout_accumulator_bet(accumulator_bet_param)
      accumulator_bet = @user.accumulator_bets.find_by(id: accumulator_bet_param[:id].to_i)
      return if accumulator_bet.blank?
      Betting::AccumulatorBetCashout.run(
        accumulator_bet: accumulator_bet, cashout_odd: accumulator_bet_param[:cashout_odd].to_f
      )
    end

    def generate_failed_bet_data(param, object)
      @status = false
      error = object.present? ? object.errors.full_messages : I18n.t('accumulator_bets.not_found')
      [params: param, errors: error]
    end
  end
end
