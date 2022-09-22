module LS
  module Inplay
    class FeedResultJob < ApplicationJob
      queue_as :result_process
      attr_accessor :match_uids

      def perform
        match_ids = Bet.where(status: 'pending').pluck(:match_id)
        @match_uids = Match.ended.inplay.recent_by_date.where(id: match_ids).pluck(:uid).uniq

        return if @match_uids.blank?
        data = client.snapshot
        return if data.nil?

        data[:Body][:Events].each do |fixture|
          fixture_id = fixture[:FixtureId].to_s
          markets = fixture[:Markets]

          match = Match.find_by uid: fixture_id
          next if match.blank?
          LS::MatchResolutionJob.perform_later(fixture_id, markets)

          status = match.load_ls_status(fixture[:Fixture][:Status])
          match.update_column(:status, status) if match.status != 'ended'
        end
      end

      private

      def client
        @client ||= Lsports::Client.new(params: params)
      end

      def params
        { fixtureIds: match_uids.join(", ") }
      end
    end
  end
end