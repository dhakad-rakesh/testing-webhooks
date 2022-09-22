module GS
  module SpecifierMarket

    def fetch_goals_over_under(match_data, specifier_text)
      # {"total"=>"0.5"}
      localteam_score, visitorteam_score = fetch_scores(match_data)
      total_score = localteam_score + visitorteam_score
      # assuming total is the only key
      return 'Over' if total_score > specifier_text["handicap"].to_f
      'Under'
    end

    def fetch_scores(match_data, time = 'ft')
      #match_data[time.to_sym][:score].gsub('[', '').gsub(']', '').split('-')
      half = time == 'ht' ? :"1" : :"2"
      match_data[:results][:"0"][:scores][half].values.map(&:to_i)
    end

    # not sure
    def fetch_match_goals(match_data, specifier_text)
      # {"total"=>"0.5"}
      localteam_score, visitorteam_score = fetch_scores(match_data)
      total_score = localteam_score + visitorteam_score
      # assuming total is the only key
      return 'Over' if total_score > specifier_text["handicap"].to_f
      'Under'
    end

    def fetch_goal_sequence(match_data, specifier_text)
      # handicap => 1st Goal, 2nd Goal etc
      goal_text = specifier_text["handicap"]
      match_data[:results][:"0"][:events].each do |event_id, event_data|
        if event_data[:text].include? "- #{goal_text} -"
          return "Home" if event_data[:text].include? match_data[:results][:"0"][:home][:name]
          return "Away" if event_data[:text].include? match_data[:results][:"0"][:away][:name]
        end
      end
      "No"
    end

    def fetch_first_half_goals(match_data, specifier_text)
      localteam_score, visitorteam_score = fetch_scores(match_data, 'ht')
      first_half_total_score = localteam_score + visitorteam_score
      return 'Over' if first_half_total_score > specifier_text["handicap"].to_f
      'Under'
    end

    # CORNERS MARKET STARTED
    def fetch_2_way_corners(match_data, specifier_text)
      #commentaries XML
      total_corners = match_data[:stats][:localteam][:corners].total.to_f + 
        match_data[:stats][:visitorteam][:corners].total.to_f
      return 'Over' if total_corners > specifier_text["handicap"].to_f
      'Under'
    end

    def fetch_1st_half_corners(match_data, specifier_text)
      # three way market based on specifier. 
      total_corners = match_data[:stats][:localteam][:corners].total.to_f +
        match_data[:stats][:visitorteam][:corners].total.to_f
      return 'Exact' if total_corners == specifier_text["handicap"].to_f
      total_corners > specifier_text["handicap"].to_f ? 'Over' : 'Under'
    end

    #http://footballbetmasters.com/corners-betting-guide/
    def fetch_alternative_total_corners(match_data, specifier_text)
      # three way market based on specifier. 
      total_corners = match_data[:stats][:localteam][:corners].total.to_f +
        match_data[:stats][:visitorteam][:corners].total.to_f
      return 'Exact' if total_corners == specifier_text["handicap"].to_f
      total_corners > specifier_text["handicap"].to_f ? 'Over' : 'Under'
    end

    def fetch_total_corners(match_data, specifier_text)
      # 1780 "Over", "Under", "Exactly"
      total_corners = match_data[:results][:"0"][:stats][:corners][:"0"].to_i + match_data[:results][:"0"][:stats][:corners][:"1"].to_i
      return "Exactly" if total_corners == specifier_text["handicap"].to_i
      total_corners > specifier_text["handicap"].to_i ? "Over" : "Under"
    end

    def fetch_asian_corners(match_data, specifier_text)
      total_corners = match_data[:stats][:localteam][:corners].total.to_f +
        match_data[:stats][:visitorteam][:corners].total.to_f
      return 'void' if total_corners == specifier_text["handicap"].to_f
      total_corners > specifier_text["handicap"].to_f ? 'Over' : 'Under'
    end

    def fetch_1st_half_asian_corners(match_data, specifier_text)
      # same code
      total_corners = match_data[:stats][:localteam][:corners].total.to_f +
        match_data[:stats][:visitorteam][:corners].total.to_f
      return 'void' if total_corners == specifier_text["handicap"].to_f
      total_corners > specifier_text["handicap"].to_f ? 'Over' : 'Under'
    end
    # CORNERS MARKET ENDED

    # HANDICAP MARKETS STARTED
    def fetch_asian_handicap(match_data, specifier_text)
      # {name=-0.5} {name=-2.5} {name=2} # 2 way(-1.5) only if draw occure the bet will be void(refunded)
      fetch_handicap(match_data, specifier_text)
    end

    def fetch_asian_handicap_first_half(match_data, specifier_text)
      # {name=-0.5} {name=-2.5} {name=2} # 2 way(-1.5) only if draw occure the bet will be void(refunded)
      fetch_handicap(match_data, specifier_text, 'ht')      
    end

    def fetch_handicap_result(match_data, specifier_text)
      # 3 way home/away/draw
      result = fetch_handicap(match_data, specifier_text)
      result == 'void' ? 'Draw' : result
    end

    def fetch_handicap_result_1st_half(match_data, specifier_text)
      # 3 way home/away/draw
      result = fetch_handicap(match_data, specifier_text, 'ht')
      result == 'void' ? 'Draw' : result
    end

    def fetch_handicap(match_data, specifier_text, time = 'ft')
      localteam_score, visitorteam_score = match_data[time.to_sym][:score].gsub('[', '').gsub(']', '').split('-').map(&:to_f)
      localteam_score = localteam_score + specifier_text["name"].to_f
      return 'void' if localteam_score == visitorteam_score
      return  'Home' if localteam_score > visitorteam_score
      'Away'
    end
    # HANDICAP MARKETS ENDED
  end
end
