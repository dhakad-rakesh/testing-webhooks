class Team < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  default_scope { i18n }

  include Favouriteable

  belongs_to :sport
  validates :uid, uniqueness: true
  has_many :competitors, dependent: :nullify
  has_many :matches, through: :competitors
  has_many :team_tournaments, dependent: :nullify
  has_many :tournaments, through: :team_tournaments
  has_many :team_players, dependent: :destroy

  scope :sort_by_favourites, -> { left_outer_joins(:favourites).order('favourites.created_at') }
  scope :with_active_matches, -> { where(id: Match.active_within_7_days.map(&:team_ids).flatten.uniq) }
  scope :favourites_by_user, -> (user) { with_active_matches.where(id: user.favourite_teams.values) }
  scope :search, -> (query) { with_active_matches.i18n { name.lower.matches("%#{query.to_s.downcase}%") } }
end
