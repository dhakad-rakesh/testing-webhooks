class AddAllowBettingToGammabetSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :gammabet_settings, :allow_betting, :boolean, :default => true
  end
end
