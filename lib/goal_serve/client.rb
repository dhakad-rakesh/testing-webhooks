module GoalServe
  class Client < Request
    attr_accessor :api_key, :base_url, :inplay_base_url
    include Api::StaticSportEventInformation
    include Api::EntityDescriptions

    def initialize
      #Not using api keys for now
      #@api_key = Figaro.env.goal_serve_api_key
      #@base_url = Figaro.env.goal_serve_base_url
      @base_url = Figaro.env.gs_base_url
      @inplay_base_url = Figaro.env.gs_inplay_base_url
    end

    private

    def request_url(path = "")
      base_url + path
    end

    def inplay_request_url(path)
      inplay_base_url + path
    end

    def headers
      {}
    end
  end
end
