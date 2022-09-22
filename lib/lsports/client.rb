module Lsports
  class Client < Request
    attr_accessor :username, :password, :prematch_base_url, :prematch_guid,
                  :inplay_base_url, :inplay_guid, :sport, :params, :inplay_package_id
    include Api::Prematch

    def initialize(sport: nil, params: {})
      @username = Figaro.env.LSPORTS_USER_NAME
      @password = Figaro.env.LSPORTS_PASSWORD

      @prematch_base_url = Figaro.env.LSPORTS_PREMATCH_BASE_URL
      @prematch_guid = Figaro.env.LSPORTS_PREMATCH_GUID

      @sport = sport
      @params = params

      @inplay_base_url = Figaro.env.LSPORTS_INPLAY_BASE_URL
      @inplay_package_id = Figaro.env.LSPORTS_INPLAY_PACKAGE_ID
      # @inplay_guid = Figaro.env.LSPORTS_PREMATCH_GUID
    end

    private

    def prematch_request_url(path = '')
      prematch_base_url + path
    end

    def inplay_request_url(path)
      inplay_base_url + path
    end

    def prematch_authenticated_params
      { username: username, password: password, guid: prematch_guid }
    end

    def prematch_headers
      { params: prematch_authenticated_params.merge!(sport_params) }
    end

    def sport_params
      params.merge!({ sports: sport.uid }) if sport
      params
    end

    def inplay_authenticated_params
      { username: username, password: password, packageid: inplay_package_id }
    end

    def inplay_headers
      { params: inplay_authenticated_params.merge!(sport_params) }
    end
  end
end
