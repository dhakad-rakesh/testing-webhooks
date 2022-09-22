module Api
  module Accounts
    extend ActiveSupport::Concern
    def wallets
      wallets = {}
      current_user.wallets.each { |wallet| wallets[wallet[:wallet_type]] = wallet.available_amount }
      render json: wallets
    end

    def ledgers
      ledgers = current_user.ledgers.paginate(page: params[:page],
                                              per_page: params[:per_page])
      render_collection(ledgers)
    end
  end
end
