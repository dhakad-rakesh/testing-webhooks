class CreatePromoCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :promo_codes do |t|
      t.string :name
      t.string :code, index: { unique: true }, null: false
      t.integer :percent, default: 0
      t.integer :kind, default: 0
      t.integer :status, default: 0
      t.datetime :valid_till
      t.integer :limit_per_user
      t.integer :usage_limit
      t.text :settings
      t.timestamps
    end
  end
end
