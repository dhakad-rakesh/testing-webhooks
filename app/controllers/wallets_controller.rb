class WalletsController < BaseController
  before_action :set_wallet, only: %I[show update]

  def index
    @wallets = current_user.wallets
  end

  def show
    @ledgers = @wallet.ledgers.order_by_recent.paginate(page: params[:page])
  end

  def update
    if @wallet.update(available_amount: @wallet.available_amount + 1000)
      flash[:alert] = t('success_update', name: t('amount'))
    else
      flash[:error] = t('went_wrong')
    end
    redirect_to user_wallet_path(@wallet)
  end

  private

  def set_wallet
    @wallet = Wallet.find_by(id: params[:id])
    return if @wallet.present?
    flash[:error] = t('not_found', name: t('wallet'))
    redirect_to user_wallets_path(current_user)
  end
end
