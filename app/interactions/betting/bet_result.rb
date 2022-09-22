# Update betting result in bets and make ledgers for won or refund bets.
module Betting
  class BetResult < ::Betting::Settlement
    object :match_outcome
    validates :match_outcome, presence: true

    def execute
      return if status.blank?
      bets = []
      ledgers = []
      fetched_bets.each do |bet|
        @bet = bet
        next unless valid_specifier_or_identifier?
        @bet.status = status
        # updates predictions, total profit and average profit
        # UpdateBettingSummary.run!(bet: @bet)
        bets << @bet
        ledgers << process_lost_bet
        ledgers << process_won_bets
      end
      # Update raking of all this users and their preffered leadersboard
      # UpdateBettingSummaryRankings.run(match_id: match_id, user_ids: user_ids)
      # UpdateBettingSummaryRankings.run(match_id: match_id, user_ids: user_ids, competition: true)
      # Update rank of all users
      import_bets_and_ledgers(bets, ledgers)
    end

    private

    # def user_ids
    #   fetched_bets.map(&:user_id).uniq
    # end

    def valid_specifier_or_identifier?
      @bet.specifier_text == match_outcome.specifier_text ||
        match_outcome.identifier == @bet.identifier
    end

    # TODO : Reduce wallet of site in case of fiat currency
    # We create ledgers and update the amount in wallet.
    def process_won_bets
      return unless @bet.won?
      # calculate_amount is profit in case of win and in case of refund or loss it will be stake
      # TODO : Need Transaction here
      amount = calculate_amount
      amount = Wallets::Base.new(wallet).credit(amount + @bet.stake)
      wallet.ledgers.create(arguments_of_bets) unless amount.zero?
    end

    def process_lost_bet
      return unless @bet.lost?
      @amount = @bet.stake
      ledger = wallet.ledgers.where(bet: @bet).first
      ledger.remark = remark if ledger.present?
      ledger
    end

    def arguments_of_bets
      @amount = calculate_amount
      { bet: @bet, amount: @amount, remark: remark, transaction_type: :credit, status: Ledger::STATUSES["succeeded"] }
    end

    # provide remark for transaction
    def remark
      I18n.t(
        "bets.remarks.#{status}", match: match.title, market: market_title,
                                  amount: @amount
      )
    end

    def match
      @match ||= match_outcome.match
    end

    # For a single match_outcome we have single name accross multiple bets
    def market_title
      market = match_outcome.market
      @market_title ||= MatchMarketOutcomeName.call(market.name, match, market.id, match_outcome.specifier_text)
    end

    def status
      @status ||=
        if match_outcome.void_factor.equal?(1.0) && match_outcome.result.zero?
          :refunded
        elsif match_outcome.result.equal?(1.0)
          :won
        elsif match_outcome.result.zero?
          :lost
        end
    end

    def fetched_bets
      @fetched_bets ||= Bet.where(
        market_id: match_outcome.market_id, match_id: match_id,
        outcome_id: match_outcome.outcomeable_id, status: :pending
      )
    end

    def match_id
      match_outcome.match_id
    end
  end
end
