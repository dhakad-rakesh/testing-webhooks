class AddBettingBonusOnBet < ActiveRecord::Migration[5.2]
  def change
    add_column :combo_bets, :betting_bonus, :decimal, precision: 17, scale: 5 , default: 0.0
  end
end

