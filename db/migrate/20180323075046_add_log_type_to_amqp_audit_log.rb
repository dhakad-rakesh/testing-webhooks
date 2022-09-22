class AddLogTypeToAmqpAuditLog < ActiveRecord::Migration[5.2]
  def change
    add_column :amqp_audit_logs, :log_type, :string
  end
end
