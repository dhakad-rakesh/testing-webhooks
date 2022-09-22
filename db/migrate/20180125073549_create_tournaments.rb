class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :uid, index: true
      t.references :sport, index: true, null: false

      t.timestamps
    end
  end
end
