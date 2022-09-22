class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :betting_pool
  belongs_to :wallet

  delegate :available_amount, to: :wallet
  delegate :username, to: :user

  validates :betting_pool_id, uniqueness: { scope: :user_id, message: 'can be joined only once by a user' }
end
