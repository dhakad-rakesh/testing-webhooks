class Admin::DashboardController < Admin::BaseController
  skip_load_and_authorize_resource
  before_action :check_sub_admin, only: :index
  before_action :set_date_filter
  before_action :set_user_ids, only: %I[summaries_filter sports_overview_filter esports_overview_filter top_sports_filter profit_filter]

  def index; end

  def summaries_filter
    @summaries_filter = SummariesFilter.new(
      start_date: @start_date,
      end_date: @end_date,
      user_ids: @user_ids
    )
  end

  def sports_overview_filter
    @sports_overview_filter = sportsbook_overview_filter(kind: :sports)
  end

  def esports_overview_filter
    @esports_overview_filter = sportsbook_overview_filter(kind: :esports)
  end

  def casino_overview_filter
    @casino_overview_filter = CasinoOverviewFilter.new(
      start_date: @start_date,
      end_date: @end_date,
      user_ids: @user_ids
    )
  end

  def slot_game_overview_filter
    @slot_game_overview_filter = SlotGameOverviewFilter.new(
      start_date: @start_date,
      end_date: @end_date,
      user_ids: @user_ids
    )
  end

  def top_casino_filter
    @top_casino_filter = TopCasinoFilter.new(
      start_date: @start_date,
      end_date: @end_date,
      user_ids: @user_ids
    )
  end

  def top_slot_game_filter
    @top_slot_game_filter = TopSlotGameFilter.new(
      start_date: @start_date,
      end_date: @end_date,
      user_ids: @user_ids
    )
  end

  def top_sports_filter
    @top_sports_filter = TopSportsFilter.new(
      start_date: @start_date,
      end_date: @end_date,
      user_ids: @user_ids
    )
  end

  def profit_filter
    @profit_filter = ProfitFilter.new(
      start_date: @start_date,
      end_date: @end_date,
      user_ids: @user_ids
    )

    render json: @profit_filter.stats
  end

  # def favourite_matches
  #   @matches = Match.top_five
  #   respond_to do |format|
  #     format.js {}
  #   end
  # end

  # def favourite_markets
  #   @markets = Market.top_five
  #   respond_to do |format|
  #     format.js {}
  #   end
  # end

  # def user_chart
  #   respond_to do |format|
  #     format.html {}
  #     format.json do
  #       render json: { user_sign_up: ::AdminDashboard::UserPresenter.count(params[:type], params[:interval] || 'day') }
  #     end
  #   end
  # end

  # def reset_counter
  #   respond_to do |format|
  #     format.js
  #   end
  # end

  private

  def set_user_ids
    @user_ids ||= if current_admin_user.is_reseller?
                    current_admin_user.users.ids
                  else
                    :all
                  end
  end

  # def set
  #   unless current_admin_user.is_reseller?
  #     set_income(Ledger.players_ledgers)
  #     set_users
  #     set_bets
  #   else
  #     set_income(Ledger.reseller_ledgers(current_admin_user))
  #     set_users(current_admin_user.users)
  #     set_bets(Bet.reseller_bets(current_admin_user), ComboBet.reseller_combo_bets(current_admin_user))
  #   end
  # end

  # def set_income(ledgers)
  #   @total_income = filtered_data(ledgers).total_income
  # end

  # def set_users(users = nil)
  #   users = users || User
  #   @total_users = filtered_data(users).count
  # end

  # def set_bets(bets = nil, combo_bets = nil)
  #   bets = bets || Bet
  #   combo_bets = combo_bets || ComboBet
  #   @total_bets = filtered_data(bets).count + filtered_data(combo_bets).count
  # end

  # def filtered_data(items)
  #   case params[:kind]
  #   when 'today'
  #     return items.between(Time.zone.now, Time.zone.now)
  #   when 'yesterday'
  #     return items.between(Time.zone.yesterday, Time.zone.yesterday)
  #   when 'this_week'
  #     return items.between(Time.zone.now.beginning_of_week, Time.zone.now)
  #   when 'last_week'
  #     last_week_start = (Date.today.beginning_of_week - 7).to_date
  #     last_week_end = last_week_start.end_of_week
  #     return items.between(last_week_start, last_week_end)
  #   when 'this_month'
  #     return items.between(Time.zone.now.beginning_of_month, Time.zone.now)
  #   when 'last_month'
  #     last_month_end = (Date.today.beginning_of_month - 1).to_date
  #     last_month_start = last_month_end.beginning_of_month
  #     return items.between(last_month_start, last_month_end)
  #   else
  #     []
  #   end
  #   @start_date = params[:start_date].to_date rescue Time.zone.now
  #   @end_date = params[:end_date].to_date rescue Time.zone.now
  #   items = items.between(@start_date, @end_date)
  # end

  def check_sub_admin
    redirect_to admin_admin_user_path(current_admin_user) and return if current_admin_user.is_sub_admin?
  end

  def sportsbook_overview_filter(kind:)
    SportsbookOverviewFilter.new(
      kind: kind,
      start_date: @start_date,
      end_date: @end_date,
      user_ids: @user_ids
    )
  end

  def set_date_filter
    return unless params[:start_date] && params[:end_date]

    return if @start_date && @end_date

    @start_date = params[:start_date].to_time
    @end_date = params[:end_date].to_time
  end
end
