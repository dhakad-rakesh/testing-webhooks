module Extensions
  module Match
    module TournamentUtil
      def tournament_uid
        Rails.cache.fetch([:tournament_uid, id], expire_in: Constants::CACHE_EXPIRE_TIME.days) do
          tournament&.uid
        end
      end

      def tournament_name
        Rails.cache.fetch([:tournament, :name, id], expire_in: Constants::CACHE_EXPIRE_TIME.days) do
          tournament.name
        end
      end

      def non_supported_tournament?
        !Tournament.enabled_tournament_uid.include?(tournament_uid)
      end
    end
  end
end
