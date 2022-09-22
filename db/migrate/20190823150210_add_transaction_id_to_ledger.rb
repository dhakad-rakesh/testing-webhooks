class AddTransactionIdToLedger < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :transaction_id, :integer
  end
end
