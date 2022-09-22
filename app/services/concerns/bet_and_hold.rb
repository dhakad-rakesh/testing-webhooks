module BetAndHold
  extend ActiveSupport::Concern

  # current_wallet will be wallet in case of public contest and traditional bets
  def current_wallet
    # currency_wallet
    @participant ? betting_pool_wallet : points_wallet
  end

  def betting_pool_wallet
    @participant.wallet
  end

  def points_wallet
    @points_wallet ||= @user.point_wallet
  end

  def currency_wallet
    @currency_wallet ||= @user.currency_wallet
  end

  # Set flag and return whole data and errors
  def generate_failed_bet_data(params, object)
    @status = false
    is_odds_error = odds_error?(object)
    { params: params, errors: object.errors.full_messages, odds_changed: is_odds_error }
  end

  # TODO: Don't do this... .
  def odds_error?(object)
    return false unless object.errors.count == 1
    object.errors.full_messages.include?(I18n.t(:invalid_odds))
  end

  def bet_slips_total_amount
    @bet_slips.map { |a| a[:stake].to_f }.sum
  end

  def valid_betslips_amount
    return @combo_bet_stake.to_f <= bet_wallet.wallet.available_amount if @bet_type == "combo"
    bet_slips_total_amount <= bet_wallet.wallet.available_amount
  end

  def generate_ledger(bet)
    current_wallet.ledgers.create!(bet: bet, amount: bet.stake, transaction_type: :debit)
  end
end
