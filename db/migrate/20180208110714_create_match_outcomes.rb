class CreateMatchOutcomes < ActiveRecord::Migration[5.2]
  def change
    create_table :match_outcomes do |t|
      t.references :match, foreign_key: true
      t.references :outcome, foreign_key: true
      t.references :market, foreign_key: true
      t.decimal :odds
      t.decimal :probabilities

      t.timestamps
    end
  end
end
