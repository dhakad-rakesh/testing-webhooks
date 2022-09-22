class CreateCasinoItems < ActiveRecord::Migration[5.2]
  def change
    create_table :casino_items do |t|
      t.string :uuid,         null: false
      t.string :name
      t.string :image
      t.string :item_type
      t.string :provider
      t.string :technology
      t.boolean :has_lobby
      t.boolean :is_mobile
      t.boolean :has_freespins
      t.boolean :active,      default: true

      t.timestamps
    end
  end
end
