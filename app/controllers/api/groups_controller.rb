class Api::GroupsController < Api::BaseController
  def index
    groups = Group.all.paginate(page: params[:page], per_page: params[:per_page])
    render_collection(groups)
  end
end
