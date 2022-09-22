module Payments
  class DepositCallbackHandler < ApplicationInteraction
    interface :handler, methods: %i[call]
    interface :validator, methods: %i[call]
    interface :request, methods: %i[params]

    include ::Payments::Webhooks::Statuses

    set_callback :type_check, :before, :validate_ledger
    set_callback :type_check, :before, :validate_processed_transaction

    validate :validate_deposit_request
  
    def execute
      handler.call(request)
      credit_referral_amount unless ledger.betable.amount_credited_to_referrer?
      callback_redirect_for(SUCCESS)
    rescue ::Payments::CancelledError
      callback_redirect_for(CANCELLED)
    rescue ::Payments::FailedError => error
      callback_redirect_for(FAILED, custom_message: error.message)
    rescue StandardError => error
      Rails.logger.error(message: 'Technical error appeared on deposit',
                         error_object: error)

      callback_redirect_for(SYSTEM_ERROR)
    end
    
    def callback_redirect_for(status, custom_message: nil)
      ::Payments::Webhooks::DepositRedirectionUrlBuilder.call(
        status: status,
        request_id: order_id,
        custom_message: custom_message
      )
    end

    def validate_deposit_request
      return if validator.call(request.params)
      errors.add(:deposit, I18n.t('errors.messages.deposit.malformed'))
    end

    def validate_ledger
      return if ledger
      errors.add(:deposit, I18n.t('errors.messages.deposit.not_found'))
    end

    def validate_processed_transaction
      return unless ledger&.processed?
      errors.add(:deposit, I18n.t('errors.messages.deposit.processed'))
    end

    def ledger
      @ledger ||= Ledger.find_by(id: order_id)
    end

    def order_id
      request.params[:order_id]
    end

    def credit_referral_amount
      return unless ledger.betable.eligible_to_credit_referrer?
      Users::CreditReferralAmountJob.perform_later(ledger.betable_id)
    end
  end
end
