class AddUserPromoCodeIdToLedgers < ActiveRecord::Migration[5.2]
  def change
    add_reference :ledgers, :user_promo_code, foreign_key: true
  end
end
