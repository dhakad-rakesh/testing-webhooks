class AddUniqueIndexToOutcome < ActiveRecord::Migration[5.2]
  def up
    add_index :markets_outcomes, %I[market_id outcome_id], unique: true
    remove_index :outcomes, :uid
    add_index :outcomes, :uid, unique: true
  end

  def down
    remove_index :markets_outcomes, %I[market_id outcome_id]
    remove_index :outcomes, :uid
    add_index :outcomes, :uid
  end
end
