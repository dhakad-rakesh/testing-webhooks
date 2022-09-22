module Betting
  class Cashout < ::Betting::Base
    object :bet
    float :cashout_odd

    set_callback :type_check, :before, :set_data
    set_callback :type_check, :before, :match_status
    set_callback :type_check, :before, :validate_bet_status
    # set_callback :type_check, :before, :validate_odds
    #set_callback :type_check, :before, :validate_market
    set_callback :type_check, :before, :validate_market_is_closed?

    def execute
      ActiveRecord::Base.transaction do
        bet.wallet.credit(@cashout_amount)
        bet.status = 'cashed_out'
        bet.cashed_out_amount = @cashout_amount
        after_bet_cashout(bet, @cashout_amount) if bet.save
      end
      bet
    end

    private

    def set_data
      @data = Utility::Cache.default_cache_market(bet.match_id)
      @market_data = @data.dig(:markets, bet.market_id, bet.identifier)
      if @market_data.present?
        @outcome_data = @market_data.dig(:outcomes, bet.outcome_id)
        @status = @market_data[:status] == '1' && @outcome_data[:status] == '1' if @outcome_data.present?
      end
      cashout_amount
      validate_cashout_amount(cashout_amount)
      add_data_not_found_error
    end

    def cashout_amount
      @cashout_amount = CashoutService.payout_value(bet, cashout_odd)
    end

    def add_data_not_found_error
      errors.add(:match, I18n.t(:no_data)) if @data.dig(:markets).nil?
    end

    # Check if bet is pending i.e. eligible for cashout
    def validate_bet_status
      return true if bet.pending?
      errors.add(:base, I18n.t(:cashout_not_eligible))
    end

    def validate_odds
      # Calculate current odds for a bet and set it to initial odd if bet is currently inactive
      current_odds = @status ? (@outcome_data || {}).dig(:odds)&.to_f : bet.odds.to_f
      return true if current_odds == cashout_odd
      errors.add(:match, I18n.t(:odds_changed))
    end

    # Generate ledger for cashout transaction and send mail to user for cashout
    def after_bet_cashout(bet, cashout_amount)
      Ledgers::GenerateBetLedgers.new(ledger_params(bet, cashout_amount)).call
      # BetsNotifyMailer.with(bet_id: bet.id).cashed_out.deliver_later
    end

    def ledger_params(bet, cashout_amount)
      remark = "Cashed out bet with #{bet.stake}"
      { wallet: bet.wallet, betable: bet, transaction_type: :credit, amount: cashout_amount,
        remark: remark, status: Ledger::STATUSES["succeeded"] }
    end

    def validate_cashout_amount(amount)
      errors.add(:base, I18n.t(:refund_not_cashoutable)) if amount < 0
    end

    def match_status
      # Stop cashout 10 minutes before the match ended
      return true if bet.cashoutable?
      errors.add(:base, I18n.t(:cashout_not_eligible))
    end

    def validate_market
      if bet.have_over_under_market? && bet.outcome.name == 'Over' && ((bet&.combo_bet&.odds || bet.odds.to_f) > 2.99)
        errors.add(:base, I18n.t(:no_cashout_available))
      end
    end

    def validate_market_is_closed?
      errors.add(:base, I18n.t(:cashout_not_allowed)) if cashout_odd.blank?
    end
  end
end
