class Api::SeasonsController < Api::BaseController
  def index
    seasons = Season.all.paginate(page: params[:page], per_page: params[:per_page])
    render_collection(seasons)
  end
end
