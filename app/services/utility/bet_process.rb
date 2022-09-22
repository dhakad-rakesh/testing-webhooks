# Utility::Cache
module Utility
  module BetProcess
    module InstanceMethods
      # Deduct betslip stack from wallet, create bets
      include BetAndHold

      def process_bet(bet_param)
        # deduct wallet amount we will save this wallet in the end when all bet
        # slips are saved
        # For competition make debit method properly.
        if (@bet_type == "combo" && bet_param[:stake] = 0.0) || bet_wallet.debit(bet_param[:stake].to_f).try(:save)
          # create bet, context is betslip interaction
          bet = if @participant.present?
                  Betting::PoolBetSlip.run(bet_param.merge(wallet: current_wallet,
                                                           betting_pool_id: @betting_pool.id))
                else
                  Betting::BetSlip.run(bet_param.merge(wallet: current_wallet))
                end
          if bet.errors.present?
            # tell bets has errors and errors
            @failed_bets << generate_failed_bet_data(bet_param, bet)
          else
            bet.result
          end
        else
          # Wallet doesnt have sufficient amount
          @failed_bets << generate_failed_bet_data(bet_param, bet_wallet.wallet)
        end
      end

      def process_bet_slip_informations(bet_slips, user)
        # add user id and bet type to the params
        bet_slips.map do |bet_slip|
          bet_slip[:user] = user
          bet_slip
        end
      end

      def initialize_other_params(args)
        @status = true # used as flag if all bets are saved or not
        @failed_bets = []
        @bet_slips = process_bet_slip_informations(args[:bet_slips], @user)
      end

      # update wallet and if we have any invalid bet then raise error to break
      # transaction block in parent.
      def post_transaction_process
        bet_wallet.persist_wallet!
      end
    end

    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end
end
