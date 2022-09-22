class SlotGamesController < ApplicationController
  include Utility::SlotGames::Response
  skip_before_action :verify_authenticity_token
  before_action :authorize_action_with_basic_token!
  before_action :set_user, only: %I[authenticate]
  before_action :verify_user, except: %I[authenticate]

  def authenticate
    render json: authenticate_response
  end

  def getFunds
    render json: user_balance_response
  end

  def getStake
    response = SlotGames::Callbacks::Debit.new(params, @user).call
    render json: response
  end

  def rollbackStake
    response = SlotGames::Callbacks::Rollback.new(params, @user).call
    render json: response
  end

  def returnWin
    response = SlotGames::Callbacks::Credit.new(params, @user).call
    render json: response
  end

  def gameClose
    render json: success_response
  end
  
  private

  # def verfify_token(token)
  #   @token ||= Doorkeeper::AccessToken.find_by(token: token)  
  # end

  def set_user
    # render json: session_not_found_response and return unless verfify_token(params[:token]) 
    @user = User.find_by(login_token: params[:token] )
    render json: session_expired_response and return unless @user 
  end

  def verify_user
    @user = User.find_by(id: params.dig(:user, :id), login_token: params.dig(:user, :token)) 
    render json: session_not_found_response and return unless @user
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
    return if auth_header && Base64.decode64(auth_header.split(' ')[1]).eql?(basic_auth_credentials)
    render json: token_not_found_response and return
  end

  def basic_auth_credentials
    "#{Figaro.env.SLOT_AUTH_USERNAME}:#{Figaro.env.SLOT_AUTH_PASSWORD}"
  end

  def auth_header
    request.headers['Authorization']
  end

end
