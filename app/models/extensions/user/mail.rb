module Extensions
  module User
    module Mail
      extend ActiveSupport::Concern

      included do
        after_save :send_username_changed_email, if: :username_changed?
        after_save :send_kyc_status_changed_email, if: :kyc_status_changed?
      end

      def send_username_changed_email
        UserNotifyMailer.with(user_id: id).username_changed.deliver_later
      end

      def send_kyc_status_changed_email
        UserNotifyMailer.with(user_id: id).kyc_status_changed.deliver_later
      end

      def kyc_status_changed?
        is_changed?(:kyc_status)
      end

      # Some username is present and previously its value was not nil

      def username_changed?
        is_changed?(:username)
      end

      def is_changed?(attribute)
        previous_changes[attribute.to_sym]&.first.present?
      end
    end
  end
end
