class AddTransactionHashToLedger < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :transaction_hash, :string
  end
end
