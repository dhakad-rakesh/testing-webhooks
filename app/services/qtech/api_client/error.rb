module Qtech
  module ApiClient
    class Error < ::StandardError
      class << self
        def errors
          @errors ||= {
            400 => Qtech::ApiClient::Error::BadRequest,
            401 => Qtech::ApiClient::Error::Unauthorized,
            403 => Qtech::ApiClient::Error::Forbidden,
            404 => Qtech::ApiClient::Error::NotFound,
            429 => Qtech::ApiClient::Error::RateLimited,
            500 => Qtech::ApiClient::Error::InternalServerError,
            502 => Qtech::ApiClient::Error::ProxyError
          }
        end

        def on_complete(response)
          klass = errors[response.try(:http_code)&.to_i] || Qtech::ApiClient::Error::Unknown
          fail klass.new(klass.new(response.inspect)) # rubocop:disable RaiseArgs
        end
      end

      # Raised when Qtech::ApiClient returns a 4xx HTTP status code
      ClientError = Class.new(self)

      # Raised when Qtech::ApiClient returns the HTTP status code 400
      BadRequest = Class.new(ClientError)

      # Raised when Qtech::ApiClient returns the HTTP status code 401
      Unauthorized = Class.new(ClientError)

      # Raised when Qtech::ApiClient returns the HTTP status code 403
      Forbidden = Class.new(ClientError)

      # Raised when Qtech::ApiClient returns the HTTP status code 404
      NotFound = Class.new(ClientError)

      # Raised when Qtech::ApiClient returns the HTTP status code 429
      RateLimited = Class.new(ClientError)

      # Raised when Qtech::ApiClient returns a 5xx HTTP status code
      ServerError = Class.new(self)

      # Raised when Qtech::ApiClient returns the HTTP status code 500
      InternalServerError = Class.new(ServerError)

      # Raised when Qtech::ApiClient returns the HTTP status code 502
      ProxyError = Class.new(ServerError)

      # Raised when Qtech::ApiClient returns the HTTP status code 503
      ServiceUnavailable = Class.new(ServerError)

      # Raised when Qtech::ApiClient returns unknown status code
      Unknown = Class.new(self)
    end
  end
end
