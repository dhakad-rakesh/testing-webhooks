class AddNewColumnsToCountries < ActiveRecord::Migration[5.2]
  def change
  	add_column :countries, :enabled, :boolean, default: true
  	add_column :countries, :rank, :integer
  end
end
