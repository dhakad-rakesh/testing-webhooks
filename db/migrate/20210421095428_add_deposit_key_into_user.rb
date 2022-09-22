class AddDepositKeyIntoUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deposit_key, :string
  end
end
