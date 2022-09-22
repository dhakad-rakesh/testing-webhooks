class ChangeDefaultKycStatusInUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :kyc_status, :string, default: "NotDone"
  end

  def down
    change_column :users, :kyc_status, :string, default: "Pending"
  end   
end
