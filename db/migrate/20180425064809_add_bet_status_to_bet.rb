class AddBetStatusToBet < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :status, :integer
    rename_column :bets, :stack, :stake
  end
end
