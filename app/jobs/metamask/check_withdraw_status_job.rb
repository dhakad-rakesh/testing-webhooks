# Run Every 10 Minute,
class Metamask::CheckWithdrawStatusJob < ApplicationJob
  queue_as :default

  def perform
    ledgers = Ledger.unsettel_withdrawal_transactions
    ledgers.find_in_batches do |group|
      group.each do |ledger|
        Ledgers::CheckAndUpdateLedgerStatus.new(ledger).call rescue nil
      end
    end
  end
end
