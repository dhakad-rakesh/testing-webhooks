class CasinoController < ApplicationController
  include Utility::Casino::Response
  skip_before_action :verify_authenticity_token
  before_action :authorize_action_with_basic_token!
  before_action :set_user
  before_action :verify_sid, except: :sid
  before_action :set_user_session, only: %I[check]
  before_action :generate_temporary_sid, only: %I[sid]
  
  def check
    render json: check_response
  end
  
  def sid
    render json: check_response
  end

  def balance
    render json: user_balance_response
  end

  def debit
    response = Casino::Callbacks::Debit.new(params, @user).call
    @user.show_real_time_user_wallet
    render json: response
  end

  def credit
    response = Casino::Callbacks::Credit.new(params, @user).call
    @user.show_real_time_user_wallet
    render json: response
  end

  def cancel
    response = Casino::Callbacks::Rollback.new(params, @user).call
    @user.show_real_time_user_wallet
    render json: response
  end
  
  private

  def decoded_auth_token
    @token ||= Doorkeeper::AccessToken.find_by(token: params[:sid])
  end

  def verify_sid
    # @user = User.find_by(id: decoded_auth_token&.resource_owner_id)
    valid_sid = @user.id.eql?(decoded_auth_token&.resource_owner_id)
    render json: session_not_found_response and return unless valid_sid 
    @uuid = params[:uuid]   
  end

  def set_user
    @user = User.find_by(id: params[:userId])
    render json: invalid_parameter_response and return unless @user 
  end

  def generate_temporary_sid
    @new_session_id = @user.temporary_access_token.token 
    @uuid = params[:uuid]
  end

  def set_user_session
    decoded_auth_token.destroy
    access_token = @user.generate_access_token
    @new_session_id = access_token.token
  end

  def authorize_action_with_basic_token!
    return if params[:authToken] && Base64.decode64(params[:authToken]).eql?(basic_auth_credentials)
    render json: token_not_found_response and return
  end

  def basic_auth_credentials
    "#{Figaro.env.BASIC_AUTH_USERNAME}:#{Figaro.env.BASIC_AUTH_PASSWORD}"
  end

end
