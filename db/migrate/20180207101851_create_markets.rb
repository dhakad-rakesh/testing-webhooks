class CreateMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :markets do |t|
      t.integer :status, index: true
      t.string :name
      t.string :uid, index: true

      t.timestamps
    end
  end
end
