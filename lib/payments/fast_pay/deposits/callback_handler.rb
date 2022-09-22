# frozen_string_literal: true

module Payments
  module FastPay
    module Deposits
      class CallbackHandler < Handlers::DepositCallbackHandler
        include ::Payments::FastPay::TransactionStates

        def call
          return cancel_ledger_transaction! if cancelled?
          save_transaction_id! unless ledger.transaction_id
          return complete_ledger_transaction if approved?
          fail_ledger_transaction!
        end

        private

        def request_id
          request.params['order_id']
        end

        def cancelled?
          transaction_state == CANCELLED 
        end

        def approved?
          transaction_state == SUCCESSFUL
        end

        def transaction_state
          @transaction_state ||= request.params['status']
        end

        def cancel_ledger_transaction!
          Rails.logger.warn message: 'Payment request cancelled',
                            status: transaction_state,
                            order_id: request_id,
                            transaction_id: transaction_id
          ledger.register_cancellation!('Cancelled by user')

          raise ::Payments::CancelledError
        end

        def fail_ledger_transaction!
          Rails.logger.warn message: 'Payment request failed',
                            status: transaction_state,
                            order_id: request_id,
                            transaction_id: transaction_id
          ledger.register_failure!('Payment failed')

          raise ::Payments::FailedError
        end

        def complete_ledger_transaction
          Rails.logger.info message: 'Payment success',
                            status: transaction_state,
                            order_id: request_id,
                            transaction_id: transaction_id
          ledger.register_success!('Payment success')
        end

        def save_transaction_id!
          ledger.update!(transaction_id: transaction_id)
        end

        def transaction_id
          request.params['transaction_id']
        end
      end
    end
  end
end
