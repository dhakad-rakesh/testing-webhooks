# frozen_string_literal: true

module Payments
  module Methods
    FASTPAY = 'fast_pay'
    FASTPAY_DISPLAY_NAME = 'Fastpay'

    MANUAL = 'manual'

    METHOD_PROVIDERS = {
      FASTPAY => {
        provider: ::Payments::FastPay::Provider,
        name: FASTPAY,
        display_name: FASTPAY_DISPLAY_NAME,
        currency_supported: ::Payments::FastPay::Currency::AVAILABLE_CURRENCY_LIST
      },
      MANUAL => {
        currency_supported: ::Payments::FastPay::Currency::AVAILABLE_CURRENCY_LIST
      }
    }.freeze

    PAYOUT_PROVIDERS = {
      FASTPAY => {
        provider: ::Payments::FastPay::Provider,
        name: FASTPAY,
        display_name: FASTPAY_DISPLAY_NAME,
        currency_supported: ::Payments::FastPay::Currency::AVAILABLE_CURRENCY_LIST
      },
      MANUAL => {
        currency_supported: ::Payments::FastPay::Currency::AVAILABLE_CURRENCY_LIST
      }
    }.freeze

    def find_method_provider(method)
      find_provider_config(method)[:provider]
    end

    def provider_method_name(method)
      find_provider_config(method)[:name]
    end

    def find_provider_config(method)
      config = METHOD_PROVIDERS[method]
      return config if config.present?

      err_msg = "No provider found for method #{method}"
      raise Payments::NotSupportedError, err_msg
    end
  end
end
