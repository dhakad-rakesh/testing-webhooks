require 'will_paginate/array'

class Admin::DisputesController < Admin::BaseController  
  skip_load_and_authorize_resource

  def index
    if query.present?
      @market_data = MarketData
      @market_data = @market_data.between(query[:start_date].to_time, query[:end_date].to_time) if query[:filter_date].present?
      @market_data = @market_data.by_match(query[:match_id])
                                 .filter_by_market_uid(@market_uid)
      @market_data = @market_data.paginate(per_page: Constants::PER_PAGE, page: params[:page])
    end
  end

  private

  def query
    @query = params[:query]

    @market_uid ||= Market.find_by(id: @query&.dig(:market_id))&.uid
    return if @query&.dig(:match_id).blank? || @market_uid.blank?
    
    @query
  end
end