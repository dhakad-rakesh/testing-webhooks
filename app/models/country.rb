class Country < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  default_scope { i18n }

  has_many :tournaments
  has_many :sport_countries, dependent: :nullify
  has_many :sports, through: :sport_countries

  scope :sorted, -> { order(:rank) }
  scope :enabled, -> { where(enabled: true) }
  scope :with_matches, -> { joins(:sport_countries).where("sport_countries.number_of_matches > ?", 0)
                                                   .distinct
                                                   .sorted }
end
