class CreateUserTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_transactions do |t|
      t.string :transaction_type
      t.float :amount
      t.integer :user_id
      t.boolean :status

      t.timestamps
    end
  end
end
