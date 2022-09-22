module BR
  module AMQP
    class AuditLogJob < ApplicationJob
      def perform(routing_key, timestamp, xml)
        audit_log = AmqpAuditLog.find_or_initialize_by(routing_key: routing_key, xml_data: xml,
                                                       timestamp_in_ms: timestamp)
        is_new_record = audit_log.new_record?
        audit_log.save if is_new_record
        # OddsSummaryJob.perform_later(xml, routing_key) if routing_key.include?('odds_change')
        return unless routing_key.include?('fixture_change')
        FixtureChangeJob.perform_now(audit_log.id) if is_new_record
      end
    end
  end
end
