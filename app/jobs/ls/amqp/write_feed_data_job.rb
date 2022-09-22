module LS
  module AMQP
    class WriteFeedDataJob < ApplicationJob
      def perform(data, timestamp)
        return if data[:Body].blank? || data[:Body][:Events].blank?
        data[:Body][:Events].each do |fixture|
          write_into_file(fixture, data[:Header][:Type], timestamp)
        end
      end

      private
      def write_into_file(fixture, header_type, timestamp)
        file = File.open("#{file_name(fixture[:FixtureId])}", "a")
        file.write(",\n")
        file.write("#{header_type}_#{timestamp}".to_json)
        file.write(": ")
        file.write(fixture.merge!({"Time"=> "#{fixture[:Livescore][:Scoreboard][:Time] rescue nil }"}).to_json)
        file.close
      end

      def file_name(fixture_id)
        file_name = "ls_amqp_feed_job_#{fixture_id}.json"
        directory = ENV.fetch('LSPORTS_FEED_DIRECTORY', '/home/ubuntu/Feeds/')
        directory + file_name
      end
    end
  end
end