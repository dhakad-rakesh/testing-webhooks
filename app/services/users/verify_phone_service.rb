module Users
  class VerifyPhoneService < ApplicationService
    attr_reader :phone_number, :otp, :token

    def initialize(phone_number, otp, token)
      @phone_number = phone_number
      @otp = otp
      @token = token
    end

    def call
      service = GoogleApi::PhoneVerificationService.new(request)
      response = service.verify_otp!(otp)
      response.phone_number == user_phone_number
    rescue
      raise CustomErrors::PhoneVerificationError
    end

  private

    def request
      {
        session_info: token
      }
    end

    def user_phone_number
      "+#{phone_number}"
    end
  end
end
