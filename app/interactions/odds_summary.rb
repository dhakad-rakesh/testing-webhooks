# OddsSummary gives all the timestamps and odds of all outcomes for a given market
# (for a specific identifier or match).
class OddsSummary < ApplicationInteraction
  object :match
  integer :market_id
  integer :identifier

  set_callback :type_check, :before, :set_market
  set_callback :type_check, :before, :set_data

  # We fetch the odds data from firebase
  def execute
    content = { 'outcomes' => {} }
    fetch_odds_summary_data.each do |outcome_key, outcome_value|
      specifiers = outcome_value['timestamps'].values.first['specifiers']
      outcome_uid = extract_data_from_key(outcome_key)
      outcome = Outcome.find_by(uid: outcome_uid)
      content['outcomes'][outcome.id.to_s] = {
        'name' => outcome_name(outcome, specifiers),
        'odds_summary' => generate_outcome_odds_summary(outcome_value)
      }
    end
    content
  end

  private

  # self NOTE : This is slow when data is larges
  def fetch_odds_summary_data
    firebase_client.get(odds_summary_firebase_url)&.body || {}
  end

  def set_market
    @market = Market.find_by(id: market_id)
    errors.add(:market, 'not found') if @market.blank?
  end

  def firebase_client
    # @firebase_client ||= #Firebase::Client.new(Figaro.env.firebase_base_url)
  end

  def set_data
    @match = match
    @specifier_key = identifier.to_s
  end

  # We need to store the firebase keys with some prefix but for process we require the actual data from keys
  # For e.g specifier_1234 we need only 1234 not specifier_1234
  def extract_data_from_key(key)
    key.split('_').last
  end

  def generate_outcome_odds_summary(odds_data)
    data = []
    odds_data['timestamps'].each do |timestamp_key, odds_value|
      timestamp = extract_data_from_key(timestamp_key)
      odd = odds_value['odds']
      data << { 'timestamp' => timestamp, 'odd' => odd }
    end
    data
  end

  def outcome_name(outcome, specifiers = {})
    Rails.cache.fetch(
      Utility::Cache.outcome_cache_key(match, market_id, outcome, specifiers),
      expire_in: Constants::CACHE_EXPIRE_TIME.days
    ) do
      MatchMarketOutcomeName.call(outcome.name, match, market_id, specifiers)
    end
  end

  def odds_summary_firebase_url
    "odds_summary/#{@match.uid}/markets/market_#{@market.uid}/specifiers/specifier_#{@specifier_key}"
  end
end
