class AddEventIdToAmqpAuditLog < ActiveRecord::Migration[5.2]
  def change
    add_column :amqp_audit_logs, :event_id, :string
  end
end
