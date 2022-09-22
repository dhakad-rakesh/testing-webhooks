class AddIndexToAdminEnable < ActiveRecord::Migration[5.2]
  def change
    %I[sports matches tournaments].each do |table|
      add_index table, :enabled
    end
  end
end
