class AddAdminUserIdToLedgers < ActiveRecord::Migration[5.2]
  def change
    add_reference :ledgers, :admin_user, foreign_key: true
  end
end
