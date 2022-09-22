class AddBonusStakeToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :bonus_stake, :decimal, precision: 17, scale: 5, :default => 0.0
  end
end
