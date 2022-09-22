class ChangeBettingBonusInWallets < ActiveRecord::Migration[5.2]
  def change
    change_column :wallets, :betting_bonus, :decimal, precision: 17, scale: 8 , default: 0.0
  end
end
