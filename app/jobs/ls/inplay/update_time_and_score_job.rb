module LS
  module Inplay
    class UpdateTimeAndScoreJob < ApplicationJob
      queue_as :result_process
      include Utility::JobUtility::PublishDataUtility

      def perform(fixture_data)
        # data = {"Header":{"Type":2,"MsgId":13,"MsgGuid":"5d03607e-30f2-4091-9d28-54e599d08697","ServerTimestamp":1588779885},"Body":{"Events":[{"FixtureId":5391512,"Livescore":{"Scoreboard":{"Status":2,"CurrentPeriod":20,"Time":"480","Results":[{"Position":"1","Value":"0"},{"Position":"2","Value":"0"}]},"Periods":[{"Type":10,"IsFinished":true,"IsConfirmed":true,"Results":[{"Position":"1","Value":"0"},{"Position":"2","Value":"0"}],"Incidents":null},{"Type":20,"IsFinished":false,"IsConfirmed":false,"Results":[{"Position":"1","Value":"0"},{"Position":"2","Value":"0"}],"Incidents":null}],"Statistics":[{"Type":1,"Results":[{"Position":"1","Value":"0"},{"Position":"2","Value":"0"}],"Incidents":null},{"Type":6,"Results":[{"Position":"1","Value":"0"},{"Position":"2","Value":"0"}],"Incidents":null},{"Type":7,"Results":[{"Position":"1","Value":"0"},{"Position":"2","Value":"0"}],"Incidents":null},{"Type":8,"Results":[{"Position":"1","Value":"0"},{"Position":"2","Value":"0"}],"Incidents":null},{"Type":10,"Results":[{"Position":"1","Value":"0"},{"Position":"2","Value":"0"}],"Incidents":null}],"LivescoreExtraData":[]},"Markets":null}]}}
        null = ""

        scoreboard = fixture_data.dig(:Livescore, :Scoreboard)
        return if scoreboard.nil?

        match = Match.find_by uid: fixture_data["FixtureId"].to_s
        return if match.nil?
        match.running_time = fixture_data[:Livescore][:Scoreboard][:Time].to_i / 60 rescue 0
        score = ""
        results = scoreboard.dig(:Results).nil? ? [] : scoreboard.dig(:Results)

        results.each do |result|
          if score.present?
            score += ":" + (result[:Value] || 0).to_s
          else
            score += (result[:Value] || 0).to_s
          end
        end

        # Update inplay matches list
        # Utility::InplayMatches.update_list(match)

        match.score = score

        status = scoreboard.dig(:Status)

        # Saving the results at the end of match
        match.results = fixture_data[:Livescore]
        if match.changed?
          match.save 
          # publish_livescore(match)
        end
      end
    end
  end
end