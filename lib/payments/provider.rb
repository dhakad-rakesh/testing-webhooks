# frozen_string_literal: true

module Payments
  class Provider
    attr_reader :transaction

    def initialize(transaction)
      @transaction = transaction
    end

    def validate_user
      user_validation_handler.call(transaction)
    end

    def payment_page_url
      raise ::NotImplementedError
    end

    def process_payout
      payout_request_handler.call(transaction)
    end

    protected

    def user_validation_handler
      raise NotImplementedError
    end

    def payout_request_handler
      raise NotImplementedError
    end
  end
end
