class Admin::OrganizationsController < Admin::BaseController
  include Organizations

  def index
    @organizations = Organization.all
    @organizations = @organizations.paginate(page: params[:page])
  end
end
