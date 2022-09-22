class ChangeBettingBonusInComboBet < ActiveRecord::Migration[5.2]
  def change
    change_column :combo_bets, :betting_bonus, :decimal, precision: 17, scale: 8 , default: 0.0
  end
end
