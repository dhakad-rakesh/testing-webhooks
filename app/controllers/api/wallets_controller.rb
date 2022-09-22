class Api::WalletsController < Api::BaseController
  def index
    render json: current_user.wallets_detail
  end
end
