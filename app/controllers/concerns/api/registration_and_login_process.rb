module Api
  module RegistrationAndLoginProcess
    extend ActiveSupport::Concern
    included do
      def social_sign_in
        begin
          user = User.from_omniauth(request.env['omniauth.auth'])
        rescue NoMethodError
          return render_error_response('Unable to login. Something went wrong.')
        end
        return render_error_response(I18n.t('users.provider.error')) if user.is_a?(Symbol)
        access_token = user.generate_access_token
        if access_token.is_a?(Doorkeeper::AccessToken)
          return render json: { result: {
            access_token: access_token.token, message: I18n.t('users.provider.message', username: user.username),
            user: UserSerializer.new(user, include: [], scope_name: 'current_user')
          }}
        end
        render_error_response(access_token)
      end

      def sign_in(validate_password: true)
        if validate_password && !@user&.valid_password?(params[:password])
          return render_error_output(I18n.t('users.password.invalid'))
        end

        unless @user.user_not_in_exclusion_time?
          return render_error_output(t('devise.failure.exclusion_period', time: @user.exclusion_time))
        end

        return render_error_output(I18n.t('account.disabled')) unless @user.enabled

        # access_token = encode_token({ user_id: @user.id })
        # SessionLog::CreateJob.perform_later(@user.id)
        # ::Users::UpdateDeviceIdJob.perform_later(@user.id, device_id: params[:device_id]) if params[:device_id].present?
        # @user.update_tracked_fields!(request)
        # return render json: {
        #     access_token: access_token,
        #     user: UserSerializer.new(@user, include: [], scope_name: 'current_user')
        #   }
          
        access_token = @user.generate_access_token
        if access_token.is_a?(Doorkeeper::AccessToken)
          @user.update(login_token: access_token.token)
          SessionLog::CreateJob.perform_later(@user.id)
          ::Users::UpdateDeviceIdJob.perform_later(@user.id, device_id: params[:device_id]) if params[:device_id].present?
          @user.update_tracked_fields!(request)
          return render json: { result: {
            access_token: access_token.token,
            user: UserSerializer.new(@user, include: [], scope_name: 'current_user')
          }}
        end
        render_error_output(access_token)
      end
    end
  end
end
