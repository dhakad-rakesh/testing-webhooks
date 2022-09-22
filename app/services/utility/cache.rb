# Utility::Cache
module Utility
  class Cache
    def self.odds_change_cache_key(match_id)
      ["match_id_#{match_id}", :odds_data]
    end

    def self.odds_change_player_cache_key(match_id)
      ["match_id_#{match_id}", :player_odds_data]
    end

    def self.common_markets_cache_key(match)
      [:common_markets, Utility::Sport.info(match).name]
    end

    def self.outcome_cache_key(match, market_id, resource, specifiers)
      [match.id, market_id, resource.class.name, resource.id, :outcome_name] + specifiers.to_a
    end

    def self.match_title_key(match)
      [:match_title, match.id]
    end

    def self.fetch_object_by_uid(class_name, uid)
      Rails.cache.fetch("#{class_name.name.downcase}_#{uid}") do
        class_name.find_by(uid: uid)
      end
    end

    def self.load_outcomes_for_market(market)
      Rails.cache.fetch("load_outcomes_#{market.uid}_#{market.updated_at.to_i}") do
        market.outcomes
      end
    end

    def self.default_cache_market(match)
      Rails.cache.fetch(Utility::Cache.odds_change_cache_key(match.is_a?(Match) ? match.id : match)) || { markets: {} }
    end

    def self.competitor_goals(competitor)
      ["match_id_#{competitor.match_id}_competitor_id#{competitor.id}", :goals]
    end

    def self.enabled_markets_uids
      Rails.cache.fetch(:enabled_markets_uids) do
        Market.pluck(:uid)
      end
    end

    def self.player_bet_slips_cache_key(user_id)
      ["bet_slips_#{user_id}", :player_bet_slip_data]
    end

    def self.user_todays_debit_key(user_id)
      "user_#{user_id}_debit_amount_#{Time.zone.now.to_date.to_s}"
    end

    def self.sorted_sport_markets_key(sport_id:)
      "sport_markets_#{sport_id}"
    end

    def self.disabled_sport_markets_key(sport_id:)
      "disabled_sport_markets_#{sport_id}"
    end

    def self.enabled_sport_markets_key(sport_id:)
      "enabled_sport_markets_#{sport_id}"
    end
  end
end
