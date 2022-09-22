module Odds
  class WriteToPersistentLayer < ApplicationInteraction
    object :match
    time :snapshot_time
    hash :odds_data, strip: false

    set_callback :execute, :before, -> { sanitize_data } 

    def execute
      MarketData.create!(match_id: match.id, odds_data: odds_data, snapshot_time: snapshot_time)
    end

    def sanitize_data
      odds_data[:markets].each do |uid, market|
        market['49'].delete('handicaps')
      end
    end
  end
end
