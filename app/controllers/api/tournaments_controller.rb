class Api::TournamentsController < Api::SkipAuthenticationController
  before_action :set_tournament, only: %I[show matches teams]
  before_action :set_bets, only: %I[my_bets]
  before_action :set_country, only: %I[index]
  before_action :set_sport, only: %I[index]
  include Api::Countries

  def index
    if params[:sport_id].present? && @sport.blank?
      return render json: { error: I18n.t('sport.not_found') }, status: :not_found
    end

    if @country.present?
      return render json: @country.tournaments
                                  .filter_by_sport(params[:sport_id])
                                  .active_tournaments_with_number_of_matches
                                  .sort_by_rank
    end

    #default = Hash[Tournament.tournament_types.keys.product([[]])]
    default = {"tournaments"=>[]}
    return render json: default.to_json if fetch_tournaments.blank?
    render json: process_tournaments(default)
  end

  def show
    return render_not_found_response(I18n.t(:not_found, name: I18n.t(:tournament))) unless @tournament
    render json: @tournament
  end

  def uid
    @tournament = Tournament.get_by_uid_and_country_uid(params[:tournament_uid], params[:country_uid]) if params[:tournament_uid].present? && params[:country_uid].present?
    return render_not_found_response(I18n.t(:not_found, name: I18n.t(:tournament))) unless @tournament
    render json: @tournament
  end

  def matches
    return render_not_found_response(I18n.t(:not_found, name: I18n.t(:tournament))) unless @tournament
    @scope = params[:scope] || 'all'
    match_scope = @tournament.matches.upcoming.schedulable
    match_scope = match_scope.by_countries(@countries) if @countries.present?
    if (scope_method = %w[live upcoming].detect { |scope| @scope == scope })
      match_scope = match_scope.send(scope_method)
    end
    match_scope = match_scope.sorted.paginate(page: params[:page], per_page: params[:per_page])
    render_collection(match_scope, include: %w[venue teams sport], score: @scope.eql?('live'), market_id: params[:market_id])
  end

  def teams
    return render_not_found_response(I18n.t(:not_found, name: I18n.t(:tournament))) unless @tournament
    tournament_teams = @tournament.teams.sort_by_favourites.paginate(page: params[:page],
                                                                     per_page: params[:per_page])
    render_collection(tournament_teams)
  end

  def my_bets
    tournament_ids = @bets.order(created_at: :desc).pluck(:tournament_id)
    @tournaments = Tournament.where(id: tournament_ids).paginate(page: params[:page], per_page: params[:per_page])
    render_collection(@tournaments)
  end

  private

  def set_tournament
    @tournament = Tournament.find_by(id: params[:id])
  end

  def set_bets
    params[:scope] = params[:scope].presence || 'all'
    @bets = current_user.bets.traditional.order(created_at: :desc)
    return unless (scope_method = %w[pending won lost].detect { |scope| params[:scope] == scope })
    @bets = @bets.send(scope_method)
  end

  def set_country
    if params[:country_id].present?
      @country = Country.where(id: params[:country_id].to_i).first
    end
    render_not_found_response(I18n.t(:not_found, name: I18n.t(:country))) if @country.nil?
  end

  def set_sport
    return if params[:sport_id].blank?
    @sport = Sport.find_by(id: params[:sport_id])
    @context = @sport.tournaments if @sport.present?
  end

  def serialize_tournaments
    ActiveModelSerializers::SerializableResource.new(
      fetch_tournaments, include: [:sport], each_serializer: TournamentSerializer, scope: current_user,
                         scope_name: :current_user
    ).as_json
  end

  def fetch_tournaments
    tournaments = (@context || Tournament).includes(:sport).active_tournaments_with_active_matches.order(:name)
    return tournaments.active_tournaments_by_countries(params[:country]).uniq if params[:country].present?
    tournaments = tournaments.active_tournaments_by_continent(params[:continent]).uniq if params[:continent].present?
    tournaments
  end

  def process_tournaments(default)
    tournaments = serialize_tournaments
    #tournaments = tournaments[:tournaments]&.group_by { |t| t[:tournament_type] }
    default.merge(tournaments)
  end
end
