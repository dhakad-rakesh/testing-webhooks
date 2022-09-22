module Scoreable
  extend ActiveSupport::Concern
  included do
    after_create :update_match
  end

  def update_match
    match.update(score: { home_score: home_score, away_score: away_score })
  end
end
