class AddUserWalletLimitToGammabetSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :gammabet_settings, :user_wallet_limit, :integer, default: 40000
  end
end
