class AddCommentToLedgers < ActiveRecord::Migration[5.2]
  def change
    add_column :ledgers, :comment, :string
  end
end
