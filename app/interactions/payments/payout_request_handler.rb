module Payments
  class PayoutRequestHandler < ApplicationInteraction
    object :ledger
    string :status
    string :remark, default: ''

    def execute
      case status
      when Ledger::APPROVED
        # TODO: make handler class
        response = client.post('withdraw', withdraw_params)
        return error_response if response.try(:code) != '200'
        data = JSON.parse(response.body)
        if data['success'].present?
          ledger.update(tracking_id: data['data']['transactionHash']) if data['data']['transactionHash'].present?
          return ledger.register_success!(remark) 
        end
        error_response
        # ledger.register_success!(remark)
        # Metamask::WithdrawAmountJob.perform_later(ledger)
        # handler.call(transaction)
      when Ledger::REJECTED
        ledger.register_rejection!(remark)
      end

    rescue ::Payments::PayoutError => error
      failure_response(error)
    ensure
      Notifications::PublishNotificationJob.perform_later(ledger.id, Constants::NOTIFICATION_KIND[:withdrawal_settlement])
    end

    def handler
      case ledger.mode
      when Ledger::FAST_PAY
        ::Payments::FastPay::Payouts::RequestHandler
      end
    end

    def transaction
      ::Payments::Transactions::Payout.new(
        id: ledger.id,
        user: ledger.betable,
        method: ledger.mode,
        currency: ledger.wallet.currency,
        amount: ledger.amount,
        receiver: ledger.account_details,
        status: status
      )
    end

    def failure_response(error)
      log_failure(error)
      ledger.register_failure!(failure_message)
      errors.add(:base, error.message)
    end

    def log_failure(error)
      Rails.logger.error(
        message: failure_message,
        transaction_id: ledger.id,
        error_object: error
      )
    end

    def failure_message
      I18n.t('errors.messages.payout.failed')
    end

    def client
      @client ||= Metamask::Client.new
    end

    def metamask_user_params
     {
      "receiverAddress": ledger.account_details,
      "amount": ledger.amount,
      "ledgerId": ledger.id
      }
    end

    def normal_user_params
      metamask_user_params.merge!({"privateKey": ledger.betable.deposit_key })
    end

    def withdraw_params
      ledger.betable.normal? ? normal_user_params : metamask_user_params
    end

    def error_response
      errors.add(:base, 'Withdrawal failed')
    end
  end
end
