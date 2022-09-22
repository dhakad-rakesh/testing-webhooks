module Payments
  module FastPay
    module Validations
      class PaymentValidationHandler < ApplicationService

        def initialize(transaction)
          @transaction = transaction
        end

        def call
          return unless ledger
          send_validate_deposit_request
          validate_response!
          valid_deposit_request?
        rescue NotImplementedError => error
          # TODO
        end

      private

        attr_reader :transaction, :response, :ledger

        def ledger
          @ledger ||= Ledger.find_by(id: transaction[:order_id]) 
        end

        def send_validate_deposit_request
          @response = client.validate_deposit(deposit_params)
        end

        def client
          Client.new
        end

        def deposit_params
          {
            merchant_mobile_no: ENV['FASTPAY_MOBILE_NUMBER'],
            store_password: ENV['FASTPAY_PASSWORD'],
            order_id: transaction[:order_id]
          }
        end

        def validate_response!
          return if response['code'] == 200
          raise NotImplementedError
        end

        def valid_deposit_request?
          response['data'] == transaction_details
        end

        def transaction_details
          transaction_params.merge(
            transaction_id: transaction[:transaction_id].to_i,
            bill_amount: format('%<num>0.2f', num: transaction[:bill_amount].to_f)
          )
        end

        def transaction_params
          transaction.slice(
            :order_id, :customer_account_no, :status, :received_at
          )
        end
      end
    end
  end
end
