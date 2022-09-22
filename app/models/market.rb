class Market < ApplicationRecord
  extend Mobility
  translates :name, type: :string
  default_scope { i18n }

  include Extensions::Market::SubstituteNameTag
  include SoccerFilters
  include MarketPriorityMapping
  include MarketCategoryMapping

  before_validation :define_priority, if: :name_changed?

  GOAL_SEQUENCE_MARKET_UID = '1778'
  MARKET_NAME_REGEX = /[-!+$\w\s]+?/
  NAME_REGEX = Regexp.new("({(#{MARKET_NAME_REGEX})})").freeze
  enum status: { disabled: 0, enabled: 1 }.freeze

  store :settings, coder: Hash, accessors: %I[period display_name liability provider]

  scope :top_five, lambda {
                     joins(:bets).select('market_id, markets.id, name, count(*) as bet_count')
                                 .group(:market_id, :name, :id)
                                 .order('bet_count desc')
                                 .limit(5)
                   }

  has_and_belongs_to_many :outcomes, dependent: :nullify
  has_many :match_outcomes, dependent: :nullify
  has_many :bets, dependent: :nullify
  has_many :category_joins, as: :categorizable, dependent: :destroy
  has_many :categories, through: :category_joins
  belongs_to :bet_type, optional: true
  belongs_to :play_type, optional: true
  store_accessor :specifier_text

  scope :soccer_supported_markets, -> { where(uid: Constants::SOCCER_SUPPORTED_MARKETS) }
  scope :soccer_player_markets, -> { where(uid: Constants::SOCCER_SUPPORTED_PLAYER_MARKETS) }
  scope :pre_match_markets, -> { where(uid: Constants::PREMATCH_MARKETS) }
  scope :specifier_markets, -> { where(is_specifier_market: true) }
  scope :enable, -> { where(enabled: true) }
  scope :disable, -> { where(enabled: false) }
  scope :active_markets, -> { where(settings: {provider: 'lsports'}, enabled: true).sorted }
  scope :sorted, -> { order(:priority) }

  after_save :remove_market_uid_cache

  def active_match_outcomes(match_id)
    match_outcomes.where(match_id: match_id, status: '1')
  end

  def period
    super || ''
  end

  def fancy_name
    display_name || name
  end

  def lsport?
    self.provider == 'lsports'
  end

  # def display_name
  #   super || ''
  # end

  # def display_name
  #   super || 0
  # end

  def self.player_market_ids
    Rails.cache.fetch(:player_market_ids, expire_in: 3.hours) do
      soccer_player_markets.pluck(:id)
    end
  end

  def self.player_market?(market_id)
    player_market_ids.include?(market_id)
  end

  def self.find_uid(uid)
    Rails.cache.fetch([:market_uid, uid], expire_in: Constants::CACHE_EXPIRE_TIME.days) do
      Market.find_by(uid: uid)
    end
  end

  def remove_market_uid_cache
    Rails.cache.delete([:market_uid, uid])
  end

  def outcome_result(result_text, outcome_name)
    return outcome_name.include?(result_text) && 1.0 || 0 if is_double_chance?
    outcome_name == result_text && 1.0 || 0
  end

  def is_double_chance?
    #self.bet_type&.name.to_s == "double chance"
    name.downcase.include?('double chance')
  end

  def self.markets_enable_ids
    Rails.cache.fetch(:markets_enable_ids) do
      Market.enable.order(:priority).pluck(:uid)
    end
  end

  def self.disable_markets_ids
    Rails.cache.fetch(:disable_markets_ids) do
      Market.disable.order(:priority).pluck(:uid)
    end
  end

  def self.all_markets_ids
    Rails.cache.fetch(:all_markets_ids) do
      Market.order(:priority).pluck(:uid)
    end
  end

  def define_priority
    return if priority

    matched = PRIORITIES_MAP.detect do |rule|
      name =~ rule[:pattern]
    end

    self.priority = matched ? matched[:priority] : DEFAULT_PRIORITY
  end
end
