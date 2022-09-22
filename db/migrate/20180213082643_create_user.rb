class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  'infinity_token'
      t.string  'infinity_refresh_token'

      t.timestamps
    end
  end
end
