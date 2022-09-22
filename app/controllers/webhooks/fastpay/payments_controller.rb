module Webhooks
  module Fastpay
    class PaymentsController < ApplicationController
      skip_before_action :verify_authenticity_token

      # TODO: Introduce database level locks
      def create
        Rails.logger.info "Fastpay callback received for order id: #{request.params[:order_id]}"
        Rails.logger.info request
                    
        lock_name = "deposit_lock_#{request.params[:order_id]}"
        outcome = RedisMutex.with_lock(lock_name, block: 0) do
                    ::Payments::DepositCallbackHandler.run(
                      request: request,
                      handler: handler,
                      validator: validator
                    )
                  end
        return redirect_to callback_redirect_with(outcome.errors.full_messages) unless outcome.valid?
        redirect_to outcome.result
      rescue RedisMutex::LockError
        Rails.logger.error "Failed to acquire deposit lock for order id: #{request.params[:order_id]}"
        redirect_to callback_redirect_with(I18n.t('errors.messages.failed_to_acquire_lock'))
      end

      protected

      def handler
        ::Payments::FastPay::CallbackHandler
      end

      def validator
        ::Payments::FastPay::Validations::PaymentValidationHandler
      end

      def callback_redirect_with(custom_message=nil)
        ::Payments::Webhooks::DepositRedirectionUrlBuilder.call(
          status: fallback_redirection,
          request_id: order_id,
          custom_message: custom_message
        )
      end

      def order_id
        request.params[:order_id]
      end

      def fallback_redirection
        ::Payments::Webhooks::Statuses::FALLBACK_REDIRECTION
      end
    end
  end
end
