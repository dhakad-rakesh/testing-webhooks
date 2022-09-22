class SummariesFilter
  attr_reader :start_date, :end_date, :user_ids

  def initialize(start_date: nil, end_date: nil, user_ids: :all)
    @start_date = start_date
    @end_date = end_date
    @user_ids = user_ids
  end

  def deposit
    @deposit ||= OpenStruct.new(
      total: entity(model: Ledger).deposits.sum(:amount),
      player_count: entity(model: Ledger).deposits.pluck(:betable_id).uniq.count
    )
  end

  def withdrawal
    @withdrawal ||= OpenStruct.new(
      total: entity(model: Ledger).withdrawals.pluck(:amount).sum(&:abs),
      player_count: entity(model: Ledger).withdrawals.pluck(:betable_id).uniq.count
    )
  end

  def user
    @user ||= OpenStruct.new(
      online: source_by_role(model: User).online.count,
      login_count: entity(model: User).sum(:sign_in_count),
      total_registered: entity(model: User).count
    )
  end

  def total_players_balance
    source_by_role(model: Wallet).point.sum(:available_amount)
  end

  def total_profit
    entity(model: Bet).total_profit
  end

  def total_bonus_amount
    entity(model: Ledger).total_bonus_amount
  end

  def total_casino_bonus
    Wallet.currency.sum(:casino_bonus)
  end

  def total_betting_bonus
    Wallet.point.sum(:betting_bonus)
  end

  private

  # def total_winnings
  #   winnings_by_model(model: Bet) + winnings_by_model(model: ComboBet)
  # end

  # def winnings_by_model(model:)
  #   entity(model: model).total_winnings
  # end

  # def total_stakes
  #   stakes_by_model(model: Bet) + stakes_by_model(model: ComboBet)
  # end

  # def stakes_by_model(model:)
  #   entity(model: model).settled.sum(:stake)
  # end

  def entity(model:)
    return source_by_role(model: model) unless start_date && end_date

    source_by_role(model: model).between(start_date, end_date)
  end

  def source_by_role(model:)
    return model if user_ids.eql?(:all)

    model.by_users(user_ids)
  end
end
