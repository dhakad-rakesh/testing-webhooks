module Friendable
  extend ActiveSupport::Concern
  included do
    belongs_to :user
    belongs_to :friend, class_name: 'User'
    validates :user, presence: true
    validates :friend, presence: true, uniqueness: { scope: :user }
    validate :not_self
  end

  private

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end
end
