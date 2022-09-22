class BetType < ApplicationRecord
  has_and_belongs_to_many :play_types, dependent: :nullify

  # Specify whether bet type is for player markets or not
  enum market_type: { non_player_market: 0, player_market: 1 }
end
