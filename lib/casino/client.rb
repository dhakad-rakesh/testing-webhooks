module Casino
  class Client < Request
    attr_accessor :casino_id, :api_token, :base_url

    def initialize
      @casino_id = Figaro.env.CASINO_KEY
      @api_token = Figaro.env.CASINO_API_TOKEN
      @base_url = Figaro.env.CASINO_BASE_URL
    end

    def user_authentication(params)
      post("#{base_url}/ua/v1/#{casino_id}/#{api_token}", params)
    end

    private

    def request_url(path)
      "#{base_url}/#{path}"
    end

  end
end
