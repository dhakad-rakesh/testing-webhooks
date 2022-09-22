module Ledgers
  class GenerateBetLedgers
    def initialize(args = {})
      @current_wallet = args[:wallet]
      @betable = args[:betable]
      @transaction_type = args[:transaction_type] || :debit
      @amount = args[:amount] || @betable.stake
      @remark = args[:remark]
      @source_wallet_id = args[:source_wallet_id]
      @transaction_id = args[:transaction_id]
      @approved = args[:approved].present? ? args[:approved] : true
      @bonus_amount = args[:bonus_amount] || 0
      @kind = args[:kind] || Ledger::DEFAULT
      @mode = args[:mode] || nil
      @admin_user_id = args[:admin_user_id] || nil
      @status = args[:status] || Ledger::STATUSES["initial"]
    end

    def call
      generate_ledger_transaction
    end

    private

    def generate_ledger_transaction
      ledger = @current_wallet.ledgers.create!(betable: @betable, amount: @amount, remark: @remark, approved: @approved,
        transaction_type: @transaction_type, source_wallet_id: @source_wallet_id, transaction_id: @transaction_id,
        bonus_amount: @bonus_amount, kind: @kind, mode: @mode, admin_user_id: @admin_user_id, status: @status)

      #counter entry
      if ledger.source_wallet.present?
        if @transaction_type == :credit
          transaction_type = :debit
          amount = -@amount
        else
          transaction_type = :credit
          amount = @amount.abs
        end
        ledger.source_wallet.ledgers.create!(
          betable: ledger.source_wallet.usable,
          amount: amount,
          approved: @approved,
          transaction_type: transaction_type,
          remark: @remark,
          status: @status
        )
      end
    end
  end
end
