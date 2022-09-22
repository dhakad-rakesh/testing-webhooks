module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if verified_user = env['warden'].user || find_user_by_jwt
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def find_user_by_jwt
      User.find_by(login_token: request.params[:token])
    rescue
      nil
    end
  end
end
