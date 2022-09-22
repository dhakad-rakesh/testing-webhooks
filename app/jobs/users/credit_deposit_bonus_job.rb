class Users::CreditDepositBonusJob < ApplicationJob
  queue_as :low

  def perform(user)
    @user = user
    @amount = GammabetSetting.deposit_bonus_amount
    ActiveRecord::Base.transaction do
      user.current_wallet.credit(@amount, withdrawable: false, cashback_type: 'betting')
      create_ledger
    end
  end

  private
  def create_ledger
    transaction.user.current_wallet.ledgers.create!(
      amount: transaction.amount,
      betable: transaction.user,
      transaction_type: 'credit',
      status: 'succeeded',
      remark: "First Deposit Reward"
    )
  end
  
  def transaction
    ::Payments::Transactions::Deposit.new(
      user: @user,
      amount: @amount,
    )
  end
end
