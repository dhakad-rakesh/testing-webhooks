class CreateAddresses < ActiveRecord::Migration[5.2]
  create_table :addresses do |t|
    t.references :user, foreign_key: true
    t.string :country
    t.string :state
    t.string :city
    t.string :address
    t.string :zip_code

    t.timestamps
  end
end
