# Run after every 15 minute
module LS
  module Inplay
    class UpdateInplaySubscribedMatchesJob < ApplicationJob
      queue_as :default

      def perform
        fixtures = client.ordered_inplay_fixture
        return if fixtures.blank? || fixtures["FixtureOrders"].blank?
        match_uids = fixtures[:FixtureOrders].pluck(:FixtureId)
        if match_uids.present?
          matches = Match.where(uid: match_uids)
          matches.where(inplay_subscribed: false).update_all(inplay_subscribed: true)
          missing_matches_list = match_uids - matches.pluck(:uid).map(&:to_i)
          LS::CreateMissingMatchesJob.perform_later(missing_matches_list) unless missing_matches_list.blank?
          #Created matches will be update for inplay_subscired in next iteration
        end
      end

      private

      def client
        @client ||= Lsports::Client.new(params: schedule)
      end

      def schedule
        from_date = (Time.zone.now - 6.hours).to_i
        { FromDate: from_date }
      end
    end
  end
end