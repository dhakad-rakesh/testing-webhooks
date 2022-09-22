class AddKindToLedgersAndTransferRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :kind, :integer, default: 0
    add_column :transfer_records, :kind, :integer, default: 0
  end
end
