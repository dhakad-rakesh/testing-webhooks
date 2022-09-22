module Wallets
  module Reports
    class BalanceLimitExeeded
      require 'csv'
      attr_reader :balance_limit, :route_helper

      def initialize(balance_limit = Figaro.env.user_balance_limit)
        @balance_limit = balance_limit.to_f
        @route_helper = Rails.application.routes.url_helpers
      end

      def generate
        csv = fetch_records_and_generate_csv
        send_email(csv) if csv.size > 90 #check if csv has data
      end

      private

      def fetch_records_and_generate_csv
        users = User.available
        CSV.generate do |csv|
          csv << ["User Id", "User Email", "UserName", "User Available Balance", "User Enabled", "User Access Link"]

          users.each do |user|
            available_amount = user.available_amount
            if available_amount >= balance_limit
              disable_user(user) unless user.enabled_by == 'admin'
              csv << [user.id, user.email, user.username, available_amount, user.reload.enabled, "https://www.bwinner.bet#{route_helper.admin_user_path(user)}"]
            end
          end
        end
      end

      def send_email(csv)
        NotificationMailer.balance_limit_exeeded(csv).deliver_later
      end

      def disable_user(user)
        user.enabled = false
        user.save(validate: false)
      end
    end
  end
end
