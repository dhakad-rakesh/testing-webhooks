class AddValidFromToPromoCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :promo_codes, :valid_from, :datetime
  end
end
