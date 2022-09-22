module Soccer
  module Feed
    module GS
      class PlayerListJob < ApplicationJob
        queue_as :low

        def perform(team_uid)
          team = Team.find_by(uid: team_uid)
          return if team&.uid.blank?
          team_information = client.competitor_information(team_uid)
                                   .with_indifferent_access
          # team_information = GoalServe::Feed::TeamInfo.new.call.xml_to_hash
          players = team_information.dig(:teams, :team, :squad, :player) rescue []
          custom_no_player_logger(team_information) if players.blank?
          Array.wrap(players).each do |player_info|
            Soccer::Feed::GS::PlayerJob.perform_later(player_info, team_uid)
          end
        end

        private

        def custom_no_player_logger(data)
          Rails.logger.info "[Player Feed] : [ No Player present] : [#{data}]"
        end

        def client
          @client ||= GoalServe::Client.new
        end
      end
    end
  end
end
