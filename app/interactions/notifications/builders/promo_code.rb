module Notifications
  module Builders
    class PromoCode < ApplicationInteraction
      object :user, default: nil
      integer :notification_object_id
      string :kind
      hash :options, default: {}, strip: false
  
      set_callback :type_check, :after, :set_promo_code
      set_callback :type_check, :after, :validate_receiver
  
      attr_accessor :promo_code
  
      def execute
        return if user.present? && !user.subscribed_to_notifications
        { user: user, notification: notification, data: data, topics: topics }.compact
      end
  
      def set_promo_code
        @promo_code ||= ::PromoCode.find_by(id: notification_object_id)
        errors.add(:base, 'Could not find promo code') unless promo_code
      end
  
      def notification
        { title: title, body: body }
      end
    
      def title
        key = 'messages.notifications.promo_code.title'
        localized_message(key, specifiers)
      end

      def body
        key = "messages.notifications.promo_code.body.#{promo_code.kind}"
        localized_message(key, specifiers)
      end

      def localized_message(key, values)
        I18n.t(key, values)
      end

      def specifiers
        { 
          promo_code: promo_code.code,
          percentage: promo_code.percent,
          amount: promo_code.maximum_cashback['IQD']
        }
      end
    
      def data
        {
          id: promo_code.id,
          kind: kind
        }.merge(promo_code.details(currency).except(:kind))
      end

      def currency
        user&.current_wallet&.currency || 'IQD'
      end

      def validate_receiver
        return if user.present? || options[:broadcast].present?
        errors.add(:base, I18n.t('errors.messages.notifications.invalid_receiver'))
      end

      def topics
        return unless options[:broadcast]
        topic = Constants::ALL_USERS_TOPIC
        "'#{topic}' in topics"
      end
    end
  end
end