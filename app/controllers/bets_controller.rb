class BetsController < BaseController
  include Api::MyBets
  skip_before_action :authenticate_user!, only: [:add_bet_slip, :remove_bet_slip]

  layout 'user_theme'
  before_action :check_kyc, :validates_betting_allowed?, only: %I[create]
  before_action :set_bets, only: %I[index]
  before_action :set_betting_pool, only: %I[create index]

  def index
    @bets = filter_bets(@bets).paginate(page: params[:page], per_page: params[:per_page])
    render_collection(@bets)
  end

  def add_bet_slip
    write_slip_data(add_slip_data(params[:bet_slip]))
    # render json: { message: @errors }, status: :bad_request unless @errors.blank?
  end

  def remove_bet_slip
    write_slip_data(remove_slip_data(params[:bet_slip]))
  end

  def create
    total_betted_winning = current_user.total_betted_winning
    total_bet_slips_winning = params[:bet_slips].values.inject(0) do |sum, slip|
      stake = slip["stake"]
      sum + (stake.to_f * slip["odds"].to_f)
    end
    
    # max_win_limit = Constants::MAX_PER_DAY_WINNING
    # if (total_betted_winning + total_bet_slips_winning) > max_win_limit
    #   remaining_wining = max_win_limit - total_betted_winning
    #   return render_error_response(t('bets.errors.bet_limit_exceeded', max_win_limit: max_win_limit, remaining_wining: remaining_wining))
    # end

    @bet_slips = params[:bet_slips].values
    if (@bet_slips.count > Constants::SLIP_SELECTING_LIMIT)
      return render_error_response("You can't place more than #{Constants::SLIP_SELECTING_LIMIT} bets at a time.")
    end
    match_ids = @bet_slips.map { |a| a['match_id'] }.uniq
    @matches = Match.active_matches.where(id: match_ids)
    return render_not_found_response(t('.matches_response')) if @matches.size < match_ids.size

    @status, @failed_bets = process_bets

    unless @status
      @reload_bet_slips = false
      unless @failed_bets.kind_of?(String)
        @failed_bets.each do |bet_slip|
          next unless bet_slip[:odds_changed]
          @reload_bet_slips = true
        end
      end
      @reload_bet_slips ? update_betslips : render_error_response(@failed_bets)
    else
      Rails.cache.delete(Utility::Cache.player_bet_slips_cache_key(current_user.id))
      @bets = current_user.placed_bets.pending
      @balance = current_user.available_amount
      @total_betted_winning = current_user.total_betted_winning
    end
  end

  def my_bets
    @bets = fetch_bets(Bet, params).paginate(page: params[:page], per_page: 10)
  end

  private

  def set_betting_pool
    return if params[:betting_pool_id].blank?
    @betting_pool = BettingPool.find_by(id: params[:betting_pool_id]&.to_i)
    return render_not_found_response(t('not_found', name: t('pool'))) if @betting_pool.blank?
  end

  def filter_bets(bets)
    %w[country continent tournament_id].each do |parameter|
      bets = bets.where("#{parameter} = ?", params[parameter.to_sym].downcase) if params[parameter.to_sym].present?
    end
    bets
  end

  def set_bets
    params[:scope] = params[:scope].presence || 'all'
    @bets = current_user.bets.traditional.order(created_at: :desc)
    @bets = @bets.where(betting_pool: @betting_pool) if @betting_pool.present?
    return @bets unless (scope_method = %w[pending won lost hold resolved].detect { |scope| params[:scope] == scope })
    @bets = @bets.send(scope_method)
  end

  def process_bets
    BetProcess.new(bet_slips: @bet_slips, user: current_user, betting_pool: @betting_pool, bet_type: params[:bet_type], combo_bet_stake: params[:combo_bet_stake] ).call
  end

  def validates_betting_allowed?
    return(render_error_response(t('betting.suspended'))) unless current_user.betting_allowed?
    return(render_error_response(t('betting.suspended'))) unless GammabetSetting.betting_allowed?
  end

  def add_slip_data(bet_slip)
    data = fetch_slip_data
    slip = data.find do |s|
      s[:match_id] == bet_slip[:match_id] && s[:market_id] == bet_slip[:market_id] && bet_slip[:outcome_id] == s[:outcome_id]
    end

    # match = data.find do |s|
    #   s[:match_id] == bet_slip[:match_id]
    # end

    if slip.present?
      slip[:stake] = bet_slip[:stake]
      slip[:total_value] = bet_slip[:total_value]
    # elsif match.blank?
    else
      bet_slip[:total_value] = '0.00'
      data << bet_slip
    end
    # @errors = "Please select a different match" unless match.blank?
    data
  end

  def remove_slip_data(bet_slip)
    data = fetch_slip_data
    data.delete_if do |s|
      bet_slip == 'All' || (s[:match_id] == bet_slip[:match_id] && s[:market_id] == bet_slip[:market_id] && bet_slip[:outcome_id] == s[:outcome_id])
    end
    data
  end

  def update_betslips
    updated_slips = []
    data = Rails.cache.fetch(Utility::Cache.player_bet_slips_cache_key(current_user.id)) || []
    data.each do |slip|
      match = Match.find_by(id: slip[:match_id])
      if match.in_play?
        odds = match.firestore_snapshot.dig(:market, slip[:market_uid].to_s.to_sym, :outcomes, slip[:outcome_id].to_s.to_sym, :Price)
      else
        odds = Utility::MarketUtility.identifier_data(slip[:match_id], slip[:market_id], "49").dig(:outcomes, slip[:outcome_id].to_s).dig(:odds)
      end
      if slip[:odds] != odds
        slip[:odds] = odds
        slip[:odds_changed] = true
      else
        slip[:odds_changed] = false
      end
      updated_slips << slip
    end
    Rails.cache.write(Utility::Cache.player_bet_slips_cache_key(current_user.id), updated_slips)
    true
  end

  def write_slip_data(data)
    if current_user.present?
      Rails.cache.write(Utility::Cache.player_bet_slips_cache_key(current_user.id), data)
    else
      Rails.cache.write(Utility::Cache.player_bet_slips_cache_key(request.remote_ip), data)
    end
  end

  def fetch_slip_data
    if current_user.present?
      Rails.cache.fetch(Utility::Cache.player_bet_slips_cache_key(current_user.id)) || []
    else
      Rails.cache.fetch(Utility::Cache.player_bet_slips_cache_key(request.remote_ip)) || []
    end
  end
end
