module Payments
  class RequestPayout < ApplicationInteraction
    object :user
  
    float :amount
    # string :currency
    # string :payment_method
    # string :receiver_mobile, default: nil
    string :deposit_address

    set_callback :type_check, :after, :validate_amount, if: :amount

    validate :withdrawable_amount
  
    def execute
      ::Payments::Payout.call(transaction)
      # TODO: Add custom error classes, Add generic handler for now
    rescue Exception => e
      # errors.add(:base, e.message)
      errors.add(:base, I18n.t('errors.messages.transaction_not_completed'))
    end
  
    def transaction
      ::Payments::Transactions::Payout.new(
        user: user,
        # method: payment_method,
        # currency: currency,
        amount: amount,
        receiver: deposit_address
      )
    end

    def validate_amount
      if amount <= 0
        errors.add(:base, I18n.t('wallets.errors.invalid_amount'))
      elsif amount < GammabetSetting.minimum_withdrawal_amount.to_f
        errors.add(:base, I18n.t('errors.messages.payout.minimum_amount', amount: GammabetSetting.minimum_withdrawal_amount))
      # elsif amount > GammabetSetting.maximum_withdrawal_amount.to_f
      #   errors.add(:base, I18n.t('errors.messages.payout.maximum_amount', amount: GammabetSetting.maximum_withdrawal_amount))
      end
    end

    # def invalid_amount_message
    #   I18n.t('errors.messages.payout.minimum_amount', 
    #     amount: GammabetSetting.minimum_withdrawal_amount
    #   )
    # end

    def withdrawable_amount
      return if user.withdraw_allowed?(amount)
      errors.add(:base, I18n.t('errors.messages.payout.insufficient_amount'))
      # return if user.current_wallet.amount >= amount
      # return if user.withdraw_allowed?(amount)
      # errors.add(:base, 'Insufficient withdrawal balance')
    end
  end
end
