module LS
  class TimeAndScoreUpdateBatch < ApplicationJob
    queue_as :result_process
    attr_accessor :match_uids

    def perform(m_uids)
      @match_uids = m_uids
      data = client.scores.with_indifferent_access rescue nil
      return if data.nil?

      data[:Body].each do |fixture|
        LS::Inplay::UpdateTimeAndScoreJob.perform_later(fixture)
      end
    end

    private

    def client
      @client = Lsports::Client.new(params: params)
    end

    def params
      { fixtures: match_uids.join(', ') }
    end
  end
end
