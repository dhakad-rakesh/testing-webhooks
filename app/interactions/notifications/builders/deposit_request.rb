module Notifications
  module Builders
    class DepositRequest < ApplicationInteraction
      integer :notification_object_id
      string :kind
  
      set_callback :type_check, :after, :set_ledger
  
      attr_accessor :ledger
  
      def execute
        { notification: notification, data: data, topics: topics }
      end
  
      def set_ledger
        @ledger ||= Ledger.find_by(id: notification_object_id)
        errors.add(:base, 'Could not find ledger') unless ledger
      end
  
      def notification
        { title: title, body: body, click_action: click_action }
      end

      def title
        key = 'messages.notifications.deposit_request.title'
        localized_message(key, specifiers)
      end

      def body
        key = 'messages.notifications.deposit_request.body'
        localized_message(key, specifiers)
      end

      def localized_message(key, values)
        I18n.t(key, values)
      end

      def specifiers
      { ledger_id: ledger.id, status: ledger.status ,user_number: ledger.betable.user_number }
      end
    
      def data
        {
          id: ledger.id,
          kind: kind,
          status: ledger.status
        }
      end

      def topics
        topic = Constants::ADMIN_NOTIFICATIONS_TOPIC
        "'#{topic}' in topics"
      end

      def click_action
        Rails.application.routes.url_helpers.payments_admin_reports_url
      end
    end
  end
end