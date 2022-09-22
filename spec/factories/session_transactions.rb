FactoryBot.define do
  factory :session_transaction do
    game_session_id { 1 }
    amount { "9.99" }
    currency { "MyString" }
    game_uuid { "MyString" }
    player_id { "MyString" }
    transaction_id { "MyString" }
    session_id { "MyString" }
    type { "" }
    bet_transaction_id { "MyString" }
    game_type { "MyString" }
  end
end
