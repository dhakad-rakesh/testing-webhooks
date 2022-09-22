class CreateOutcomes < ActiveRecord::Migration[5.2]
  def change
    create_table :outcomes do |t|
      t.string :name
      t.integer :status
      t.string :uid, index: true
      t.references :market, foreign_key: true

      t.timestamps
    end
  end
end
