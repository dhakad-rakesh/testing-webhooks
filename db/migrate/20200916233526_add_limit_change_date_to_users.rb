class AddLimitChangeDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deposit_limit_updated_at, :datetime
    add_column :users, :bet_limit_updated_at, :datetime
  end
end
