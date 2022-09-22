class Api::TeamsController < Api::SkipAuthenticationController
  before_action :match, only: %I[index]
  before_action :set_team, only: %I[matches]

  def index
    return render json: { error: I18n.t('matches.not_found') }, status: :not_found unless @match
    teams = @match.teams.sort_by_favourites
    render json: teams
  end

  def matches
    return render_not_found_response(I18n.t(:not_found, name: I18n.t(:team))) unless @team
    matches = @team.matches.upcoming.schedulable
    render json: { matches: matches.map{ |m| MatchSerializer.new(m, score: true) } }
  end

  private

  def match
    @match ||= Match.find_by(id: params[:match_id])
  end

  def set_team
    @team = Team.find_by(id: params[:id])
  end
end
