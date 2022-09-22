module Qtech
  module ApiClient
    module Api
      module AuthenticationApis
        def retrive_access_token
          Rails.logger.info "username: #{qt_user_name} / password=#{qt_password} "
          get(auth_path('v1/auth/token?grant_type=password&response_type=' \
                        "token&username=#{qt_user_name}&password=#{qt_password}"))
        end

        def revoke_access_token(token = nil)
          delete(
            auth_path('v1/auth/token'),
            Authorization: 'Bearer ' + token.presence || retrive_access_token['access_token']
          )
        end

        def qt_user_name
          @qt_user_name ||= ENV['qt_user']
        end

        def qt_password
          @qt_password ||= ENV['qt_password']
        end

        def auth_path(path)
          "#{qt_plate_form_url}/#{path}"
        end
      end
    end
  end
end
