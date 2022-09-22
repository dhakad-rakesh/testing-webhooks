class Api::Test::BetController < Api::BaseController
  skip_before_action :user_authorize!
  before_action :authenticate_admin_user!
  before_action :check_admin_role
  # This controller should only be used for test purpose by developer
  def resolve_bet
    @bets = Bet.where(id: params[:id])
    @match = @bets.first.match
    @status =  params[:status]
    if @bets.present? && @status.in?(['won', 'lost', 'cancelled', 'refunded', 'half_won', 'half_lost'])
      Betting::LS::DirectBetResult.run(data: { match: @match, market: @bets.first.market,  bets: @bets, status: @status, specifiers: {} })
      render json: { message: 'done' }
    else
      render json: { message: 'wrong params' }
    end
  end

  def resettel_bet
    @bet = Bet.find_by(id: params[:id])
    @status =  params[:status]
    if @bet.present? && !@bet.pending? && @status.in?(['won', 'lost', 'cancelled', 'refunded', 'half_won', 'half_lost'])
      Betting::LS::BetResettlement.new(@bet, @status).run
      render json: { message: 'done' }
    else
      render json: { message: 'wrong params' }
    end 
  end

  def run_schedule_matches_job
    ScheduleMatchesJob.perform_later
    render json: { message: 'done' }
  end

  def run_odds_change_job
    LS::OddsChangeJob.perform_later(true)
    render json: { message: 'done' }
  end

  def check_amqp_listener_status
    status = Rails.cache.read(:amqp_prematch_listener_status)
    render json: { status: status }
  end

  def set_amqp_listener_status
    ttl = params[:expire_time]&.to_i || 15
    status = params[:status]
    if status.blank?
      render json: { error: 'Status Blank' } 
      return
    end
    msg = Rails.cache.write(:amqp_prematch_listener_status, status, expires_in: ttl.seconds)
    render json: { message: msg }
  end

  def get_match_firestore_data
    match_uid = params[:uid]
    data = OddsStore::CloudFirestore.read([match_uid]) rescue {}
    if params[:dig_query].present?
      dig_query = params[:dig_query].split(',').map{|s| s.to_sym }
      data = data.dig(*dig_query)
    end
    render plain: JSON.pretty_generate(data)
  end

  private

  def check_admin_role
    render json: { error: 'User not allowed.' } unless current_admin_user&.is_super_admin?
  end 
end
