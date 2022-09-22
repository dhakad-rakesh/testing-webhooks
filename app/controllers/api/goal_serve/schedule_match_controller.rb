class Api::GoalServe::ScheduleMatchController < ActionController::Base
  before_action :authenticate_request

  def sport
    render status: 404
    # begin
    #   sport_name = params[:sport_name]
    #   file = "/tmp/#{sport_name}.json.gz"
    #   send_file file, status: :ok
    # rescue StandardError => e
    #   render status: 404
    # end
  end

  def result
    # post_inplay_url = "/results/#{params[:match_schedule_date]}/#{params[:match_uid]}.json"
    # match_result = client.inplay_result(post_inplay_url)
    render json: {}, status: :ok
    # begin
    #   match = Match.find_by(uid: params[:match_uid])
    #   if match.present? && match.sport.soccer?
    #     match_result = match&.results || {}
    #   else
    #     post_inplay_url = "/results/#{params[:match_schedule_date]}/#{params[:match_uid]}.json"
    #     match_result = client.inplay_result(post_inplay_url)
    #   end
    #   render json: match_result, status: :ok
    # rescue StandardError => e
    #   render json: {}, status: :ok
    # end
  end

  private

  def client
    @client ||= GoalServe::Client.new
  end

  def authenticate_request
    render_unauthorized && return unless Figaro.env.GS_TOTP_AUTH_SECRET.eql?(token)
  end

  def token
    request.headers['AUTHORIZATION'].try(:gsub, /bearer /i, '') || ''
  end

  def render_unauthorized
    render json: { error: 'You are not authorized to perform such action.' }, status: :unauthorized
  end
end