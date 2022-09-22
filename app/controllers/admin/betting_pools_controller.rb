class Admin::BettingPoolsController < Admin::BaseController
  before_action :set_match, only: %I[create new show edit destroy]
  before_action :set_betting_pool, only: %I[show edit update destroy]
  before_action :assign_matches, only: %I[edit new create update]

  def index
    @betting_pools = BettingPool.all
  end

  def create
    @betting_pool = BettingPool.new(betting_pool_params)
    betting_pool_matches = @betting_pool.matches.pluck(:id)
    respond_to do |format|
      if @betting_pool.save
        matches = Match.where(
          id: params.dig(:betting_pool, :match_id).map(&:to_i)
                   .reject { |match_id| betting_pool_matches.include?(match_id) }
        ).order(:schedule_at)
        @betting_pool.matches << matches if matches.present?
        format.html do
          redirect_to admin_betting_pool_path(@betting_pool),
            notice: t('.successful')
        end
      else
        format.html { render :new, notice: t('went_wrong') }
      end
    end
  end

  def show
    @bets = @betting_pool.bets.select('user_id, id')
  end

  def new
    @betting_pool = BettingPool.new
  end

  def edit; end

  def update
    respond_to do |format|
      if @betting_pool.update(betting_pool_update_params)
        betting_pool_matches = @betting_pool.matches.pluck(:id)
        matches = Match.where(
          id: params.dig(:betting_pool, :match_id).map(&:to_i)
                   .reject { |match_id| betting_pool_matches.include?(match_id) }
        )
        @betting_pool.matches << matches if matches.present?
        format.html do
          redirect_to admin_betting_pool_path(@betting_pool),
                      notice: t('success_update', name: t('pool'))
        end
      else
        format.html { render :edit, notice: t('went_wrong') }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @betting_pool.participants.blank? && @betting_pool.destroy
        format.html { redirect_to admin_betting_pools_path, notice: t('success_destroy', name: t('pool')) }
      else
        format.html { render :show, notice: t('went_wrong') }
      end
    end
  end

  private

  def set_betting_pool
    @betting_pool = BettingPool.find_by(id: params[:id]&.to_i)
    redirect_to admin_matches_path, notice: t('not_found', name: t('pool')) unless @betting_pool
  end

  def set_match
    @match = Match.find_by(id: params[:match_id]&.to_i)
    redirect_to admin_matches_path, notice: t('not_found', name: t('user')) if params[:match_id].present? && @match.blank?
  end

  def assign_matches
    tournament_ids = Tournament.where(uid: Constants::ALLOWED_SOCCER_TOURNAMENT).map(&:id)
    @matches = Match.available_matches
                    .where(tournament_id: tournament_ids)
                    .active_within_7_days
                    .includes(:sport, :tournament, :teams, :betting_pools)
  end

  def betting_pool_params
    params[:betting_pool][:winnings_distribution_method] = params[:betting_pool][:winnings_distribution_method]&.to_i
    params.require(:betting_pool).permit(
      :entry_amount, :points_per_user, :winnings_distribution_method, :name,
      :minimum_participants
    )
  end

  def betting_pool_update_params
    params.require(:betting_pool).permit(:name)
  end
end
