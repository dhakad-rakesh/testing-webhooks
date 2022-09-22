module Casino
  class Request
    def get(url: url, params: {})
      data = RestClient.get(request_url(url), headers(params))
    rescue StandardError => error
      error
    end

    def post(url, params = {})
      uri = URI.parse(url)
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request.body = JSON.dump(params)
      req_options = {
        use_ssl: uri.scheme == "https",
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    rescue StandardError => error
      error
    end
  end
  Dir[Rails.root.join('lib', 'casino', 'api', '*.rb')].each { |f| require_dependency f }
end
