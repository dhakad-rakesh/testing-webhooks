class CreateCasinoMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :casino_menus do |t|
      t.string :name
      t.integer :menu_type, default: 0, index: true
      t.integer :menu_order
      t.boolean :enabled, default: true

      t.timestamps
    end

    add_column :casino_items, :casino_menu_id, :integer
  end
end
