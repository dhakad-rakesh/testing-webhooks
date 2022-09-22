module Casino
  module Callbacks
    class Credit < Transaction
      def process
        return bet_not_found_response unless corresponding_debit_transaction
        # return general_error_response('Debit transaction already processed') if existing_credit_transaction

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
        transactions.bet_types.find_by(transaction_id: params.dig(:transaction, :refId))
      end

      def existing_transaction
        transactions.win_types.find_by(transaction_id: params.dig(:transaction, :refId))
      end

      def ledger_remark
        "Credits won on casino betting"
      end

      def transaction_amount
        convert_et2_to_etherum(params.dig(:transaction, :amount).to_f)
      end
    end
  end
end
