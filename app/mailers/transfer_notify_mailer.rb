class TransferNotifyMailer < ApplicationMailer
  before_action :set_parameters

  def notify_debit
    send_mail(@email, "Amount Debited")
  end

  def notify_credit
    send_mail(@email, "Amount Credited")
  end

  private

  def set_parameters
    @payor = User.find_by_id params[:payor_id]
    @payee = User.find_by_id params[:payee_id]
    @email = params[:transaction_type] === "debit" ? @payor.email : @payee.email
    @amount = params[:amount]
  end
end
  