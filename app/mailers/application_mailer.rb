class ApplicationMailer < ActionMailer::Base
  default from: 'BETDEFI <services@betdefi.com>'
  layout 'mailer'

  def send_mail(email, subject)
    return if email.blank?
    mail(to: email, subject: subject)
  end

  def send_mail_notification(email, subject)
    return if email.blank?
    mail(to: email, subject: subject, from: Figaro.env.FROM_EMAIL_ADDRESS) do |format|
      format.html { render(layout: false) }
    end
  end
end
