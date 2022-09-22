class Api::MatchesController < Api::SkipAuthenticationController
  before_action :set_favourite_ids, only: %I[live_matches add_favourite remove_favourite favourite_matches]
  before_action :set_match, only: %i[show live_score odds_summary add_favourite remove_favourite]
  before_action :set_bets, only: %I[my_bets]
  before_action :set_tournament_id
  include Api::Countries
  include MatchFilter

  def index
    match_scope = filtered_matches.paginate(page: params[:page], per_page: params[:per_page])
    @tournament = Tournament.find_by_id(params[:tournament_id])
    return render json: { 
                          tournament: TournamentSerializer.new(@tournament, scope_name: :current_user),
                          error: I18n.t('matches.not_found')
                        }, status: :not_found if match_scope.blank? && @tournament.present?
    collection = match_scope.map do |match|
                    # match.name = match.title
                    match
                  end
    render_array_with_query_pagination(collection, 'matches', match_scope, match_options)
  end

  def live_matches(matches = nil)
    matches = Match.non_favourite_live_matches(@favorite_ids) unless params[:action] === "favourite_matches"
    data = []
    matches.each do |sport_id, sport_matches|
      sport_name = sport_matches.first.sport.name.titleize
      tournament_matches = sport_matches.group_by(&:tournament)
      serialized_matches = tournament_matches.map{|t, m| {tournament: t, matches: serialize_matches(m)}}
      data << { name: sport_name, id: sport_id.to_s, live_matches: serialized_matches }
    end
    render json: { data: data }
  end

  def favourite_matches
    matches = Match.favourite_live_matches(@favorite_ids)
    live_matches(matches)
  end

  def show
    # @match.name = @match.title
    render json: @match
  end

  def live_score
    return render_not_found_response(I18n.t('matches.not_found')) unless @match
    sport_name = Utility::Sport.info(@match).name
    serializer_name = sport_name + 'MatchScoreSerializer'
    score = @match.send(sport_name.downcase + '_match_scores')
    return render_error_response('Score not available') if score.blank?
    render_collection(score, serializer: serializer_name.safe_constantize)
  end

  def my_bets
    match_ids = @bets.where(tournament_id: params[:id]).order(created_at: :desc).pluck(:match_id)
    @matches = Match.where(id: match_ids).paginate(page: params[:page], per_page: params[:per_page])
    render_collection(@matches)
  end

  def odds_summary
    odds_summary = OddsSummary.run(market_id: params[:market_id].to_i, identifier: params[:identifier].to_i,
                                   match: @match)
    return render_error_response(odds_summary.errors.full_messages) if odds_summary.errors.present?
    render json: odds_summary.result
  end

  def available_matches
    @sport = Sport.find_by(name: "Soccer")
    tournament_ids = @sport&.tournaments&.active_tournaments_with_active_matches.pluck(:id)
    #tournament_ids = Tournament.where(uid: Constants::ALLOWED_SOCCER_TOURNAMENT).map(&:id)
    matches = Match.where(tournament_id: tournament_ids).active_within_7_days.order(:schedule_at)
                   .paginate(page: params[:page], per_page: params[:per_page])
    render_collection(matches)
  end

  def odds_change
    matches = Match.active_with_live_matches
    data = []
    matches.each do |match|
      data << { 
        id: match.id,
        markets: match.odds_data[:markets],
        match_status: match.status,
        running_score: match.try(:score),
        running_time: match.try(:running_time)
      }
    end
    render json: { data: data }
  end

  def add_favourite
    match_id = @match.id
    unless @favorite_ids.include? match_id
      @favorite_ids << match_id
      Rails.cache.write("live_favorite_matches_#{request.remote_ip}", @favorite_ids.uniq)
      render json: { match_id: match_id, message: I18n.t('matches.add_favourite'), status: 200 }
    else
      render json: { message: 'Already added as a favorite.', status: 400 }
    end
  end

  def remove_favourite
    match_id = @match.id
    if @favorite_ids.include? match_id
      @favorite_ids.delete(match_id)
      Rails.cache.write("live_favorite_matches_#{request.remote_ip}", @favorite_ids)
      render json: { match_id: match_id, message: I18n.t('matches.remove_favourite'), status: 200 }
    else
      render json: { message: 'Not marked as favorite.', status: 400 }
    end 
  end

  # TODO: Refactor and do not modify params hash
  def favorites
    params[:team_id] = current_user.favourite_teams&.values || []
    params[:tournament_id] = current_user.favourite_tournaments&.values || []
    render_favourites_response(filtered_matches)  
  end

  private

  def set_favourite_ids
    @favorite_ids = Rails.cache.fetch("live_favorite_matches_#{request.remote_ip}") || []
  end

  def set_match
    @match = Match.find_by(id: params[:id].to_i)
    return render_not_found_response(I18n.t('matches.not_found')) unless @match
  end

  def set_bets
    params[:scope] = params[:scope].presence || 'all'
    @bets = current_user.bets.traditional.order(created_at: :desc)
    return unless (scope_method = %w[pending won lost hold].detect { |scope| params[:scope] == scope })
    @bets = @bets.send(scope_method)
  end

  def set_tournament_id
    if params[:tournament_id].blank? && params[:tournament_uid].present? && params[:country_uid].present?
      params[:tournament_id] = Tournament.get_id_by_uid_and_country_uid(params[:tournament_uid], params[:country_uid])
    end
  end

  def serialize_matches(matches)
    matches.map{|m| MatchSerializer.new(m, score: true)}
  end

  def match_options
    { 
      market_id: params[:market_id],
      markets: fetch_options(:markets),
      statistics: fetch_options(:statistics)
    }
  end

  def fetch_options(key)
    params.fetch(key, 'true') == 'true'
  end

  def render_favourites_response(matches)
    favorites_response = {}
    favourite_teams =  current_user.favourite_teams&.values || []
    matches.each do |match|
      favorites_response[match.sport_id] ||= {}
      favorites_response[match.sport_id][match.tournament_id] ||= {}
      match.teams.each do |team|
        next unless favourite_teams.include?(team.id)
        favorites_response[match.sport_id][match.tournament_id][team.id] ||= []
        serialize_match =  MatchSerializer.new(match, markets: false, scope: current_user, scope_name: :current_user)
        favorites_response[match.sport_id][match.tournament_id][team.id] << serialize_match
      end
    end
    render json: favorites_response
  end
end
