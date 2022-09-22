module Betting
  class Settlement < ::Betting::Base
    # We update bet status in case of any won, lost or refund
    # We create ledgers in case of won and refund in case of lost it is already
    # deducted.
    def import_bets_and_ledgers(bets)
      Bet.import bets.compact, on_duplicate_key_update: %I[status]
      send_betting_mails(bets)
    end

    # TODO : send all bets in jobs don't loop here
    def send_betting_mails(bets)
      # bets.each { |bet| BetsNotifyMailer.with(bet_id: bet.id).send(bet.status).deliver_later if bet.combo_bet_id.nil? }
    end

    def calculate_amount
      @amount = if @bet.won?
                  @bet.total.abs
                elsif @bet.refunded? || @bet.cancelled?
                  @bet.stake
                end.to_f
    end

    def wallet
      @wallet = @bet.wallet
    end

    def wallet_for_combo_bet(bet)
      bet.wallet
    end
  end
end
