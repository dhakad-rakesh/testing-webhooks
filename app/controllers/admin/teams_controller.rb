class Admin::TeamsController < Admin::BaseController
  def index
    @teams = Team.all.includes(:sport).paginate(page: params[:page])
  end
end
