class Outcome < ApplicationRecord
  has_and_belongs_to_many :markets
  # has_many :match_outcomes, as: :outcomeable, dependent: :destroy
  has_many :matches, through: :match_outcomes
  # has_many :bets, dependent: :nullify

  def self.find_uid(uid)
    Rails.cache.fetch([:outcome_uid, uid], expire_in: Constants::CACHE_EXPIRE_TIME.days) do
      Outcome.find_by(uid: uid)
    end
  end
end
