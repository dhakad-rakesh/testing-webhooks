module Casino
  module Callbacks
    class Rollback < Transaction

      def process
        if debit_transaction = corresponding_debit_transaction
  
          return general_error_response('Wrong amount') if unmatched_amount(debit_transaction.amount)
          
          if credit_into_wallet
            user_balance_response
          else
            general_error_response
          end
        else
          # Recording rollback transaction is necessary to deny corresponding debit request incase it arrive later
          # create_transaction
          bet_not_found_response
        end
      end

      private

      def corresponding_debit_transaction
        transactions.bet_types.find_by(transaction_id: params.dig(:transaction, :refId))
      end

      def unmatched_amount(amount)
        amount != transaction_amount
      end

      def transaction_params
        super().merge({
          amount: transaction_amount,
          bet_type: 'refund'
        })
      end

      def existing_transaction
        transactions.refund_types.find_by(transaction_id: params.dig(:transaction, :refId))
      end

      def ledger_remark
        "Refund for unsuccessful casino game bet placement"
      end

      def transaction_amount
        convert_et2_to_etherum(params.dig(:transaction, :amount).to_f)
      end
    end
  end
end
