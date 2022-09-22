module GS
  class BetsRefundJob < ApplicationJob
    queue_as :result_process

    def perform(match_id, status_id)
      match = Match.find_by_id match_id

      match.bets.pending.each do |bet|
        wallet = bet.wallet
        if bet.combo_bet_id.nil?
          refund_amount = bet.stake
          wallet.credit(refund_amount)
          bet.update_columns(status: "refunded") 
          remark = "Refund of #{refund_amount} for Bet #{bet.id} due to match #{Match::GS_REFUND_CODES[status_id]}"
          Ledgers::GenerateBetLedgers.new(wallet: wallet, transaction_type: :refund, amount: refund_amount, approved: true, remark: remark, betable: bet.user, transaction_id: "refund_bet_#{bet.id}").call
        else
          combo_bet = bet.combo_bet
          if combo_bet.status == "pending"
            refund_amount = combo_bet.stake
            wallet.credit(refund_amount)
            combo_bet.update_columns(status: "refunded") 
            combo_bet.bets.update_all(status: "refunded")
            remark = "Refund of #{refund_amount} for Combo Bet #{combo_bet.id} due to match #{Match::GS_REFUND_CODES[status_id]}"
            Ledgers::GenerateBetLedgers.new(wallet: wallet, transaction_type: :refund, amount: refund_amount, approved: true, remark: remark, betable: combo_bet.user, transaction_id: "refund_combobet_#{combo_bet.id}").call
          end
        end
      end

      match.update_column(:status, "resolved")
    end
  end
end