class AddDepositCountIntoUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deposit_count, :integer, default: 0
  end
end
