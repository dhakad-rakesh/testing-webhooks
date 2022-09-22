class CreateReferrals < ActiveRecord::Migration[5.2]
  def change
    create_table :referrals do |t|
      t.float :reward_amount
      t.float :threshold_amount
      t.integer :status, default: 0
      t.references :user, foreign_key: true, index: { unique: true }, null: false
      t.references :referrer, foreign_key: { to_table: :users }, null: false
    end
  end
end
