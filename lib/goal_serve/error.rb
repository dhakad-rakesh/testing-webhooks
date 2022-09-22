module GoalServe
  class Error < ::StandardError
    class << self
      def errors
        @errors ||= {
          400 => GoalServe::Error::BadRequest,
          401 => GoalServe::Error::Unauthorized,
          403 => GoalServe::Error::Forbidden,
          404 => GoalServe::Error::NotFound,
          429 => GoalServe::Error::RateLimited,
          500 => GoalServe::Error::InternalServerError,
          502 => GoalServe::Error::ProxyError,
          408 => GoalServe::Error::RequestReadTimeOut
        }
      end

      def on_complete(response)
        klass = errors[error_code(response)] || GoalServe::Error::Unknown
        fail klass.new(klass.new(response.inspect)) # rubocop:disable RaiseArgs
      end

      private
      
      def error_code(response)
        response.try(:http_code)&.to_i || get_code_from_message(response.message)
      end

      def get_code_from_message(message)
        case message
        when 'Timed out reading data from server'
          408
        else
          nil  
        end
      end
    end
    # Raised when GoalServe returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when GoalServe returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when GoalServe returns the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised when GoalServe returns the HTTP status code 403
    Forbidden = Class.new(ClientError)

    # Raised when GoalServe returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when GoalServe returns the HTTP status code 429
    RateLimited = Class.new(ClientError)

    # Raised when GoalServe returns a 5xx HTTP status code
    ServerError = Class.new(self)

    # Raised when GoalServe returns the HTTP status code 500
    InternalServerError = Class.new(ServerError)

    # Raised when GoalServe returns the HTTP status code 502
    ProxyError = Class.new(ServerError)

    # Raised when GoalServe returns the HTTP status code 503
    ServiceUnavailable = Class.new(ServerError)

    # Raised when GoalServe unable to retrun data
    RequestReadTimeOut = Class.new(ServerError)

    # Raised when GoalServe returns unknown status code
    Unknown = Class.new(self)
  end
end