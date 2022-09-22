class AddTransferRecordIdToLedgers < ActiveRecord::Migration[5.2]
  def change
    add_reference :ledgers, :transfer_record
  end
end
