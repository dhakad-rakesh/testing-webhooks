# frozen_string_literal: true

module Payments
  module FastPay
    module Payouts
      class RequestHandler < Handlers::PayoutRequestHandler

        private

        def log_response
          Rails.logger.info(
            message: 'Fastpay payout request',
            request_id: transaction.id,
            response: response
          )
        rescue StandardError => error
          Rails.logger.error(
            message: 'Fastpay payout request cannot be logged',
            request_id: transaction.id,
            error_object: error
          )
        end

        def created?
          succeeded_request? && succeeded_response?
        end

        def succeeded_request?
          request.code == 200
        end

        def succeeded_response?
          status_code == 200
        end

        def status_code
          response['code']
        end

        def client
          Client.new
        end

        def request
          @request ||= client.request_payout(payout_params)
        end

        def response
          @response ||= JSON.parse(request.body)
        end

        def payout_params
          @payout_params ||= Payouts::RequestBuilder.call(transaction)
        end

        def raw_error_message
          return if succeeded_response?
          response['messages'].join(' ')
        end

        def error_message
          @error_message ||= "Fastpay: #{raw_error_message}"
        end
      end
    end
  end
end
