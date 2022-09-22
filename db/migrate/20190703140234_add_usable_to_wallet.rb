class AddUsableToWallet < ActiveRecord::Migration[5.2]
  def change
  	add_column :wallets, :usable_id, :integer
  	add_column :wallets, :usable_type, :string
  end
end
