class AddApkUrlToGammabetSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :gammabet_settings, :url, :string
  end
end
