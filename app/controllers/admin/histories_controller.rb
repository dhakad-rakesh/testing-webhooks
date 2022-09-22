class Admin::HistoriesController < Admin::BaseController
  skip_load_and_authorize_resource
  before_action :check_status, only: [:bets]

  def payments
    @ledgers = Ledger.where(wallet_id: Wallet.point.pluck(:id)).all
  end

  def bets
    @ledgers = Ledger.where(wallet_id: Wallet.point.pluck(:id)).all
  end
end
