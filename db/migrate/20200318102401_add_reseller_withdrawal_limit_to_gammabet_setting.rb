class AddResellerWithdrawalLimitToGammabetSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :gammabet_settings, :reseller_withdrawal_limit, :integer, default: 3000
  end
end
