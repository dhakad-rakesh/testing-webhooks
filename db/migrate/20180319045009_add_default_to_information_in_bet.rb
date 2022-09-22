class AddDefaultToInformationInBet < ActiveRecord::Migration[5.2]
  def up
    change_column :bets, :information, :json, default: {}
  end

  def down
    change_column :bets, :information, :json, default: nil
  end
end
