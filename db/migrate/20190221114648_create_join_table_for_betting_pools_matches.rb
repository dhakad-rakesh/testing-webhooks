class CreateJoinTableForBettingPoolsMatches < ActiveRecord::Migration[5.2]
  def change
    create_join_table :betting_pools, :matches do |t|
      t.belongs_to :betting_pool, index: { unique: true }
      t.belongs_to :match, index: { unique: true }
      t.index %I[betting_pool_id match_id], unique: true
    end
  end
end
