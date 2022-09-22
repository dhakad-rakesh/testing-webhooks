class Admin::MarketsController < Admin::BaseController
  require 'will_paginate/array'
  #before_action :set_sport, only: %I[index]
  before_action :set_match, only: %I[index update]
  before_action :set_market, only: %I[edit update show]
  before_action :set_sport_market, only: %I[update_sport_market]
  before_action :set_sport, only: %I[index get_sports_markets]
  after_action :delete_sport_markets_cache, only: %I[update_sport_market]

  def index
    @markets = @sport.sport_markets
      # if market_params[:match_id].present? && @match.present?
      #   @match.sport.markets # show all markets
      # elsif market_params[:sport_id].present? && @sport.present?
      #   @sport.markets
      # else
      #   Market.where(sport_id: @sports.first.id)
      # end
    @markets = @markets.order(:priority).paginate(page: params[:page], per_page: Constants::PER_PAGE)
  end

  def edit; end

  def update
    if @match.present?
      if params[:enabled] == 'false' && @match.supported_market_uids.include?(@market.uid)
        @match.supported_market_uids = @match.supported_market_uids - [@market.uid]
        @match.save
        return render json: { message: "Market status updated successfully." }
      elsif params[:enabled] == 'true' && @match.supported_market_uids.exclude?(@market.uid)
        @match.supported_market_uids = @match.supported_market_uids + [@market.uid]
        @match.save
        return render json: { message: "Market status updated successfully." }
      end
    elsif @market.update(market_update_params)
      delete_market_ids_cache
      if request.xhr?
        return render json: { message: "Market status updated successfully." }
      else
        clear_market_hash
        flash[:notice] = t('success_update', name: t('market'))
        redirect_to admin_market_path(@market)
      end
    else
      flash[:error] = t('went_wrong')
      #redirect_to admin_match_markets_path(@match)
    end
  end

  def show
  end

  def update_markets_rank
    params[:sorted_ids].each_with_index do |id, index|
      market = Market.find_by(id: id&.to_i)
      market.update(rank: index+1)
    end
    delete_market_ids_cache
    return render json: { message: "Rank updated successfully." }
  end

  def get_sports_markets
    @markets = @sport.sport_markets.joins(:market)
    @markets = @markets.joins(market: :categories).where(categories: { id: params[:category_id] }) if params[:category_id].present?
    @markets = @markets.where(priority: params[:priority]) if params[:priority].present?
    @markets = @markets.where(visible: params[:visible]) if params[:visible].present?
    @markets = @markets.where('markets.name ILIKE ?', "%#{params[:name].strip}%") if params[:name].present?
    @markets = @markets.order(:priority).paginate(page: params[:page], per_page: Constants::PER_PAGE)

    respond_to do |format|
      format.js
    end
  end

  def get_sports
    return unless Sport::KINDS.include? params[:sport_kind].to_sym
    @sports = Sport.send("#{params[:sport_kind]}").visible

    render :json => @sports
  end

  def update_sport_market
   return unless @market.update(sport_market_update_params)
   
   render json: { message: "Market updated successfully!" }
  end

  private

  def set_sport
    @sports = Sport.sports.visible
    @sport = unless params[:sport_id].present?
      @sports.find_by(name: 'Football') || @sports.first
    else
      Sport.find_by(id: params[:sport_id])
    end
    return if @sport.present?
    flash[:error] = t('not_found', name: t('sport'))
    redirect_to admin_markets_path
  end

  def set_sport_market
    @market = SportMarket.find_by(id: params[:sm_id])
  end

  def sport_market_update_params
    params.require(:sport_market).permit(:priority, :visible)
  end

  def set_match
    return if market_params[:match_id].blank?
    @match = Match.find_by(id: market_params[:match_id])
    return @match if @match.present?
    flash[:error] = t('not_found', name: t('market'))
    redirect_to admin_dashboard_index_path(current_user)
  end

  # def set_sport
  #   return if market_params[:sport_id].blank?
  #   @sport = find_sport(market_params[:sport_id])
  #   return @sport if @sport.present?
  #   flash[:error] = t('not_found', name: t('sport'))
  #   redirect_to admin_dashboard_index_path(current_user)
  # end

  # def find_sport(id)
  #   Sport.find_by(id: id)
  # end

  def set_market
    @market = Market.find_by(id: params[:id].to_i)
  end

  def market_params
    params.permit(:match_id, :sport_id)
  end

  def market_update_params
    params.require(:market).permit(:enabled, :display_name)
  end

  def delete_market_ids_cache
    Rails.cache.delete(:markets_enable_ids)
    Rails.cache.delete(:all_markets_ids)
    Rails.cache.delete(:disable_markets_ids)
  end

  def delete_sport_markets_cache
    Rails.cache.delete(Utility::Cache.sorted_sport_markets_key(sport_id: @market.sport_id))
    Rails.cache.delete(Utility::Cache.disabled_sport_markets_key(sport_id: @market.sport_id))
    Rails.cache.delete(Utility::Cache.enabled_sport_markets_key(sport_id: @market.sport_id))
  end

  def clear_market_hash 
    Rails.cache.write("markets_name_#{@market.uid}", @market.display_name)
  end

  def delete_sport_markets_cache
    Rails.cache.delete(Utility::Cache.sorted_sport_markets_key(sport_id: @market.sport_id))
    Rails.cache.delete(Utility::Cache.disabled_sport_markets_key(sport_id: @market.sport_id))
    Rails.cache.delete(Utility::Cache.enabled_sport_markets_key(sport_id: @market.sport_id))
  end
end
