class Admin::OccupationsController < Admin::BaseController
  include Occupations

  def index
    @occupations = Occupation.all
    @occupations = @occupations.paginate(page: params[:page])
  end
end
