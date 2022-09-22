class CmsNotificationMailer < ApplicationMailer
  include ActionView::Helpers::OutputSafetyHelper
  def notification_details(email, subject, body)
    @email = email
    @body = raw(body)
    send_mail_notification(@email, subject)
  end
end
