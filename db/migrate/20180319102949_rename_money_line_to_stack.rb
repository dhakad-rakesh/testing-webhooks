class RenameMoneyLineToStack < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :bets, :money_line, :stack
  end

  def self.down
    rename_column :bets, :stack, :money_line
  end
end
