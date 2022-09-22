class Api::SportsController < Api::SkipAuthenticationController
  before_action :set_sport, only: %I[show matches live_scores]
  include Api::Countries

  def index
    sports = Sport.active_sports.sort_by_rank.paginate(page: params[:page],
                                                       per_page: params[:per_page])
    apk_version = GammabetSetting.first.api_version
    apk_url = GammabetSetting.first.url
    render json: {
      sports: sports.map{|s| SportSerializer.new(s, scope: current_user, scope_name: :current_user)},
      latest_apk_version: apk_version,
      latest_apk_url: apk_url,
      meta: pagination_dict(sports)
    }
  end

  def show
    # return render_not_found_response('sport not found') unless @sport
    # render json: @sport
    tournaments = @sport&.tournaments
    tournaments = tournaments.where(id: params[:league_id]) if params[:league_id].present?
    filtered_tournaments = if params[:scope] == 'live'
                             live_matches(tournaments)
                           elsif params[:scope] == 'today'
                             todays_matches(tournaments)
                           else
                             non_live_matches(tournaments)
                           end

    render_collection(paginate_tournaments(filtered_tournaments), live_casino: params[:scope])
  end

  def matches
    return render_not_found_response('sport not found') unless @sport
    @scope = params[:scope] || 'all'
    countries = fetch_countries
    match_scope = @sport.matches.active_matches
    match_scope = match_scope.by_countries(countries) if countries.present?
    if (scope_method = %w[live upcoming].detect { |scope| @scope == scope })
      match_scope = match_scope.send(scope_method)
    end
    match_scope = match_scope.paginate(page: params[:page], per_page: params[:per_page])
    render_collection(match_scope, include: %w[venue teams tournament], score: @scope.eql?('live'))
  end

  def live_scores
    return render_not_found_response('sport not found') unless @sport

    live_matches = @sport.matches.live.paginate(page: params[:page], per_page: params[:per_page])
    return render_not_found_response('no live matches') if live_matches.blank?

    render_collection(live_matches, score: true, include: %w[sport])
  end

  private

  def set_sport
    @sport = Sport.find_by(id: params[:id])
    return render_not_found_response(I18n.t('errors.messages.sports.not_found')) if @sport.blank?
    render_error_response(I18n.t('errors.messages.sports.not_available')) if current_user.disabled_sports.include?(@sport.id)
  end

  def live_matches(tournaments)
    tournament_ids = Match.live.pluck(:tournament_id).uniq
    begin
      tournaments.where('tournaments.id in (?)', tournament_ids)
                 .includes(:matches)
                 .where(matches: {
                          enabled: true,
                          status: 'in_progress'
                        })
                 .order(:name)
    rescue StandardError
      []
    end
  end

  def non_live_matches(tournaments)
    tournaments.active_tournaments_with_active_matches
               .includes(:matches)
               .where(matches: {
                        enabled: true,
                        status: 'not_started'
                      })
               .order(:name)
  rescue StandardError
    []
  end

  def todays_matches(tournaments)
    tournaments.active_tournaments_with_active_matches
               .includes(:matches)
               .where(matches: {
                        enabled: true,
                        status: %w[in_progress not_started],
                        schedule_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
                      })
               .order(:name)
  rescue StandardError
    []
  end

  def paginate_tournaments(tournaments)
    tournaments.paginate(page: params[:page],
                         per_page: params[:per_page])
  end
end
