class AddStatusAndCashbackValueToUserPromoCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :user_promo_codes, :status, :integer, default: 0
    add_column :user_promo_codes, :cashback_value, :integer
  end
end
