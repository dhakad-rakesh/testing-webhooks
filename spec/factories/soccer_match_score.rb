FactoryBot.define do
  factory :soccer_match_score do
    match_status { '7' }
    home_score { 1 }
    away_score { 0 }
    clock { { match_time: '49:58' } }
    period_scores do
      { period_score: [
        {
          match_status_code: '6',
          number: 1,
          home_score: 1,
          away_score: 0
        },
        {
          match_status_code: 7,
          number: 2,
          home_score: 0,
          away_score: 0
        }
      ] }
    end
    statistics do
      { corners: { home: 1, away: 4 },
        red_cards: { home: 0, away: 0 },
        yellow_cards: { home: 0, away: 0 },
        yellow_red_cards: { home: 0, away: 0 } }
    end
    home_corners { 1 }
    away_corners { 4 }
    match_id { FactoryBot.create(:match).id }
  end
end
