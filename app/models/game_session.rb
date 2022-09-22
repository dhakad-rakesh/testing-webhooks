class GameSession < ApplicationRecord
  belongs_to :user, foreign_key: :player_id
  has_many :session_transactions
end
