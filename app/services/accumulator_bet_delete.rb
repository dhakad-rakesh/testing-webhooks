class AccumulatorBetDelete
  def initialize(args = {})
    @user = args[:user]
    initialize_other_params(args)
  end

  def call
    @accumulator_bets.each do |accumulator_bet_params|
      delete_bets_in_accumulator(accumulator_bet_params)
    end
    [@status, @failed_bets]
  end

  private

  def delete_bets_in_accumulator(accumulator_bet_params)
    accumulator_bet = @user.accumulator_bets.find_by(id: accumulator_bet_params[:id])
    if accumulator_bet.blank?
      @failed_bets << generate_failed_bet_data(accumulator_bet_params)
    else
      accumulator_bet.bets.accumulator.where(id: accumulator_bet_params[:bets]&.map { |bet| bet[:id] })&.destroy_all
      accumulator_bet.destroy if accumulator_bet.bets.accumulator.count.zero?
    end
  end

  def generate_failed_bet_data(param)
    @status = false
    [params: param, errors: I18n.t('accumulator_bets.not_found')]
  end

  def initialize_other_params(args)
    @status = true # used as flag if all bets are saved or not
    @failed_bets = [] # know which bets have issues
    @accumulator_bets = args[:accumulator_bet_slips]
  end
end
