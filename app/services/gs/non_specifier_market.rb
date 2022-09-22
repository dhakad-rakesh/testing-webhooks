module GS
  module NonSpecifierMarket

    def fetch_3way_result(match_data)
      localteam_score, visitorteam_score = fetch_scores(match_data)
      return 'X' if localteam_score == visitorteam_score
      return '1' if localteam_score > visitorteam_score
      '2'
    end

    def fetch_draw_no_bet(match_data)
      return fetch_home_away(match_data) if @market.uid == '6'
      #10563 inplay market
      localteam_score, visitorteam_score = fetch_scores(match_data)
      return 'void' if localteam_score == visitorteam_score
      return 'Home' if localteam_score > visitorteam_score
      'Away'
    end

    def fetch_home_away(match_data)
      localteam_score, visitorteam_score = fetch_scores(match_data)
      return 'void' if localteam_score == visitorteam_score
      return '1' if localteam_score > visitorteam_score
      '2'
    end

    # RESULT MARKET STARTED
    def fetch_full_time_result(match_data)
      # outcome name => 1X2
      fetch_match_result(match_data)
    end

    def fetch_fulltime_result(match_data)
      # outcome name => Home X Away
      localteam_score, visitorteam_score = fetch_scores(match_data)
      return 'X' if localteam_score == visitorteam_score
      return 'Home' if localteam_score > visitorteam_score
      'Away'
    end

    def fetch_result_both_teams_to_score(match_data)
      #8 prematch
      localteam_score, visitorteam_score = fetch_scores(match_data)
      result =  if localteam_score == visitorteam_score
                  "Draw"
                elsif localteam_score > visitorteam_score
                  "Home"
                else
                  "Away"
                end
      return "#{result} Yes" if localteam_score.to_f.positive? && visitorteam_score.to_f.positive?
      "#{result} No"
    end

    def fetch_result___both_teams_to_score(match_data)
      #50461 inplay
      localteam_score, visitorteam_score = fetch_scores(match_data)
      result =  if localteam_score == visitorteam_score
                  "X"
                elsif localteam_score > visitorteam_score
                  "Home"
                else
                  "Away"
                end
      return "#{result} & Yes" if localteam_score.to_f.positive? && visitorteam_score.to_f.positive?
      "#{result} & No"
    end

    # def fetch_match_winner(match_data)
    #   # outcome name => Home / Away / Draw
    #   fetch_match_result(match_data)
    # end

    def fetch_half_time_result(match_data)
      #return unless Match::GS_STATUSES_FINISHED.include? match_data[:info][:period]
      localteam_score, visitorteam_score = fetch_scores(match_data)
      return_outcome_name(localteam_score, visitorteam_score)
    end

    def return_outcome_name(localteam_score, visitorteam_score)
      return 'X' if localteam_score == visitorteam_score
      return localteam_score > visitorteam_score ? '1' : '2' if @market.uid == '13'
      localteam_score > visitorteam_score ? 'Home' : 'Away'
    end

    def fetch_match_result(match_data, time = 'ft')
      #return unless Match::GS_STATUSES_FINISHED.include? match_data[:info][:period]
      localteam_score, visitorteam_score = fetch_scores(match_data)
      return 'X' if localteam_score == visitorteam_score
      return '1' if localteam_score > visitorteam_score
      '2'
    end

    # RESULT MARKET ENDED

    # CORRECT SCORE MARKET STARTED
    def fetch_correct_score(match_data)
      # outcome 3:0 2:4 1:5 0:6 7:8 
      #return unless Match::GS_STATUSES_FINISHED.include? match_data[:info][:period]
      localteam_score, visitorteam_score = fetch_scores(match_data)
      correct_score_outcome(localteam_score, visitorteam_score)
    end

    def fetch_half_time_correct_score(match_data)
      # outcome 3:0 2:4 1:5 0:6 7:8 
      localteam_score, visitorteam_score = fetch_scores(match_data, 'ht')
      correct_score_outcome(localteam_score, visitorteam_score)
    end

    def correct_score_outcome(localteam_score, visitorteam_score)
      outcome_name = "#{localteam_score}-#{visitorteam_score}"
      return "X #{outcome_name}" if localteam_score == visitorteam_score
      return "Home #{outcome_name}" if localteam_score > visitorteam_score
      "Away #{outcome_name}"
    end  
    # CORRECT SCORE MARKET ENDED

    def fetch_both_teams_to_score(match_data)
      # yes or no
      localteam_score, visitorteam_score = fetch_scores(match_data)
      return 'Yes' if localteam_score.to_f.positive? && visitorteam_score.to_f.positive?
      'No'
    end

    def fetch_both_teams_to_score_in_1st_half(match_data)
      # yes or no
      localteam_score, visitorteam_score = fetch_scores(match_data, 'ht')
      return 'Yes' if localteam_score.to_f.positive? && visitorteam_score.to_f.positive?
      'No'
    end

    #copy of above method
    def fetch_both_teams_to_score___1st_half(match_data)
      # yes or no
      localteam_score, visitorteam_score = fetch_scores(match_data, 'ht')
      return 'Yes' if localteam_score.to_f.positive? && visitorteam_score.to_f.positive?
      'No'
    end

    def fetch_both_teams_to_score_in_2nd_half(match_data)
      # yes or no
      ht_localteam_score, ht_visitorteam_score = fetch_scores(match_data, 'ht')
      ft_localteam_score, ft_visitorteam_score = fetch_scores(match_data)
      return 'Yes' if (ft_localteam_score.to_i - ht_localteam_score.to_i).positive? &&
        (ft_visitorteam_score.to_i - ht_visitorteam_score.to_i).positive?
      'No'
    end

    #copy of above method
    def fetch_both_teams_to_score___2nd_half(match_data)
      # yes or no
      ht_localteam_score, ht_visitorteam_score = fetch_scores(match_data, 'ht')
      ft_localteam_score, ft_visitorteam_score = fetch_scores(match_data)
      return 'Yes' if (ft_localteam_score.to_i - ht_localteam_score.to_i).positive? &&
        (ft_visitorteam_score.to_i - ht_visitorteam_score.to_i).positive?
      'No'
    end

    def fetch_double_chance(match_data)
      # "Draw/Away" "Home/Away" "Home/Draw"
      #return unless Match::GS_STATUSES_FINISHED.include? match_data[:info][:period]
      localteam_score, visitorteam_score = fetch_scores(match_data)
      return 'X' if localteam_score == visitorteam_score
      if @market.uid == "3"
        return '1' if localteam_score > visitorteam_score
        return '2'
      else
        return 'Home' if localteam_score > visitorteam_score
        return 'Away'
      end
    end


    #### PREGAME MARKETS

    # DOUBLE CHANGE START
    def fetch_half_time_double_chance(match_data)
      # "Draw/Away" "Home/Away" "Home/Draw"
      localteam_score, visitorteam_score = fetch_scores(match_data, 'ht')
      return 'X' if localteam_score == visitorteam_score
      return  '1' if localteam_score > visitorteam_score
      '2'
    end

    # def fetch_double_chance___1st_half(match_data)
    #   # "Draw/Away" "Home/Away" "Home/Draw"
    #   fetch_ht_ft_result(match_data, 'ht')
    # end

    def fetch_half_time_full_time(match_data)
      # ht/ft => draw/draw home/home away/away draw/home draw/away home/draw home/away away/draw away/home total 9 outcome
      "#{fetch_ht_ft_result(match_data, 'ht')} - #{fetch_ht_ft_result(match_data)}"      
    end

    def fetch_ht_ft_result(match_data, time = 'ft')
      localteam_score, visitorteam_score = fetch_scores(match_data, time)
      return 'X' if localteam_score == visitorteam_score
      return  'Home' if localteam_score > visitorteam_score
      'Away'
    end
    # DOUBLE CHANGE END

    # GOALS MARKET STARTED
    def fetch_goals_odd_even(match_data)
      localteam_score, visitorteam_score = fetch_scores(match_data)
      (localteam_score + visitorteam_score).odd? ? 'Odd' : 'Even'
    end

    def fetch_home_team_odd_even_goals(match_data)
      #return unless Match::GS_STATUSES_FINISHED.include? match_data[:info][:period]
      localteam_score, visitorteam_score = fetch_scores(match_data)
      localteam_score.odd? ? 'Home - Odd' : 'Home - Even'
    end

    def fetch_away_team_odd_even_goals(match_data)
      #return unless Match::GS_STATUSES_FINISHED.include? match_data[:info][:period]
      localteam_score, visitorteam_score = fetch_scores(match_data)
      visitorteam_score.odd? ? 'Away - Odd' : 'Away - Even'
    end

    def fetch_1st_half_goals_odd_even(match_data)
      localteam_score, visitorteam_score = fetch_scores(match_data, 'ht')
      (localteam_score + visitorteam_score).odd? ? 'Odd' : 'Even'
    end

    def fetch_2nd_half_goals_odd_even(match_data)
      ft_localteam_score, ft_visitorteam_score = fetch_scores(match_data)
      ht_localteam_score, ht_visitorteam_score = fetch_scores(match_data, 'ht')
      second_half_score = (ft_localteam_score - ht_localteam_score) + (ft_visitorteam_score - ht_visitorteam_score)
      second_half_score.odd? ? 'Odd' : 'Even'
    end

    def fetch_highest_scoring_half(match_data)
      # Draw   1st Half   2nd Half
      first_half_score = fetch_scores(match_data, 'ht').sum(&:to_i)
      second_half_score = fetch_scores(match_data).sum(&:to_i)
      return 'Draw' if first_half_score == second_half_score
      first_half_score > second_half_score ? '1st Half' : '2nd Half'
    end

    def fetch_home_team_highest_scoring_half(match_data)
      # Draw   1st Half   2nd Half
      first_half_score = fetch_scores(match_data, 'ht').first
      second_half_score = fetch_scores(match_data).first
      second_half_score = second_half_score - first_half_score
      return 'Home - Tie' if first_half_score == second_half_score
      first_half_score > second_half_score ? 'Home - 1st Half' : 'Home - 2nd Half'
    end

    def fetch_away_team_highest_scoring_half(match_data)
      # Draw   1st Half   2nd Half
      first_half_score = fetch_scores(match_data, 'ht').last
      second_half_score = fetch_scores(match_data).last
      second_half_score = second_half_score - first_half_score
      return 'Away - Tie' if first_half_score == second_half_score
      first_half_score > second_half_score ? 'Away - 1st Half' : 'Away - 2nd Half'
    end
    # GOALS MARKET ENDED

    def fetch_scores(match_data, time = 'ft')
      #match_data[time.to_sym][:score].gsub('[', '').gsub(']', '').split('-')
      half = time == 'ht' ? :"1" : :"2"
      match_data[:results][:"0"][:scores][half].values.map(&:to_i)
    end

    # def fetch_live_score(match_data)
    #   match_data[:info][:score].split(":").map(&:to_i)
    # end

    def fetch_70_mins_result(match_data)
      # test the market should disable before 50 - 70 minute
      return unless match_data[:info][:minute] == "70"
      home_score, away_score = fetch_live_score(match_data)
      return 'X' if home_score == away_score
      home_score > away_score ? 'Home' : 'Away'
    end

    def fetch_80_mins_result(match_data)
      # test the market should disable before 50 - 80 minute
      return unless match_data[:info][:minute] == "80"
      home_score, away_score = fetch_live_score(match_data)
      return 'X' if home_score == away_score
      home_score > away_score ? 'Home' : 'Away'
    end
  end
end
