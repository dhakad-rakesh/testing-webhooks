class CreateBettingPool < ActiveRecord::Migration[5.2]
  def change
    create_table :betting_pools do |t|
      t.integer :status, default: 0
      t.integer :entry_amount
      t.integer :points_per_user
      t.integer :total_points, default: 0
      t.integer :winnings_distribution_method
      t.datetime :closing_time

      t.timestamps
    end
  end
end
