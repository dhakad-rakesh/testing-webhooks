class Users::ManageNotificationSubscriptionsJob < ApplicationJob
  queue_as :low

  def perform(user_id, unsubscribe: false)
    user = User.find_by(id: user_id)
    return unless user
    device_ids = user.device_ids
    # TODO: Update fcm gem and remove all device ids corresponding to a notification key
    if unsubscribe
      Users::ManageTopicSubscriptionsJob.perform_later(user.id, [], device_ids)
    else
      Users::ManageTopicSubscriptionsJob.perform_later(user.id, device_ids, [])
    end
  end
end
