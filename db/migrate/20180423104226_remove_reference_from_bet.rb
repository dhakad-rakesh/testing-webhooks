class RemoveReferenceFromBet < ActiveRecord::Migration[5.2]
  def change
    remove_reference :bets, :match_outcome, index: true, foreign_key: true
  end
end
