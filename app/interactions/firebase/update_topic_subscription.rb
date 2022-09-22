module Firebase
  class UpdateTopicSubscription < ApplicationInteraction
    string :topic
    array :device_ids, default: []
    array :old_device_ids, default: []
    set_callback :execute, :before, -> { fcm }

    def execute
      update_topic_subscriptions!
    # TODO: Handle custom exception here
    rescue ::StandardError => e
      custom_error_logger(e)
      errors.add(:base, I18n.t('users.device_id.update.failed'))
    end

    def update_topic_subscriptions!
        remove_topic_subscription!
        add_topic_subscription!
    end

    def remove_topic_subscription!
      return unless old_device_ids.present?
      response = fcm.unsubsribe_from_topic(topic, old_device_ids)
      validate_response!(response)
    end

    def add_topic_subscription!
      return unless device_ids.present?
      response = fcm.subscribe_to_topic(topic, device_ids)
      validate_response!(response)
    end

    def validate_response!(response)
      raise Firebase::Exceptions::FailedTopicSubscription unless response[:status_code] == 200
    end

    def fcm
      @fcm ||= Firebase::CloudMessaging.new
    end

    def custom_error_logger(exception)
      Honeybadger.notify(
        "[CloudMessaging Error] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class
      )
    end
  end
end
