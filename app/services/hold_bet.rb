class HoldBet < BetProcess
  include Utility::HoldBet

  def initialize(args = {})
    @user = args[:user]
    @betting_pool = args[:betting_pool]
    @participant = @betting_pool.participants.find_by(user_id: @user.id) if @betting_pool
    initialize_other_params(args)
  end

  def call
    Bet.transaction do
      @bet_slips.each do |bet_param|
        process_bet(bet_param)
      end
      post_transaction_process
    end
    [@status, @failed_bets]
  end

  private

  def bet_parameters(object, odds)
    {
      market_id: object.market_id,
      match_id: object.match_id,
      odd: odds,
      outcome: object.outcome,
      stake: object.stake,
      identifier: object.identifier,
      user: current_user
    }
  end
end
