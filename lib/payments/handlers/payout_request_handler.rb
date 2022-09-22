# frozen_string_literal: true

module Payments
  module Handlers
    class PayoutRequestHandler < ::ApplicationService
      def initialize(transaction)
        @transaction = transaction
      end

      def call
        log_response
        return complete_ledger_transaction if created?

        payout_failed!
      end

      protected

      attr_reader :transaction

      delegate :withdrawal, to: :transaction, allow_nil: true

      def log_response
        raise NotImplementedError, "Implement ##{__method__} method!"
      end

      def created?
        raise NotImplementedError, "Implement ##{__method__} method!"
      end

      def payout_failed!
        fail_ledger_transaction!
        raise ::Payments::PayoutError, error_message
      end

      def error_message
        raise NotImplementedError, 'Implement #error_message method!'
      end

      def ledger
        @ledger ||= ::Ledger.find(transaction.id)
      end

      def fail_ledger_transaction!
        ledger.register_failure!('Payment failed')
      end

      def complete_ledger_transaction
        ledger.register_success!('Payout success', status: transaction.status)
        success_response
      end

      def success_response
        I18n.t('messages.payout.success')
      end
    end
  end
end
