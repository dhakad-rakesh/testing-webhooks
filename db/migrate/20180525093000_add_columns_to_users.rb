class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :datetime
    remove_column :users, :infinity_token, :string
    remove_column :users, :infinity_refresh_token, :string
  end

  def down
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :date_of_birth, :datetime
    add_column :users, :infinity_token, :string
    add_column :users, :infinity_refresh_token, :string
  end
end
