class ConfirmHoldBet < BetProcess
  include Utility::HoldBet

  def initialize(args = {})
    @user = args[:user]
    @bet_ids = args[:bets_params].map { |bet_id| bet_id[:id] }
    @status = true
    @failed_bets = []
  end

  def call
    @bets = @user.bets.hold.where(id: @bet_ids).compact
    return([false, I18n.t('hold.invalid')]) if @bets.blank?
    Bet.transaction do
      @bets.compact.each do |bet|
        process_bet(bet, bet_parameters(bet))
      end
    end
    [@status, @failed_bets]
  end

  private

  def bet_valid?(bet, bet_params)
    return false if bet.accumulator_bet.blank? && bet.wallet.available_amount < bet.stake
    @data = Utility::MarketUtility.odds_data(bet_params[:match_id])
    return false if @data.blank?
    @market_data = @data[
      Market.player_market_ids.include?(bet_params[:market_id]) ? :player_markets : :markets
    ].dig(bet_params[:market_id], bet_params[:identifier])
    return false if @market_data.blank?
    @outcome_data = @market_data.dig(:outcomes, bet_params[:outcome].id)
    return false if @outcome_data.blank?
    @market_data[:status] == '1' && @outcome_data[:status] == '1'
  end

  def place_bet(bet, bet_params)
    bet.status = :pending
    bet.odds = @outcome_data.dig(:odds)
    is_traditional_bet = bet.accumulator_bet.blank?
    bet.wallet.debit(bet.stake) if is_traditional_bet
    return unless bet.save
    return unless is_traditional_bet
    # BetsNotifyMailer.with(bet_id: bet.id).placed.deliver_later
    after_process_bet(bet, bet_params)
  end

  def process_bet(bet, bet_params)
    bet_valid?(bet, bet_params) ? place_bet(bet, bet_params) : process_failed_bet(bet)
  end

  def process_failed_bet(bet)
    @status = false
    @failed_bets << bet
  end

  def bet_parameters(object)
    {
      market_id: object.market_id,
      match_id: object.match_id,
      outcome: object.outcome,
      stake: object.stake,
      identifier: object.identifier,
      user: @user
    }
  end
end
