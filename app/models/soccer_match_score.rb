class SoccerMatchScore < ApplicationRecord
  belongs_to :match
  include Scoreable

  PERIOD = { '6' => '1st Half', '7' => '2nd Half' }.freeze

  def match_statistics
    parsed_statistics
  end

  def periods
    periods = {}
    Array.wrap(parsed_period_scores).each do |period|
      periods[PERIOD[period['match_status_code']]] = replace_by_competitors(period.slice('home_score', 'away_score'))
    end
    periods
  end

  def parsed_period_scores
    JSON.parse period_scores.values
                            .first
                            .gsub(/:(\w+)/) { "\"#{Regexp.last_match(1)}\"" }
                            .gsub('=>', ':')
  end

  def parsed_statistics
    match_statistics = statistics
    match_statistics.each_key do |k|
      match_statistics[k] = JSON.parse match_statistics[k]
                            .gsub(/:(\w+)/) { "\"#{Regexp.last_match(1)}\"" }.gsub('=>', ':')
      replace_by_competitors(match_statistics[k])
    end
    match_statistics
  end

  def team_name(competitor)
    competitor.name
  end

  def replace_by_competitors(score)
    keys = score.keys
    match.competitors.each do |c|
      score[team_name(c).to_s] = score.delete(keys.select { |k| k.include?(c.qualifier) }.first)
    end
    score
  end
end
