class AddReferenceTransactionIdIntoSessionTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :session_transactions, :ref_transaction_id, :string
  end
end
