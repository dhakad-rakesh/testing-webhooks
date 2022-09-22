class EmailOtpMailer < ApplicationMailer
  layout 'mailer'

  def send_mail( email, otp)
    # @user = User.find(user_id)
    @body = "Your OTP is #{otp}"
    mail(
      from: Figaro.env.FROM_EMAIL_ADDRESS,
      to: email,
      subject: 'OTP'
    )
  end

end
