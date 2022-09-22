class AddUtilizedCasinoBonusToSessionTransactions < ActiveRecord::Migration[5.2]
  change_table :session_transactions do |t|
    t.decimal :utilized_bonus, precision: 17, scale: 5, default: 0.0
  end
end
