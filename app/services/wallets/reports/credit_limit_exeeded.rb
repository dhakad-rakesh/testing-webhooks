module Wallets
  module Reports
    class CreditLimitExeeded
      require 'csv'
      attr_reader :cr_limit_interval, :credit_limit, :route_helper

      def initialize(cr_limit_interval = Figaro.env.user_credit_limit_interval, credit_limit = Figaro.env.user_credit_limit)
        @cr_limit_interval = cr_limit_interval
        @credit_limit = credit_limit.to_f
        @route_helper = Rails.application.routes.url_helpers
      end

      def generate
        csv = fetch_records_and_generate_csv
        send_email(csv) if csv.size > 80 # check if csv has data
      end

      private

      def fetch_records_and_generate_csv
        users = User.available
        CSV.generate do |csv|
          csv << ['User Id', 'User Email', 'UserName', 'Credit Amount', 'Credit Interval', 'User Access Link']

          users.each do |user|
            user_info = fetch_user_info(user)
            csv << [user.id, user.email, user.username, user_info[:credit_amount], cr_limit_interval, "https://www.bwinner.bet#{route_helper.admin_user_path(user)}"] if user_info[:invalid]
          end
        end
      end

      def send_email(csv)
        NotificationMailer.credit_limit_exeeded(csv).deliver_later
      end

      def date_range
        case cr_limit_interval

        when 'daily'
          (Time.zone.now.beginning_of_day-1.day)..(Time.zone.now.end_of_day-1.day)
        when 'weekly'
          Time.zone.now.beginning_of_week..Time.zone.now.end_of_week
        when 'monthly'
          Time.zone.now.beginning_of_month..Time.zone.now.end_of_month
        else
          Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
        end
      end

      def fetch_user_info(user)
        ledgers = user.ledgers
                      .credit
                      .where(created_at: date_range)

        credit_amount = ledgers.sum(:amount)
        invalid = credit_amount > credit_limit

        { credit_amount: credit_amount, invalid: invalid }
      end
    end
  end
end
