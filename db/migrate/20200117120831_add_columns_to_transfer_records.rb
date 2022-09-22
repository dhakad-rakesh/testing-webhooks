class AddColumnsToTransferRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :transfer_records, :commision_earned, :float
    add_column :transfer_records, :actual_transfer, :float
  end
end
