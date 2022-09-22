module Sportable
  module Create
    module GS
      class TeamPlayers < Sportable::Base
        string :name, :uid, :age, :gender, :player_type, :nationality,
               :jersey_number, :country_code, default: nil
        object :team
        validates :name, :uid, presence: true

        def execute
          teamplayer = TeamPlayer.find_or_initialize_by(uid: uid)
          begin
            teamplayer.update!(inputs) && teamplayer
          rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
            TeamPlayer.find_by(uid: uid)
          end
        end
      end
    end
  end
end

# Player data from Goal Serve API
# {"id"=>"478822", "name"=>"Gerson", "number"=>"", "age"=>"31", "position"=>"G",
#  "injured"=>"False", "minutes"=>"0", "appearences"=>"0", "lineups"=>"0",
#  "substitute_in"=>"0", "substitute_out"=>"0", "substitutes_on_bench"=>"1",
#  "goals"=>"0", "assists"=>"0", "yellowcards"=>"0", "yellowred"=>"0", "redcards"=>"0",
#  "isCaptain"=>"", "shotsTotal"=>"", "shotsOn"=>"", "goalsConceded"=>"",
#  "fouldDrawn"=>"", "foulsCommitted"=>"", "tackles"=>"", "blocks"=>"", 
#  "crossesTotal"=>"", "crossesAccurate"=>"", "interceptions"=>"", "clearances"=>"",
#  "dispossesed"=>"", "saves"=>"", "insideBoxSaves"=>"", "duelsTotal"=>"",
#  "duelsWon"=>"", "dribbleAttempts"=>"", "dribbleSucc"=>"", "penComm"=>"",
#  "penWon"=>"", "penScored"=>"", "penMissed"=>"", "penSaved"=>"", "passes"=>"",
#  "pAccuracy"=>"", "keyPasses"=>"", "woordworks"=>"", "rating"=>""}
