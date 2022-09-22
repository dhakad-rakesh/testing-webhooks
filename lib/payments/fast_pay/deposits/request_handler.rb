# frozen_string_literal: true

module Payments
  module FastPay
    module Deposits
      class RequestHandler < ApplicationService
        include ::Payments::Methods

        def initialize(transaction)
          @transaction = transaction
        end

        def call
          validate_request_params!
          send_deposit_url_request
          validate_response!
          payment_page_url
        rescue ::Payments::ApiError => error
          fail_ledger!(error.message)
        end

        private

        attr_reader :transaction, :response

        def validate_request_params!
          RequestValidator.call(deposit_params)
        end

        def send_deposit_url_request
          @response = client.receive_deposit_redirect_url(deposit_params)
        end

        def validate_response!
          return if response['code'] == 200
          raise ::Payments::ApiError, response['messages'].join(' ')
        end

        def deposit_params
          @deposit_params ||= Deposits::RequestBuilder.call(transaction)
        end

        def client
          Client.new
        end

        def payment_page_url
          client.payment_page_url(response['token'])
        end

        def fail_ledger!(message)
          ledger = Ledger.find(transaction.id)
          ledger.register_failure!(message)

          raise ::Payments::GatewayError, message
        end
      end
    end
  end
end
