class CreateGameSessions < ActiveRecord::Migration[5.2]
  def change
    create_table  :game_sessions do |t|
      t.string    :game_uuid,       null: false
      t.integer   :player_id,       null: false
      t.string    :currency,        default: 'USD'
      t.string    :session_id,      null: false
      t.string    :return_url
      t.string    :game_type,       default: 'casino'
      t.decimal   :wallet_amount
      t.decimal   :balance
      t.string    :win
      t.string    :bet
      t.string    :refund
      t.datetime  :start_time
      t.datetime  :end_time
      t.string    :status,          default: 'in_progress'

      t.timestamps
    end
  end
end
