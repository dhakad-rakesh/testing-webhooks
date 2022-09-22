module Payments
  class DepositRequestHandler < ApplicationInteraction
    object :ledger
    string :status
    string :remark, default: ''

    def execute
      case status
      when Ledger::APPROVED
        # TODO: make handler class
        ledger.register_success!(remark)
      when Ledger::REJECTED
        ledger.register_rejection!(remark)
      end

    rescue ::Payments::PayoutError => error
      failure_response(error)
    ensure
      # Notifications::PublishNotificationJob.perform_later(ledger.id, Constants::NOTIFICATION_KIND[:withdrawal_settlement])
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
  end
end
