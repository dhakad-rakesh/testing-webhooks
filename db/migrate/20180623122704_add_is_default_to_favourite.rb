class AddIsDefaultToFavourite < ActiveRecord::Migration[5.2]
  def change
    add_column :favourites, :is_default, :boolean, default: false
  end
end
