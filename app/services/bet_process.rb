class BetProcess
  include Utility::BetProcess

  POST_PROCESS = [Ledgers::GenerateBetLedgers].freeze

  # args will always be 3 arguments bet_slips, competition (can be nil) and user
  def initialize(args = {})
    @user = args[:user]
    @bet_type = args[:bet_type]
    @combo_bet_stake = args[:combo_bet_stake]
    initialize_other_params(args)
  end

  def call
    # return([false, I18n.t('participant.not_found')]) if @betting_pool.present? && @participant.blank?
    return([false, I18n.t('wallets.not_enough_amount')]) unless valid_betslips_amount
    Bet.transaction do
      if @bet_type == "combo"
        @available_bonus = bet_wallet.wallet.betting_bonus
        combo_bet = @user.combo_bets.new(odds: fetch_combo_odds, stake: @combo_bet_stake, bonus_stake: bonus_amount(@combo_bet_stake)) 
        combo_bet.errors.add(:base, I18n.t('errors.messages.combo_bets.select_multiple_matches')) if any_duplicate_match_exist_in_bets?

        if any_duplicate_match_exist_in_bets? || !(combo_bet.save)
          @failed_bets = []
          @failed_bets << generate_failed_bet_data(@bet_slips, combo_bet)
          fail(ActiveRecord::Rollback)
        end
        bet_wallet.debit(@combo_bet_stake).save
      end
      @bet_slips.each do |bet_param|
        # process each bet, create transaction, change wallet data
        bet_param.merge!(combo_bet_id: combo_bet.id) if combo_bet.present?
        @available_bonus = bet_wallet.wallet.betting_bonus if combo_bet.blank?
        bet = process_bet(bet_param)
        after_process_bet(bet, bet_param) unless combo_bet.present?
      end
      # store changes in wallet and raise error if invalid bet present
      fail(ActiveRecord::Rollback) unless @status
      after_combo_bet_process(combo_bet, @bet_slips) if @bet_type == "combo"
      post_transaction_process
    end
    [@status, @failed_bets]
  end

  private

  def bet_wallet
    # TODO: Seperate logic for different types of competitions
    @bet_wallet ||=
      Wallets::Base.new(current_wallet)
  end

  def after_process_bet(bet, bet_param)
    return unless bet.is_a?(Bet)
    POST_PROCESS.each do |context|
      context.new(basic_params(bet).merge(bet_param: bet_param).merge(bonus_params(bet))).call
    end
    # BetsNotifyMailer.with(bet_id: bet.id).placed.deliver_later
  end

  def after_combo_bet_process(combo_bet, bet_param)
    combo_bet.update_bonus_stake
    combo_bet.update_betting_bonus!
    current_wallet.ledgers.create(arguments_of_bets(combo_bet, combo_bet.stake).merge(bonus_params(combo_bet)))
    ComboBetNotifyMailer.with(combo_bet_id: combo_bet.id).placed.deliver_later
  end

  def arguments_of_bets(combo_bet, amount)
    { betable: combo_bet, amount: amount, remark: get_remark(combo_bet.bets.first), transaction_type: :debit, status: Ledger::STATUSES["succeeded"] }
  end

  def bonus_params(bet)
    return {} if available_bonus.zero?
    
    { kind: Ledger::BONUS, bonus_amount: bonus_amount(bet.stake) }
  end

  def available_bonus
    @available_bonus ||= bet_wallet.wallet.betting_bonus
  end

  def bonus_amount(stake)
    stake.to_f <= available_bonus ? stake : available_bonus
  end

  def basic_params(bet)
    remark = get_remark(bet)
    { user: @user, wallet: bet.wallet,
      betable: bet, remark: remark, mode: Ledger::INTERNAL,
      status: Ledger::STATUSES["succeeded"] }
  end

  def combo_bet_params(combo_bet)
    remark = get_remark(combo_bet.bets.first)
    { user: @user, wallet: current_wallet,
      betable: combo_bet, remark: remark,
      mode: Ledger::INTERNAL,
      status: Ledger::STATUSES["succeeded"] }
  end

  def get_remark(bet)
    pre = "Debit of #{(bet.combo_bet_id.present?) ? bet.combo_bet.stake : bet.stake} for placing "
    post = bet.combo_bet_id.nil? ? "bet" : "combo bet # #{bet.combo_bet_id}"
    pre + post 
  end

  def fetch_combo_odds
    combo_odds = @bet_slips.map{ |slip| slip[:odds].to_f }.inject(:*)
    NumberService.round_to_8_decimal(combo_odds)
  end

  def any_duplicate_match_exist_in_bets?
    match_ids = @bet_slips.pluck("match_id")
    match_ids.length != match_ids.uniq.length 
  end
end
