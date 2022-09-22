module Notifications
  module Builders
    class BetSettlement < ApplicationInteraction
      integer :notification_object_id
      string :kind
  
      set_callback :type_check, :after, :set_bet
  
      attr_accessor :bet
  
      def execute
        return unless target_user.subscribed_to_notifications || bet.notifiable?
        { user: target_user, notification: notification, data: data }
      end
  
      def set_bet
        @bet ||= model.find_by(id: notification_object_id)
        errors.add(:base, 'Could not find bet') unless bet
      end
  
      def model
        kind.downcase == 'bet' ? Bet : ComboBet
      end
  
      def notification
        { title: title, body: body }
      end

      def title
        key = "messages.notifications.#{model.name.downcase}.title"
        localized_message(key, specifiers)
      end

      def body
        key = "messages.notifications.#{model.name.downcase}.body"
        localized_message(key, specifiers)
      end

      def localized_message(key, values)
        I18n.t(key, values)
      end

      def specifiers
      { status: bet.status, match_name: bet.try(:match).try(:name) }
      end
    
      def data
        {
          id: bet.id,
          kind: kind,
          status: bet.status
        }
      end

      def target_user
        @target_user ||= bet.user
      end
    end
  end
end