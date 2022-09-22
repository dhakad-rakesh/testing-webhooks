class AddDisabledSportIdsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :disabled_sport_ids, :string, array: true, default: []
  end
end
