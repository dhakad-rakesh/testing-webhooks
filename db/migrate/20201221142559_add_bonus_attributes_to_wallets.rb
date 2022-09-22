class AddBonusAttributesToWallets < ActiveRecord::Migration[5.2]
  change_table :wallets do |t|
    t.decimal :betting_bonus, precision: 17, scale: 5, default: 0.0
    t.decimal :casino_bonus, precision: 17, scale: 5, default: 0.0
  end
end
