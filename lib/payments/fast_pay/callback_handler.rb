module Payments
  module FastPay
    class CallbackHandler < ::ApplicationService
      DEPOSIT = 'credit'
      WITHDRAWAL = 'debit'

      def initialize(request)
        @request = request
      end

      def call
        callback_handler.call(request)
      end

      private

      attr_reader :request

      def request_id
        request.params['order_id']
      end

      def payment_type
        @payment_type ||= Ledger.find(request_id)
                          .transaction_type
      end

      def callback_handler
        case payment_type
        when DEPOSIT
          ::Payments::FastPay::Deposits::CallbackHandler
        when WITHDRAWAL
          ::Payments::FastPay::Payouts::CallbackHandler
        else
          non_supported_payment_type!
        end
      end

      def non_supported_payment_type!
        raise ::Payments::NotSupportedError, 'Non supported payment type'
      end
    end
  end
end
