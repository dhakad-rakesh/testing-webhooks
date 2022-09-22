class SetForgotPasswordMailer < ApplicationMailer
  def sender(email, pswd)
    @pswd = pswd
    @email = email
    mail(to: email, subject: 'Your new password')
  end
end
