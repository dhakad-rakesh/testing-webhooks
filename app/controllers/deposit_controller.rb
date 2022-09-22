class DepositController < ApplicationController

  def available_deposit_methods
    available_methods = ::Payments::Deposit::PAYMENT_METHODS
    return render_partial_success_response(I18n.t('methods.deposit.not_found')) if available_methods.blank?
    render json: available_methods
  end

  def create_deposit_request
    deposit_params = params.require(:deposit).permit(:amount, :currency, :method)
    ::Payments::Deposit.new.execute_operation(deposit_params)
  end
end
