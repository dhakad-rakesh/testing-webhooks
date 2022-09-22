module Score
  class MatchScore < Score::Base
    set_callback :validate, :after, -> { set_attributes }

    def execute
      # call association
      # match.soccer_match_scores / match.tennis_match_scores / american_football_match_scores
      return unless score_attributes
      return if score_attributes[:match_status] == '0'
      match_score = match.send("#{sport_type}_match_scores").build
      match_score.assign_attributes(score_attributes)
      match_score.save(validate: false) && match_score
    end

    private

    # We will have multiple methods like soccer_attributes and american_football_attributes etc.
    # Sport name in underscore formate followed by _attributes
    # According to name of sport name
    def set_attributes
      self.sport_type = Utility::Sport.info(@match).name_underscore
      send("#{sport_type}_score_attributes") if sport_type == 'soccer'
    end

    def soccer_score_attributes
      self.sport_event_status = sport_event_status.with_indifferent_access
      statistics = sport_event_status[:statistics] || {}
      self.score_attributes =
        fetch_attributes(sport_event_status).merge(
          statistics: statistics,
          home_corners: statistics[:corners] && statistics[:corners][:home] || nil,
          away_corners: statistics[:corners] && statistics[:corners][:away] || nil
        ).with_indifferent_access
    end

    def cricket_score_attributes
      self.sport_event_status = sport_event_status.with_indifferent_access
      self.score_attributes = fetch_attributes(sport_event_status)
    end

    def tennis_score_attributes
      self.sport_event_status = sport_event_status.with_indifferent_access
      self.score_attributes = fetch_attributes(sport_event_status)
    end

    def fetch_attributes(sport_event_status)
      Constants.const_get("#{sport_type.upcase}_SCORE_ATTRIBUTES").map do |key|
        { key => sport_event_status[key] }
      end.inject(&:merge)
    end
  end
end
