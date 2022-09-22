module LS
  module Inplay
    class UpdateMatadataJob < ApplicationJob
      queue_as :result_process
      include Utility::JobUtility::PublishDataUtility

      def perform(fixture_data)
        # data = {"Header"=>{"Type"=>1, "MsgId"=>8, "MsgGuid"=>"8374591c-8cc6-41f0-bc7d-b3d1912f54ce", "ServerTimestamp"=>1588420913}, "Body"=>{"Events"=>[{"FixtureId"=>5376124, "Fixture"=>{"Sport"=>{"Id"=>35232, "Name"=>"Ice Hockey"}, "Location"=>{"Id"=>79, "Name"=>"Russia"}, "League"=>{"Id"=>36976, "Name"=>"League Pro Moscow"}, "StartDate"=>"2020-05-02T11:00:00", "LastUpdate"=>"2020-05-02T12:01:37.733629", "Status"=>3, "Participants"=>[{"Id"=>52396976, "Name"=>"Ice Banda", "Position"=>"1"}, {"Id"=>52396974, "Name"=>"Shest Trolley", "Position"=>"2"}]}, "Livescore"=>nil, "Markets"=>nil}]}}
        # fixture_data = {"FixtureId"=>5376124, "Fixture"=>{"Sport"=>{"Id"=>35232, "Name"=>"Ice Hockey"}, "Location"=>{"Id"=>79, "Name"=>"Russia"}, "League"=>{"Id"=>36976, "Name"=>"League Pro Moscow"}, "StartDate"=>"2020-05-02T11:00:00", "LastUpdate"=>"2020-05-02T12:01:37.733629", "Status"=>3, "Participants"=>[{"Id"=>52396976, "Name"=>"Ice Banda", "Position"=>"1"}, {"Id"=>52396974, "Name"=>"Shest Trolley", "Position"=>"2"}]}, "Livescore"=>nil, "Markets"=>nil}
        
        match = Match.find_by uid: fixture_data['FixtureId'].to_s
        return if match.nil?

        ls_status = fixture_data['Fixture']['Status']
        status = match.load_ls_status(ls_status) unless ls_status.nil?

        match.status = status unless ls_status.nil?

        if (match.about_to_start? || match.coverage? || match.not_started?) && status == 'in_progress' && match.live == false
          match.live = true
          OddStore.new(match.id).odds_data = { markets: {} }
        end

        # Subscribed Inplay, We update inplay subscribed with cron
        # match.inplay_subscribed = true unless match.inplay_subscribed

        # ended, cancelled, postponed, interrupted, abandoned
        if [3, 4, 5, 6, 7].include?(ls_status)
          match.live = false
          match.enabled = false if match.enabled
        else
          match.enabled = true unless match.enabled
        end

        if match.changed?
          match.save 
          publish_status_updates(match)
        end

        # clean_queue(match.uid) if ls_status != 2 # in progress # Not required on inplay thorugh aws lambda
      end

      private

      # def clean_queue(match_uid)
      #   queue = "odds_#{match_uid}"
      #   Sidekiq::Queue.all.select { |a| a.name == queue }.first&.clear
      # end
    end
  end
end
