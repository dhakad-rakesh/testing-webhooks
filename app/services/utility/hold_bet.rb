# Utility::Cache
module Utility
  module HoldBet
    module InstanceMethods
      include BetAndHold
      # Deduct betslip stack from wallet, create bets

      def process_bet(bet_param)
        params = bet_param.merge(wallet: current_wallet, betting_pool_id: @betting_pool&.id)
        bet = if bet_param[:accumulator_bet_id].present? && !bet_param[:accumulator_bet_id].zero?
                Betting::AccumulatorBetSlip.run(params.merge!(bet_type: :accumulator))
              else
                Betting::HoldBetSlip.run(params.merge(bet_type: :traditional))
              end
        if bet.errors.present?
          # tell bets has errors and errors
          @failed_bets << generate_failed_bet_data(bet_param, bet)
        else
          bet.result
        end
      end

      # add user id and bet type to the params
      def process_bet_slip_informations(bet_slips, user)
        bet_slips.map do |bet_slip|
          bet_slip[:user] = user
          bet_slip
        end
      end

      def initialize_other_params(args)
        @status = true # used as flag if all bets are saved or not
        @failed_bets = [] # know which bets have issues
        @bet_slips = process_bet_slip_informations(args[:bet_slips], @user)
      end

      # update wallet and if we have any invalid bet then raise error to break
      # transaction block in parent.
      def post_transaction_process
        fail(ActiveRecord::Rollback) unless @status
      end
    end
    def self.included(receiver)
      receiver.send :include, InstanceMethods
    end
  end
end
