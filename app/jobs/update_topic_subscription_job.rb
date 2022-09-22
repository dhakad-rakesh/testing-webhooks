class UpdateTopicSubscriptionJob < ApplicationJob
  queue_as :low

  def perform(topic, device_ids, old_device_ids)
    Firebase::UpdateTopicSubscription.run!(
      topic: topic,
      device_ids: device_ids,
      old_device_ids: old_device_ids
    )
  end
end
