class CreateSports < ActiveRecord::Migration[5.2]
  def change
    create_table :sports do |t|
      t.string :name
      t.integer :status, index: true, null: false
      t.string :acronym, index: true
      t.string :uid, index: true
      t.timestamps
    end
  end
end
