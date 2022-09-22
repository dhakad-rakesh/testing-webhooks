# frozen_string_literal: true

module Payments
  module FastPay
    module Payouts
      class RequestBuilder < ApplicationService

        def initialize(transaction)
          @transaction = transaction
        end

        def call
          {
            merchant_mobile_no: ENV['FASTPAY_MOBILE_NUMBER'],
            store_password: ENV['FASTPAY_PASSWORD'],
            reference_id: @transaction.id,
            amount: @transaction.amount,
            receiver_mobile_no: @transaction.receiver
          }
        end
      end
    end
  end
end
