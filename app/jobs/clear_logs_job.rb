class ClearLogsJob < ApplicationJob
  queue_as :clear_logs

  after_perform do |job|
    NotificationMailer.clear_logs_job.deliver_later
  end

  def perform(*args)
    matches = Match.where("schedule_at < ? and status != ?", Time.zone.now - 4.hours, "ended")
    matches.update_all(enabled: false, status: "ended", highlight: false)
    system("rake log:clear")
  end
end
