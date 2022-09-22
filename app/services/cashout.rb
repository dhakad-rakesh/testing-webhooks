class Cashout
  def initialize(args = {})
    @user = args[:user]
    @bets = args[:bets]
    @combo = args[:combo]
    @status = true
    @failed_bets = []
  end

  def call
    Bet.transaction do
      @bets.each do |bet_param|
        bet = cashout_bet(bet_param)
        @failed_bets << generate_failed_bet_data(bet_param, bet) if bet.nil? || bet.errors.present?
      end
      @status = cashout_combo_bet if (@status && @combo)
    end
    [@status, @failed_bets]
  end

  private

  def cashout_bet(bet_param)
    bet = @user.bets.find_by(id: bet_param[:id].to_i)
    return if bet.blank?
    # Set cashout odd to passed odd for cashout or to initial odd of the bet if bet's market or outcome is inactive
    # cashout_odd = bet_param[:cashout_odd].present? ? bet_param[:cashout_odd].to_f : bet.odds.to_f
    cashout_odd = bet_param[:cashout_odd]
    result = Betting::Cashout.run(bet: bet, cashout_odd: cashout_odd) unless @combo
    result = Betting::ComboCashout.run(bet: bet, cashout_odd: cashout_odd) if @combo
    result
  end

  def generate_failed_bet_data(param, object)
    @status = false
    error = object.present? ? object.errors.full_messages : I18n.t('bets.not_found')
    [params: param, errors: error]
  end

  def cashout_combo_bet
    begin
      ActiveRecord::Base.transaction do
        c_amount = cashout_amount
        @combo.cashout_amount = c_amount
        @user.current_wallet.credit(c_amount)
        @combo.status = 'cashed_out'
        after_combo_cashout(@combo, c_amount) if @combo.save
      end
    rescue Exception => e
      @failed_bets << [{errors: [e.message]}]
      return false
    end
    true
  end

  def cashout_amount
    CashoutService.payout_value(@combo, cashout_odd)
  end

  def cashout_odd
    c_odds = @combo.bets.map{|b| (b.current_odds || b.odds).to_f }
    c_odds.reject(&:zero?).inject(:*) 
  end

  def after_combo_cashout(combo, co_amount)
    combo.update_betting_bonus!
    Ledgers::GenerateBetLedgers.new(ledger_params(combo, co_amount)).call
    # BetsNotifyMailer.with(combo_id: @combo.id).cashed_out_combo_bet.deliver_later
  end

  def ledger_params(combo, co_amount)
    remark = "Cashed out Combo bet ##{combo.id} with #{combo.stake}"
    { wallet: @user.current_wallet, transaction_type: :credit, amount: co_amount,
      remark: remark, betable: combo, status: Ledger::STATUSES["succeeded"]}
  end
end
