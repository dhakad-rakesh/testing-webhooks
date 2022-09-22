# frozen_string_literal: true

module Payments
  class Operation < ApplicationService
    attr_reader :transaction

    def initialize(transaction)
      @transaction = transaction
    end

    def call
      validate_transaction!
      execute_operation
    end

    protected

    def execute_operation
      raise ::NotImplementedError
    end

    def validate_transaction!
      return if transaction.valid?

      raise Payments::InvalidTransactionError, transaction
    end

    def provider
      find_method_provider(transaction.method).new(transaction)
    end
  end
end
