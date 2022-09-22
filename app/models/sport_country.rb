class SportCountry < ApplicationRecord
  belongs_to :sport
  belongs_to :country
  validates :sport_id, uniqueness: { scope: :country_id }

  scope :filter_by_sport, -> (sport_id) { where(sport_id: sport_id) }
  scope :with_matches, -> { where("sport_countries.number_of_matches > ?", 0) }

  scope :enabled, ->  { includes(:country).where('countries.enabled': true).order('countries.rank') }
  scope :sorted_by_name, -> { order('countries.name') }
  scope :sorted_by_rank, -> { order(:rank) }
end
