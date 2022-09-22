class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image_id
      t.string :image_filename
      t.integer :image_size
      t.string :image_content_type

      t.timestamps
    end
  end
end
