class Referral < ApplicationRecord
  belongs_to :user
  belongs_to :referrer, class_name: 'User'

  PENDING = 'pending'
  CREDITED = 'credited'

  STATUSES = {
    PENDING => 0,
    CREDITED => 1
  }

  enum status: STATUSES
end
