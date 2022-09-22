# frozen_string_literal: true

module Payments
  module Handlers
    class DepositCallbackHandler < ::ApplicationService

      def initialize(request)
        @request = request
      end

      protected

      attr_reader :request

      def request_id
        raise NotImplementedError, 'Implement #request_id method!'
      end

      def ledger
        @ledger ||= ::Ledger.find(request_id)
      end

      def fail_related_entities
        # customer_bonus&.fail!
        # entry_request&.origin&.failed!
      end
    end
  end
end
