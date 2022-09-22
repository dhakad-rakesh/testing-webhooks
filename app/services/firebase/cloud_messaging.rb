require 'fcm'

module Firebase
  class CloudMessaging
    attr_accessor :user

    def initialize(user=nil)
      @user = user 
    end

    def generate_notification_key(id)
      client.create(*generation_params(id).values)
    end

    def recover_notification_key(key_name)
      client.recover_notification_key(key_name)  
    end

    def notify(notification, data)
      client.send_with_notification_key(
        user.notification_key,
        notification: notification,
        data: data
      )
    end

    def send_to_topics(topics, notification, data)
      client.send_to_topic_condition(
        topics,
        notification: notification,
        data: data
      )
    end

    def add_device_id(id, key=nil)
      client.add(*params(id, key).values)
    end

    def remove_device_id(id, key=nil)
      client.remove(*params(id, key).values)
    end

    def subscribe_to_topic(topic, ids)
      client.batch_topic_subscription(topic, ids)
    end
    
    def unsubsribe_from_topic(topic, ids)
      client.batch_topic_unsubscription(topic, ids)
    end

    def params(id, key=nil)
      key ||= user.notification_key
      base_params.merge({
        notification_key: key,
        registration_ids: [id]
      })
    end

    def generation_params(id)
      base_params.merge(registration_ids: [id])
    end

    def base_params
      { 
        key_name: user.user_number,
        project_id: project_id
      }
    end

    def client
      @client ||= FCM.new(server_key)
    end

    def server_key
      ENV.fetch(
        'FCM_SERVER_KEY',
        'AAAAKFLsgbk:APA91bHeAHOkk8nr1gFVDqDF-v6gf5TY0ZiclksAY5ZchrWLQwJ20WRqUKkEC2rHx669fmlc2w2q45th93IM-bY9Mqe-fxmj-HhFkQ-kjG2R8YzcdimchmvG_QyIm4qtngQYD1rZ-I-p'
      )
    end

    def project_id
      ENV.fetch('FCM_SENDER_KEY', "173189923257")
    end
  end
end
