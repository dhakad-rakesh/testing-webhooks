class Users::OmniauthCallbacksController < ApplicationController
  def social_sign_in
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if !@user.is_a?(Symbol) && @user.persisted?
      @user.skip_confirmation! unless @user.confirmed?
      flash[:notice] = t('users.sign_in')
      sign_in @user, event: :authentication
      redirect_to root_path
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end
end
