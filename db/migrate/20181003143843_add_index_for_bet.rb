class AddIndexForBet < ActiveRecord::Migration[5.2]
  def change
    add_index :bets, %I[match_id market_id status]
  end
end
