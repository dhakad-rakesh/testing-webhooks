class ComboBetResult < ::Betting::Settlement
  def update(bet)
    combo_bet = bet.combo_bet
    status = combo_bet.bets.pluck(:status).compact.uniq
    combo_bet.update_betting_bonus!
    # status should include only 'pending', 'lost' or 'won' if other status present this code will not work.
    # return if status.include? 'pending'

    if (status & %w[lost half_won half_lost]).any?
      combo_bet.update status: 'lost'
      # combo_bet.bets.update_all status: 'lost'
      # ComboBetNotifyMailer.with(combo_bet_id: combo_bet.id).lost.deliver_later
    # elsif status == ['won'] || status.sort == ['refunded', 'won']
    elsif (status & %w[lost pending half_won half_lost]).none? && (status & %w[won]).any?
      process_combo_bet(bet, combo_bet, 'won')
      # ComboBetNotifyMailer.with(combo_bet_id: combo_bet.id).won.deliver_later
    elsif (status & %w[lost pending half_won half_lost]).none? && (status & %w[refunded cancelled hold]).any?
      process_combo_bet(bet, combo_bet, 'refunded')
      # ComboBetNotifyMailer.with(combo_bet_id: combo_bet.id).refunded.deliver_later
    end
    Notifications::PublishNotificationJob.perform_later(combo_bet.id, Constants::NOTIFICATION_KIND[:combo_bet])
  end

  private

  def process_combo_bet(bet, combo_bet, status)
    wallet = bet.wallet
    combo_bet.update status: status
    process_won_bet(combo_bet, wallet)
  end

  def process_won_bet(combo_bet, wallet)
    amount = ( combo_bet.available_odds * combo_bet.stake )
    betting_bonus = combo_bet.betting_bonus
    amount = Wallets::Base.new(wallet).credit(amount, bonus_amount: betting_bonus)
    wallet.ledgers.create(arguments_of_bets(combo_bet, amount)) unless amount.zero?
  end

  def arguments_of_bets(combo_bet, amount)
    { betable: combo_bet, amount: amount, remark: remark(amount, combo_bet), transaction_type: :credit, status: Ledger::STATUSES["succeeded"] }
  end

  def remark(amount, combo_bet)
    I18n.t(
      "combo_bets.#{combo_bet.status}", amount: amount.round(8), combo_bet_id: combo_bet.id
    )
  end
end
