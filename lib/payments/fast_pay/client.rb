# frozen_string_literal: true

module Payments
  module FastPay
    class Client
      include HTTParty

      CONTENT_TYPE = 'application/json; charset=utf8'

      base_uri ENV.fetch('FASTPAY_BASE_URL', 'https://dev.fast-pay.cash')
      raise_on [400, 401, 403, 500]
      headers 'Accept': 'application/json',
              'Content-Type': CONTENT_TYPE
      format :json
      debug_output $stdout

      def receive_deposit_redirect_url(deposit_params)
        route = '/merchant/generate-payment-token'

        request(:post, route, body: deposit_params.to_json,
                              headers: { 'Content-Type' => CONTENT_TYPE })
      end

      def validate_deposit(deposit_params)
        route = '/merchant/payment/validation'

        request(:post, route, body: deposit_params.to_json,
          headers: { 'Content-Type' => CONTENT_TYPE })
      end

      def payment_page_url(token)
        "#{self.class.base_uri}/merchant/payment?token=#{token}"
      end

      def request_payout(payout_params)
        route = '/api/v2/merchant/cash-back'

        request(:post, route, body: payout_params.to_json,
                              headers: { 'Content-Type' => CONTENT_TYPE })
      end

      private

      def request(method, route, **options)
        self.class.send(method, route, options)
      rescue HTTParty::Error => e
        e.response
      end
    end
  end
end
