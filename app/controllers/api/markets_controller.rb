class Api::MarketsController < Api::SkipAuthenticationController
  before_action :match, only: %I[odds_data]

  # TODO: Handle growing number of markets
  def index
    markets = Market.active_markets.pluck(:uid, :name).to_h
    render json: { markets: markets }, status: 200
  end

  def odds_data
    return render_not_found_response(I18n.t('matches.not_found')) unless @match
    markets = @match.arrange_markets_by_ranking
    render json: { markets: markets, match_status: @match.actual_status }
  end

  def filters
    render json: Market.soccer_filters.to_json
  end

  private

  def match
    @match ||= Match.find_by(id: params[:match_id])
  end
end
