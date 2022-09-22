module Sportradar
  class Request
    def get_data(url)
      data = RestClient.get(request_url(url))
      JSON.parse(data)
    rescue StandardError => e
      Sportradar::Error.on_complete(e)
    end
  end
end
