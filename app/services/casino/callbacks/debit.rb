module Casino
  module Callbacks
    class Debit < Transaction
      def process
        return insufficient_funds_response if transaction_amount > wallet_balance

        if debit_from_wallet
          user_balance_response
        else
          general_error_response('Debit failed')
        end
      end

      private

      def debit_from_wallet
        ActiveRecord::Base.transaction do
          current_wallet.lock!
          transaction = create_transaction
          Wallets::Base.new(current_wallet).debit(transaction_amount).save
          # current_wallet.debit(transaction_amount)
          create_ledger(transaction, :bet, transaction_amount)
          true
        end
      end

      def transaction_params
        super().merge({
          amount: transaction_amount,
          bet_type: 'bet'
        })
      end

      def wallet_balance
        # user.total_balance
        user.available_amount
      end

      def ledger_remark
        'Debited for bet/tip on casino.'
      end


      def existing_transaction
        transactions.bet_types.find_by(transaction_id: params.dig(:transaction, :refId))
      end

      def repeated_transaction_error
        bet_already_exist_response
      end

      def transaction_amount
        convert_et2_to_etherum(params.dig(:transaction,:amount).to_f)
      end
    end
  end
end
