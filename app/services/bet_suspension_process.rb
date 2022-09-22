class BetSuspensionProcess
  def initialize(bet, admin_user)
    @bet = bet
    @admin_user = admin_user
  end

  def call
    bet_suspendable?
    set_bet_wallet
    create_ledger
    return complete_ledger_transaction! if process_suspension

    suspension_failed!
  end

  private

  attr_accessor :bet, :ledger, :wallet, :admin_user

  def bet_suspendable?
    return true if bet.present? && bet.pending?

    err_msg = I18n.t('bets.suspend.invalid')
    raise Exception err_msg
  end

  def set_bet_wallet
    @wallet = is_combo? ? bet.bets.first.wallet : bet.wallet
  end

  def create_ledger
    @ledger = wallet.ledgers.create!(
      amount: bet.stake,
      betable: bet,
      transaction_type: 'credit',
      mode: 'admin',
      status: 'pending',
      admin_user_id: admin_user.id
    )
  end

  def process_suspension
    Bet.transaction do
      suspend_combo_bets if is_combo?
      bet.update(status: 'cancelled')
    end
  end

  def suspend_combo_bets
    bet.bets.update(status: 'cancelled')
  end

  def complete_ledger_transaction!
    ledger.register_bet_cancellation!("#{bet.class.name} with ID: #{bet.id} suspended.")
  end

  def suspension_failed!
    ledger.register_rejection!("Suspension of #{bet.name} with ID: #{bet.id} failed.")
  end
  
  def is_combo?
    bet.class.name.eql?('ComboBet')
  end
end
