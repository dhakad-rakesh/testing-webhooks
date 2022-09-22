module MatchFilter
  extend ActiveSupport::Concern

  private

  def filtered_matches
    countries = fetch_countries
    match_scope = fetch_matches(countries)
    if (scope_method = %w[live upcoming last_minutes highlight].detect { |scope| (params[:scope] || 'all') == scope })
      match_scope = match_scope.send(scope_method)
    end
    match_scope.order(:schedule_at)
  end

  # TODO: Optimize & refactor
  def fetch_matches(countries)
    arguments = {}
    arguments[:sport_id] = params[:sport_id] if params[:sport_id].present?
    arguments[:tournament_id] = params[:tournament_id] if params[:tournament_id].present?
    arguments['teams.id'] =  params[:team_id] if params[:team_id].present?
    user_disabled_sports = current_user.present? ? current_user.disabled_sports : []
    global_disabled_sports = Sport.disabled_sports.pluck(:id)
    disabled_sports = { sport_id: user_disabled_sports + global_disabled_sports }
    includes = [:tournament, :teams, :sport, :team_players, :venue]
    match_scope = Match.visible.includes(includes).where.not(disabled_sports).where(arguments).sort_by_tournament(request.headers['X-TimeZone'])
    match_scope = Match.visible.includes(includes).upcoming_7_days.where.not(disabled_sports).where(arguments).sort_by_tournament(request.headers['X-TimeZone']) if params[:scope] == 'upcoming'
    match_scope = Match.visible.includes(includes).active_matches.where.not(disabled_sports).where(arguments).sort_by_tournament(request.headers['X-TimeZone']) if params[:scope] == 'highlight'
    match_scope = match_scope.by_countries(countries) unless countries.blank?
    match_scope = match_scope.dafault_to_view unless params[:scope] == 'all'
    match_scope
  end

  # Ignore country if premier league is selected, to resolve Wales matches issue
  def premier_league_selected?
    tournament_uid = Tournament.find_by(id: params[:tournament_id])&.uid
    tournament_uid == 'sr:tournament:17'
  end
end
