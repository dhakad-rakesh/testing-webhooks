class CreateFavourite < ActiveRecord::Migration[5.2]
  def change
    create_table :favourites do |t|
      t.references :favouriteable, polymorphic: true, index: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
