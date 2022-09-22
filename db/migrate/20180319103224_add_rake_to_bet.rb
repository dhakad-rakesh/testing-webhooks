class AddRakeToBet < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :rake, :float, default: 0.0
  end
end
