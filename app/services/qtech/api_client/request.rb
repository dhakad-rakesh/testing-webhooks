module Qtech
  module ApiClient
    class Request
      def get(url, path_headers = {})
        data = RestClient.get(url, path_headers.presence || headers)
        JSON.parse(data.body).with_indifferent_access
      rescue StandardError => e
        Betradar::Error.on_complete(e)
      end

      def delete(url, path_headers = {})
        RestClient.delete(url, path_headers.presence || headers)
      rescue StandardError => e
        Betradar::Error.on_complete(e)
      end

      def post(url, params = {}, path_headers = {})
        data = RestClient.post(url, params, path_headers.presence || headers)
        JSON.parse(data.body).with_indifferent_access
      rescue StandardError => e
        Qtech::ApiClient::Error.on_complete(e)
      end
    end
    Dir[Rails.root.join('services', 'qtech', 'api_client', 'api', '*.rb')].each { |f| require_dependency f }
  end
end
