class AddMarketsAndOutcomesInBet < ActiveRecord::Migration[5.2]
  def change
    add_reference :bets, :market, index: true
    add_reference :bets, :outcome, index: true
    add_reference :bets, :match, index: true
    add_column :bets, :specifier_text, :json
  end
end
