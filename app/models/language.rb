class Language < ApplicationRecord
  # has_and_belongs_to_many :users
  scope :enabled, -> { where(enabled: true) }
end
