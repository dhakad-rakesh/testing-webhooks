class AddRoutingTypeToAmqpAuditLog < ActiveRecord::Migration[5.2]
  def change
    add_column :amqp_audit_logs, :routing_type, :string
  end
end
