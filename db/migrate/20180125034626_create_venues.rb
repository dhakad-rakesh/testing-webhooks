class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :city_name
      t.string :country_name
      t.references :match, index: true, null: false
      t.timestamps
    end
  end
end
