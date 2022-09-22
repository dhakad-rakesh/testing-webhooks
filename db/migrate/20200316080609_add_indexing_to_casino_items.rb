class AddIndexingToCasinoItems < ActiveRecord::Migration[5.2]
  def change
    add_index :casino_menus, :menu_order
    add_index :casino_menus, [:menu_order, :enabled], name: 'index_casino_menus_enabled'

    add_index :casino_items, :casino_menu_id
    add_index :casino_items, [:casino_menu_id, :active], name: 'index_casino_items_menus_active'
    
    add_index :casino_items, [:casino_menu_id, :active, :has_freespins], name: 'index_casino_items_menus_free_spin'
    add_index :casino_items, [:casino_menu_id, :active, :has_lobby], name: 'index_casino_items_menus_lobby'
    add_index :casino_items, [:casino_menu_id, :active, :is_mobile], name: 'index_casino_items_menus_mobile'

    add_index :casino_items, [:casino_menu_id, :active, :provider], name: 'index_casino_items_menus_provider'
    # Indexing name for search
    add_index :casino_items, [:casino_menu_id, :active, :name], name: 'index_casino_items_menus_name'
    add_index :casino_items, [:casino_menu_id, :active, :provider, :name], name: 'index_casino_items_menus_provider_name'
    
    # We already have combination with freespin, lobby and mobile 
    # don't think that user would frequently be used same
  end
end
