class AddCountryCodeToVenue < ActiveRecord::Migration[5.2]
  def change
    add_column :venues, :country_code, :string
  end
end
