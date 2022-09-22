class DashboardController < BaseController
  layout 'koorabet_theme'
  skip_before_action :authenticate_user!
  before_action :set_tournament, only: [:tournament_fixtures]
  before_action :set_match, only: [:get_match_markets]
  before_action :set_sport, only: %i[index highlight_and_last_minutes_matches]
  before_action :fetch_highlight_and_last_minutes_matches, only: %i[index highlight_and_last_minutes_matches]

  def index
    # @sports = Sport.includes(:countries).sort_by_rank.active_sports
    # redirect_to sport_path(sport)
    # @live_match = Match.find_by(id: params[:match_id])
    # return if @live_match.blank?
    # @bets = @live_match&.bets&.where(user_id: current_user.id)&.where(bet_type: :traditional)&.order(created_at: :desc)
    # markets = Rails.cache.fetch(Utility::Cache.odds_change_cache_key(@live_match.id)) do
    #   Odds::MatchOutcomeOddsData.run!(match: @live_match)
    # end
    # @markets = markets[:markets]
    render 'home'
  end

  def home; end

  def countries_list
    @sport = Sport.find_by(id: params[:sport_id]&.to_i)
    @countries = @sport.available_countries_with_matches
    @show_link = ''
    case params[:kind]
    when 'show all'
      @show_link = 'show less'
    when 'show less'
      @show_link = 'show all'
    else
      []
    end
    respond_to do |format|
      format.js
    end
  end

  def tournament_fixtures
    @matches = @tournament&.matches&.upcoming&.schedulable
    respond_to do |format|
      format.js
    end
  end

  def get_match_markets
    @markets = @match.arrange_markets_by_ranking
    respond_to do |format|
      format.js
    end
  end

  def search
    matches = Match.search(params[:query])
    @grouped_matches = matches.group_by { |m| m&.tournament&.name }
    respond_to do |format|
      format.js
    end
  end

  def highlight_and_last_minutes_matches
    respond_to do |format|
      format.js
    end
  end

  private

  def set_tournament
    @tournament = Tournament.find_by(id: params[:tournament_id])
  end

  def set_match
    @match = Match.find_by(id: params[:match_id])
  end

  def set_sport
    @sport = Sport.find_by(id: params[:sport_id])
    # Set default sport #Soccer
    @sport = Sport.find_by(uid: 6046) if @sport.blank?
  end

  def fetch_highlight_and_last_minutes_matches
    @highlighted_matches = @sport.matches.highlight.schedulable.order(:schedule_at)
    @last_minutes_matches = @sport.matches.last_minutes.order(:schedule_at)
  end
end
