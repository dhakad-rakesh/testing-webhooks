class CreateLedgers < ActiveRecord::Migration[5.2]
  def change
    create_table :ledgers do |t|
      t.belongs_to :wallet, foreign_key: true
      t.belongs_to :bet, foreign_key: true
      t.string :remark
      t.integer :transaction_type, default: 0
      t.float :amount, default: 0.0

      t.timestamps
    end
  end
end
