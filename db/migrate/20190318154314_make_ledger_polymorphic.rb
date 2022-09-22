class MakeLedgerPolymorphic < ActiveRecord::Migration[5.2]
  def change
    remove_column :ledgers, :bet_id, :integer
    add_column :ledgers, :betable_id, :integer
    add_column :ledgers, :betable_type, :string

    add_index :ledgers, %I[betable_type betable_id]
  end
end
