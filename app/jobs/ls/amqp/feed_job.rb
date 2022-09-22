module LS
  module AMQP
    class FeedJob < ApplicationJob
      queue_as :amqp_processes

      def perform(routing_key, timestamp, data)
        # Storing data into cache
        # write_data_into_file(data, timestamp)

        case data[:Header][:Type]

        when 0 # Full event (fixture, markets, livescore)
        # when Constants::LSPORTS_MSG_TYPE["Fixture metadata"] # 1 Fixture metadata update
        #   update_metadata(data)
        when Constants::LSPORTS_MSG_TYPE["Livescore"] # 2 Livescore update
          update_time_and_score(data)
        # when Constants::LSPORTS_MSG_TYPE["Market Update"] # 3 Market update
        # matches_markets_odds_update(data)
        when 4 # Leagues
        when 5 # Sports
        when 6 # Locations
        when 7 # Markets
        when 8 # Bookmakers

        when 31 # Keep Alive
          # Rails.logger.info "Keep Alive"
        when 32 # Heartbeat
          # Rails.logger.info "Heartbeat"
        when Constants::LSPORTS_MSG_TYPE["Settlements"] # 35
          LS::FeedResultJob.perform_later(data, 'inplay')
        when Constants::LSPORTS_MSG_TYPE["Snapshot"] # 36
          create_match(data)        
          update_metadata(data)
          update_time_and_score(data)
          # matches_markets_odds_update(data)
        when 37 # Outright fixture metadata
        when 38 # Outright Leauge
        end
      end

      private
      
      def create_match(data)
        data[:Body][:Events].each do |fixture|
          match = Match.find_by uid: fixture[:FixtureId].to_s
          next if match.present?
          LS::CreateMatchJob.perform_later(fixture[:FixtureId].to_s, fixture[:Fixture])
        end
      end

      def matches_markets_odds_update(data)
        data[:Body][:Events].each do |fixture|
          LS::Inplay::MatchMarketsOddsChangeJob.perform_later(fixture)
        end
      end

      def update_metadata(data)
        #mark match as end or update status
        data[:Body][:Events].each do |fixture|
          LS::Inplay::UpdateMatadataJob.perform_later(fixture)
        end
      end

      def update_time_and_score(data)
        data[:Body][:Events].each do |fixture|
          LS::Inplay::UpdateTimeAndScoreJob.perform_later(fixture)
        end
      end

      def write_data_into_file(data, timestamp)
        WriteFeedDataJob.perform_later(data, timestamp)
      end
    end
  end
end
