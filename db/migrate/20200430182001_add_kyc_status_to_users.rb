class AddKycStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :kyc_status, :string, default: 'Pending'
  end
end
