class CreateBettingSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :betting_summaries do |t|
      t.references :user, foreign_key: true
      t.references :match, foreign_key: true
      t.integer :predictions_count, default: 0
      t.bigint :total_profit, default: 0.0
      t.bigint :average_profit, default: 0.0
      t.text :information

      t.timestamps
    end
  end
end
