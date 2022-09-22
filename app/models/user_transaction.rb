class UserTransaction < ApplicationRecord
  belongs_to :user
  validates :amount, :transaction_type, :user_id, presence: true
end
