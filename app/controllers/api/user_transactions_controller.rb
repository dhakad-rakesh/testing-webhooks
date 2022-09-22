class Api::UserTransactionsController < Api::BaseController
  
  def create
    user_transaction = current_user.user_transactions.create(user_transactions_params)
  	return render_success_response(I18n.t('user_transaction.create.success')) if user_transaction.valid?
    render_error_response(user_transaction.errors.full_messages)
  end

  def index
  end

  private

  def user_transactions_params
    params.permit(:amount, :transaction_type)
  end

end


