module Payments
  class RequestDeposit < ApplicationInteraction
    object :user
  
    float :value
    string :transactionHash
    alias :amount :value
    # string :currency
    string :payment_method, default: nil
    string :promo_code, default: nil

    set_callback :type_check, :after, :validate_amount, if: :amount
  
    def execute
      ::Payments::Deposit.call(transaction)
      # TODO: Add custom error classes, Add generic handler for now
    rescue Payments::DepositLimitError => e
      errors.add(:base, e.message)
    rescue Exception => e
      # errors.add(:base, e.message)
      errors.add(:base, I18n.t('errors.messages.transaction_not_completed'))
    end
  
    def transaction
      ::Payments::Transactions::Deposit.new(
        user: user,
        method: payment_method,
        amount: amount,
        transaction_hash: transactionHash
      )
    end

    def validate_amount
      # return unless amount < GammabetSetting.minimum_deposit_amount.to_f
      return if amount > 0
      errors.add(:base, invalid_amount_message)
    end

    def invalid_amount_message
      I18n.t('wallets.errors.invalid_amount')
    end
  end
end
