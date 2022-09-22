# Utility::SportUtility
module Utility
  class Sport
    def self.info(object)
      Rails.cache.fetch([:sport_info, object.sport_id], expire_in: Constants::CACHE_EXPIRE_TIME.days) do
        object.sport
      end
    end
  end
end
