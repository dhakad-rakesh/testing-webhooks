class ChangeStatusInMatch < ActiveRecord::Migration[5.2]
  def up
    change_column :matches, :status, :string
  end

  def down
    change_column :matches, :status, :integer
  end
end
