class TeamPlayer < ApplicationRecord
  validates :uid, uniqueness: true
  belongs_to :team
  has_many :match_outcomes, as: :outcomeable, dependent: :destroy

  def self.fetch_by_uid(uid)
    Rails.cache.fetch("team_player_#{uid}", expire_in: Constants::CACHE_EXPIRE_TIME.days) do
      TeamPlayer.find_by(uid: uid)
    end
  end
end
