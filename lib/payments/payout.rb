# frozen_string_literal: true

module Payments
  class Payout < ::Payments::Operation
    include Methods

    PAYMENT_METHODS = [
      *::Payments::Methods::PAYOUT_PROVIDERS
    ].freeze

    private

    attr_accessor :ledger

    def execute_operation
      # is_currency_supported?
      ActiveRecord::Base.transaction do
        transaction.wallet.debit(transaction.amount)
        create_ledger
        assign_ledger_to_transaction
      end
      #payout_response
    end

    private

    # def is_currency_supported?
    #   config = find_provider_config(transaction.method)
    #   return true if config[:currency_supported].include?(transaction.currency)

    #   err_msg = "Currency not supported for method #{transaction.method}"
    #   raise ::Payments::NotSupportedError, err_msg
    # end

    def create_ledger
      @ledger = transaction.wallet.ledgers.create!(
        amount: transaction.amount,
        betable: transaction.user,
        transaction_type: 'debit',
        mode: transaction.method,
        status: 'pending',
        account_details: transaction.receiver,
        remark: "Requested withdraw of #{'%.10f' % transaction.amount}"
      )
    end

    def assign_ledger_to_transaction
      transaction.id = ledger.id
    end

    def payout_response
      return provider.process_payout if auto_withdrawal?
      I18n.t('messages.payout.pending')
    end

    def auto_withdrawal?
      transaction.amount <= GammabetSetting.auto_withdrawal_limit
    end
  end
end
