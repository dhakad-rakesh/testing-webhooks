class CreateParticipantsForBettingPools < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.belongs_to :user, index: true
      t.belongs_to :betting_pool, index: true
      t.index %i[user_id betting_pool_id], unique: true
      t.float :pool_balance, default: 0
      t.timestamps
    end
  end
end
