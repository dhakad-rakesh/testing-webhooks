class AddBetTypeIndexInBets < ActiveRecord::Migration[5.2]
  def change
    add_index :bets, :status
    add_index :bets, :bet_type
  end
end
