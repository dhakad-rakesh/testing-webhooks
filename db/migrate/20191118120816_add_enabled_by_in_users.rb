class AddEnabledByInUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :enabled_by, :string
  end
end
