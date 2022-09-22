class AddContinentToVenue < ActiveRecord::Migration[5.2]
  def change
    add_column :venues, :continent, :string
  end
end
