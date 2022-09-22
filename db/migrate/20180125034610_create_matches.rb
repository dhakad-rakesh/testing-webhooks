class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :uid, index: true
      t.integer :status
      t.datetime :schedule_at
      t.timestamps
    end
  end
end
