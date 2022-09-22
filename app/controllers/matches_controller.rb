class MatchesController < BaseController
  before_action :load_sport, :load_match, only: :show
  layout 'main'
  skip_before_action :authenticate_user!

  def show
    @bets = current_user.placed_bets.pending if current_user.present?
    markets = Rails.cache.fetch(Utility::Cache.odds_change_cache_key(@live_match.id)) do
      Odds::MatchOutcomeOddsData.run!(match: @live_match)
    end
    @markets = markets[:markets]
  end

  def index
    scope = Match::SCOPES.include?(params[:scope]) ? params[:scope].downcase : 'all'
    @matches = Match.active_matches.send(scope).paginate(page: params[:page], per_page: params[:per_page])
  end

  private

  def load_match
    @live_match = @sport.matches.active_matches.where(id: params[:id]).first
    if @live_match.blank?
      flash[:error] = "Match is not available."
      redirect_to root_path and return
    end
  end

  def load_sport
    @sport = Sport.find_by(id: params[:sport_id])
    if @sport&.name.to_s != "Soccer"
      flash[:error] = "Sport is not available."
      redirect_to root_path and return
    end
  end 
end
