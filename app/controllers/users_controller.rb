class UsersController < BaseController
  layout 'user_theme'
  after_action :sign_out_user, only: %I[update_responsive_gambling], if: -> { current_user.saved_change_to_exclusion_time? }

  def edit; end

  def responsive_gambling
    
  end

  def update
    bypass_blank_password
    current_user.assign_attributes((current_user.email.blank?) ? user_params : user_params.except(:email))
    if current_user.save
      flash[:error] = current_user.errors.full_messages.to_sentence if current_user.errors.any?
      flash[:notice] = t('success_update', name: t('user'))
      bypass_sign_in current_user
      redirect_to edit_user_path(current_user)
    else
      flash[:error] = current_user.errors.full_messages.to_sentence
      redirect_to edit_user_path(current_user)
    end
  end

  def set_rc_timestamp
    session[:rc_timestamp] = Time.zone.now.to_i
  end

  def update_responsive_gambling
    current_user.assign_attributes(user_params)
    exclusion_time_in_utc = params[:user][:exclusion_time]&.in_time_zone(params[:zone])&.utc
    current_user.exclusion_time = exclusion_time_in_utc 
    
    current_user.reality_check_timer = nil if user_params[:disable_rc_timer] == '1' ||
                                              user_params[:reality_check_timer] == '00:00'

    if current_user.save(validate: false)
      set_rc_timestamp if current_user.saved_change_to_reality_check_timer?
      flash[:notice] = t('success_update', name: t('settings'))
    else
      flash[:error] = t('went_wrong')
    end
    
    redirect_to responsive_gambling_user_path(current_user)
  end

  private

  def bypass_blank_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :username, :email, :occupation, :organization,
      :password, :password_confirmation, :reality_check_timer, :disable_rc_timer,
      :exclusion_time, :selfie_picture, :govt_id_picture, :zone_name, :street,
      :house_number, :town_city, :zip_code, :phone_number
    )
  end

  def sign_out_user
    return unless current_user.exclusion_time &.> Time.zone.now
    Doorkeeper::AccessToken.where(resource_owner_id: current_user).destroy_all
    sign_out current_user
  end
end
