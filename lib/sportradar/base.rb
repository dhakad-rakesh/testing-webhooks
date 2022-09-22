module Sportradar
  class Base < Request
    def base_url
      @base_url ||= Figaro.env.sportradar_base_url
    end
  end
end
