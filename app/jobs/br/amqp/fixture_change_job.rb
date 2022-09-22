module BR
  module AMQP
    class FixtureChangeJob < ApplicationJob
      def perform(audit_log_id)
        audit_log = AmqpAuditLog.find(audit_log_id)
        event_id = audit_log.routing_key.split('.')[-3, 2].join(':')
        return unless event_id.include?('match')
        data = client.fixture_changes.with_indifferent_access
        data = data[:fixture_changes][:fixture_change].select { |change_data| change_data[:sport_event_id] == event_id }
        return if data.blank? || data.first.blank?
        process_data(data.first)
      end

      private

      def process_data(event_data)
        event_uid = event_data[:sport_event_id]
        match = Match.find_by(uid: event_uid) if event_uid.include?('match')
        return if match.blank?
        match.update(schedule_at: event_data[:update_time])
      end

      def client
        @client ||= Betradar::Client.new
      end
    end
  end
end
