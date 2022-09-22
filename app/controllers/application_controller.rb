class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_enabled_user, :gs_session
  before_action :reality_check_notification, except: :set_rc_timestamp
  before_action :log_user_activity, if: :user_signed_in?
  helper_method :social_app?
  helper_method :main_sport
  helper_method :current_time

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %I[first_name last_name email
                                                         password username
                                                         title street house_number town_city
                                                         zip_code phone_number country
                                                         security_answers: [question_id answer]])
    devise_parameter_sanitizer.permit(:account_update, keys: %I[first_name last_name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username])
  end

  def user_authorize!
    user = User.find_by(login_token: doorkeeper_token.token) if doorkeeper_token
    render json: { message: I18n.t('users.not_found') }, status: 401 unless user
  end

  def render_not_found_response(message)
    render_response(message, 404)
  end

  def render_success_response(message)
    render_response(message, 200)
  end

  def render_error_response(message)
    render_response(message, 400)
  end

  def render_partial_success_response(message, errors)
    render json: { message: message, errors: errors }, status: :ok
  end

  def render_response(message, code)
    render json: { message: message }, status: code
  end

  def log_user_activity
    current_user.touch(:last_activity_at)
  end

  private

  def check_enabled_user
    return if current_user.blank? || current_user.enabled
    current_user.access_tokens.last.update(revoked_at: Time.zone.now)
  end

  def gs_session
    session[:gs_session] ||= params[:gs_session].to_s == "true"
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_index_path
    else
      # assign user's ip slips to his/her id
      bet_slips = Rails.cache.fetch(Utility::Cache.player_bet_slips_cache_key(request.remote_ip)) { [] }
      if bet_slips.count > 0
        Rails.cache.write(Utility::Cache.player_bet_slips_cache_key(current_user.id), bet_slips)
        Rails.cache.delete(Utility::Cache.player_bet_slips_cache_key(request.remote_ip))
      end
      if request.env['HTTP_REFERER']&.include?('casino')
        session[:return_to] = '/casino'
      else
        super  
      end
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:gs_session] ||= params[:gs_session].to_s == "true"
    if resource_or_scope == :admin_user
      new_admin_user_session_path
    else
      return request.referrer if request.referrer.include?('casino')
      super
    end
  end

  def social_app?
    Figaro.env.social_app == 'true'
  end

  def reality_check_notification
    begin
      return if current_user.blank? || current_user.reality_check_timer.nil?

      rc_time = current_user.reality_check_timer.strftime('%H:%M')

      rc_time_stamp = Time.parse(rc_time).seconds_since_midnight

      offset_time = session[:rc_timestamp] || sign_in_timestamp
      notification_timestamp = offset_time + rc_time_stamp

      @notify = Time.zone.now >= Time.zone.strptime("#{notification_timestamp}", '%s')
    rescue ::StandardError => exception
      @notify = false
    end
  end

  def sign_in_timestamp
    current_user.current_sign_in_at.to_i
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
    end
  end
  helper_method :mobile_device?

  def main_sport
    @main_sport ||= Sport.main_sport
  end
  
  def current_time(date, zone = Constants::TIME_ZONE, format = '%e %b %Y, %H:%M %a')
    date&.in_time_zone(zone)&.strftime(format)
  end

  # Devise override
  def sign_out(resource_or_scope=nil)
    UpdateTopicSubscriptionJob.perform_later(Constants::ADMIN_NOTIFICATIONS_TOPIC, nil, [session[:current_device_id]].compact)
    super(resource_or_scope)
  end
end
