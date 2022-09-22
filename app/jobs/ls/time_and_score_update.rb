module LS
  class TimeAndScoreUpdate < ApplicationJob
    queue_as :result_process

    def perform
      @matches_uids = Match.where(schedule_at: (Time.zone.now - 1.hour)..Time.zone.now, inplay_subscribed: false)
                         .pluck(:uid)
                         .uniq

      @matches_uids.each_slice(10).each_with_index do |m_uids, index|
        TimeAndScoreUpdateBatch.set(wait: index.minutes).perform_later(m_uids)
      end
    end
  end
end
