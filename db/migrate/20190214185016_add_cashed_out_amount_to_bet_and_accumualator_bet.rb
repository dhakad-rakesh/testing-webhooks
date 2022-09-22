class AddCashedOutAmountToBetAndAccumualatorBet < ActiveRecord::Migration[5.2]
  def change
    add_column :accumulator_bets, :cashed_out_amount, :float
    add_column :bets, :cashed_out_amount, :float
  end
end
