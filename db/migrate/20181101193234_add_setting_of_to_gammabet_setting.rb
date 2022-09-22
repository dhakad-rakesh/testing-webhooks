class AddSettingOfToGammabetSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :gammabet_settings, :setting_of, :integer, default: 0
  end
end
