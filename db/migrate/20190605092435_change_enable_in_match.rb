class ChangeEnableInMatch < ActiveRecord::Migration[5.2]
  def change
    change_column :matches, :enabled, :boolean, :default => false
  end
end
