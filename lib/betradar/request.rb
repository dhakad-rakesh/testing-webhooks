module Betradar
  class Request
    def get(url)
      data = RestClient.get(request_url(url), headers)
      Hash.from_xml(data)
    rescue StandardError => e
      Betradar::Error.on_complete(e)
    end

    def post(url, params = {})
      data = RestClient.post(request_url(url), params, headers)
      Hash.from_xml(data)
    rescue StandardError => e
      Betradar::Error.on_complete(e)
    end
  end
  Dir[Rails.root.join('lib', 'betradar', 'api', '*.rb')].each { |f| require_dependency f }
end
