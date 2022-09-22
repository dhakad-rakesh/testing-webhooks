module Utility
  class InplayMatches
    KEY = 'inplay_matches_list'.freeze

    def self.add(uid)
      return if uid.nil?

      new_cache_list = list
      new_cache_list.push(uid.to_s)

      Rails.cache.write(KEY, new_cache_list.join(', '))
    end

    def self.remove(uid)
      return if uid.nil?

      new_cache_list = list
      new_cache_list.delete(uid.to_s)

      Rails.cache.write(KEY, new_cache_list.join(', '))
    end

    def self.cache_list
      Rails.cache.fetch(KEY)
    end

    def self.list
      cache_list&.split(', ') || []
    end

    def self.update_list(match)
      inplay_list = list

      if Match::ACTIVE_STATUS.include?(match.status) && inplay_list.exclude?(match.uid)
        add(match.uid)
      elsif Match::INACTIVE_STATUS.include?(match.status) && inplay_list.include?(match.uid)
        remove(match.uid)
      end
    end
  end
end
