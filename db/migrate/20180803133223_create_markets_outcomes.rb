class CreateMarketsOutcomes < ActiveRecord::Migration[5.2]
  def change
    create_table :markets_outcomes do |t|
      t.belongs_to :market, index: true
      t.belongs_to :outcome, index: true

      t.timestamps
    end
    remove_column :outcomes, :market_id, :integer
  end
end
