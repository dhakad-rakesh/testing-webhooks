class AddIndexToAmqpAuditLog < ActiveRecord::Migration[5.2]
  def change
    add_index :amqp_audit_logs, :routing_type
  end
end
