class Admin::BetsController < Admin::BaseController
  load_and_authorize_resource
  before_action :set_user, only: %i[index search]
  before_action :set_bet, only: :suspend_bet

  def index
    # @bets = Bet.all
    # arguments = {}
    # %I[match_id user_id betting_pool_id].each do |args|
    #   arguments[args] = params[args] if params[args].present?
    # end
    # @bets = @bets.where(arguments) if arguments.present?
    @bets = if @user.present?
              @user.bets.not_combo
            elsif params[:match_id].present?
              Bet.where(match_id: params[:match_id])
            else
              Bet.not_combo
            end

    @bets = @bets.order_by_recent.paginate(page: params[:page], per_page: Constants::PER_PAGE)
  end

  def search
    @bets = @user.present? ? @user.bets.not_combo : Bet.not_combo
    @bets = @bets.where(id: params[:bet_id]) if params[:bet_id].present?
    @bets = @bets.send(params[:bet_status]) if params[:bet_status].present?
    @bets = @bets.between(params[:bet_created_at_start_date].to_date, params[:bet_created_at_end_date].to_date) if params[:bet_created_at].present?
    @bets = @bets.search_by_stake(params[:bet_min_amt].to_f, params[:bet_max_amt].to_f) if params[:bet_min_amt].present? && params[:bet_max_amt].present?
    @bets = @bets.joins(:match).where('matches.sport_id': sport_ids) if params[:sport_kind].present? || params[:sport_id].present?
    @bets = @bets.order_by_recent.paginate(page: params[:page], per_page: Constants::PER_PAGE)
  end

  def suspend_bet
    BetSuspensionProcess.new(@bet, current_admin_user).call
    msg = 'Bet suspended successfully'
    render json: { message: msg }
  rescue Exception => e
    render json: { error: e.message }, status: :bad_request
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def set_bet
    @bet = params[:type].eql?('single') ? Bet.find_by(id: params[:id]) : ComboBet.find_by(id: params[:id])
  end

  def sport_ids
    params[:sport_id].presence || Sport.send(params[:sport_kind]).ids
  end
end
