module Soccer
  module Feed
    class PlayerJob < ApplicationJob
      queue_as :low
      def perform(player_info, team_uid)
        team = Team.find_by(uid: team_uid)
        return if team.blank?
        ::Soccer::Create::TeamPlayers.run!(
          team_player_params(player_info).merge(team: team)
        )
      end

      private

      def team_player_params(player_info)
        { uid: player_info[:id], country_code: player_info[:country_code],
          full_name: player_info[:full_name], gender: player_info[:gender],
          dob: player_info[:date_of_birth], player_type: player_info[:type],
          nationality: player_info[:nationality], name: player_info[:name],
          jersey_number: player_info[:jersey_number] }
      end
    end
  end
end
