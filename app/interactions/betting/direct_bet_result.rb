module Betting
  class DirectBetResult < ::Betting::Settlement
    hash :data, strip: false
    set_callback :type_check, :before, :initailize_objects
    set_callback :type_check, :before, :status

    def execute
      return if @match.blank? || @market.blank?
      # bets = @market.bets.where(outcome_id: @outcome.id, match_id: @match.id).pending
      # bets = bets.select { |a| a.identifier == data['identifier'] } if data['identifier'].present?
      @bets ||= Bet.where(outcome_id: outcome_ids, match_id: @match.id)
      process_bets_and_ladgers(@bets)
    end

    private

    def outcome_ids
      #@outcomes.map{|k,v| v[:uid]}
      @market.outcomes.pluck(:id)
    end

    def process_bets_and_ladgers(bets)
      user_bets = []
      ledgers = []
      accumulator_bets = []
      bets.each do |bet|
        @bet = bet
        @bet.update_columns(status: status)
        #   # updates predictions, total profit and average profit
        #   UpdateBettingSummary.run!(bet: @bet)
        user_bets << @bet
        if @bet.accumulator?
          accumulator_bets << @bet
        else
          ledgers << process_won_bets unless bet.combo_bet_id.present?
          ledgers << process_refunded_bets
        end
        check_pool_status(bet.betting_pool) if bet.betting_pool.present?
      end
      import_bets_and_ledgers(user_bets)
      #need permanent fix
      Bet.where(id: bets.pluck(:id)).combo_bets.group_by(&:combo_bet_id).each do |combo_bet_id, bets|
        ComboBetResult.new.update(bets)
      end
      process_accumulator_bets(accumulator_bets)
    end

    def initailize_objects
      @match = data[:match] || Match.find_by(uid: data['match_uid'])
      # @market = Market.find_by(uid: data.dig('market', 'id'))
      # @outcome = Outcome.find_by(uid: data.dig('outcome_data', 'id'))
      @market = data[:market]
      #@outcomes = data[:market][:outcomes]
      @result = data[:result]
      @void_factor = data[:void_factor]
      @specifier_text = data['specifiers'].to_h if data['specifiers'].present?
      @bets = data[:bets]
    end

    def status
      @status ||=
        if @void_factor.equal?(1.0) && @result.zero?
          :refunded
        elsif @result.equal?(1.0)
          :won
        elsif @result.zero?
          :lost
        end
      errors.add(:status, I18n.t('betting.invalid_status')) if @status.blank?
      @status
    end

    def process_accumulator_bets(bets)
      accumulators = []
      AccumulatorBet.where(id: bets.map(&:accumulator_bet_id).uniq).each do |accumulator|
        bets_status = accumulator.bets.map(&:status).compact.uniq
        if bets_status == ['won']
          accumulator = process_won_accumulator_bets(accumulator)
        elsif bets_status.include?('lost') || bets_status.include?('refunded')
          accumulator.status = :lost
        end
        accumulators << accumulator
      end
      AccumulatorBet.import accumulators.compact, on_duplicate_key_update: %I[status]
    end

    # In case of won we need to update amount in accoumulator wallet
    def process_won_accumulator_bets(accumulator)
      accumulator.status = :won
      amount = (accumulator.stake * accumulator.odds.to_f).round(8)
      wallet.credit(amount)
      wallet.ledgers.create(arguments_of_accumulator_bets(accumulator, amount))
      accumulator
    end

    # TODO : Reduce wallet of site in case of fiat currency
    # We create ledgers and update the amount in wallet.
    def process_won_bets
      return unless @bet.won?
      amount = calculate_amount
      amount = Wallets::Base.new(wallet).credit(amount)
      wallet.ledgers.create(arguments_of_bets) unless amount.zero?
    end

    def process_refunded_bets
      return unless @bet.refunded? || @bet.cancelled?
      wallet.credit(@bet.stake)
      wallet.ledgers.create(arguments_of_bets)
    end

    def remark_for_bet
      I18n.t(
        "bets.remarks.#{status}", match: @match.title, market: @market.name, amount: @amount
      )
    end

    def remark_for_combo_bet
      I18n.t(
        "combo_bets.#{status}", match: @match.title, market: @market.name, amount: @amount, combo_bet_id: @bet.combo_bet_id
      )
    end

    # def market_title
    #   @market_title ||= MatchMarketOutcomeName.call(@market['name'], @match, @market['id'], @specifier_text)
    # end

    def arguments_of_bets(amount = nil)
      @amount = amount || calculate_amount.round(8)
      remark = @bet.combo_bet_id.present? ? remark_for_combo_bet : remark_for_bet
      { betable: @bet, amount: @amount, remark: remark, transaction_type: :credit, status: Ledger::STATUSES["succeeded"] }
    end

    def arguments_of_accumulator_bets(accumulator, amount)
      remark = "Credited #{amount} for winning accumulator bet"
      { betable: accumulator, amount: amount, remark: remark, transaction_type: :credit }
    end

    def check_pool_status(betting_pool)
      return unless betting_pool.bets.pending.blank? && match_ended?(betting_pool.last_match)
      Pool::Payout.perform_later(betting_pool.id)
    end

    def match_ended?(match)
      Constants::MATCH_ENDED_STATUSES.include?(match.betting_status)
    end
  end
end
