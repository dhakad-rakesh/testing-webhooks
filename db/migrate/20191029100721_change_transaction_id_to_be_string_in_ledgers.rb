class ChangeTransactionIdToBeStringInLedgers < ActiveRecord::Migration[5.2]
  def up
    change_column :ledgers, :transaction_id, :string
  end

  def down
    change_column :ledgers, :transaction_id, :integer, using: 'transaction_id::integer'
  end
end
