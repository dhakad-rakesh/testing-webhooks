class MarketSerializer < BaseSerializer
  attributes :id, :name, :status, :uid, :period
  belongs_to :bet_type
  belongs_to :play_type
end
