class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.float :available_amount, default: 0
      t.integer :wallet_type, default: 0
      t.float :locked_amount, default: 0
      t.boolean :is_current, default: false
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
