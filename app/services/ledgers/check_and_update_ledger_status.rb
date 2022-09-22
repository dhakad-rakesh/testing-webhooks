module Ledgers
  class CheckAndUpdateLedgerStatus

    def initialize(ledger)
      @ledger = ledger
    end

    def call
      @status = fetch_transaction_status
      return false if @ledger.blank? || @status.blank?
      return false unless @ledger.status.in?(Ledger::UNSETTEL_STATUSES)
      if @status == 'CONFIRMED'
        @ledger.approved!
      elsif @status == 'FAILED'
        ledger.update(comment: "Rejected By Blockchain", status: 'pending')
      end
    end

    private

    def client
      @client ||= Metamask::Client.new
    end

    def fetch_transaction_status
      response = client.get('getTransactionStatus', {transactionHash: @ledger.tracking_id})
      return false unless response.try(:code).try(:to_s) == '200'
      data = JSON.parse(response.body)
      return false unless data['success']
      status = data['data']['status']
    end
  end
end