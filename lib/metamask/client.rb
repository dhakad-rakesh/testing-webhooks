module Metamask
  class Client < Request
    attr_accessor :base_url

    def initialize
      @base_url = Figaro.env.METAMASK_BASE_URL
    end
    
    private

    def request_url(path)
      "#{base_url}/#{path}"
    end

  end
end
