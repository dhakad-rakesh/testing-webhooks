module LS
  class FeedResultJob < ApplicationJob
    queue_as :result_process
    attr_accessor :match_uids

    def perform(data=nil, kind = 'prematch')
      if ( kind == 'inplay' || kind == 'listener_settlement') && data.present?
        # instant market resolution

        data[:Body][:Events].each do |event|
          match = Match.find_by_uid(event[:FixtureId].to_s)
          next if match.blank? || match.bets.blank?
          LS::MatchResolutionJob.perform_later(event[:FixtureId].to_s, event[:Markets])
        end
      elsif kind == 'prematch'
        # run through cron

        match_ids = Bet.where(status: 'pending').pluck(:match_id)
        @match_uids = Match.ended.recent_by_date.where(id: match_ids).pluck(:uid).uniq

        return if @match_uids.blank?

        data = client.fixture_markets
        return if data.nil?

        data[:Body].each do |fixture|
          fixture_id = fixture[:FixtureId].to_s
          markets = fixture[:Markets]

          match = Match.find_by uid: fixture_id
          next if match.blank?
          LS::MatchResolutionJob.perform_later(fixture_id, markets)
        end
      end
    end

    private

    def client
      @client ||= Lsports::Client.new(params: params)
    end

    def params
      { fixtures: match_uids.join(", ") }
    end
  end
end