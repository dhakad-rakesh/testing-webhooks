class AddModeToLedgers < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :mode, :integer
  end
end
