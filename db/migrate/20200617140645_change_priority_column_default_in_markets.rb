class ChangePriorityColumnDefaultInMarkets < ActiveRecord::Migration[5.2]
  def change
    change_column_default :markets, :priority, nil
  end
end
