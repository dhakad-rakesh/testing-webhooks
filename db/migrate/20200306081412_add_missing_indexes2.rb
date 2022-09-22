class AddMissingIndexes2 < ActiveRecord::Migration[5.2]
  def change
    add_index :wallets, [:usable_id, :usable_type]
    add_index :wallets, :created_at
    add_index :ledgers, [:betable_type, :created_at, :transaction_type], name: 'index_betable_created_t_type'
  end
end
