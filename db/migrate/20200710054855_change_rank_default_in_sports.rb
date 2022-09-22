class ChangeRankDefaultInSports < ActiveRecord::Migration[5.2]
  def change
    change_column_default :sports, :rank, from: 0, to: nil
  end
end
