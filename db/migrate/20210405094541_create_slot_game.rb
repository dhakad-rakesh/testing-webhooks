class CreateSlotGame < ActiveRecord::Migration[5.2]
  def change
    create_table :slot_games do |t|
      t.string :uuid, null: false
      t.string :name
      t.string :image
      t.string :provider
      t.boolean :has_free_rounds
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
