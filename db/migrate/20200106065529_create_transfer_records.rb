class CreateTransferRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :transfer_records do |t|
      t.integer :payor_id
      t.integer :payee_id
      t.integer :merchant_id
      t.string :message
      t.float :amount
      t.integer :status

      t.timestamps
    end
  end
end
