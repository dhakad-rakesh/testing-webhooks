class AddWalletToBets < ActiveRecord::Migration[5.2]
  def change
    add_reference :bets, :wallet, foreign_key: true
  end
end
