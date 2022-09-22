class AddBettingPoolIdToBetsAndAccumulatorBets < ActiveRecord::Migration[5.2]
  def change
    add_reference :bets, :betting_pool, index: true
    add_reference :accumulator_bets, :betting_pool, index: true
  end
end
