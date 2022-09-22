# Once in a day
module CmsTemplates
  class SpecialDayNotificationJob < ApplicationJob
    queue_as :low

    def perform
      @content = CmsTemplate.special_day_notification.order(updated_at: :desc).limit(1).first
      return if @content.blank?

      current_day = Time.zone.today
      User.where('extract(month from date_column) = ?', current_day.month)
          .where('extract(day   from date_column) = ?', current_day.day).find_in_batches do |group|
        group.each do |person|
          CmsNotificationMailer.notification_details(
            person.email, @content.subject, @content.content
          ).deliver_later
        end
      end
    end
  end
end
