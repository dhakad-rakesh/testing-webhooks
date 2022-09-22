class AddPlayNumberToAccumulatorBet < ActiveRecord::Migration[5.2]
  def change
    add_column :accumulator_bets, :play_number, :integer
  end
end
