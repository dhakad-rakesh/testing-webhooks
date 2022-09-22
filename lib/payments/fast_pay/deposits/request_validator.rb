# frozen_string_literal: true

module Payments
  module FastPay
    module Deposits
      class RequestValidator < ApplicationService
        include ::Payments::Methods

        MANDATORY_FIELDS = %i[
          merchant_mobile_no store_password order_id bill_amount
          success_url fail_url cancel_url
        ].freeze

        def initialize(deposit_params)
          @deposit_params = deposit_params
        end

        def call
          check_mandatory_fields!
        end

        private

        attr_reader :deposit_params

        def check_mandatory_fields!
          return unless missing_mandatory_fields.any?

          raise_validation_error(
            "Fields are required: #{missing_mandatory_fields.join(', ')}"
          )
        end

        def check_currency!
          return if currency_available?

          raise_validation_error(
            I18n.t('errors.messages.currency_not_supported')
          )
        end

        def missing_mandatory_fields
          @missing_mandatory_fields ||= MANDATORY_FIELDS - fields_with_value
        end

        def raise_validation_error(message)
          raise NotImplementedError
        end

        def fields_with_value
          deposit_params.reject { |_k, value| value.blank? }.keys
        end
      end
    end
  end
end
