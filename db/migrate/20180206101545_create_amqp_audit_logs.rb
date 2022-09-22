class CreateAmqpAuditLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :amqp_audit_logs do |t|
      t.string :routing_key
      t.string :timestamp_in_ms
      t.text :xml_data

      t.timestamps
    end
  end
end
