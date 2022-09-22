require 'will_paginate/array'

class Api::BetsController < Api::BaseController
  include Api::MyBets
  before_action :set_bets, only: %I[index]
  before_action :validates_betting_allowed?, :check_stake, only: %I[create]
  # before_action :check_kyc, only: %I[create]
  skip_before_action :verify_authenticity_token, only: [:create]
  # before_action :set_betting_pool, only: %I[create index]
  before_action :set_bet_slips, only: %I[create]

  def index
    bets = fetch_bets(Bet, params)
    render_args = { json: bets, root: "bets", meta: pagination_dict(bets) }
    render render_args
  end

  def create
    if (@bet_slips.count > Constants::SLIP_SELECTING_LIMIT)
      return render_error_response(I18n.t(:bet_limit_message, limit: Constants::SLIP_SELECTING_LIMIT))
    end
    match_ids = @bet_slips.map { |a| a[:match_id] }.uniq
    matches = Match.where(id: match_ids).pluck(:id)
    unless matches.count.equal?(match_ids.size)
      return render_not_found_response(I18n.t('matches.not_found_count', count: matches - match_ids))
    end
    status, failed_bets = process_bets
    unless status
      reload_bet_slips = false
      unless failed_bets.kind_of?(String)
        failed_bets.each do |bet_slip|
          next unless bet_slip[:odds_changed]
          reload_bet_slips = true
        end
      end
      if reload_bet_slips
        render_data(update_betslips(params[:bet_slips]), reload_bet_slips)
      else
        render_error_response(failed_bets)
      end
    else
      render_message = (params[:bet_type] == 'combo') ? I18n.t('success_create', name: t('combo_bet')) : I18n.t('success_create', name: t('bet'))
      render_success_response(render_message)
    end
  end

  def my_bets
    bets = fetch_bets(Bet, params)
    render_collection(bets)
  end

  private

  # def set_betting_pool
  #   return if params[:betting_pool_id].blank?
  #   @betting_pool = BettingPool.find_by(id: params[:betting_pool_id]&.to_i)
  #   return render_not_found_response(I18n.t('betting_pool.not_found')) if @betting_pool.blank?
  # end

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
    BetProcess.new(bet_slips: @bet_slips, user: current_user,  bet_type: params[:bet_type], combo_bet_stake: params[:combo_bet_stake] ).call
  end

  def validates_betting_allowed?
    return(render_error_response(t('betting.suspended'))) unless current_user.betting_allowed?
    return(render_error_response(I18n.t('betting.suspended'))) unless GammabetSetting.betting_allowed?
  end

  def update_betslips(data)
    updated_slips = []
    data.each do |slip|
      match = Match.find_by(id: slip[:match_id])
      if match.in_play?
        formated_market_uid = slip[:specifier].present? ? "#{slip[:market_uid]}^#{slip[:specifier]}" : slip[:market_uid] 
        odds = match.firestore_snapshot.dig(:market, formated_market_uid.to_s.to_sym, :outcomes, slip[:outcome_id].to_s.to_sym, :Price)
      else
        odds = Utility::MarketUtility.identifier_data(slip[:match_id], slip[:market_id], "49").dig(:outcomes, slip[:outcome_id].to_s).dig(:odds)
      end
      if odds.present? && slip[:odds] != odds
        slip[:odds] = odds
        slip[:odds_changed] = true
      else
        slip[:odds_changed] = false
      end
      updated_slips << slip
    end
    updated_slips
  end

  def render_data(updated_betslips, reload_bet_slips)
    render json: {
      updated_betslips: updated_betslips,
      reload_bet_slips: reload_bet_slips,
      errors: t('odds_changed')
    }, :status => :bad_request
  end

  def check_stake
    stake = params[:combo_bet_stake].to_f
    if params[:bet_type] == 'combo' && stake <= 0 
      return render_error_response(t('combo_bets.errors.stake'))
    end
  end

  def set_bet_slips
    params[:bet_slips] = JSON.parse(params[:bet_slips]).map { |slip| slip.with_indifferent_access } rescue params[:bet_slips] 
    return render_error_response(I18n.t('bets.slips_required')) if params[:bet_slips].blank?
    @bet_slips =  params[:bet_slips].map do |slip|
                    slip[:outcome_id] = slip[:outcome_id].to_s
                    slip[:match_id] = Match.find_by(uid: slip[:match_uid])&.id if slip[:match_id].blank?
                    slip[:market_id] = Market.find_by(uid: slip[:market_uid])&.id if slip[:market_id].blank?
                    slip[:tournamentId] = Tournament.get_id_by_uid_and_country_uid(slip[:tournamentUId], slip[:countryUId]) if slip[:tournamentId].blank? && slip[:tournamentUId].present? && slip[:countryUId].present? 
                    slip[:sportId] = Sport.find_by(uid: slip[:sportId])&.id if slip[:sportId].blank? && slip[:sportUId]
                    slip
                  end
  end
end
