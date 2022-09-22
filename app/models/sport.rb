class Sport < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  default_scope { i18n }

  include Favouriteable
  include EsportsMapping

  has_many :seasons, dependent: :destroy
  has_many :tournaments, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :bets, through: :matches
  has_many :sport_markets, dependent: :destroy
  has_many :markets, through: :sport_markets
  has_many :teams, dependent: :destroy
  has_many :sport_countries, dependent: :nullify
  has_many :countries, through: :sport_countries
  enum status: { active: 0, disabled: 1 }
  validates :uid, uniqueness: true

  KINDS = {
    sports: SPORTS = 'sports',
    esports: ESPORTS = 'esports'
  }

  enum kind: KINDS

  #before_save :update_matches_and_tournaments, if: :enabled_changed?

  scope :sort_by_favourites, -> { left_outer_joins(:favourites).order('favourites.created_at') }

  scope :active_sports, -> { where(enabled: true) }
  scope :disabled_sports, -> { where(enabled: false) }

  scope :search, -> (query) { active_sports.sort_by_rank.where('name ilike ?', "%#{query}%") }
  scope :main_sport, -> { where(name: 'Soccer').first }
  scope :sorted, -> { order('created_at') }
  scope :sort_by_rank, -> { order('rank') }
  scope :visible, -> { where.not(uid: Sport::ESPORTS_ID).order(:rank) }
  scope :available_for_user, -> (user) { visible.where.not(id: user.disabled_sports) }
  scope :favourites_by_user, -> (user) { available_for_user(user).where(id: user.favourite_sports.values) }

  def supported_sport?
    Constants::SUPPORTED_SPORTS.include?(name)
  end

  def update_matches_and_tournaments
    ActiveRecord::Base.transaction do
      tournaments.map { |tournament| tournament.update!(enabled: enabled) }
      matches.available_matches.map { |match| match.update!(enabled: enabled) }
    end
  end

  def name_underscore
    name.parameterize.downcase.underscore
  end

  def soccer?
    name.casecmp?('soccer')
  end

  def supported_market_uids
    markets.pluck(:uid)
  end

  def fancy_name
    return display_name if display_name.present?
    name
  end

  def available_countries_with_matches
    countries.enabled.with_matches
  end
end
