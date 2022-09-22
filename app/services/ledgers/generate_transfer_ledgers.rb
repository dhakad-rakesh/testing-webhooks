module Ledgers
  class GenerateTransferLedgers
    def initialize(args = {})
      @current_wallet = args[:wallet]
      @remark = args[:remark]
      @transaction_type = args[:transaction_type]
      @amount = args[:amount]
      @transfer_record_id = args[:transfer_record_id]
    end

    def call
      generate_transfer_ledgers
    end

    private

    def generate_transfer_ledgers
      @current_wallet.ledgers.create!(amount: @amount, remark: @remark,
                                      approved: true,
                                      transaction_type: @transaction_type,
                                      betable_type: "Transfer",
                                      transfer_record_id: @transfer_record_id)
    end
  end
end
