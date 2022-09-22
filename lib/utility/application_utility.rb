module Utility
  class ApplicationUtility
    def self.social_app?
      Figaro.env.social_app == 'true'
    end
  end
end
