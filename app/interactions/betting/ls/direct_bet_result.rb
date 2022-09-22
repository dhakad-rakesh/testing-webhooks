module Betting
  module LS
    class DirectBetResult < ::Betting::DirectBetResult

      def execute
        process_bets_and_ladgers(@bets)
      end

      private

      def initailize_objects
        @bets = data[:bets]
        @match = data[:match]
        @market = data[:market]
        @status = data[:status]
      end

      def process_bets_and_ladgers(bets)
        user_bets = []
        ledgers = []
        bets.each do |bet|
          @bet = bet
          if @bet.pending?
            @bet.update(status: status)

            user_bets << @bet
            if bet.combo_bet_id.nil?
              if bet.won?
                ledgers << process_won_bets
              elsif bet.refunded? || bet.cancelled?
                ledgers << process_refunded_bets
              elsif bet.half_lost? || bet.half_won?
                ledgers << process_half_refund
              end
              # BetsNotifyMailer.with(bet_id: bet.id).send(bet.status).deliver_later
              Notifications::PublishNotificationJob.perform_later(bet.id, Constants::NOTIFICATION_KIND[:bet])
            else
              ComboBetResult.new.update(bet)
            end
          else
            Betting::LS::BetResettlement.new(@bet, status).run
          end
        end
      end

      def status
        errors.add(:status, I18n.t('betting.invalid_status')) if @status.blank?
        @status
      end

      def process_half_refund
        amount = @bet.total / 2
        amount = Wallets::Base.new(wallet).credit(amount)
        wallet.ledgers.create(arguments_of_bets(amount)) unless amount.zero?
      end
    end
  end
end
