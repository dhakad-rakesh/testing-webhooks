class UserPromoCode < ApplicationRecord
  belongs_to :user
  belongs_to :promo_code
  has_one :ledger

  PENDING = 'pending'
  SUCCEEDED = 'succeeded'
  FAILED = 'failed'
  CANCELLED = 'cancelled'

  STATUSES = {
    PENDING => 0,
    SUCCEEDED => 1,
    FAILED => 2,
    CANCELLED => 3
  }

  RESERVED_STATUSES = [PENDING, SUCCEEDED]

  enum status: STATUSES

  scope :reserved, -> { where(status: RESERVED_STATUSES) }
  scope :order_by_recent, -> { order(created_at: :desc) }

  validate :promo_code_usage

  def promo_code_usage
    return unless promo_code.limit_exhausted?
    errors.add(:base, I18n.t('errors.messages.promo_code.limit_exhausted'))
  end

  def details
    {
      code: promo_code.code,
      cashback_value: cashback_value,
      status: status
    }
  end
end
