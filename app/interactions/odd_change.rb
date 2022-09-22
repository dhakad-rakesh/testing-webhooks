class OddChange < ApplicationInteraction
  hash :outcome_data, strip: false
  hash :specifiers, strip: false, default: {}
  string :routing_key, default: nil
  object :match
  array :outcomes, default: []
  integer :market_id
  integer :play_number, default: 0
  boolean :from_match_outcome, default: false
  set_callback :type_check, :before, :set_resource

  def execute
    [
      @resource.id,
      { name: outcome_name, class_name: @resource.class.name, play_number: play_number,
        odds: outcome_data[:odds].to_f, status: outcome_data['active'] }
    ]
  end

  def outcome_name
    Rails.cache.fetch(
      Utility::Cache.outcome_cache_key(match, market_id, @resource, specifiers),
      expire_in: Constants::CACHE_EXPIRE_TIME.days
    ) do
      MatchMarketOutcomeName.call(@resource.name, match, market_id, specifiers)
    end
  end

  private

  def set_resource
    @resource =
      (
        (outcomes.present? && outcomes.detect { |a| a.uid == outcome_data[:id] }) ||
        Outcome.find_by(uid: outcome_data[:id])
      )
  end

  def odd_type
    routing_key.split('.').slice(1, 2).join('.') if routing_key.present?
  end
end
