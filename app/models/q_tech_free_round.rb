class QTechFreeRound < ApplicationRecord

  #ASSOCIATIONS
  belongs_to :user
  belongs_to :q_tech_casino_game

  enum status: { promoted: 0, claimed: 1, in_progress: 2, completed: 3, expired: 4, failed: 5, deleted: 6, cancelled: 7}

  #VALIDATIONS
  validates :user_id, :q_tech_casino_game_id, presence: true
  validates :txn_id, uniqueness: true

  #SCOPES
  scope :order_by_recent, -> { order(created_at: :desc) }
  scope :promoted_or_inprogress, -> {where("status in (?)", [0, 2])}
end
