class AddIsFeaturedIntoSlotGames < ActiveRecord::Migration[5.2]
  def change
    add_column :slot_games, :is_featured, :boolean, default: false
  end
end
