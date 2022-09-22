class CreateUserPromoCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_promo_codes do |t|
      t.references :user, foreign_key: true
      t.references :promo_code, foreign_key: true
    end
  end
end
