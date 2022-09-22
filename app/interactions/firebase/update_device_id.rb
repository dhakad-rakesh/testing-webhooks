module Firebase
  class UpdateDeviceId < ApplicationInteraction
    object :user
    string :device_id, default: nil
    string :old_device_id, default: nil

    set_callback :type_check, :after, :validate_device_ids
    set_callback :execute, :before, -> { fcm }

    NOTIFICATION_KEY_NOT_FOUND = 'notification_key not found'

    def execute
      if user.notification_key.blank?
        generate_notification_key!
      else
        begin
          update_device_ids!
        rescue Firebase::Exceptions::NotificationKeyNotFound
          generate_notification_key!        
        end
      end
      manage_user_topic_subscriptions
    # TODO: Handle custom exception here
    rescue Firebase::Exceptions::FailedDeviceIdUpdate => e
      errors.add(:base, e.message)
    rescue ::StandardError => e
      custom_error_logger(e)
      errors.add(:base, I18n.t('users.device_id.update.failed'))
    end

    def update_device_ids!
      User.transaction do
        key = user.notification_key
        user.update!(update_params)
        remove_device_id!(key)
        add_device_id!(key)
      end
    end

    def generate_notification_key!
      response = fcm.generate_notification_key(device_id)
      validate_response!(response)
      key = JSON.parse(response[:body])['notification_key']
      user.update!(notification_key: key, device_ids: [device_id])
    end

    def remove_device_id!(key)
      return unless old_device_id.present?
      response = fcm.remove_device_id(old_device_id, key)
      validate_response!(response)
    end

    def add_device_id!(key)
      return unless device_id.present?
      response = fcm.add_device_id(device_id, key)
      raise Firebase::Exceptions::NotificationKeyNotFound if notification_key_not_found?(response)
      validate_response!(response)
    end

    def validate_response!(response)
      return if response[:status_code] == 200
      error_msg = JSON.parse(response[:body])&.dig('error')
      raise Firebase::Exceptions::FailedDeviceIdUpdate, error_msg
    end

    def fcm
      @fcm ||= Firebase::CloudMessaging.new(user)
    end

    def custom_error_logger(exception)
      Honeybadger.notify(
        "[CloudMessaging Error] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class
      )
    end

    def manage_user_topic_subscriptions
      Users::ManageTopicSubscriptionsJob.perform_later(user.id, [device_id].compact, [old_device_id].compact)
    end

    def validate_device_ids
      return if device_id.present? || old_device_id.present?
      errors.add(:base, I18n.t('errors.messages.device_id.presence'))
    end

    def update_params
      device_ids = (user.device_ids + [device_id] - [old_device_id]).compact
      key = device_ids.present? ? user.notification_key : nil
      parameters = { device_ids: device_ids }
      # Uncomment to remove notification keys when there are no device ids
      # parameters = parameters.merge(notification_key: key) if key.nil?
      parameters
    end

    def notification_key_not_found?(response)
      body = JSON.parse(response[:body])
      response[:status_code] == 400 && body['error'] == NOTIFICATION_KEY_NOT_FOUND
    end
  end
end
