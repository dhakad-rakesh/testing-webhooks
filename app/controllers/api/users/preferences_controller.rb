# Handles current user's profile.
class Api::Users::PreferencesController < Api::BaseController
  skip_before_action :user_authorize!, only: %I[upload_kyc]
  before_action :verify_user, only: %I[upload_kyc]
  before_action :set_errors, only: %I[update upload_kyc]
  # skip_before_action :check_country_status
  before_action :set_favourite_type, only: :favourites
  skip_before_action :check_sign_up_status
  before_action :verify_image, only: :upload_kyc

  def show
    render json: current_user, with_wallet: true
  end

  def update
    # set_favourites
    # current_user.reassociate_topics(params[:related_topics])
    outcome = User::UpdateProfileIntr.run(update_user_params)
    return render_not_found_output(outcome.errors.full_messages.first) unless outcome.errors.blank?
    render_success_output(success_message(params[:update_type]))
  end

  def upload_kyc
    outcome = User::UpdateProfileIntr.run(user: current_user, params: user_params.to_h.merge(kyc_status: 'Pending'))
    return render_not_found_output(outcome.errors.full_messages.first) unless outcome.errors.blank?

    msg = {
      selfie_picture: (url_for_image(current_user&.selfie_picture) if params[:selfie_picture].present?),
      govt_id_picture: (url_for_image(current_user&.govt_id_picture) if params[:govt_id_picture].present?),
      id_picture: (url_for_image(current_user&.id_picture) if params[:id_picture].present?)
    }
    NotificationMailer.kyc_request(AdminUser.first, current_user).deliver_later
    render_success_output(msg)
  end

  def common_settings
    render json: { result: current_user.user_settings}, status: :ok
  end

  def upload_profile_pic
    outcome = User::UpdateProfileIntr.run(user: current_user, params: user_profile_params.to_h)
    return render_not_found_response(outcome.errors.full_messages.first) unless outcome.errors.blank?

    msg = {
      image: (url_for_image(current_user&.image) if params[:image].present?),
    }

    render_success_response(msg)
  end

  def favourites
    records = @favourite_type.favourites_by_user(current_user).paginate(page: params[:page], per_page: params[:per_page])
    render_collection(records)
  end

  private

  def verify_image
    render_error_output("Image / PDF can't be empty") unless params[:selfie_picture].present? && params[:govt_id_picture].present? && params[:id_picture].present?
  end

  def verify_user
    return render_not_found_response(I18n.t('users.not_found')) unless current_user
  end

  def update_user_params
    {
      user: current_user,
      params: user_params.to_h
    }.merge(extra_details)
  end

  def extra_details
    params.permit(:otp, :token)
  end

  def user_profile_params
    user_params.merge(address_attributes: address_attributes)
  end

  def user_params
    params[:upcoming_event_notification] = ActiveRecord::Type::Boolean.new.deserialize(params[:upcoming_event_notification]) if params[:upcoming_event_notification].present?
    params[:promotional_notification] = ActiveRecord::Type::Boolean.new.deserialize(params[:promotional_notification]) if params[:promotional_notification].present?
    params.permit(
      :username, :first_name, :last_name, :date_of_birth, :phone, :image, :gender, :email,
      :password, :password_confirmation, :current_password, :selfie_picture, :govt_id_picture, :id_picture, :currency,
      :locale, :subscribed_to_notifications, :bank_name, :account_number, :account_holder_name, :two_factor_authentication,
      :upcoming_event_notification, :promotional_notification
    )
  end

  def address_attributes
    params.permit(:state, :city, :zip_code, :street_address)
  end

  def favourite_params
    params.permit(:favourite_league, :favourite_tournament, :favourite_cup, :favourite_team)
  end

  def set_errors
    @errors = []
  end

  def set_favourites
    favourites = User::FavouriteIntr.run(user: current_user, favourite_params: favourite_params.to_hash)
    @errors << favourites.errors.full_messages if favourites.errors
    @errors = @errors.flatten.compact
  end

  # TODO: Remove this stupid line
  def url_for_image(image)
    Rails.application.routes.url_helpers.url_for(image)
  end

  def set_favourite_type
    @favourite_type ||= fetch_type_from_params
  end

  def fetch_type_from_params
    case params[:type]&.downcase
    when 'tournament'
      Tournament
    when 'team'
      Team
    else
      Sport
    end
  end

  def success_message(type)
    return t('success') if type.blank?

    {
      notification: t('preferences.notification'),
      password: t('preferences.password'),
      address: t('preferences.address')
    }.dig(type.to_sym)
  end
end
