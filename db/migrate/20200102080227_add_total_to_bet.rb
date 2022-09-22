class AddTotalToBet < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :total, :float, default: 0.0
  end
end
