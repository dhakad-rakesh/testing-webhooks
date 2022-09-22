class Users::ManageTopicSubscriptionsJob < ApplicationJob
  queue_as :low

  def perform(user_id, device_ids, old_device_ids)
    user = User.find_by(id: user_id)
    return unless user
    topics = [Constants::ALL_USERS_TOPIC]
    topics += favourite_topics(user)
    # Invoke subscription job for each topic
    topics.each do |topic|
      UpdateTopicSubscriptionJob.perform_async(topic, device_ids, old_device_ids)
    end
  end

  def favourite_topics(user)
    channel = Constants::FAVOURITE_TEAM_TOPIC
    user.favourite_teams.values.map { |team_id| "#{channel}_#{team_id}" }
  end
end
