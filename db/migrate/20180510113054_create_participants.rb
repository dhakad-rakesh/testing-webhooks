class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.integer :status, default: 0
      t.integer :points_used, default: 0
      t.integer :points_gained, default: 0
      t.integer :points_pool, default: 1000
      t.integer :entry_amount, default: 0
      t.json :information, default: {}

      t.references :user, foreign_key: true
      t.references :competition, foreign_key: true

      t.timestamps
    end
  end
end
