class AddPromoTypeToPromoCode < ActiveRecord::Migration[5.2]
  def change
    add_column :promo_codes, :promo_type, :integer, default: 0
  end
end
