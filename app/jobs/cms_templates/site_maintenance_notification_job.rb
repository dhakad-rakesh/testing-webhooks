# As per admin schedule
# Will be checked every hour
module CmsTemplates
  class SiteMaintenanceNotificationJob < ApplicationJob
    queue_as :low

    def perform
      @contents = CmsTemplate.site_maintenance_notification.where(schedule_at: Time.zone.now..Time.zone.now + 1.hour) #.order(updated_at: :desc).limit(1).first
      return if @contents.blank?

      User.where.not(email: nil).find_in_batches do |group|
        group.each do |person|
          @contents.each do |content|
            CmsNotificationMailer.notification_details(
              person.email, content.subject, content.content
            ).deliver_later(wait_until: content.schedule_at)
          end
        end
      end
    end
  end
end
