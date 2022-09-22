class Tournament < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  default_scope { i18n }

  include Favouriteable

  enum tournament_type: { pending: 0, league: 1, tournament: 2, cup: 3 }

  belongs_to :sport
  belongs_to :country
  validates :uid, presence: true
  validates :uid, uniqueness: { scope: :country_id }

  has_many :team_tournaments, dependent: :nullify
  has_many :teams, through: :team_tournaments
  has_many :matches, dependent: :destroy
  has_many :seasons, dependent: :destroy
  has_many :seasons, dependent: :destroy
  has_many :bets # rubocop:disable Rails/HasManyOrHasOneDependent

  before_save :update_matches, if: :enabled_changed?

  scope :sort_by_favourites, -> { left_outer_joins(:favourites).order('favourites.created_at') }
  scope :active_tournaments, -> { where(enabled: true) }
  scope :search, -> (query) { active_tournaments_with_number_of_matches.i18n { name.lower.matches("%#{query.to_s.downcase}%") } }
  scope :active_tournaments_by_countries, lambda { |countries|
                                            joins(matches: :venue).where(
                                              enabled: true,
                                              matches: {
                                                enabled: true,
                                                venues: { country_name: Array.wrap(countries).map(&:downcase) }
                                              }
                                            )
                                          }
  scope :active_tournaments_by_continent, lambda { |continents|
                                            joins(matches: :venue).where(
                                              enabled: true,
                                              matches: {
                                                enabled: true,
                                                venues: { continent: Array.wrap(continents).map(&:downcase) }
                                              }
                                            )
                                          }
  scope :active_tournaments_with_active_matches, lambda {
    active_tournaments.where(id: Match.active_matches.pluck(:tournament_id).uniq)
  }

  scope :active_tournaments_with_live_matches, lambda {
    active_tournaments.where(id: Match.live.pluck(:tournament_id).uniq)
  }
  scope :filter_by_sport, -> (sport_id) { where(sport_id: sport_id) }
  scope :filter_by_country, -> (country_id) { where(country_id: country_id) }
  scope :active_tournaments_with_number_of_matches, -> {
    active_tournaments.where('number_of_matches > ?', 0)
  }

  scope :sort_by_rank, -> { order(:rank) }
  scope :favourites_by_user, -> (user) { active_tournaments_with_active_matches.where(id: user.favourite_tournaments.values) }

  after_save :remove_tournament_cache

  def fancy_name
    return display_name if display_name.present?
    name
  end

  def remove_tournament_cache
    Rails.cache.delete(:enabled_tournament_uid)
  end

  def update_matches
    ActiveRecord::Base.transaction do
      matches.available_matches.update_all(enabled: enabled)
    end
  end

  def enabled!
    update(enabled: true)
  end

  def self.enabled_tournament_uid
    Rails.cache.fetch(:enabled_tournament_uid, expire_in: Constants::CACHE_EXPIRE_TIME.days) do
      active_tournaments.pluck(:uid)
    end
  end

  def self.get_by_uid_and_country_uid(tournament_uid, country_uid)
    Tournament.joins(:country).where('tournaments.uid = ? AND countries.uid = ?',tournament_uid.to_s, country_uid.to_s).first
  end

  def self.get_id_by_uid_and_country_uid(tournament_uid, country_uid)
    Tournament.joins(:country).where('tournaments.uid = ? AND countries.uid = ?',tournament_uid.to_s, country_uid.to_s).limit(1).pluck(:id).first
  end
end
