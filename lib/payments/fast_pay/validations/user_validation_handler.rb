# frozen_string_literal: true

module Payments
  module FastPay
    module Validations
      class UserValidationHandler < ApplicationService
        include ::Payments::Methods

        delegate :user, to: :transaction
        delegate :address, to: :user
        delegate :state_code, :country_code, to: :address, allow_nil: true

        def initialize(transaction)
          @transaction = transaction
        end

        def call
          supported_currency?
        end

        private

        attr_reader :transaction

        def supported_currency?
          return true unless transaction.currency
          ::Payments::FastPay::Currency::AVAILABLE_CURRENCY_LIST
            .fetch(mode, [])
            .include?(transaction.currency)
        end

        def mode
          @mode ||= provider_method_name(transaction.method)
        end
      end
    end
  end
end
