class WelcomeMailer < ApplicationMailer
  def sender(email)
    @email = email
    send_mail(@email, 'Thank you for signing up.')
  end
end
