class Api::BaseController < ApplicationController
  before_action :authorize_user_doorkeeper_access
  before_action :user_authorize!
  # before_action :doorkeeper_authorize!
  # before_action :check_apk_version
  before_action :set_page_params
  #before_action :check_country_status
  before_action :check_sign_up_status

  private

  def check_apk_version
    unless request.headers['HTTP_APK_VERSION'] == GammabetSetting.apk_version.to_s
      return render json: { message: I18n.t(:upgrade_apk), url: GammabetSetting.first.url }, status: 400
    end
  end

  def set_page_params
    params[:page] = params[:page].to_i.zero? ? 1 : params[:page].to_i
    params[:per_page] = params[:per_page].to_i.zero? ? Constants::CASINO_PERPAGE : params[:per_page].to_i
  end

  def current_user
    @current_user ||= User.find_by(login_token: doorkeeper_token.token) if doorkeeper_token
    # @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    # @current_user ||= User.find_by(id: decoded_token&.first&.dig("user_id"))
  end

  def encode_token(payload)
    JWT.encode payload , Figaro.env.JWT_SECRET
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, Figaro.env.JWT_SECRET, true, algorithm: 'HS256')
      rescue StandardError => e
        nil
      end
    end
  end

  def auth_header
    request.headers['Authorization']
  end

  def render_not_found_response(message)
    render_response(message, 404)
  end

  def render_not_found_output(message)
    render_error_output(message, 404)
  end

  def render_error_response(message)
    render_response(message, 400)
  end

  # def render_error_output(message)
  #   render json: { message: message }, status: 400
  # end

  def render_partial_success_response(message, errors)
    render json: { message: message, errors: errors }, status: :ok
  end

  def render_error(message)
    render json: { error: message }, status: 200
  end

  def render_success_response(message)
    render_response(message, 200)
  end

  def render_success_output(message)
    render json: { result: { message: message }}, status: 200
  end

  def render_response(message, code)
    render json: { message: message }, status: code
  end

  def render_error_output(message, code={})
    render json: { error: { error_message: message }}, status: 200
  end

  def render_cashout_response(message, code, errors, cashoutable={})
    render json: { message: message, cashoutable: cashoutable, errors: errors }, status: code
  end

  def authorize_user_doorkeeper_access
    current_user
  end

  def pagination_dict(collection)
    {
      total_count: collection.count,
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages
    }
  end

  def render_collection(collection, options = {})
    render_args = { json: collection, meta: pagination_dict(collection) }.merge(options)
    render render_args
  end

  def render_array_with_query_pagination(collection, root, query = nil, options = {})
    query = collection if query.nil?
    render_args = { json: collection, root: root, meta: pagination_dict(query) }.merge(options)
    render render_args
  end

  def check_country_status
    return if social_app?
    status = Countries::CheckBettingAllowed.new(ip_address: request.env['REMOTE_ADDR']).call
    return render_error_response(I18n.t(:country_betting_disabled)) unless status
  end

  def check_sign_up_status
    return unless current_user
    # return render_error_response(I18n.t('users.unverified')) unless current_user.completed_sign_up?
  end
end
