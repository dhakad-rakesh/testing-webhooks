module Sportradar
  class Error < ::StandardError
    class << self
      def errors
        @errors ||= {
          400 => Sportradar::Error::BadRequest,
          401 => Sportradar::Error::Unauthorized,
          403 => Sportradar::Error::Forbidden,
          404 => Sportradar::Error::NotFound,
          429 => Sportradar::Error::RateLimited,
          500 => Sportradar::Error::InternalServerError,
          502 => Sportradar::Error::ProxyError
        }
      end

      def on_complete(response)
        klass = errors[response.try(:http_code)&.to_i] || Sportradar::Error::Unknown
        fail klass.new(klass.new(response.inspect)) # rubocop:disable RaiseArgs
      end
    end

    # Raised when Sportradar returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when Sportradar returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when Sportradar returns the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised when Sportradar returns the HTTP status code 403
    Forbidden = Class.new(ClientError)

    # Raised when Sportradar returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when Sportradar returns the HTTP status code 429
    RateLimited = Class.new(ClientError)

    # Raised when Sportradar returns a 5xx HTTP status code
    ServerError = Class.new(self)

    # Raised when Sportradar returns the HTTP status code 500
    InternalServerError = Class.new(ServerError)

    # Raised when Sportradar returns the HTTP status code 502
    ProxyError = Class.new(ServerError)

    # Raised when Sportradar returns the HTTP status code 503
    ServiceUnavailable = Class.new(ServerError)

    # Raised when Sportradar returns unknown status code
    Unknown = Class.new(self)
  end
end
