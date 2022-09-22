# frozen_string_literal: true

module Payments
  class Validation < Operation
    include Methods

    private

    def execute_operation
      user_validation_handler.call(transaction)
    end

    def user_validation_handler
      provider.validate_user
    end
  end
end
