# frozen_string_literal: true

module Payments
  class Deposit < ::Payments::Operation
    include Methods
    include Utility::UserLimitsHelper

    PAYMENT_METHODS = [
      *::Payments::Methods::METHOD_PROVIDERS
    ].freeze

    private

    attr_accessor :ledger, :user_promo_code, :promo_details

    def execute_operation
      # is_currency_supported?
      # validate_deposit_amount
      create_deposit_records!
      assign_ledger_to_transaction
      # provider.payment_page_url
    end

    def is_currency_supported?
      config = find_provider_config(transaction.method)
      return true if config[:currency_supported].include?(transaction.currency)

      err_msg = "Currency not supported for method #{transaction.method}"
      raise ::Payments::NotSupportedError, err_msg
    end

    def validate_deposit_amount
      user = transaction.user
      amount = transaction.amount
      valid_deposit_limits(user: user, amount: amount)
    end

    def deposit_error(err_msg:)
      raise ::Payments::DepositLimitError, err_msg
    end

    def create_deposit_records!
      ActiveRecord::Base.transaction do
        reserve_promo_code! if transaction.promo_code.present?
        transaction.wallet.credit(transaction.amount)
        transaction.user.increment!(:deposit_count)
        create_ledger!
      end
    end

    def reserve_promo_code!
      @promo_details = User::PromoCodeVerificationIntr.run!(promo_verification_params)
      @promo_details = @promo_details.with_indifferent_access
      @user_promo_code = transaction.user.user_promo_codes.create(user_promo_creation_params)
    end

    def promo_verification_params
      { user: transaction.user, code_name: transaction.promo_code, deposit_amount: transaction.amount }
    end

    def user_promo_creation_params
      { promo_code_id: promo_details[:id], cashback_value: cashback_value }
    end

    def cashback_value
      if promo_details[:kind] == PromoCode::FIXED_VALUE
        promo_details[:maximum_cashback]
      else
        (transaction.amount * promo_details[:percent]) / 100
      end
    end

    # Keep ledger amount same as actual transaction & store cashback value in user promo code record
    def create_ledger!
      @ledger = transaction.wallet.ledgers.create!(ledger_params)
    end

    def ledger_params
      {
        amount: transaction.amount,
        betable: transaction.user,
        transaction_type: 'credit',
        mode: transaction.method,
        status: 'succeeded',
        remark: "Requested deposit of #{transaction.amount}",
        tracking_id: transaction.transaction_hash
      }.merge(cashback_params)
    end

    def cashback_params
      return {} unless transaction.promo_code.present?
      { kind: Ledger::CASHBACK, user_promo_code_id: user_promo_code.id, cashback_type: promo_details[:promo_type] }
    end

    def assign_ledger_to_transaction
      transaction.id = ledger.id
    end

    def blockchain_transaction
      return {} if transaction.transaction_hash.blank?
      {transaction_hash: transaction.transaction_hash}
    end
  end
end
