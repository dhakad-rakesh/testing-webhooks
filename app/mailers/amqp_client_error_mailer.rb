class AmqpClientErrorMailer < ApplicationMailer
  def client_error(email, exception_class, exception_cause, exception_occured_at)
    @email = email
    @exception_class = exception_class
    @exception_cause = exception_cause
    @exception_occured_at = exception_occured_at
    mail(to: email, from: Figaro.env.FROM_EMAIL_ADDRESS, subject: "Urgent || AMQP Client || Error || #{@exception_occured_at}")
  end

  def amqp_listner_down(email, reported_at)
    @email = email
    @reported_at = reported_at
    mail(to: email, from: Figaro.env.FROM_EMAIL_ADDRESS, subject: "Urgent || AMQP Client || #{Rails.env.capitalize} || Feed stopped working")
  end
end
