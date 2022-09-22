# Qtech::ApiClient::Client.new
module Qtech
  module ApiClient
    class Client < ::Qtech::ApiClient::Request
      attr_accessor :base_url, :passkey
      include ::Qtech::ApiClient::Api::CommonWallet
      include ::Qtech::ApiClient::Api::AuthenticationApis
      include ::Qtech::ApiClient::Api::GameDetails
      include ::Qtech::ApiClient::Api::FreeGameDetails
      include ::Qtech::ApiClient::Api::PlayerGameHistory

      def initialize
        @passkey = Figaro.env.qteck_pass_key
        @base_url = Figaro.env.wallet_base_url
      end

      private

      def headers
        {}
      end

      def qt_plate_form_url
        @qt_plate_form_url = 'https://api-int.qtplatform.com'
      end

      def qt_plateform_headers
        {
          Authorization: "Bearer #{retrive_access_token[:access_token]}"
        }
      end
    end
  end
end
