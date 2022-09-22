FactoryBot.define do
  factory :game_session do
    game_uuid { "MyString" }
    player_id { 1 }
    currency { "MyString" }
    session_id { "MyString" }
    return_url { "MyString" }
    start_time { "" }
    end_time { "" }
  end
end
