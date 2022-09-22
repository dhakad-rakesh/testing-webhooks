module Api
  module StaticSportEventInformation
    # All sport events for a specific day
    def schedules(postfix_url)
      get(postfix_url)
    end

    def live_odds(cat = 'soccer_10')
      get("getodds/soccer?cat=#{cat}")
    end

    def prematch_odds(postfix_url)
      get(postfix_url)
    end

    def inplay_result(post_match_url)
      get(post_match_url)
    end
  end
end
