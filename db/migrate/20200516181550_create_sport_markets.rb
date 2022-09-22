class CreateSportMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :sport_markets do |t|
      t.belongs_to :sport
      t.belongs_to :market
      t.integer :priority
      t.boolean :visible, default: true

      t.timestamps
    end
  end
end
