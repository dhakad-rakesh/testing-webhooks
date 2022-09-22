module Betradar
  class Error < ::StandardError
    class << self
      def errors
        @errors ||= {
          400 => Betradar::Error::BadRequest,
          401 => Betradar::Error::Unauthorized,
          403 => Betradar::Error::Forbidden,
          404 => Betradar::Error::NotFound,
          429 => Betradar::Error::RateLimited,
          500 => Betradar::Error::InternalServerError,
          502 => Betradar::Error::ProxyError
        }
      end

      def on_complete(response)
        klass = errors[response.try(:http_code)&.to_i] || Betradar::Error::Unknown
        fail klass.new(klass.new(response.inspect)) # rubocop:disable RaiseArgs
      end
    end

    # Raised when Betradar returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when Betradar returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when Betradar returns the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised when Betradar returns the HTTP status code 403
    Forbidden = Class.new(ClientError)

    # Raised when Betradar returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when Betradar returns the HTTP status code 429
    RateLimited = Class.new(ClientError)

    # Raised when Betradar returns a 5xx HTTP status code
    ServerError = Class.new(self)

    # Raised when Betradar returns the HTTP status code 500
    InternalServerError = Class.new(ServerError)

    # Raised when Betradar returns the HTTP status code 502
    ProxyError = Class.new(ServerError)

    # Raised when Betradar returns the HTTP status code 503
    ServiceUnavailable = Class.new(ServerError)

    # Raised when Betradar returns unknown status code
    Unknown = Class.new(self)
  end
end
