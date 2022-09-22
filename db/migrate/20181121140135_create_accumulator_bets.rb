class CreateAccumulatorBets < ActiveRecord::Migration[5.2]
  def change
    create_table :accumulator_bets do |t|
      t.float :odds
      t.float :stake, default: 0.0
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.references :wallet, foreign_key: true
      t.timestamps
    end
  end
end
