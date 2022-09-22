class Api::Users::BettingPoolsController < Api::BaseController
  before_action :set_betting_pools, only: %I[index]

  def index
    render_collection(@betting_pools.paginate(page: params[:page], per_page: params[:per_page]))
  end

  private

  def set_betting_pools
    @betting_pools = current_user.betting_pools
    return unless (scope_method = %w[opened closed].detect { |scope| params[:scope] == scope })
    @betting_pools = @betting_pools.send(scope_method)
  end
end
