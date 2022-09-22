class AccumulatorBetCreate
  def initialize(args = {})
    @user = args[:user]
    @bet_slips = args[:bet_slips]
    @betting_pool = args[:betting_pool]
    @participant = @betting_pool.participants.find_by(user_id: @user.id) if @betting_pool
    @status = false
    @failed_bets = []
  end

  def call
    ActiveRecord::Base.transaction do
      accumulator_bet = AccumulatorBet.create!(user: @user, wallet: current_wallet, status: 4,
                                               play_number: assign_play_number, betting_pool_id: @betting_pool&.id)
      @bet_slips.each do |bet_slip|
        bet_slip.merge!(accumulator_bet_id: accumulator_bet.id)
      end
      @status, @failed_bets = HoldBet.new(bet_slips: @bet_slips, user: @user, betting_pool: @betting_pool).call
      fail ActiveRecord::Rollback unless @status
    end
    [@status, @failed_bets]
  end

  def assign_play_number
    used_play_numbers = @user.accumulator_bets.pluck(:play_number).compact
    fetch_lowest_available_number(used_play_numbers)
  end

  def current_wallet
    @participant ? betting_pool_wallet : points_wallet
  end

  def betting_pool_wallet
    @participant.wallet
  end

  def points_wallet
    @points_wallet ||= @user.point_wallet
  end

  def fetch_lowest_available_number(numbers)
    numbers = numbers.uniq.sort!
    play_number = 1
    numbers.each do |number|
      next if number <= 0
      return play_number if play_number != number
      play_number += 1
    end
    play_number
  end
end
