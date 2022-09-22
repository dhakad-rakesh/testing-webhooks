class RevertIsBettingAllowedToUser < ActiveRecord::Migration[5.2]
  def up
    change_column_default :users, :is_betting_allowed, true
    User.update_all(is_betting_allowed: true)
  end

  def down
    change_column_default :users, :is_betting_allowed, false
    User.update_all(is_betting_allowed: false)
  end
end
