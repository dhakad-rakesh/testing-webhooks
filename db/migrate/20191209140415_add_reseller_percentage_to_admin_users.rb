class AddResellerPercentageToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :reseller_percentage, :float, default: 80.00
  end
end
