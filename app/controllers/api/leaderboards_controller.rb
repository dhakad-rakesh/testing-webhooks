class Api::LeaderboardsController < Api::BaseController
  before_action :set_match, only: %I[match]
  before_action :set_start_date, only: %I[world]
  def world
    @users = Rails.cache.fetch('world_leaderboard', expires_in: 2.minutes) do
      Leaderboards::World.run!(start_date: @start_date)
    end
    @match = Match.find_by(uid: 'sr:match:14736791') # TODO: Remove this after 26/02/19 testing
    @match_leaderboard = Rails.cache.fetch("match_leaderboard_#{@match.id}", expires_in: 2.minutes) do
      Leaderboards::Match.run!(match: @match)
    end
    render json: { leaders_board: @users, match_leaderboard: @match_leaderboard,
                   meta: { start_date: @start_date } }.to_json
  end

  def match
    return render_not_found_response(I18n.t('match.not_found')) unless @match
    data = Rails.cache.fetch("match_leaderboard_#{@match.id}", expires_in: 5.minutes) do
      Leaderboards::Match.run!(match: @match)
    end
    render json: data
  end

  private

  def start_date
    return Time.zone.today if params[:period] == 'today'
    return nil if invalid_date_params # invalid_date_param whitelist interval and period
    return Date.new(params[:interval]) if params[:period] == 'year'
    params[:interval]&.send(params[:period])&.ago&.to_date
  end

  def invalid_date_params
    params[:interval].blank? || params[:interval].negative? ||
      !Constants::ALLOWED_PERIODS.include?(params[:period])
  end

  def set_match
    @match = Match.find_by(id: params[:match_id])
  end

  def set_start_date
    params[:interval] = params[:interval].to_i
    @start_date = start_date
  end
end
