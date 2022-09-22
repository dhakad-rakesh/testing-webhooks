class SportsController < BaseController
  layout 'main'

  before_action :active_menu, only: :show
  before_action :set_sport, only: :show
  skip_before_action :authenticate_user!

  def show
    tournaments = @sport&.tournaments
    tournaments = tournaments.where(id: params[:league_id]) if params[:league_id].present?

    @tournaments = if params[:scope] == 'live'
                     live_matches(tournaments)
                   elsif params[:scope] == 'today'
                     todays_matches(tournaments)
                   else
                     non_live_matches(tournaments)
                   end

    # Search matches with name and acronym
    # @searched_team_ids = Team.includes(:matches)
    #                          .includes(:tournaments)
    #                          .where('matches.enabled' => true)
    #                          .where('tournaments.enabled' => true)
    #                          .where("lower(teams.name) ILIKE lower(?) OR lower(teams.acronym) ILIKE lower(?)", "%#{params[:search]}%", "%#{params[:search]}%")
    #                          .pluck(:id)

    #Search matches with acronym
    @searched_team_ids = Team.where("lower(name) ILIKE lower(?)", "%#{params[:search]}%")
                         .pluck(:id)
    @searched_tournaments_ids = @tournaments.where("lower(name) ILIKE lower(?)", "%#{params[:search]}%").pluck(:id)

    respond_to do |format|
      format.js
      format.html
    end
    @bets = current_user.placed_bets.pending if current_user.present?
  end

  private

  def set_sport
    @sport = Sport.find_by(id: params[:id])

    if @sport&.name.to_s != 'Soccer'
      flash[:error] = 'Sport is not available.'
      redirect_to root_path and return
    end
  end

  def live_matches(tournaments)
    tournament_ids = Match.live.pluck(:tournament_id).uniq
    begin
      tournaments.where('tournaments.id in (?)', tournament_ids)
                 .includes(:matches)
                 .where(matches: {
                          enabled: true,
                          status: 'in_progress'
                        })
                 .order(:name)
    rescue StandardError
      []
    end
  end

  def non_live_matches(tournaments)
    tournaments.active_tournaments_with_active_matches
               .includes(:matches)
               .where(matches: {
                        enabled: true,
                        status: 'not_started'
                      })
               .order(:name)
  rescue StandardError
    []
  end

  def todays_matches(tournaments)
    tournaments.active_tournaments_with_active_matches
               .includes(:matches)
               .where(matches: {
                        enabled: true,
                        status: %w[in_progress not_started],
                        schedule_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
                      })
               .order(:name)
  rescue StandardError
    []
  end

  def active_menu
    session[:scope] = params[:scope]
  end
end
