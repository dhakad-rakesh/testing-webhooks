class TransferRecord < ApplicationRecord
  has_many :ledgers
  belongs_to :payor, class_name: "User", foreign_key: 'payor_id'
  belongs_to :payee, class_name: "User", foreign_key: 'payee_id'

  validates_presence_of :payor_id, :payee_id, :amount, :actual_transfer, :commision_earned

  scope :order_by_recent, -> { order(created_at: :desc) }
  scope :between, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
  scope :paid_by, -> (user) { where(payor_id: user.id) }
  
  scope :filter_from_amount, ->(amount) {
    where('amount >= ?', amount)
  }

  scope :filter_to_amount, ->(amount) {
    where('amount <= ?', amount)
  }

  DEFAULT = 'default'
  REFERRAL_REWARD = 'referral_reward'

  KINDS = {
    DEFAULT => 0,
    REFERRAL_REWARD => 1
  }

  enum kind: KINDS
  enum status: [:pending, :completed, :failed]

  def payor_name
    payor.full_name
  end

  def payee_name
    payee.full_name
  end
end
