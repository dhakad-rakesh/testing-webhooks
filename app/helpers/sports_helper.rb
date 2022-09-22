module SportsHelper
  def searched_matches(matches, team_ids)
    matches.select{ |match| searched_teams?(match, team_ids) }
  end

  def searched_teams(match, team_ids)
    (team_ids&match.team_ids)
  end

  def searched_teams?(match, team_ids)
    searched_teams(match, team_ids).present?
  end
end
