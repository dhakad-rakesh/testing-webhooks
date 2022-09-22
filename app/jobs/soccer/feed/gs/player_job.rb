module Soccer
  module Feed
    module GS
      class PlayerJob < ApplicationJob
        queue_as :low

        def perform(player_info, team_uid)
          team = Team.find_by(uid: team_uid)
          return if team.blank?
          ::Soccer::Create::GS::TeamPlayers.run!(
            team_player_params(player_info).merge(team: team)
          )
        end

        private

        def team_player_params(player_info)
          { uid: player_info[:id], name: player_info[:name], age: player_info[:age],
            gender: player_info[:gender], player_type: player_info[:player_type],
            nationality: player_info[:nationality],
            jersey_number: player_info[:jersey_number],
            country_code: player_info[:country_code]
           }
        end
      end
    end
  end
end
