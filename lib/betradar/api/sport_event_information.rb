module Api
  module SportEventInformation
    # Summary information about a sport event
    def summary(event_id, event_type = 'sr:match')
      get("sports/en/sport_events/#{event_type}:#{event_id}/summary.xml")
    end

    # Information about an ongoing sport event
    # Detailed information (including event timeline) for a sport event.
    # Prematch, Live or Post-match. Prematch info is very brief .
    # Postmatch the results are there
    def event_info(event_id, event_type = 'sr:match')
      get("sports/en/sport_events/#{event_type}:#{event_id}/timeline.xml")
    end

    # All available categories for a sport
    def categories(sport_id)
      get("sports/en/sports/sr:sport:#{sport_id}/categories.xml")
    end

    # All available tournaments for a sport
    def sport_tournaments(sport_id)
      get("sports/en/sports/sr:sport:#{sport_id}/tournaments.xml")
    end

    # All available sports
    def sports
      get('sports/en/sports.xml')
    end

    # All available tournaments for all sports
    def tournaments
      get('sports/en/tournaments.xml')
    end

    # Basic information about a tournament (name, start/end date, list of competitors)
    def tournaments_info(tournament_id, tournament_type = 'sr:tournament')
      get("sports/en/tournaments/#{tournament_type}:#{tournament_id}/info.xml")
    end

    # All available seasons for tournament
    def tournament_season(id, type = 'sr:tournament')
      get("sports/en/tournaments/#{type}:#{id}/seasons.xml")
    end
  end
end
