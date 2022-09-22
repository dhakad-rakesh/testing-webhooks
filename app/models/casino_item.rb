class CasinoItem < ApplicationRecord
  scope :active_items, -> { where(active: true) }
  scope :search_results, -> ( search ) { where("lower(name) ILIKE lower(?)", "%#{search}%") }
  scope :has_freespins, -> { where(has_freespins: true) }
  scope :has_lobby, -> { where(has_lobby: true) }
  scope :is_mobile, -> { where(is_mobile: true) }
  scope :providers, -> ( provider ) { where("provider in (?)", provider) }
  scope :item_types, -> ( item_types ) { where(item_type: item_types) }
  scope :live_casino, -> { where(item_type: Constants::LIVE_CASINO) }
  scope :non_live_casino, -> { where.not(item_type: Constants::LIVE_CASINO) }
  scope :assigned_to_menus, -> ( menu_id ) { where(casino_menu_id: menu_id) }
  scope :menu_items, -> ( menu_ids ) { active_items.where(casino_menu_id: menu_ids) }
  scope :search_by, -> ( query ) { where('lower(name) ilike ?', "%#{query.downcase}%") }

  has_many :session_transactions, foreign_key: :game_uuid,
                                  primary_key: :uuid                                   

  belongs_to :casino_menu, optional: true
  self.per_page = Constants::CASINO_PERPAGE

  has_one_attached :thumbnail_image
end
