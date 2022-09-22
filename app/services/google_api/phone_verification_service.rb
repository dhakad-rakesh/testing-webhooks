require 'google/apis/identitytoolkit_v3'

module GoogleApi
  class PhoneVerificationService
    attr_accessor :phone, :recaptcha, :session_info, :service

    Identitytoolkit = Google::Apis::IdentitytoolkitV3
    
    def initialize(args)
      @phone = "+#{args[:phone]}"
      @recaptcha = args[:recaptcha]
      @session_info = args[:session_info]
      @service = Identitytoolkit::IdentityToolkitService.new
      @service.key = key
    end

    def send_otp!
      service.send_relyingparty_verification_code(send_verification_code_request)
    end

    def verify_otp!(otp)
      service.verify_relyingparty_phone_number(verify_phone_number_request(otp))
    end

    def send_verification_code_request
      Identitytoolkit::IdentitytoolkitRelyingpartySendVerificationCodeRequest.new(
        phone_number: phone,
        recaptcha_token: recaptcha
      )
    end

    def verify_phone_number_request(otp)
      Identitytoolkit::IdentitytoolkitRelyingpartyVerifyPhoneNumberRequest.new(
        session_info: session_info,
        code: otp
      )
    end

    def key
      ENV.fetch('FIREBASE_API_KEY', 'AIzaSyCyKMnajK0Qm8UeP44dQXoMO3wjwAS5_0k')
    end
  end
end
