module Users
  class SendOtpMail < ApplicationService
    attr_reader :email, :otp

    def initialize(email, otp)
      @email = email
      @otp = otp
    end

    def call
      EmailOtpMailer.send_mail(email, otp).deliver
      otp
    rescue StandardError => e
      raise e.message
    end

  end
end
