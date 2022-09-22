class AddUnverifiedPhoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :unverified_phone, :string
  end
end
