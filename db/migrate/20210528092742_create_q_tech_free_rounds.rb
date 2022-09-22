class CreateQTechFreeRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :q_tech_free_rounds do |t|
      t.string :txn_id
      t.references :user, foreign_key: true
      t.references :q_tech_casino_game, foreign_key: true
      t.float :total_bet_value
      t.float :total_payout
      t.string :round_options, array: true
      t.string :currency
      t.string :promo_code
      t.integer :validity_days
      t.boolean :rejectable
      t.string :bonus_id
      t.integer :status, default: 0
      t.datetime :promoted_date_time
      t.datetime :claimed_date_time
      t.datetime :failed_date_time
      t.datetime :completed_date_time
      t.datetime :cancelled_date_time
      t.datetime :deleted_date_time
      t.datetime :expired_date_time
      t.string :claimed_round_option

      t.timestamps
    end
  end
end
