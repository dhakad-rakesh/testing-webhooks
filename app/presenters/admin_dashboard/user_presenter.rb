module AdminDashboard
  class UserPresenter
    class << self
      def count(type = 'sign_up', interval = 'day')
        send("fetch_#{type}_data", start_time(interval), end_time, interval)
      end

      def start_time(interval)
        return Time.zone.now - 10.days if interval == 'day'
        return Time.zone.now - 30.days if interval == 'month'
        Time.zone.now - 1.year
      end

      def end_time
        Time.zone.now
      end

      def fetch_sign_up_data(start_time, end_time, interval)
        data = User.where(created_at: start_time..end_time)
                   .group("DATE_TRUNC('#{interval}', created_at)")
                   .count
        { labels: formate_labels(data.keys), data: data.values }
      end

      def fetch_login_data(_start_time, _end_time, interval)
        data = ActiveRecord::Base.connection.execute("SELECT count(*),
          temp.date from (SELECT  COUNT(DISTINCT(user_id)) as count,
          user_id,DATE_TRUNC('#{interval}', created_at) as date FROM session_logs GROUP BY user_id,
          DATE_TRUNC('#{interval}', created_at)) AS temp GROUP BY temp.date").entries
        { labels: data.entries.map { |d| formate_labels([d['date'].to_date]) },
          data: data.entries.map { |d| d['count'] } }
      end

      def formate_labels(labels)
        labels.map { |l| l.strftime('%d %b') }
      end
    end
  end
end
