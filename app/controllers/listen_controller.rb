require 'open-uri'
require 'stringio'

class ListenController < ApplicationController
  skip_before_action :verify_authenticity_token

  def inplay_soccer
    # queue = Sidekiq::Queue.new("amqp_processes")
    # GS::FeedJob.perform_now(request.body) if queue.size.zero?
    # # This condition should not be occur
    # if queue.latency > 120
    #   # sidekiq not working notify dev and stop betting on site, after start recover the status of matches
    #   is_mail_sent = Rails.cache.fetch("sidekiq_failure_mail")
    #   unless is_mail_sent
    #     AmqpClientErrorMailer.amqp_listner_down(Figaro.env.developers_mail, Time.zone.now.to_s).deliver
    #     GammabetSetting.suspend_live_betting
    #     Rails.cache.write("sidekiq_failure_mail", true, expires_in: 1.hour)
    #   end
    # else
    #   unless GammabetSetting.live_betting_allowed?
    #     Rails.cache.delete("sidekiq_failure_mail")
    #     GammabetSetting.allow_live_betting
    #   end
    # end
    render json: :ok
  end
end
