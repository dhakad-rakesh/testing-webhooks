class SlotGame < ApplicationRecord
  scope :active_games, -> { where(active: true) }
  scope :has_free_rounds, -> { where(has_free_rounds: true) }
  scope :providers, -> ( provider ) { where("provider in (?)", provider) }
  scope :featured, -> { where(is_featured: true) }
  
  has_many :session_transactions, foreign_key: :game_uuid,
                                  primary_key: :uuid                                   

  self.per_page = Constants::CASINO_PERPAGE

  has_one_attached :thumbnail_image
  scope :search_by, -> ( query ) { where('lower(name) ilike ?', "%#{query.downcase}%") }
end
