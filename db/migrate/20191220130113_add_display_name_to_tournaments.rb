class AddDisplayNameToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :display_name, :string
  end
end
