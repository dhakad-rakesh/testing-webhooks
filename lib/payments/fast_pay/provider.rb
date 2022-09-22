# frozen_string_literal: true

module Payments
  module FastPay
    class Provider < ::Payments::Provider
      def payment_page_url
        ::Payments::FastPay::Deposits::RequestHandler.call(transaction)
      end

      protected

      def user_validation_handler
        ::Payments::FastPay::Validations::UserValidationHandler
      end

      def payout_request_handler
        ::Payments::FastPay::Payouts::RequestHandler
      end
    end
  end
end
