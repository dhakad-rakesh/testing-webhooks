module Lsports
  class Request
    def get_prematch(url)
      data = RestClient::Request.execute(method: :get, url: prematch_request_url(url),
                                         timeout: 60, open_timeout: 60, headers: prematch_headers)
      JSON.parse(data.body).with_indifferent_access if data.body.present?
    rescue StandardError => e
      custom_error_logger(e, (e.try(:response).try(:body) || e.message).to_s)
      Rails.logger.info "Lsports::Request::Error ======== #{e.try(:response).try(:body) || e.message} =========="
      nil
    end

    def get_inplay(url)
      data = RestClient::Request.execute(method: :get, url: inplay_request_url(url),
                                         timeout: 60, open_timeout: 60, headers: inplay_headers)
      JSON.parse(data.body).with_indifferent_access if data.body.present?
    rescue StandardError => e
      custom_error_logger(e, (e.try(:response).try(:body) || e.message).to_s)
      Rails.logger.info "Lsports::Request::Error ======== #{e.try(:response).try(:body) || e.message} =========="
      nil
    end

    # def get_inplay(url = '')
    #   data = RestClient::Request.execute(method: :get, url: inplay_request_url(url),
    #                                      timeout: 15, open_timeout: 15, headers: inplay_headers)
    #   # eval data.body
    #   JSON.parse(data.body).with_indifferent_access if data.body.present?
    # rescue StandardError => e
    #   custom_error_logger(e, (e.try(:response).try(:body) || e.message).to_s)
    #   Rails.logger.info "Lsports::Request::Error ======== #{e.try(:response).try(:body) || e.message} =========="
    #   nil
    # end

    def post(url, params = {})
      data = RestClient.post(request_url(url), params, headers)
      Hash.from_xml(data)
    rescue StandardError => e
      Rails.logger.info "Lsports::Request::Error ======== #{e.try(:response).try(:body) || e.message} =========="
      nil
    end

    private

    def custom_error_logger(exception, error)
      Honeybadger.notify(
        "[Lsports::Request::Error] : [#{exception.class}] : [#{exception.cause}] : [#{error}]"
      )
    end
  end
  Dir[Rails.root.join('lib', 'lsports', 'api', '*.rb')].each { |f| require_dependency f }
end
