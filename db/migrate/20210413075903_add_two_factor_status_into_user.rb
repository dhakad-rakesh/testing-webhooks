class AddTwoFactorStatusIntoUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :two_factor_status, :integer, default: 0
  end
end
