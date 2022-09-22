module Betting
  module LS
    class BetResettlement

      def initialize(bet, status)
        @bet = bet
        @new_status = status
      end

      def run
        return if @bet.blank? || @bet.status.in?([@new_status, 'cashed_out', 'pending'])
        
        wallet = @bet.wallet
        wallet_service = Wallets::Base.new(wallet)

        ActiveRecord::Base.transaction do
          if @bet.combo_bet_id.blank? # For Single Bet
            amount_to_deduct = calculate_bet_total(@bet)
            @bet.update(status: @new_status)
            amount_to_add= calculate_bet_total(@bet)
            return if amount_to_deduct.to_f == amount_to_add.to_f
            if amount_to_deduct.present? && !amount_to_deduct.zero?
              wallet_service.debit(amount_to_deduct, check_available_amount: false)
              wallet.ledgers.create(arguments_of_bet(amount_to_deduct, bet_remark(amount_to_deduct, 'resettlement'), :debit))
              wallet_service.persist_wallet!
            end
            if amount_to_add.present? && !amount_to_add.zero?
              wallet_service.credit(amount_to_add)
              wallet.ledgers.create(arguments_of_bet(amount_to_add, bet_remark(amount_to_add, @bet.status), :credit))
              wallet_service.persist_wallet!
            end
          else #For Combo Bet
            @combo_bet = @bet.combo_bet

            if @combo_bet.won? || @combo_bet.refunded?
              amount_to_deduct = calculate_combo_bet_total
              bonus_amount_to_deduct = @combo_bet.betting_bonus
              total_deduction = amount_to_deduct + bonus_amount_to_deduct
            end

            @bet.update(status: @new_status)
            update_combo_bet_status

            if @combo_bet.won? || @combo_bet.refunded?
              amount_to_add = calculate_combo_bet_total
              bonus_amount_to_add = @combo_bet.betting_bonus
              total_addition = amount_to_add + bonus_amount_to_add
            end

            return if total_deduction.to_f == total_addition.to_f
            if total_deduction.present? && !total_deduction.zero?
              wallet_service.debit(total_deduction, check_available_amount: false)
              wallet.ledgers.create(arguments_of_combo_bet(total_deduction, combo_bet_remark(total_deduction, 'resettlement'), :debit))
              wallet_service.persist_wallet!
            end
            if total_addition.present? && !total_addition.zero?
              wallet_service.credit(amount_to_add, bonus_amount: bonus_amount_to_add)
              wallet.ledgers.create(arguments_of_combo_bet(total_addition, combo_bet_remark(total_addition, @combo_bet.status), :credit))
              wallet_service.persist_wallet!
            end
          end
        end
      end

      private

      def calculate_bet_total(bet)
        amount =  if bet.won?
                    bet.total.abs
                  elsif bet.refunded? || bet.cancelled?
                    bet.stake
                  elsif bet.half_lost? || bet.half_won?
                    bet.total / 2
                  else
                    0
                  end.to_f
      end

      def calculate_combo_bet_total
        (@combo_bet.available_odds * @combo_bet.stake)
      end

      def arguments_of_bet(amount, transaction_remark, type)
        { betable: @bet, amount: amount, remark: transaction_remark, transaction_type: type, status: Ledger::STATUSES["succeeded"] }
      end

      def arguments_of_combo_bet(amount, transaction_remark, type)
        { betable: @combo_bet, amount: amount, remark: transaction_remark, transaction_type: type, status: Ledger::STATUSES["succeeded"] }
      end

      def bet_remark(amount, status)
        I18n.t(
          "bets.remarks.#{status}", match: @bet.match.title, market: @bet.market.name,
                                  amount: amount
        )
      end

      def combo_bet_remark(amount, status)
        I18n.t(
          "combo_bets.#{status}", amount: amount.round(6), combo_bet_id: @combo_bet.id
        )
      end

      def update_combo_bet_status
        status = @combo_bet.bets.pluck(:status).compact.uniq
        @combo_bet.update_betting_bonus!
        if ( status & %w[lost half_won half_lost]).any?
          @combo_bet.update status: 'lost'
          Stats::BetStatsUpdateJob.set(wait: 1.minute).perform_later(@combo_bet.id, true) rescue nil
          'lost'
        elsif (status & %w[lost pending half_won half_lost]).none? && (status & %w[won]).any?
          @combo_bet.update status: 'won'
          Stats::BetStatsUpdateJob.set(wait: 1.minute).perform_later(@combo_bet.id, true) rescue nil
          'won'
        elsif (status & %w[lost pending half_won half_lost]).none? && (status & %w[refunded cancelled hold]).any?
          @combo_bet.update status: 'refunded'
          'refunded'
        elsif (status.include?('pending'))
          @combo_bet.update status: 'pending'
          'pending'
        end
      end
    end
  end
end