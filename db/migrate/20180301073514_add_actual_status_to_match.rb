class AddActualStatusToMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :actual_status, :string
  end
end
