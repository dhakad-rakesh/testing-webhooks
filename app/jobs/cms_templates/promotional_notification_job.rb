# As per admin needs to send / schedule
module CmsTemplates
  class PromotionalNotificationJob < ApplicationJob
    queue_as :low

    def perform(template_id, user_ids = [], send_to_all = false)
      @content = CmsTemplate.promotional_notification.find_by(id: template_id)
      return if @content.blank? || ( user_ids.blank? && send_to_all == false) 

      users = User.where(id: user_ids, promotional_notification: true)
      users = User.all.where(promotional_notification: true) if send_to_all

      users.find_in_batches do |group|
        group.each do |person|
          CmsNotificationMailer.notification_details(
            person.email, @content.subject, @content.content
          ).deliver_later(wait_until: @content.schedule_at)
        end
      end
    end
  end
end
