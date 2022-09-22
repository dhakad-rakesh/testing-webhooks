class PlayType < ApplicationRecord
  has_and_belongs_to_many :bet_types, dependent: :nullify
end
