class AddSettingsToTournament < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :settings, :json
  end
end
