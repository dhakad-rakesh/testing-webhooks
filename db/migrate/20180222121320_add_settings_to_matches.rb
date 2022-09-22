class AddSettingsToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :settings, :text
  end
end
