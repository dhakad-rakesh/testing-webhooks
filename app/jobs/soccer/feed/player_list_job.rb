module Soccer
  module Feed
    class PlayerListJob < ApplicationJob
      queue_as :low

      def perform(team_uid)
        team = Team.find_by(uid: team_uid)
        return if team.blank? || team.uid.include?('simpleteam')
        team_information = client.competitor_information(team_uid)
                                 .with_indifferent_access
        players = team_information.dig(:competitor_profile, :players, :player)
        custom_no_player_logger(team_information) if players.blank?
        Array.wrap(players).each do |player_info|
          Soccer::Feed::PlayerJob.perform_later(player_info, team_uid)
        end
      end

      private

      def custom_no_player_logger(data)
        Rails.logger.info "[Player Feed] : [ No Player present] : [#{data}]"
      end

      def client
        @client ||= Betradar::Client.new
      end
    end
  end
end
