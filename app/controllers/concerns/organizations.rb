module Organizations
  extend ActiveSupport::Concern

  def index
    render json: Organization.select(:id, :name).order(:name)
  end
end
