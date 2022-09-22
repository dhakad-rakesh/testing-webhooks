class AddSettingToMatchOutcome < ActiveRecord::Migration[5.2]
  def change
    add_column :match_outcomes, :settings, :json
  end
end
