# Every wed

module CmsTemplates
  class UpcomingEventNotificationJob < ApplicationJob
    queue_as :low

    def perform
      @content = CmsTemplate.highlight_match_notification.where(schedule_at: Time.zone.now..Time.zone.now + 1.hour).order(updated_at: :desc).limit(1).first
      return if @content.blank?

      User.where(upcoming_event_notification: true).find_in_batches do |group|
        group.each do |person|
          if @content.schedule_at.present?
            CmsNotificationMailer.notification_details(
              person.email, @content.subject, @content.content
            ).deliver_later(wait_until: @content.schedule_at)
          else
            CmsNotificationMailer.notification_details(
              person.email, @content.subject, @content.content
            ).deliver_later
          end
        end
      end
    end
  end
end
