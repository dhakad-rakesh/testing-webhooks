class Api::TransactionHistoryController < Api::BaseController
  before_action :set_user_ledgers, only: :index

  def index
    transaction_history = unless params[:category].present?
                            @user_ledgers.send(type_filter)
                          else
                            @user_ledgers.send(category_scope).send(type_filter)
                          end
    transaction_history = transaction_history.between(params[:min_date].to_date, params[:max_date].to_date) if params[:min_date].present? && params[:max_date].present?
    transaction_history = transaction_history.order_by_recent.paginate(page: params[:page], per_page: params[:per_page] || 10)
    render_collection(transaction_history)
  end

  private

  def set_user_ledgers
    @user_ledgers = current_user.ledgers
  end

  def type_filter
    Ledger.methods.include?(params[:type]&.to_sym) ? params[:type] : :all
  end

  def category_scope
    case params[:category].downcase
    when 'user'
      :user_transactions
    when 'bet'
      :betting_transactions
    when 'referral_reward'
      :referral_transactions
    when 'cashback'
      :cashback_transactions
    else
      :all
    end
  end
end