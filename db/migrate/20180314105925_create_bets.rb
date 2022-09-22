class CreateBets < ActiveRecord::Migration[5.2]
  def change
    create_table :bets do |t|
      t.references :user, foreign_key: true
      t.references :match_outcome, foreign_key: true
      t.float :money_line
      t.string :odds
      t.json :information

      t.timestamps
    end
    add_index :bets, %I[user_id match_outcome_id]
  end
end
