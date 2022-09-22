class AddIsBettingAllowedToUser < ActiveRecord::Migration[5.2]
  # def change
  #   add_column :users, :is_betting_allowed, :boolean, default: false
  # end

  def up
    add_column :users, :is_betting_allowed, :boolean, default: false
    User.update_all(is_betting_allowed: false)
  end

  def down
    change_column_default :users, :is_betting_allowed, true
    User.update_all(is_betting_allowed: true)
  end
end
