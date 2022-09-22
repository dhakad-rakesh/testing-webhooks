class AddAdminEnableToBasicsModel < ActiveRecord::Migration[5.2]
  def up
    %I[sports matches tournaments].each do |table|
      add_column table, :enabled, :boolean, default: true
    end
  end

  def down
    %I[sports matches tournaments].each do |table|
      remove_column table, :enabled, :boolean, default: true
    end
  end
end
