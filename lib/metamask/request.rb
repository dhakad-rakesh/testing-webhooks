module Metamask
  class Request
    def post(url, params = {})
      uri = URI.parse(request_url(url))
      request = Net::HTTP::Post.new(uri)
      request["Authorization"] = authorization
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

    def get(url, params= {})
      uri = URI.parse(request_url(url)) 
      uri.query = URI.encode_www_form(params)   
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = authorization
      request.content_type = "application/json"
      req_options = {
        use_ssl: uri.scheme == "https",
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    rescue StandardError => error
      error
    end

    def authorization
      ActionController::HttpAuthentication::Basic.encode_credentials(Figaro.env.METAMASK_USER_AUTH, Figaro.env.METAMASK_PASS_AUTH)
    end
  end
end
