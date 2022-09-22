class AddAccumulatorIdToBets < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :accumulator_bet_id, :integer
  end
end
