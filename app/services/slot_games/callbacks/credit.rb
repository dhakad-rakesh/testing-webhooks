module SlotGames
  module Callbacks
    class Credit < Transaction
      def process
        return bet_not_found_response unless corresponding_debit_transaction

        if credit_into_wallet
          user_balance_response
        else
          general_error_response('Credit failed')
        end
      end

      private

      def transaction_params
        super().merge({
          amount: transaction_amount,
          bet_type: 'win'
        })
      end

      def corresponding_debit_transaction
        transactions.bet_types.find_by(transaction_id: params.dig(:round, :betTransactionId))
      end

      def existing_transaction
        transactions.win_types.find_by(transaction_id: params[:transactionId])
      end

      def ledger_remark
        "Credits won on slot game betting"
      end

      def transaction_amount
        params[:amount]
      end
    end
  end
end
