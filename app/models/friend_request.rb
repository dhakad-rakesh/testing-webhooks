class FriendRequest < ApplicationRecord
  include Friendable

  validate :not_friends, :not_pending

  def accept
    ActiveRecord::Base.transaction do
      user.friends << friend
      destroy
    end
  end

  private

  def not_friends
    errors.add(:friend, 'is already added') if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, 'already requested friendship') if friend.pending_friends.include?(user)
  end
end
