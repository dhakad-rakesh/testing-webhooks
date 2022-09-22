module Extensions
  module User
    module FriendShip
      extend ActiveSupport::Concern

      included do
        has_many :friend_requests, dependent: :destroy
        has_many :pending_friends, through: :friend_requests, source: :friend
        has_many :friendships, dependent: :destroy
        has_many :friends, through: :friendships
      end

      def remove_friend(friend)
        friends.destroy(friend)
      end
    end
  end
end
