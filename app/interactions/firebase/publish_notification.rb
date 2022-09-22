module Firebase
  class PublishNotification < ApplicationInteraction
    object :user, default: nil
    hash :notification, strip: false
    hash :data, strip: false, default: {}
    string :topics, default: ''
    set_callback :execute, :before, -> { fcm }

    def execute
      if topics.present?
        fcm.send_to_topics(topics, notification, data)
      else
        fcm.notify(notification, data)
      end
    rescue ::StandardError => e
      custom_error_logger(e)
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
  end
end
