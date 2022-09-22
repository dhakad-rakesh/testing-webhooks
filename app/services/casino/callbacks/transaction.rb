module Casino
  module Callbacks
    class Transaction
      include Utility::Casino::Response
      attr_reader :params, :user, :transactions

      def initialize(params, user)
        @params = params
        @user = user
        @current_wallet = user.current_wallet
        @transactions = user.session_transactions
        @uuid = params[:uuid]
      end

      def call
        return transaction_not_found_response unless params.dig(:transaction, :id).present?
        return repeated_transaction_error if existing_transaction
        return invalid_params_error_response if transaction_amount.negative?

        process
      end

      private

      attr_reader :current_wallet

      def credit_into_wallet
        ActiveRecord::Base.transaction do
          return true if transaction_amount.zero?
          current_wallet.lock!
          transaction = create_transaction

          if transaction_amount.positive?
            type = transaction.bet_type == 'win' ? 'win' : 'refund'
            current_wallet.credit(transaction_amount)
            create_ledger(transaction, type, transaction_amount)
          end
          true
        end
      end

      def transfer_bonus_stake_to_bonus_wallet(bonus_amount)
        current_wallet.deposit_losing_bonus(bonus_amount)
      end

      def create_transaction
        user.session_transactions.create(transaction_params)
      end

      def transaction_params
        {
          currency: params[:currency],
          game_uuid: params.dig(:game, :details, :table, :id),
          transaction_id: params.dig(:transaction, :refId),
          game_session_id: rand(100000),
          session_id: params[:sid]
        }
      end

      # def existing_transaction
      #   transactions.find_by(transaction_id: params.dig(:transaction, :id))
      # end

      def create_ledger(transaction, type, amount)
        transaction.ledgers.succeeded.create(
          wallet: current_wallet,
          transaction_type: type,
          amount: amount,
          remark: ledger_remark,
          betable: user
        )
      end

      def repeated_transaction_error
        repeated_bet_response
      end

      def convert_et2_to_etherum(et2_amount)
        et2_amount.to_f / 1000 
      end
    end
  end
end
