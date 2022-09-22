class AddIsFeaturedToCasinoMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :casino_menus, :is_featured, :boolean, default: false
  end
end
