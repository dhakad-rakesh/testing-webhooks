module GS
  # Fetch result from GS and enqueue resolution job
  class FeedResultJob < ApplicationJob
    queue_as :result_process

    def perform
      matches = Match.ended
      matches.each do |match|
        begin
          post_inplay_url = "/results/#{match.schedule_at.strftime("%Y%m")}/#{match.uid}.json"
          match_result = client.inplay_result(post_inplay_url)
          next if match_result.blank? #notify dev
          time_status = match_result[:results][:"0"][:time_status].to_s
          # 0 not started : 1 inplay : 2 To be fixed
          next if Match::GS_NOT_ENDED_CODES.include?(time_status)

          match.update_attribute(:results, match_result)
          
          match.update_column(:status, "resolved") and next if match.bets.blank?

          if time_status == "3" # match ended
            MatchResolutionJob.perform_later(match_result, match.id)
          elsif Match::GS_REFUND_CODES.keys.include?(time_status)
            BetsRefundJob.perform_later(match.id, time_status)
          end
        rescue ::StandardError => exception
          Honeybadger.notify("[#{exception.class}]:[Match id #{match.id}]:[Bets count #{match.bets.count}]")
          #match.update_column(:status, "resolved") if exception.is_a?(GoalServe::Error::NotFound) && match.bets.count.zero?
        end
      end
    end

    private

    def client
      @client ||= GoalServe::Client.new
    end
  end
end