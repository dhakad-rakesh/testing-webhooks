module Notifications
  module Builders
    class ReferralReward < ApplicationInteraction
      integer :notification_object_id
      string :kind
  
      set_callback :type_check, :after, :set_ledger
  
      attr_accessor :ledger
  
      def execute
        return unless target_user.subscribed_to_notifications
        { user: target_user, notification: notification, data: data }
      end
  
      def set_ledger
        @ledger ||= Ledger.find_by(id: notification_object_id)
        errors.add(:base, 'Could not find ledger') unless ledger
      end
  
      def notification
        { title: title, body: body }
      end
    
      def title
        key = 'messages.notifications.referral_reward.title'
        localized_message(key, specifiers)
      end

      def body
        key = 'messages.notifications.referral_reward.body'
        localized_message(key, specifiers)
      end

      def localized_message(key, values)
        I18n.t(key, values)
      end

      def specifiers
        { user_name: ledger.betable.payor.full_name, amount: ledger.amount }
      end
    
      def data
        {
          id: ledger.id,
          kind: kind,
          status: ledger.status
        }
      end

      def target_user
        @target_user ||= ledger.betable.payee
      end
    end
  end
end