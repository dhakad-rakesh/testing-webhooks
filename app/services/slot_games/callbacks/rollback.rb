module SlotGames
  module Callbacks
    class Rollback < Transaction

      def process
        if debit_transaction = corresponding_debit_transaction
  
          return invalid_parameter_response if unmatched_parameters(debit_transaction.amount, debit_transaction.game_session_id) 
          
          if credit_into_wallet
            user_balance_response
          else
            general_error_response
          end
        else
          bet_not_found_response
        end
      end

      private

      def corresponding_debit_transaction
        transactions.bet_types.find_by(transaction_id: params[:originalTransactionId])
      end

      def unmatched_parameters(amount, round_id)
        unmatched_amount(amount) || unmatched_round_id(round_id)
      end

      def unmatched_amount(amount)
        amount != transaction_amount
      end

      def unmatched_round_id(round_id)
        round_id != params[:roundId]
      end

      def transaction_params
        super().merge({
          amount: transaction_amount,
          bet_type: 'refund'
        })
      end

      def existing_transaction
        transactions.refund_types.find_by(transaction_id: params[:transactionId])
      end

      def ledger_remark
        "Refund for unsuccessful slot game bet placement"
      end

      def transaction_amount
        params[:amount].to_f
      end
    end
  end
end
