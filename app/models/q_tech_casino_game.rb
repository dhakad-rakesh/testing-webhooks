class QTechCasinoGame < ApplicationRecord
  %I[languages currencies supported_devices client_types].each do |column|
    serialize column
  end

  # ASSOCIATIONS
  belongs_to :casino_menu
  has_many :q_tech_free_rounds

  #VALIDATIONS
  validates :user_id, :q_tech_casino_game_id, presence: true

  # SCOPES
  scope :has_freespins, -> { where(free_spin_trigger: true) }
  scope :providers, ->(provider) { where('provider in (?)', provider) }
  scope :search_by, ->(query) { where('lower(name) ilike ?', "%#{query.downcase}%") }
end
