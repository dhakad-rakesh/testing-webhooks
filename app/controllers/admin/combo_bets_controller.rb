class Admin::ComboBetsController < Admin::BaseController
  load_and_authorize_resource
  before_action :set_user, only: %i[index search]

  def index
    # @combo_bets = ComboBet.all
    # arguments = {}
    # %I[user_id].each do |args|
    #   arguments[args] = params[args] if params[args].present?
    # end
    # @combo_bets = @combo_bets.where(arguments) if arguments.present?

    # @combo_bets = @combo_bets.paginate(page: params[:page])
    @combo_bets = @user.present? ? @user.combo_bets : ComboBet.all

    @combo_bets = @combo_bets.order_by_recent.paginate(page: params[:page], per_page: Constants::PER_PAGE)
  end

  def search
    @combo_bets = @user.present? ? @user.combo_bets : ComboBet.all
    @combo_bets = @combo_bets.where(id: params[:bet_id]) if params[:bet_id].present?
    @combo_bets = @combo_bets.send(params[:bet_status]) if params[:bet_status].present?
    @combo_bets = @combo_bets.between(params[:bet_created_at_start_date].to_date, params[:bet_created_at_end_date].to_date) if params[:bet_created_at].present?
    @combo_bets = @combo_bets.search_by_stake(params[:bet_min_amt].to_f, params[:bet_max_amt].to_f) if params[:bet_min_amt].present? && params[:bet_max_amt].present?
    @combo_bets = @combo_bets.joins(bets: :match).where(matches: { sport_id: sport_ids }) if params[:sport_id].present? || params[:sport_kind].present?
    @combo_bets = @combo_bets.order_by_recent.paginate(page: params[:page], per_page: Constants::PER_PAGE)
  end

  private

  def sport_ids
    params[:sport_id].presence || Sport.send(params[:sport_kind]).ids
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
  end
end
