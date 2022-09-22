# frozen_string_literal: true

module Payments
  class GatewayError < ::StandardError; end

  class NotSupportedError < GatewayError; end

  class FailedError < GatewayError

    def initialize(msg = nil)
      super(msg || default_message)
    end

    def default_message
      'Payment was failed'
    end
  end

  class CancelledError < GatewayError
    def message
      'Payment was cancelled'
    end
  end

  class InvalidTransactionError < ::StandardError
    def initialize(transaction)
      @transaction = transaction
      super
    end

    def message
      'Transaction data is invalid'
    end

    def validation_errors
      @transaction.errors
    end
  end

  class PayoutError < GatewayError
    def initialize(msg = nil)
      super(msg || default_message)
    end

    def default_message
      'Payout error'
    end
  end

  class ApiError < GatewayError; end

  class DepositLimitError < ::StandardError; end
end
