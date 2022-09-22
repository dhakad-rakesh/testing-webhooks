class CreatePopup < ActiveRecord::Migration[5.2]
  def change
    create_table :popups do |t|
      t.string :title
      t.string :screen
      t.string :name
      t.string :platform
      t.string :repeat_type
      t.integer :repeat_duration
      t.string :link
      t.boolean :redirection, default: false
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.string :country_ids, array: true, default: []
      t.text :structure

      t.timestamps
    end
  end
end
