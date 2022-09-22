class AddDefaultToBetStatus < ActiveRecord::Migration[5.2]
  def up
    change_column :bets, :status, :integer, default: 0
  end

  def down
    change_column :bets, :status, :integer, default: nil
  end
end
