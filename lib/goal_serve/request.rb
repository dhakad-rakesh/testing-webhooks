module GoalServe
  class Request
    def get(url = "")
      null = ""
      data = RestClient::Request.execute(method: :get, url: request_url(url),
                               timeout: 15, open_timeout: 15, headers: headers)
      eval data.body
    rescue StandardError => e
      GoalServe::Error.on_complete(e)
    end

    def get_inplay(url = "")
      null = ""
      data = RestClient::Request.execute(method: :get, url: inplay_request_url(url),
                               timeout: 15, open_timeout: 15, headers: headers)
      eval data.body
    rescue StandardError => e
      nil
    end

    def post(url, params = {})
      data = RestClient.post(request_url(url), params, headers)
      Hash.from_xml(data)
    rescue StandardError => e
      GoalServe::Error.on_complete(e)
    end
  end
  Dir[Rails.root.join('lib', 'goal_serve', 'api', '*.rb')].each { |f| require_dependency f }
end
