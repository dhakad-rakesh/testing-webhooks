class AddBetTypeAndInvitationCodeToBet < ActiveRecord::Migration[5.2]
  def change
    add_column :bets, :bet_type, :integer, default: 0, index: true
    add_column :bets, :invitation_code, :string, index: true
  end
end
