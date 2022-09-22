class Notifications::PublishNotificationJob < ApplicationJob
  queue_as :notifications

  def perform(id, kind, options={})
    user = User.kept.find_by(id: options[:user_id])
    interaction_params = {
      notification_object_id: id,
      kind: kind,
      options: options,
      user: user
    }.compact
    Notifications::PublishNotification.run!(interaction_params)
  end
end
