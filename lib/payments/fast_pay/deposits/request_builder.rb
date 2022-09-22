# frozen_string_literal: true

module Payments
  module FastPay
    module Deposits
      class RequestBuilder < ApplicationService
        include ::Payments::Methods
        include Rails.application.routes.url_helpers

        def initialize(transaction)
          @transaction = transaction
        end

        def call
          {
            merchant_mobile_no: ENV['FASTPAY_MOBILE_NUMBER'],
            store_password: ENV['FASTPAY_PASSWORD'],
            order_id: @transaction.id,
            bill_amount: @transaction.amount,
            success_url: webhooks_url,
            cancel_url: webhooks_url,
            fail_url: webhooks_url
          }
        end

      protected

        def webhooks_url
          webhooks_fastpay_payments_url
        end
      end
    end
  end
end
