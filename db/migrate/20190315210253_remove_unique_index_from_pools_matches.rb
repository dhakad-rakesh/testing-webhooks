class RemoveUniqueIndexFromPoolsMatches < ActiveRecord::Migration[5.2]
  def change
    remove_index :betting_pools_matches, %I[betting_pool_id]
    remove_index :betting_pools_matches, %I[match_id]
    add_index :betting_pools_matches, %I[betting_pool_id]
    add_index :betting_pools_matches, %I[match_id]
  end
end
