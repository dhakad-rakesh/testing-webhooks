module Api
  module EntityDescriptions
    # Player profile
    # Defines Name and details about a player
    def player_profile(player_id)
      get("sports/en/players/#{player_id}/profile.xml")
    end

    # Competitor information
    # Name and details about a competitor
    def competitor_information(competitor_id)
      get("soccerstats/team/#{competitor_id}")
    end
  end
end
