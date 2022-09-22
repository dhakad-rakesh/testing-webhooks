class AddTableAdvertisements < ActiveRecord::Migration[5.2]
  def change
    create_table :advertisements do |t|
      t.string :name
      t.boolean :enabled, default: true
      t.text :ad_url
      t.text :settings

      t.timestamps
    end
  end
end
