class SportMarket < ApplicationRecord
  belongs_to :sport
  belongs_to :market
  validates :market_id, uniqueness: { scope: :sport_id }

  after_validation :define_priority

  delegate :name, :uid, :fancy_name, :categories, to: :market

  scope :sport_markets, ->(sport_id) { where(sport_id: sport_id) }
  scope :sorted, -> { order(:priority) }
  scope :disabled, -> { where(visible: false) }
  scope :enabled, -> { where(visible: true) }

  private

  def self.sport_markets_ids(sport_id:)
    Rails.cache.fetch(Utility::Cache.sorted_sport_markets_key(sport_id: sport_id)) do
      SportMarket.sport_markets(sport_id)
                 .sorted
                 .map(&:uid)
    end
  end

  def self.enabled_sport_markets_ids(sport_id:)
    Rails.cache.fetch(Utility::Cache.enabled_sport_markets_key(sport_id: sport_id)) do
      SportMarket.sport_markets(sport_id).enabled.map(&:uid)
    end
  end

  def self.disabled_sport_markets_ids(sport_id:)
    Rails.cache.fetch(Utility::Cache.disabled_sport_markets_key(sport_id: sport_id)) do
      SportMarket.sport_markets(sport_id).disabled.map(&:uid)
    end
  end

  def define_priority
    return if priority

    self.priority = market.priority
  end
end
