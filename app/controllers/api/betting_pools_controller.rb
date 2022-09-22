class Api::BettingPoolsController < Api::BaseController
  before_action :set_betting_pools, only: %I[index]
  before_action :set_betting_pool, only: %I[show matches wallet]

  def index
    render_collection(@betting_pools.paginate(page: params[:page], per_page: params[:per_page]), include: [:matches], show_children: false)
  end

  def show
    render json: @pool, show_children: true
  end

  def matches
    render_collection(@pool.matches.paginate(page: params[:page], per_page: params[:per_page]))
  end

  def wallet
    wallets = Wallet.where(id: @pool.participants.where(user_id: current_user&.id).pluck(:wallet_id))
    render json: Wallet.wallet_details(wallets)
  end

  private

  def set_betting_pool
    @pool = BettingPool.find_by(id: params[:id].to_i)
    return render_not_found_response(I18n.t('pool.not_found')) unless @pool
  end

  def set_betting_pools
    @betting_pools = BettingPool.where.not(id: current_user.betting_pools.pluck(:id))
    return unless (scope_method = %w[opened closed].detect { |scope| params[:scope] == scope })
    @betting_pools = @betting_pools.send(scope_method)
  end
end
