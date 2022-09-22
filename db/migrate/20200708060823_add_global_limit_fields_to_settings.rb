class AddGlobalLimitFieldsToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :gammabet_settings, :max_one_bet_amount, :float
    add_column :gammabet_settings, :max_daily_bet_amount, :float
    add_column :gammabet_settings, :max_weekly_bet_amount, :float
    add_column :gammabet_settings, :max_monthly_bet_amount, :float
    add_column :gammabet_settings, :max_single_amount, :float
    add_column :gammabet_settings, :max_day_deposit_amount, :float
    add_column :gammabet_settings, :max_weekly_deposit_amount, :float
    add_column :gammabet_settings, :max_monthly_deposit_amount, :float
    add_column :gammabet_settings, :balance_amount_limit, :float
  end
end
