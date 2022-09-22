module Notifications
  module Builders
    class LiabilityExceeded < ApplicationInteraction
      integer :notification_object_id
      string :kind
  
      set_callback :type_check, :after, :set_match
  
      attr_accessor :match
  
      def execute
        { notification: notification, data: data, topics: topics }
      end
  
      def set_match
        @match ||= Match.find_by(id: notification_object_id)
        errors.add(:base, 'Could not find match') unless match
      end
  
      def notification
        { title: title, body: body, click_action: click_action }
      end
    
      def title
        key = 'messages.notifications.liability_exceeded.title'
        localized_message(key, specifiers)
      end

      def body
        key = 'messages.notifications.liability_exceeded.body'
        localized_message(key, specifiers)
      end

      def localized_message(key, values)
        I18n.t(key, values)
      end

      def specifiers
      { match_id: match.id, match_name: match.name }
      end
    
      def data
        {
          id: match.id,
          kind: kind,
          status: match.status
        }
      end

      def topics
        topic = Constants::ADMIN_NOTIFICATIONS_TOPIC
        "'#{topic}' in topics"
      end

      def click_action
        Rails.application.routes.url_helpers.admin_match_url(match)
      end
    end
  end
end