class CasinoMenu < ApplicationRecord
  enum menu_type: %i[non_live live other]
  validates :name, presence: true

  default_scope { order(:menu_order) }
  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
  scope :featured, -> { where(is_featured: true) }

  has_many :casino_items
  has_many :q_tech_casino_games

  def name_with_type
    "#{name} (#{menu_type})"
  end

end
