module Notifications
  module Builders
    class BigWin < ApplicationInteraction
      integer :notification_object_id
      string :kind
      hash :options, default: {}, strip: false
  
      set_callback :type_check, :after, :set_bet
  
      attr_accessor :bet
  
      def execute
        { notification: notification, data: data, topics: topics }
      end
  
      def set_bet
        @bet ||= model.find_by(id: notification_object_id)
        errors.add(:base, 'Could not find Bet') unless bet
      end
  
      def notification
        { title: title, body: body, click_action: click_action }
      end

      def title
        key = 'messages.notifications.big_win.title'
        localized_message(key, specifiers)
      end

      def body
        key = 'messages.notifications.big_win.body'
        localized_message(key, specifiers)
      end

      def localized_message(key, values)
        I18n.t(key, values)
      end

      def specifiers
      { bet_id: bet.id, amount: winning_amount }
      end

      def data
        {
          id: bet.id,
          kind: kind,
          status: bet.status
        }
      end

      def topics
        topic = Constants::ADMIN_NOTIFICATIONS_TOPIC
        "'#{topic}' in topics"
      end

      def model
        options[:combo] ? ComboBet : Bet   
      end

      def click_action
        Rails.application.routes.url_helpers.bets_admin_reports_url
      end

      def winning_amount
        options[:combo] ? bet.winning_amount : bet.winnings
      end
    end
  end
end