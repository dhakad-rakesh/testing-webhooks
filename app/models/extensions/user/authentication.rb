module Extensions
  module User
    module Authentication
      extend ActiveSupport::Concern

      included do
        attr_writer :login
        validates :username, uniqueness: true, presence: true
        validates :metamask_address, uniqueness: true, allow_nil: true, length: {minimum: 8}
        validates :email, uniqueness: true, allow_blank: true
        # validate :validate_username
        # invalid key is defined in user/e.yml
        # validates :username, format: { with: /\A[a-zA-Z0-9.,_]+\Z/, message: :invalid },
        #                      length: { in: 3..30 }
        # validate :password_complexity
      end

      def password_complexity
        return if password.blank?
        # validate_complex_password
        validate_common_password
      end

      # bad_password key is defined in models/user/en.yml  
      def validate_complex_password
        # return if password =~ /^(?=.*?[a-zA-Z])(?=.*?[0-9]).(?!.*?[:<>$%]).{6,14}$/
        return if password =~ /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@!*#?&])[A-Za-z\d@!*#?&]{6,14}$/
        errors.add :password, :bad_password
      end

      # TODO: Implementation to be updated
      def validate_common_password
        return unless contains_name? || contains_email?
        errors.add :password, :common_password 
      end

      def contains_email?
        contains?(email.split('@').first)
      end

      def contains_name?
        contains?(first_name) || contains?(last_name) #|| contains?(username)
      end

      def contains?(name)
        return unless name
        password =~ /#{name}/i
      end

      def generate_access_token
        access_token = Doorkeeper::AccessToken.new(
          resource_owner_id: id,
          use_refresh_token: true,
          expires_in: nil
        )
        return access_token if access_token.save
        access_token.errors.full_messages.first
      end

      def temporary_access_token
        access_token = Doorkeeper::AccessToken.new(
          resource_owner_id: id,
          use_refresh_token: true,
          expires_in: 1.hours
        )
        return access_token if access_token.save
        access_token.errors.full_messages.first
      end

      def auth_header
        request.headers['Authorization']
      end

      def verify_security_answer?(question_number, answer)
        security_answers.where(security_question_id: question_number, answer: answer).present?
      end

      def login
        @login || username || email
      end

      def validate_username
        return true unless ::User.where(email: username).exists?
        errors.add(:username, :invalid)
      end

      def generate_and_save_otp!
        otp = rand(100001..999999)
        status = save_otp!(otp)
        [status, otp]
      end

      def save_otp!(otp)
        self.update(otp: otp, otp_created_at: Time.now)
      end

      def confirm_otp(provided_otp)
        return false if provided_otp.blank? || otp.blank?
        flag = (otp_created_at + 1.hours) > Time.now && otp.eql?(provided_otp)
        return self.update(otp: nil) if flag
        false
      end
    end
  end
end
