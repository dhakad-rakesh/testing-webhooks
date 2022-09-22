class RemoveInvitationCodeFromBet < ActiveRecord::Migration[5.2]
  def up
    remove_column :bets, :invitation_code
  end

  def down
    add_column :bets, :invitation_code, :string
  end
end
