module Payments
  class MetamaskDeposit < ApplicationInteraction
    object :user
  
    integer :amount

    set_callback :type_check, :after, :validate_amount, if: :amount
  
    def execute
      ActiveRecord::Base.transaction do
        wallet = user.point_wallet
        wallet.credit(amount)
        wallet.ledgers.create!(ledger_params)
      end
    rescue Exception => e
      errors.add(:base, e.message)
      # errors.add(:base, I18n.t('errors.messages.transaction_not_completed'))
    end

    def validate_amount
      return unless amount < GammabetSetting.minimum_deposit_amount.to_f
      errors.add(:base, invalid_amount_message)
    end

    def invalid_amount_message
      I18n.t('errors.messages.deposit.minimum_amount', 
        amount: GammabetSetting.minimum_deposit_amount
      )
    end

    def ledger_params
      {
        amount: amount,
        betable: user,
        transaction_type: 'credit',
        status: 2,
        remark: "Metamask deposit"
      }
    end
  end
end
