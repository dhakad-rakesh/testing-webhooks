class ChangeTournamentSettingToJsonb < ActiveRecord::Migration[5.2]
  def change
    change_column :tournaments, :settings, :jsonb
  end
end
