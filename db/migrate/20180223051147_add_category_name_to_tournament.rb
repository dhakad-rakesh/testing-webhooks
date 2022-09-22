class AddCategoryNameToTournament < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :category_name, :string
  end
end
