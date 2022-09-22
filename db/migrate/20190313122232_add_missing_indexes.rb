class AddMissingIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :bets, :accumulator_bet_id
    add_index :markets, :bet_type_id
    add_index :markets, :play_type_id
  end
end
