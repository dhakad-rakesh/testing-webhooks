class Api::SlotGamesController < Api::BaseController
  skip_before_action :user_authorize!, except: :init_game_session
  before_action :set_games, except: :init_game_session
  before_action :set_game, only: :init_game_session

  def index
    render_game_response(fetch_games)
  end

  def featured
    render_game_response(fetch_featured_games) 
  end

  def init_game_session
    begin
      return render_error_response(I18n.t('users.not_found')) unless current_user
      return render_error_response(I18n.t('game.not_found')) unless @game
      lang = Constants::SLOT_LANGUAGE_MAP[request.headers['Accept-Language'].to_sym]
      game_url = "#{Figaro.env.SLOT_BASE_URL}/#{Figaro.env.SLOT_GAME_PARTNERCODE}/gamelauncher?operator=#{Figaro.env.SLOT_GAME_OPERATOR}&game=#{@game.uuid}&mode=real&token=#{current_user.login_token}&license=#{Figaro.env.SLOT_GAME_LICENSE}&lang=#{lang}"
    rescue StandardError => e
      return render_error_response(t('went_wrong'))
    end
    render json: { result: { url: game_url} }
  end

  private

  def set_games
    @games = SlotGame.active_games
  end

  def set_game
    @game = SlotGame.find_by(uuid: params[:uuid])
  end

  def fetch_games
    @games.paginate(page: params[:page])
  end

  def fetch_featured_games
    @games.featured.paginate(page: params[:page])
  end

  def render_game_response(games)
    render json:  { result:  {
      games: games,
      meta: pagination_dict(games)
    }}
  end

end
