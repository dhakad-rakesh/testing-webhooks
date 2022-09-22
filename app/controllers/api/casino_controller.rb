require 'json'
require 'will_paginate/array'

class Api::CasinoController < Api::BaseController
  before_action :user_authorize!, only: %i[lobby]
  skip_before_action :user_authorize!, only: %I[index]
  before_action :set_casino_menu, only: %i[init_game_session index]
  before_action :set_game, only: %i[init_game_session]
  before_action :set_menu, only: %i[index featured categories]

  def index
    items = fetch_casino_games
    render json: {
      result:  {
        filters: get_filters(@item_providers),
        menus: @casino_menus,
        items: ActiveModel::Serializer::CollectionSerializer.new(items, each_serializer: QTechCasinoGameSerializer),
        meta: pagination_dict(items)
      }
    }
  end

  def categories
    render json: @casino_menus
  end

  def featured
    # render json: { result:  { featured_menus: @casino_menus.featured.map { |menu| CasinoMenuSerializer.new(menu, featured_items: true) } } }
    items = fetch_featured_items
    render json:  { result:  {
      menus: @casino_menus,
      items: items,
      meta: pagination_dict(items)
    }}
  end

  def init_game_session
    # begin
      return render_error(I18n.t('users.not_found')) unless current_user
      return render_error_output(I18n.t('game.not_found')) unless @game

      language = Constants::CASINO_LANGUAGE_MAP[request.headers['Accept-Language'].to_sym] rescue nil
      r_params = Qtech::RequestBuilder.new(current_user, params[:ip], @game, 'en_US').execute
      @game_url = qtech_client.game_url(@game.uid, r_params)
      # Create game session
      # Casino::CreateGameSessionJob.perform_later(current_user.id, r_params) if game_url.present?
    # rescue StandardError => e
    #   # @errors = e.message
    #   return render_error_output(t('went_wrong'))
    # end
    render json: { result: { url: @game_url } }
  end

  def lobby
    r_params = requested_params
    response = client.with_lobby(params: r_params)

    fail response if response.try(:code) != 200

    @lobby_items = JSON.parse(response)
  rescue StandardError => e
    render json: { url: casino_index_path, errors: e.message }
  end

  private

  def client
    @client ||= Casino::Client.new
  end

  def qtech_client
    @client ||= ::Qtech::ApiClient::Client.new
  end

  # def requested_params
  #   if params[:action] == 'init_game_session'
  #     { 'game_uuid' => params[:id],
  #       'player_id' => current_user.id.to_s,
  #       'player_name' => current_user.full_name.strip.titlecase.delete(' '),
  #       'currency' => Constants::CASINO_CURRENCY,
  #       'session_id' => SecureRandom.hex,
  #       'email' => current_user.email }.merge(params.as_json.slice('lobby_data'))

  #   elsif params[:action] == 'lobby'
  #     { 'game_uuid' => params[:id],
  #       'currency' => Constants::CASINO_CURRENCY }
  #   else
  #     {}
  #   end
  # end

  def create_game_session_transaction
    params[:bet_type] = params[:type]
    Casino::CreateGameSessionTransaction.new(params, @user).call
  end

  def set_user
    @user ||= User.find_by(id: params[:player_id])
  end

  def get_filters(providers)
    filters = {}
    category = ['Free Spins', 'Lobby', 'Mobile']

    filters['all_providers'] = providers
    filters['category'] = category
    filters
  end

  def set_casino_menu
    @casino_menu = CasinoMenu.find_by(id: params[:menu_id])
  end

  def fetch_casino_items
    # @casino_menu ||= @casino_menus.first

    items = @casino_menu&.casino_items&.active_items || filter_casino_items
    # @item_providers = items.pluck(:provider).uniq
    items = items.has_freespins if params[:has_free_spin].present?
    items = items.has_lobby if params[:has_lobby].present?
    items = items.is_mobile if params[:is_mobile].present?
    items = items.providers(params[:provider]) if params[:provider].present?
    items = items.search_by(params[:search]) if params[:search].present?
    items.paginate(page: params[:page])
  end

  def fetch_casino_games
    @casino_menu ||= @casino_menus.first
    @items = @casino_menu.q_tech_casino_games
    @item_providers = @items.pluck(:provider).uniq

    @items = @items.has_freespins if params[:has_free_spin].present?
    @items = @items.providers(params[:provider]) if params[:provider].present?
    @items = @items.search_by(params[:search]) if params[:search].present?
    @items.paginate(page: params[:page])
  end

  def fetch_featured_items
    @casino_menus = @casino_menus.featured
    @items = filter_casino_items
    @items = @items.search_by(params[:search]) if params[:search].present?
    @items.paginate(page: params[:page])
  end

  def filter_casino_items
    CasinoItem.menu_items(@casino_menus.ids)
  end

  def set_menu
    @casino_menus = if params[:live_casino] == 'true'
      CasinoMenu.live.enabled
    else
      CasinoMenu.non_live.enabled
    end
  end

  def set_game
    # @game = CasinoItem.find_by(uuid: params[:uuid])
    @game = QTechCasinoGame.find_by(uid: params[:uuid])
  end
end
