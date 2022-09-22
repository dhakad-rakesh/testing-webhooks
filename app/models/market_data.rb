class MarketData
  include Mongoid::Document

  MARKET_SELECTOR = 'odds_data.markets.%{uid}.49.outcomes'

  field :match_id, type: Integer
  field :snapshot_time, type: Time
  field :odds_data

  index({ match_id: 1 })
  index({ match_id: 1, snapshot_time: 1 }, { unique: true })

  validates :match_id, :snapshot_time, :odds_data, presence: true
  validates :match_id, uniqueness: { scope: :snapshot_time }

  scope :by_match, -> (id) { where(match_id: id) }
  scope :between, -> (start_time, end_time) { where(snapshot_time: start_time..end_time) }

  def self.filter_by_market_uid(uid)
    pluck(:snapshot_time, MARKET_SELECTOR % {uid: uid}).sort_by { |time, _| time }
  end
end