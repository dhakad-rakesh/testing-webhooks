class Competitor < ApplicationRecord
  belongs_to :team
  belongs_to :match

  delegate :name, to: :team

  def goals
    Rails.cache.fetch(Utility::Cache.competitor_goals(self)) do
      "Unavailable"
    end
  end
end
