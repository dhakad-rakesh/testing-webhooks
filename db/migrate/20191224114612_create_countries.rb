class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :uid

      t.timestamps
    end
    add_column :tournaments, :country_id, :integer
  end

end
