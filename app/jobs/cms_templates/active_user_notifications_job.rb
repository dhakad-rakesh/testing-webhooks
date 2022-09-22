# Run from admin action
module CmsTemplates
  class ActiveUserNotificationsJob < ApplicationJob
    queue_as :low

    def perform(cms_template_id)
      @content = CmsTemplate.active_user_notification.find_by(id: cms_template_id)
      return if @content.blank?
      User.email_confirmed_users.active_users(1.week.ago).find_in_batches do |group|
        group.each do |person|
          CmsNotificationMailer.notification_details(
            person.email, @content.subject, @content.content
          ).deliver_later
        end
      end
    end
  end
end